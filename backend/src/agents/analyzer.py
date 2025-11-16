"""Influencer analyzer orchestrator."""
import asyncio
import json
import logging
from datetime import datetime, timedelta
from typing import Any, Dict, Optional

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    datefmt='%H:%M:%S'
)
logger = logging.getLogger(__name__)

from src.models.database import (
    Connection,
    Influencer,
    NewsArticle,
    Platform,
    Product,
    ProductReview,
    ReputationComment,
    TimelineEvent,
)
from src.config.settings import settings
from src.services.blackbox_client import blackbox_client
from src.services.perplexity_client import perplexity_client
from src.services.image_search import image_search_service
from src.services.wikipedia_image import wikipedia_image_service
from src.services.supabase_db import supabase_db


class InfluencerAnalyzer:
    """Orchestrates real-time influencer analysis."""

    def __init__(self, db=None):
        """Initialize analyzer (db parameter kept for backward compatibility but not used)."""
        self.db = supabase_db  # Use Supabase wrapper instead of SQLAlchemy

        # Select AI provider based on settings
        if settings.ai_provider == "perplexity":
            self.ai_client = perplexity_client
            logger.info(f"🤖 Using AI Provider: Perplexity (setting: {settings.ai_provider})")
        else:
            self.ai_client = blackbox_client
            logger.info(f"🤖 Using AI Provider: Blackbox (setting: {settings.ai_provider})")

    def _generate_name_variations(self, name: str) -> list[str]:
        """
        Generate common name variations for flexible matching.

        Args:
            name: Original influencer name

        Returns:
            List of name variations to try
        """
        variations = []

        # Try the original name first
        variations.append(name)

        # If name has no spaces, try adding space variations
        if " " not in name:
            # Try adding space before capital letters (e.g., "Tiboinshape" -> "Tibo Inshape")
            import re
            spaced = re.sub(r'([a-z])([A-Z])', r'\1 \2', name)
            if spaced != name:
                variations.append(spaced)
                # Also try with "In" capitalized (e.g., "Tibo InShape")
                variations.append(spaced.replace(" in", " In"))

        # If name has multiple words, try first name only
        if " " in name:
            first_name = name.split()[0]
            variations.append(first_name)

            # Also try without last name for common patterns (e.g., "Nabilla Vergara" -> "Nabilla")
            if len(name.split()) > 1:
                # Keep only first word
                variations.append(name.split()[0])

        # Try with @ prefix (common handle format)
        variations.append(f"@{name.replace(' ', '').lower()}")

        # Remove duplicates while preserving order
        seen = set()
        unique_variations = []
        for v in variations:
            if v not in seen:
                seen.add(v)
                unique_variations.append(v)

        return unique_variations

    async def analyze_influencer(self, influencer_name: str, analysis_level: str = "basic") -> Dict[str, Any]:
        """
        Perform real-time analysis of an influencer.

        Args:
            influencer_name: Name of the influencer to analyze
            analysis_level:
                - "platforms_only": ONLY platforms and profile picture (for top lists)
                - "basic": Platforms, products (for individual profile view)
                - "full": Everything (timeline, news, reviews, connections)

        Returns:
            Influencer profile data

        Note: For top influencer lists, use "platforms_only" to minimize token usage.
        """
        # Validate influencer name
        if not influencer_name or not influencer_name.strip():
            raise ValueError("Influencer name cannot be empty")
        
        logger.info(f"🔍 Starting {analysis_level} analysis for: {influencer_name}")

        # Check if influencer exists in cache
        influencer = self.db.get_influencer_by_name(influencer_name)

        # If cached, not expired, AND analysis was complete, return cached data
        if (influencer and
            influencer.get("cache_expires") and
            datetime.fromisoformat(influencer["cache_expires"].replace('Z', '+00:00')) > datetime.utcnow() and
            influencer.get("analysis_complete")):
            logger.info(f"✅ Returning cached data for: {influencer_name}")
            return self._build_response(influencer)

        # If cached but analysis was incomplete, we'll retry the analysis
        if influencer and not influencer.get("analysis_complete"):
            logger.info(f"⚠️  Found incomplete analysis for '{influencer_name}', retrying...")
            # Reset the analyzing flag so we can retry
            self.db.update_influencer(influencer["id"], {"is_analyzing": False})

        # If analysis is in progress, wait a bit and return partial data if available
        if influencer and influencer.get("is_analyzing") and not influencer.get("analysis_complete"):
            logger.info(f"⏳ Analysis already in progress for: {influencer_name}, returning existing data")
            # Return whatever data we have so far (partial response is better than error)
            if influencer.get("name"):
                return self._build_response(influencer)
            return {
                "status": "analyzing",
                "message": "Analysis in progress, please wait...",
                "influencer_id": influencer["id"]
            }

        # Create or update influencer record
        if not influencer:
            influencer = self.db.create_influencer({
                "name": influencer_name,
                "is_analyzing": True,
                "last_analyzed": datetime.utcnow().isoformat(),
                "cache_expires": (datetime.utcnow() + timedelta(days=7)).isoformat(),  # Cache for 7 days
            })
        else:
            influencer = self.db.update_influencer(influencer["id"], {
                "is_analyzing": True,
                "last_analyzed": datetime.utcnow().isoformat()
            })

        try:
            # Run all analysis tasks in parallel
            if analysis_level == "platforms_only":
                logger.info(f"📱 Step 1/2: Discovering social media platforms for {influencer_name}...")
            elif analysis_level == "basic":
                logger.info(f"📱 Step 1/4: Discovering social media platforms for {influencer_name}...")
            else:
                logger.info(f"📱 Step 1/6: Discovering social media platforms for {influencer_name}...")
            platforms_data = await self._run_in_thread(
                self.ai_client.analyze_influencer_platforms,
                influencer_name
            )
            logger.info(f"   ✓ Found {len(platforms_data.get('platforms', []))} platforms")

            # Validate that influencer exists - check if we found any real platforms
            if not platforms_data.get("platforms") or len(platforms_data.get("platforms", [])) == 0 or platforms_data.get("error"):
                # Try name variations as fallback
                logger.warning(f"⚠️  Initial search for '{influencer_name}' found 0 platforms, trying name variations...")
                variations = self._generate_name_variations(influencer_name)
                logger.info(f"   🔄 Will try these variations: {variations}")

                platforms_data = None
                for variation in variations[1:]:  # Skip first one (original name already tried)
                    logger.info(f"   🔍 Trying variation: '{variation}'")
                    try:
                        variation_data = await self._run_in_thread(
                            self.ai_client.analyze_influencer_platforms,
                            variation
                        )

                        # Check if this variation found platforms
                        if variation_data.get("platforms") and len(variation_data.get("platforms", [])) > 0 and not variation_data.get("error"):
                            logger.info(f"   ✅ SUCCESS! Found {len(variation_data.get('platforms', []))} platforms using '{variation}'")
                            platforms_data = variation_data
                            # Update the influencer name to the working variation
                            influencer = self.db.update_influencer(influencer["id"], {"name": variation})
                            break
                        else:
                            logger.info(f"   ✗ No platforms found for '{variation}'")
                    except Exception as e:
                        logger.warning(f"   ✗ Error trying '{variation}': {str(e)}")
                        continue

                # If all variations failed, give up
                if not platforms_data or not platforms_data.get("platforms") or len(platforms_data.get("platforms", [])) == 0:
                    logger.error(f"❌ No platforms found for '{influencer_name}' even after trying {len(variations)} name variations")
                    self.db.update_influencer(influencer["id"], {"is_analyzing": False})

                    # Clean up the influencer record if it was just created
                    if not influencer.get("analysis_complete"):
                        from src.services.supabase_client import supabase
                        supabase.table("influencers").delete().eq("id", influencer["id"]).execute()

                    tried_names = ", ".join(variations)
                    raise Exception(f"Influencer '{influencer_name}' not found. Tried variations: {tried_names}")

            # Save platform data
            if platforms_data.get("platforms"):
                logger.info(f"💾 Saving platform data...")
                await self._save_platforms(influencer, platforms_data)
                bio = platforms_data.get("bio", "")
                country = platforms_data.get("country")
                update_data = {"bio": bio}
                if country:
                    update_data["country"] = country
                    logger.info(f"   🌍 Country detected: {country}")
                influencer = self.db.update_influencer(influencer["id"], update_data)

                # Validate minimum follower threshold (10k+)
                from src.services.supabase_client import supabase
                platforms_response = supabase.table("platforms").select("follower_count").eq("influencer_id", influencer["id"]).execute()
                total_followers = sum(p.get("follower_count", 0) for p in platforms_response.data)
                if total_followers < 10000:
                    logger.warning(f"⚠️  Influencer '{influencer_name}' has only {total_followers:,} followers (below 10k threshold)")
                    self.db.update_influencer(influencer["id"], {"is_analyzing": False})

                    # Clean up the influencer record
                    if not influencer.get("analysis_complete"):
                        supabase.table("influencers").delete().eq("id", influencer["id"]).execute()

                    raise Exception(f"Influencer '{influencer_name}' does not meet the minimum follower threshold (10,000+ required, found {total_followers:,}). This prevents volatility and ensures established presence.")

                # Fetch profile picture URL only if not already stored
                if not influencer.get("avatar_url"):
                    logger.info(f"🖼️  Fetching profile picture URL...")
                    avatar_url = await self._fetch_profile_picture(influencer_name, platforms_data)
                    if avatar_url:
                        influencer = self.db.update_influencer(influencer["id"], {"avatar_url": avatar_url})
                        logger.info(f"   ✓ Profile picture URL saved")
                else:
                    logger.info(f"✓ Profile picture URL already exists")

            # Run analyses based on level
            if analysis_level == "platforms_only":
                # Platforms only: Skip ALL additional analyses (products, timeline, news, connections)
                logger.info(f"✅ Step 2/2: Platforms-only analysis complete (skipping products, timeline, news, connections)")
                products_data = None
                connections_data = None
                timeline_data = None
                news_data = None
            elif analysis_level == "full":
                logger.info(f"🔄 Step 2/6: Running full parallel analyses (products, timeline, connections, news)...")
                results = await asyncio.gather(
                    self._run_in_thread(self.ai_client.analyze_products, influencer_name, platforms_data),
                    self._run_in_thread(self.ai_client.analyze_breakthrough_moment, influencer_name, platforms_data),
                    self._run_in_thread(self.ai_client.analyze_connections, influencer_name, platforms_data),
                    self._run_in_thread(self.ai_client.analyze_news_drama, influencer_name, platforms_data),
                    return_exceptions=True
                )
                products_data, timeline_data, connections_data, news_data = results
                logger.info(f"   ✓ Parallel analyses complete")
            else:
                # Basic analysis: only products (skip timeline, news, and connections)
                logger.info(f"🔄 Step 2/4: Running basic analysis (products only)...")
                products_data = await self._run_in_thread(
                    self.ai_client.analyze_products,
                    influencer_name,
                    platforms_data
                )
                connections_data = None
                timeline_data = None
                news_data = None
                logger.info(f"   ✓ Parallel analyses complete")

            # Save all data
            if isinstance(products_data, dict):
                if analysis_level == "full":
                    logger.info(f"📦 Step 3/6: Saving products and fetching reviews...")
                    await self._save_products(influencer, products_data, platforms_data, fetch_reviews=True)
                else:
                    logger.info(f"📦 Step 3/6: Saving products (skipping reviews)...")
                    await self._save_products(influencer, products_data, platforms_data, fetch_reviews=False)
                logger.info(f"   ✓ Saved {len(products_data.get('products', []))} products")

            if isinstance(timeline_data, dict):
                logger.info(f"📅 Step 4/6: Saving timeline events...")
                await self._save_timeline(influencer, timeline_data)
                logger.info(f"   ✓ Saved {len(timeline_data.get('timeline', []))} timeline events")

            if isinstance(connections_data, dict):
                logger.info(f"🔗 Step 5/6: Saving network connections...")
                await self._save_connections(influencer, connections_data)
                logger.info(f"   ✓ Saved {len(connections_data.get('connections', []))} connections")

            if isinstance(news_data, dict):
                logger.info(f"📰 Step 6/6: Saving news and drama...")
                await self._save_news(influencer, news_data)
                logger.info(f"   ✓ Saved {len(news_data.get('news', []))} news articles")

            # Calculate trust score only when we have product data (not for platforms_only mode)
            if analysis_level == "platforms_only":
                # For platforms_only, set default trust score (will be calculated when viewing full profile)
                trust_score = 0
                logger.info(f"✅ Platforms-only analysis complete! Trust score will be calculated on profile view")
            else:
                # Calculate trust score for basic/full analysis
                logger.info(f"🎯 Calculating trust score...")
                trust_score = self._calculate_trust_score(platforms_data, products_data)
                logger.info(f"✅ Analysis complete for {influencer_name}! Trust score: {trust_score}")

            # Update influencer with final status and trust score
            influencer = self.db.update_influencer(influencer["id"], {
                "is_analyzing": False,
                "analysis_complete": True,
                "trust_score": trust_score
            })

            return self._build_response(influencer)

        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            logger.error(f"❌ Analysis failed for {influencer_name}: {str(e)}")
            logger.error(f"Full error traceback:\n{error_details}")

            # Update influencer status
            if influencer:
                self.db.update_influencer(influencer["id"], {"is_analyzing": False})

            raise Exception(f"Analysis failed for '{influencer_name}': {str(e)}")

    async def _run_in_thread(self, func, *args):
        """Run synchronous function in thread pool."""
        loop = asyncio.get_event_loop()
        return await loop.run_in_executor(None, func, *args)

    async def _save_platforms(self, influencer: Dict[str, Any], data: Dict[str, Any]):
        """Save platform data to database."""
        # Clear existing platforms
        self.db.delete_platforms(influencer["id"])

        for platform_data in data.get("platforms", []):
            platform_dict = {
                "influencer_id": influencer["id"],
                "platform_name": platform_data.get("platform", ""),
                "username": platform_data.get("username", ""),
                "follower_count": platform_data.get("followers", 0),
                "verified": platform_data.get("verified", False),
                "url": platform_data.get("url", ""),
            }
            self.db.create_platform(platform_dict)

    async def _save_products(self, influencer: Dict[str, Any], data: Dict[str, Any], platforms_data: Dict[str, Any], fetch_reviews: bool = False):
        """Save product data to database and optionally fetch reviews."""
        # Clear existing products and their reviews
        self.db.delete_products(influencer["id"])

        for product_data in data.get("products", []):
            product_dict = {
                "influencer_id": influencer["id"],
                "name": product_data.get("name", ""),
                "category": product_data.get("category", ""),
                "description": product_data.get("description", ""),
                "quality_score": 70,  # Default, will be updated
                "review_count": 0,
                "sentiment_score": 0.0,
            }

            # Check OpenFoodFacts for food or cosmetics products
            category = product_data.get("category", "").lower()
            if category in ["food", "cosmetics", "beauty"]:
                try:
                    logger.info(f"   🔍 Checking OpenFoodFacts for '{product_dict['name']}'...")
                    from src.services.openfoodfacts import openfoodfacts_client

                    # Determine API category
                    api_category = "food" if category == "food" else "cosmetics"

                    # Search for product
                    def search_product():
                        return openfoodfacts_client.search_product(product_dict["name"], api_category)

                    off_data = await self._run_in_thread(search_product)

                    if off_data:
                        # Store the data as JSON
                        import json
                        product_dict["openfoodfacts_data"] = json.dumps(off_data)

                        # Use the quality score from OpenFoodFacts
                        product_dict["quality_score"] = off_data.get("quality_score", 70)

                        if category == "food":
                            nutriscore = off_data.get("nutriscore", "N/A")
                            nova = off_data.get("nova_group", "N/A")
                            is_healthy = off_data.get("is_healthy", False)
                            logger.info(f"      ✓ NutriScore: {nutriscore}, NOVA: {nova}, Healthy: {is_healthy}, Score: {product_dict['quality_score']}")
                        else:
                            logger.info(f"      ✓ Beauty Score: {product_dict['quality_score']}/100")
                    else:
                        logger.info(f"      ⚠️  Product not found in OpenFoodFacts database")
                except Exception as e:
                    logger.warning(f"      ⚠️  OpenFoodFacts lookup failed: {str(e)}")

            # Create the product and get its ID
            created_product = self.db.create_product(product_dict)
            product_id = created_product["id"]

            # Fetch reviews for this product (only if requested)
            if fetch_reviews:
                try:
                    logger.info(f"   🔍 Searching for reviews of '{product_dict['name']}'...")
                    reviews_data = await self._run_in_thread(
                        self.ai_client.analyze_product_reviews,
                        influencer["name"],
                        product_dict["name"],
                        platforms_data
                    )

                    if isinstance(reviews_data, dict) and reviews_data.get("reviews"):
                        sentiments = []

                        # Limit to 2 reviews to reduce token consumption
                        reviews_list = reviews_data.get("reviews", [])[:2]

                        for review_item in reviews_list:
                            try:
                                # Parse date if provided
                                if review_item.get("date"):
                                    review_date = datetime.strptime(review_item.get("date", ""), "%Y-%m-%d").isoformat()
                                else:
                                    review_date = None
                            except:
                                review_date = None

                            sentiment = review_item.get("sentiment", "neutral")
                            sentiments.append(sentiment)

                            review_dict = {
                                "product_id": product_id,
                                "author": review_item.get("author", "Anonymous"),
                                "comment": review_item.get("comment", ""),
                                "platform": review_item.get("platform", ""),
                                "sentiment": sentiment,
                                "url": review_item.get("url"),
                                "date": review_date,
                            }
                            self.db.create_product_review(review_dict)

                        # Update review count and sentiment score
                        review_count = len(reviews_list)
                        sentiment_score = 0.0

                        # Calculate sentiment score (-1 to 1)
                        if sentiments:
                            positive = sentiments.count("positive")
                            negative = sentiments.count("negative")
                            neutral = sentiments.count("neutral")
                            total = len(sentiments)

                            # Sentiment score: (positive - negative) / total
                            sentiment_score = (positive - negative) / total
                            logger.info(f"      ✓ Found {review_count} reviews (😊 {positive} / 😐 {neutral} / 😞 {negative}) - Sentiment: {sentiment_score:.2f}")
                        else:
                            logger.info(f"      ✓ Found {review_count} reviews for '{product_dict['name']}'")

                        # Update product with review stats
                        self.db.update_product(product_id, {
                            "review_count": review_count,
                            "sentiment_score": sentiment_score,
                        })
                except Exception as e:
                    # If review fetching fails, just continue without reviews
                    logger.warning(f"      ⚠️  Failed to fetch reviews for {product_dict['name']}: {str(e)}")

    async def _save_timeline(self, influencer: Dict[str, Any], data: Dict[str, Any]):
        """Save timeline events to database."""
        # Clear existing timeline
        self.db.delete_timeline_events(influencer["id"])

        # Limit to maximum 7 timeline events to control API costs
        timeline_events = data.get("timeline", [])[:7]

        for event_data in timeline_events:
            try:
                event_date = datetime.strptime(event_data.get("date", ""), "%Y-%m-%d").isoformat()
            except:
                event_date = datetime.utcnow().isoformat()

            event_dict = {
                "influencer_id": influencer["id"],
                "date": event_date,
                "event_type": event_data.get("type", "achievement"),
                "title": event_data.get("title", ""),
                "description": event_data.get("description", ""),
                "platform": event_data.get("platform", ""),
                "views": event_data.get("views"),
                "likes": event_data.get("likes"),
                "url": event_data.get("url"),
            }
            self.db.create_timeline_event(event_dict)

    async def _save_connections(self, influencer: Dict[str, Any], data: Dict[str, Any]):
        """Save connection data to database (both influencers and entities like agencies/brands)."""
        # Clear existing connections
        self.db.delete_connections(influencer["id"])

        # Limit to top 8 connections (sorted by strength)
        connections_list = data.get("connections", [])
        # Sort by strength descending
        connections_list = sorted(connections_list, key=lambda x: x.get("strength", 0), reverse=True)
        # Take top 8
        connections_list = connections_list[:8]
        
        logger.info(f"   💾 Saving {len(connections_list)} connections (limited to top 8 by strength)")

        for conn_data in connections_list:
            entity_name = conn_data.get("name", "")
            entity_type = conn_data.get("entity_type", "influencer")
            connection_type = conn_data.get("connection_type", conn_data.get("type", "collaboration"))

            connected_influencer_id = None

            # If it's an influencer, create or link to influencer record
            if entity_type == "influencer":
                # Search by name (case-insensitive)
                connected_influencer = self.db.get_influencer_by_name(entity_name)

                if not connected_influencer:
                    logger.info(f"      Creating stub record for connected influencer: {entity_name}")
                    connected_influencer = self.db.create_influencer({
                        "name": entity_name,
                    })

                    # Skip fetching profile pictures for connected influencers to avoid rate limiting
                    # Their avatars will be fetched if/when user navigates to their profile
                    logger.info(f"      ✓ Created stub record (avatar will be fetched on-demand)")

                connected_influencer_id = connected_influencer["id"]

            # Create connection (both for influencers and other entities)
            connection_dict = {
                "influencer_id": influencer["id"],
                "connected_influencer_id": connected_influencer_id,
                "entity_name": entity_name,
                "entity_type": entity_type,
                "connection_type": connection_type,
                "strength": conn_data.get("strength", 1),
                "description": conn_data.get("description", ""),
            }
            self.db.create_connection(connection_dict)

    async def _save_news(self, influencer: Dict[str, Any], data: Dict[str, Any]):
        """Save news and drama articles to database."""
        # Clear existing news
        self.db.delete_news_articles(influencer["id"])

        for news_item in data.get("news", []):
            try:
                # Parse date if provided
                if news_item.get("date"):
                    article_date = datetime.strptime(news_item.get("date", ""), "%Y-%m-%d").isoformat()
                else:
                    article_date = None
            except:
                article_date = None

            article_dict = {
                "influencer_id": influencer["id"],
                "title": news_item.get("title", ""),
                "description": news_item.get("description", ""),
                "article_type": news_item.get("article_type", "news"),
                "date": article_date,
                "source": news_item.get("source", ""),
                "url": news_item.get("url"),
                "sentiment": news_item.get("sentiment", "neutral"),
                "severity": news_item.get("severity", 1),
            }
            self.db.create_news_article(article_dict)

    async def _fetch_profile_picture(self, influencer_name: str, platforms_data: Dict[str, Any]) -> str:
        """
        Fetch profile picture URL with priority order:
        1. Wikipedia (high quality, reliable, with smart resize)
        2. AI-provided URL
        3. Image search fallback

        Args:
            influencer_name: Name of the influencer
            platforms_data: Platform information including profile_picture_url

        Returns:
            Profile picture URL or None
        """
        # PRIORITY 1: Try Wikipedia first (best quality + smart crop to square)
        logger.info(f"   🔍 Checking Wikipedia for profile picture...")
        try:
            wikipedia_url = await self._run_in_thread(
                wikipedia_image_service.search_profile_picture,
                influencer_name,
                300,  # Size: 300x300px
                True  # Square crop with smart centering
            )
            if wikipedia_url:
                logger.info(f"   ✓ Found Wikipedia image (300x300 square crop, centered)")
                return wikipedia_url
        except Exception as e:
            logger.warning(f"   ⚠ Wikipedia search failed: {str(e)}")

        # PRIORITY 2: Try AI-provided URL
        profile_pic_url = platforms_data.get("profile_picture_url")
        if profile_pic_url and isinstance(profile_pic_url, str) and len(profile_pic_url) > 10:
            # Quick check: skip obviously fake URLs
            if not any(x in profile_pic_url.lower() for x in ["placeholder", "example.com", "lookaside"]):
                logger.info(f"   ✓ Using AI-provided profile picture URL")
                return profile_pic_url

        # PRIORITY 3: Fallback to image search
        logger.info(f"   ⚠ No Wikipedia/AI URL, trying image search...")

        # Get primary platform and username
        primary_platform = platforms_data.get("primary_platform", "youtube")
        username = ""

        # Try to get username from platforms
        if platforms_data.get("platforms"):
            for platform in platforms_data["platforms"]:
                if platform.get("platform") == primary_platform:
                    username = platform.get("username", "")
                    break
            if not username and platforms_data["platforms"]:
                username = platforms_data["platforms"][0].get("username", "")

        # Quick search (image_search_service already has early stopping)
        try:
            search_result = await self._run_in_thread(
                image_search_service.search_profile_picture,
                influencer_name,
                primary_platform,
                username
            )
            if search_result:
                logger.info(f"   ✓ Found profile picture via image search")
                return search_result
        except Exception as e:
            logger.warning(f"   ⚠ Image search failed: {str(e)}")

        # If all else fails, return None (frontend will show fallback avatar)
        logger.warning(f"   ⚠ No profile picture found, will use fallback")
        return None

    def _calculate_trust_score(self, platforms_data: Dict[str, Any], products_data: Dict[str, Any]) -> int:
        """Calculate basic trust score."""
        score = 50  # Base score

        # Verified accounts boost trust
        verified_count = sum(1 for p in platforms_data.get("platforms", []) if p.get("verified"))
        score += verified_count * 10

        # More platforms = more trustworthy
        score += min(len(platforms_data.get("platforms", [])) * 5, 20)

        # Cap at 100
        return min(score, 100)

    def _build_response(self, influencer: Dict[str, Any]) -> Dict[str, Any]:
        """Build complete influencer response."""
        from src.services.supabase_client import supabase
        
        # Query all related data from Supabase
        platforms_response = supabase.table("platforms").select("*").eq("influencer_id", influencer["id"]).execute()
        timeline_response = supabase.table("timeline_events").select("*").eq("influencer_id", influencer["id"]).execute()
        products_response = supabase.table("products").select("*").eq("influencer_id", influencer["id"]).execute()
        connections_response = supabase.table("connections").select("*, connected_influencer:influencers!connections_connected_influencer_id_fkey(name)").eq("influencer_id", influencer["id"]).execute()
        news_response = supabase.table("news_articles").select("*").eq("influencer_id", influencer["id"]).execute()
        
        # Build platforms list
        platforms = [
            {
                "platform": p["platform_name"],
                "username": p["username"],
                "followers": p["follower_count"],
                "verified": p["verified"],
                "url": p["url"],
            }
            for p in platforms_response.data
        ]
        
        # Build timeline list (sorted by date)
        timeline_data = sorted(
            timeline_response.data,
            key=lambda x: x.get("date") or "1970-01-01"
        )
        timeline = [
            {
                "id": str(t["id"]),
                "date": t["date"],
                "type": t["event_type"],
                "title": t["title"],
                "description": t["description"],
                "platform": t["platform"],
                "views": t["views"],
                "likes": t["likes"],
            }
            for t in timeline_data
        ]
        
        # Build products list with reviews
        products = []
        for p in products_response.data:
            # Get reviews for this product
            reviews_response = supabase.table("product_reviews").select("*").eq("product_id", p["id"]).execute()
            reviews = [
                {
                    "author": r["author"],
                    "comment": r["comment"],
                    "platform": r["platform"],
                    "sentiment": r["sentiment"],
                    "url": r["url"],
                    "date": r["date"],
                }
                for r in reviews_response.data
            ]
            
            products.append({
                "id": p["id"],
                "name": p["name"],
                "category": p["category"],
                "quality_score": p["quality_score"],
                "description": p["description"],
                "review_count": p["review_count"],
                "sentiment_score": p["sentiment_score"],
                "openfoodfacts_data": json.loads(p["openfoodfacts_data"]) if p.get("openfoodfacts_data") else None,
                "reviews": reviews,
            })
        
        # Build connections list
        connections = [
            {
                "name": c["entity_name"] or (c.get("connected_influencer", {}).get("name") if c.get("connected_influencer") else "Unknown"),
                "entity_type": c["entity_type"] or "influencer",
                "type": c["connection_type"],
                "strength": c["strength"],
                "description": c["description"],
            }
            for c in connections_response.data
        ]
        
        # Build news list (sorted by date, newest first)
        news_data = sorted(
            news_response.data,
            key=lambda x: x.get("date") or "1970-01-01",
            reverse=True
        )
        news = [
            {
                "id": n["id"],
                "title": n["title"],
                "description": n["description"],
                "article_type": n["article_type"],
                "date": n["date"],
                "source": n["source"],
                "url": n["url"],
                "sentiment": n["sentiment"],
                "severity": n["severity"],
            }
            for n in news_data
        ]
        
        return {
            "id": influencer["id"],
            "name": influencer["name"],
            "bio": influencer.get("bio"),
            "country": influencer.get("country"),
            "verified": influencer.get("verified", False),
            "trust_score": influencer.get("trust_score", 0),
            "overall_sentiment": influencer.get("overall_sentiment"),
            "avatar_url": influencer.get("avatar_url"),
            "platforms": platforms,
            "timeline": timeline,
            "products": products,
            "connections": connections,
            "news": news,
            "last_analyzed": influencer.get("last_analyzed"),
            "analysis_complete": influencer.get("analysis_complete", False),
        }

    async def fetch_timeline(self, influencer_id: int) -> Dict[str, Any]:
        """
        Fetch timeline events on-demand for an influencer.

        Args:
            influencer_id: ID of the influencer

        Returns:
            Dict with timeline events
        """
        influencer = self.db.get_influencer_by_id(influencer_id)
        if not influencer:
            raise ValueError(f"Influencer with ID {influencer_id} not found")

        # Get platform data
        from src.services.supabase_client import supabase
        platforms_response = supabase.table("platforms").select("*").eq("influencer_id", influencer_id).execute()
        platforms_data = {
            "platforms": [
                {
                    "platform": p.get("platform_name"),
                    "username": p.get("username"),
                    "followers": p.get("follower_count"),
                    "url": p.get("url")
                }
                for p in platforms_response.data
            ]
        }

        # Fetch timeline from AI
        logger.info(f"🔍 Fetching timeline for: {influencer['name']}")
        timeline_data = await self._run_in_thread(
            self.ai_client.analyze_breakthrough_moment,
            influencer["name"],
            platforms_data
        )

        # Save timeline
        if isinstance(timeline_data, dict):
            await self._save_timeline(influencer, timeline_data)
            logger.info(f"   ✓ Saved timeline events")

        # Get timeline events from database
        timeline_response = supabase.table("timeline_events").select("*").eq("influencer_id", influencer_id).execute()
        
        return {
            "influencer_id": influencer_id,
            "timeline": [
                {
                    "id": t.get("id"),
                    "date": t.get("date"),
                    "event_type": t.get("event_type"),
                    "title": t.get("title"),
                    "description": t.get("description"),
                    "platform": t.get("platform"),
                    "views": t.get("views"),
                    "likes": t.get("likes"),
                    "url": t.get("url"),
                }
                for t in sorted(timeline_response.data, key=lambda x: x.get("date") or "", reverse=True)
            ]
        }

    async def fetch_product_reviews(self, product_id: int) -> Dict[str, Any]:
        """
        Fetch reviews for a specific product on-demand.

        Args:
            product_id: ID of the product

        Returns:
            Dict with product reviews
        """
        product = self.db.get_product_by_id(product_id)
        if not product:
            raise ValueError(f"Product with ID {product_id} not found")

        influencer = self.db.get_influencer_by_id(product["influencer_id"])
        if not influencer:
            raise ValueError(f"Influencer not found for product {product_id}")

        # Get platform data
        from src.services.supabase_client import supabase
        platforms_response = supabase.table("platforms").select("*").eq("influencer_id", influencer["id"]).execute()
        platforms_data = {
            "platforms": [
                {
                    "platform": p.get("platform_name"),
                    "username": p.get("username"),
                    "followers": p.get("follower_count"),
                    "url": p.get("url")
                }
                for p in platforms_response.data
            ]
        }

        # Clear existing reviews
        self.db.delete_product_reviews(product_id)

        # Fetch reviews from AI
        logger.info(f"🔍 Fetching reviews for: {product['name']}")
        reviews_data = await self._run_in_thread(
            self.ai_client.analyze_product_reviews,
            influencer["name"],
            product["name"],
            platforms_data
        )

        # Save reviews
        if isinstance(reviews_data, dict) and reviews_data.get("reviews"):
            sentiments = []
            reviews_list = reviews_data.get("reviews", [])[:2]

            for review_item in reviews_list:
                try:
                    if review_item.get("date"):
                        review_date = datetime.strptime(review_item.get("date", ""), "%Y-%m-%d").isoformat()
                    else:
                        review_date = None
                except:
                    review_date = None

                sentiment = review_item.get("sentiment", "neutral")
                sentiments.append(sentiment)

                review_dict = {
                    "product_id": product["id"],
                    "author": review_item.get("author", "Anonymous"),
                    "comment": review_item.get("comment", ""),
                    "platform": review_item.get("platform", ""),
                    "sentiment": sentiment,
                    "url": review_item.get("url"),
                    "date": review_date,
                }
                self.db.create_product_review(review_dict)

            review_count = len(reviews_list)
            sentiment_score = 0.0

            if sentiments:
                positive = sentiments.count("positive")
                negative = sentiments.count("negative")
                neutral = sentiments.count("neutral")
                total = len(sentiments)
                sentiment_score = (positive - negative) / total

            self.db.update_product(product_id, {
                "review_count": review_count,
                "sentiment_score": sentiment_score
            })
            logger.info(f"   ✓ Saved {len(reviews_list)} reviews")

            # Reload product to get updated values
            product = self.db.get_product_by_id(product_id)

        # Get reviews from database
        reviews_response = supabase.table("product_reviews").select("*").eq("product_id", product_id).execute()
        
        return {
            "product_id": product_id,
            "product_name": product["name"],
            "review_count": product.get("review_count", 0),
            "sentiment_score": product.get("sentiment_score", 0.0),
            "reviews": [
                {
                    "id": r["id"],
                    "author": r["author"],
                    "comment": r["comment"],
                    "platform": r["platform"],
                    "sentiment": r["sentiment"],
                    "url": r["url"],
                    "date": r["date"],
                }
                for r in reviews_response.data
            ]
        }

    async def fetch_connections(self, influencer_id: int, force_refresh: bool = False) -> Dict[str, Any]:
        """
        Fetch network map/connections on-demand for an influencer.

        Args:
            influencer_id: ID of the influencer
            force_refresh: If True, refetch from AI even if connections exist

        Returns:
            Dict with connections data
        """
        influencer = self.db.get_influencer_by_id(influencer_id)
        if not influencer:
            raise ValueError(f"Influencer with ID {influencer_id} not found")

        from src.services.supabase_client import supabase
        
        # Check if connections already exist in cache
        connections_response = supabase.table("connections").select("*").eq("influencer_id", influencer_id).execute()
        
        # If connections exist and not forcing refresh, return cached data
        if connections_response.data and len(connections_response.data) > 0 and not force_refresh:
            logger.info(f"✅ Returning cached connections for: {influencer['name']} ({len(connections_response.data)} connections)")
            return {
                "influencer_id": influencer_id,
                "connections": [
                    {
                        "id": c["id"],
                        "name": c["entity_name"],
                        "entity_name": c["entity_name"],
                        "entity_type": c["entity_type"],
                        "connection_type": c["connection_type"],
                        "strength": c["strength"],
                        "description": c["description"],
                        "connected_influencer_id": c["connected_influencer_id"],
                    }
                    for c in connections_response.data
                ]
            }

        # Get platform data for AI analysis
        platforms_response = supabase.table("platforms").select("*").eq("influencer_id", influencer_id).execute()
        platforms_data = {
            "platforms": [
                {
                    "platform": p.get("platform_name"),
                    "username": p.get("username"),
                    "followers": p.get("follower_count"),
                    "url": p.get("url")
                }
                for p in platforms_response.data
            ]
        }

        # Fetch connections from AI (only if not cached)
        logger.info(f"🔍 Fetching network map for: {influencer['name']}")
        connections_data = await self._run_in_thread(
            self.ai_client.analyze_connections,
            influencer["name"],
            platforms_data
        )

        # Save connections
        if isinstance(connections_data, dict) and connections_data.get("connections"):
            await self._save_connections(influencer, connections_data)
            logger.info(f"   ✓ Saved {len(connections_data.get('connections', []))} connections")

        # Get connections from database
        connections_response = supabase.table("connections").select("*").eq("influencer_id", influencer_id).execute()
        
        return {
            "influencer_id": influencer_id,
            "connections": [
                {
                    "id": c["id"],
                    "name": c["entity_name"],
                    "entity_name": c["entity_name"],
                    "entity_type": c["entity_type"],
                    "connection_type": c["connection_type"],
                    "strength": c["strength"],
                    "description": c["description"],
                    "connected_influencer_id": c["connected_influencer_id"],
                }
                for c in connections_response.data
            ]
        }

    async def fetch_openfoodfacts_data(self, product_id: int) -> Dict[str, Any]:
        """
        Fetch OpenFoodFacts nutritional/safety data for a product on-demand.

        Args:
            product_id: ID of the product

        Returns:
            Dict with OpenFoodFacts data
        """
        product = self.db.get_product_by_id(product_id)
        if not product:
            raise ValueError(f"Product with ID {product_id} not found")

        category = product.get("category", "").lower() if product.get("category") else ""
        if category not in ["food", "cosmetics", "beauty"]:
            return {
                "product_id": product_id,
                "product_name": product["name"],
                "category": product.get("category"),
                "error": "Product category must be 'food', 'cosmetics', or 'beauty' for OpenFoodFacts lookup"
            }

        logger.info(f"🔍 Fetching OpenFoodFacts data for: {product['name']}")

        from src.services.openfoodfacts import openfoodfacts_client

        # Determine API category
        api_category = "food" if category == "food" else "cosmetics"

        # Search for product
        def search_product():
            return openfoodfacts_client.search_product(product["name"], api_category)

        off_data = await self._run_in_thread(search_product)

        if off_data:
            # Store the data as JSON
            import json
            quality_score = off_data.get("quality_score", 70)
            
            self.db.update_product(product_id, {
                "openfoodfacts_data": json.dumps(off_data),
                "quality_score": quality_score
            })

            logger.info(f"   ✓ Updated OpenFoodFacts data (quality score: {quality_score})")

            return {
                "product_id": product_id,
                "product_name": product["name"],
                "category": product.get("category"),
                "openfoodfacts_data": off_data,
                "quality_score": quality_score
            }
        else:
            return {
                "product_id": product_id,
                "product_name": product["name"],
                "category": product.get("category"),
                "error": "Product not found in OpenFoodFacts database"
            }

    async def fetch_news(self, influencer_id: int) -> Dict[str, Any]:
        """
        Fetch news and drama on-demand for an influencer.

        Args:
            influencer_id: ID of the influencer

        Returns:
            Dict with news articles
        """
        influencer = self.db.get_influencer_by_id(influencer_id)
        if not influencer:
            raise ValueError(f"Influencer with ID {influencer_id} not found")

        # Get platform data
        from src.services.supabase_client import supabase
        platforms_response = supabase.table("platforms").select("*").eq("influencer_id", influencer_id).execute()
        platforms_data = {
            "platforms": [
                {
                    "platform": p.get("platform_name"),
                    "username": p.get("username"),
                    "followers": p.get("follower_count"),
                    "url": p.get("url")
                }
                for p in platforms_response.data
            ]
        }

        # Fetch news from AI
        logger.info(f"🔍 Fetching news and drama for: {influencer['name']}")
        news_data = await self._run_in_thread(
            self.ai_client.analyze_news_drama,
            influencer["name"],
            platforms_data
        )

        # Save news
        if isinstance(news_data, dict):
            await self._save_news(influencer, news_data)
            logger.info(f"   ✓ Saved news articles")

        # Get news articles from database
        news_response = supabase.table("news_articles").select("*").eq("influencer_id", influencer_id).execute()
        
        return {
            "influencer_id": influencer_id,
            "news": [
                {
                    "id": n.get("id"),
                    "title": n.get("title"),
                    "description": n.get("description"),
                    "article_type": n.get("article_type"),
                    "date": n.get("date"),
                    "source": n.get("source"),
                    "url": n.get("url"),
                    "sentiment": n.get("sentiment"),
                    "severity": n.get("severity"),
                }
                for n in sorted(news_response.data, key=lambda x: x.get("date") or "", reverse=True)
            ]
        }

    async def fetch_reputation(self, influencer_id: int) -> Dict[str, Any]:
        """
        Fetch reputation sentiment on-demand for an influencer.

        Args:
            influencer_id: ID of the influencer

        Returns:
            Dict with overall sentiment and comments
        """
        influencer = self.db.get_influencer_by_id(influencer_id)
        if not influencer:
            raise ValueError(f"Influencer with ID {influencer_id} not found")

        # Get platform data
        from src.services.supabase_client import supabase
        platforms_response = supabase.table("platforms").select("*").eq("influencer_id", influencer_id).execute()
        platforms_data = {
            "platforms": [
                {
                    "platform": p.get("platform_name"),
                    "username": p.get("username"),
                    "followers": p.get("follower_count"),
                    "url": p.get("url")
                }
                for p in platforms_response.data
            ]
        }

        # Fetch reputation from AI
        logger.info(f"🔍 Fetching reputation for: {influencer['name']}")
        reputation_data = await self._run_in_thread(
            self.ai_client.analyze_reputation,
            influencer["name"],
            platforms_data
        )

        # Save reputation comments
        if isinstance(reputation_data, dict):
            await self._save_reputation(influencer, reputation_data)
            logger.info(f"   ✓ Saved reputation comments")

        # Get reputation comments from database
        comments_response = supabase.table("reputation_comments").select("*").eq("influencer_id", influencer_id).execute()

        return {
            "influencer_id": influencer_id,
            "overall_sentiment": reputation_data.get("overall_sentiment", "neutral"),
            "comments": [
                {
                    "id": c.get("id"),
                    "author": c.get("author"),
                    "comment": c.get("comment"),
                    "platform": c.get("platform"),
                    "sentiment": c.get("sentiment"),
                    "url": c.get("url"),
                    "date": c.get("date"),
                }
                for c in comments_response.data
            ]
        }

    async def _save_reputation(self, influencer: Dict[str, Any], data: Dict[str, Any]):
        """Save reputation comments to database."""
        # Clear existing reputation comments
        self.db.delete_reputation_comments(influencer["id"])

        # Save overall sentiment to influencer record
        overall_sentiment = data.get("overall_sentiment", "neutral")
        self.db.update_influencer(influencer["id"], {
            "overall_sentiment": overall_sentiment
        })

        # Limit to maximum 10 comments
        comments = data.get("comments", [])[:10]

        for comment_data in comments:
            try:
                comment_date = datetime.strptime(comment_data.get("date", ""), "%Y-%m-%d").isoformat()
            except:
                comment_date = None

            comment_dict = {
                "influencer_id": influencer["id"],
                "author": comment_data.get("author", ""),
                "comment": comment_data.get("comment", ""),
                "platform": comment_data.get("platform", ""),
                "sentiment": comment_data.get("sentiment", "neutral"),
                "url": comment_data.get("url"),
                "date": comment_date,
            }
            self.db.create_reputation_comment(comment_dict)
