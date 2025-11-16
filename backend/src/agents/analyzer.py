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
from src.services.profile_fetcher import profile_fetcher
from src.services.image_search import image_search_service
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

        # If analysis is in progress, return status
        if influencer and influencer.get("is_analyzing") and influencer.get("analysis_complete"):
            logger.info(f"⏳ Analysis already in progress for: {influencer_name}")
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
                "cache_expires": (datetime.utcnow() + timedelta(days=1)).isoformat(),  # Cache for 24 hours
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
                            influencer.name = variation
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

                # Fetch profile picture only if not already stored
                if not influencer.avatar_data:
                    logger.info(f"🖼️  Fetching profile picture...")
                    avatar_url = await self._fetch_profile_picture(influencer_name, platforms_data)
                    influencer.avatar_url = avatar_url

                    # Download and store the actual image data
                    if avatar_url:
                        logger.info(f"   📥 Downloading image from: {avatar_url}")
                        await self._download_and_store_image(influencer, avatar_url)
                else:
                    logger.info(f"✓ Profile picture already exists, skipping download")

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
                influencer.trust_score = 0
                logger.info(f"✅ Platforms-only analysis complete! Trust score will be calculated on profile view")
            else:
                # Calculate trust score for basic/full analysis
                logger.info(f"🎯 Calculating trust score...")
                influencer.trust_score = self._calculate_trust_score(platforms_data, products_data)
                logger.info(f"✅ Analysis complete for {influencer_name}! Trust score: {influencer.trust_score}")

            influencer.is_analyzing = False
            influencer.analysis_complete = True
            self.db.commit()

            return self._build_response(influencer)

        except Exception as e:
            import traceback
            error_details = traceback.format_exc()
            logger.error(f"❌ Analysis failed for {influencer_name}: {str(e)}")
            logger.error(f"Full error traceback:\n{error_details}")

            # Update influencer status
            if influencer:
                influencer.is_analyzing = False
                self.db.commit()

            raise Exception(f"Analysis failed for '{influencer_name}': {str(e)}")

    async def _run_in_thread(self, func, *args):
        """Run synchronous function in thread pool."""
        loop = asyncio.get_event_loop()
        return await loop.run_in_executor(None, func, *args)

    async def _save_platforms(self, influencer: Influencer, data: Dict[str, Any]):
        """Save platform data to database."""
        # Clear existing platforms
        self.db.query(Platform).filter(Platform.influencer_id == influencer.id).delete()

        for platform_data in data.get("platforms", []):
            platform = Platform(
                influencer_id=influencer.id,
                platform_name=platform_data.get("platform", ""),
                username=platform_data.get("username", ""),
                follower_count=platform_data.get("followers", 0),
                verified=platform_data.get("verified", False),
                url=platform_data.get("url", ""),
            )
            self.db.add(platform)

        self.db.commit()

    async def _save_products(self, influencer: Influencer, data: Dict[str, Any], platforms_data: Dict[str, Any], fetch_reviews: bool = False):
        """Save product data to database and optionally fetch reviews."""
        # Clear existing products and their reviews
        self.db.query(Product).filter(Product.influencer_id == influencer.id).delete()

        for product_data in data.get("products", []):
            product = Product(
                influencer_id=influencer.id,
                name=product_data.get("name", ""),
                category=product_data.get("category", ""),
                description=product_data.get("description", ""),
                quality_score=70,  # Default, will be updated
            )
            self.db.add(product)
            self.db.flush()  # Flush to get product ID

            # Check OpenFoodFacts for food or cosmetics products
            category = product_data.get("category", "").lower()
            if category in ["food", "cosmetics", "beauty"]:
                try:
                    logger.info(f"   🔍 Checking OpenFoodFacts for '{product.name}'...")
                    from src.services.openfoodfacts import openfoodfacts_client

                    # Determine API category
                    api_category = "food" if category == "food" else "cosmetics"

                    # Search for product
                    def search_product():
                        return openfoodfacts_client.search_product(product.name, api_category)

                    off_data = await self._run_in_thread(search_product)

                    if off_data:
                        # Store the data as JSON
                        import json
                        product.openfoodfacts_data = json.dumps(off_data)

                        # Use the quality score from OpenFoodFacts
                        product.quality_score = off_data.get("quality_score", 70)

                        if category == "food":
                            nutriscore = off_data.get("nutriscore", "N/A")
                            nova = off_data.get("nova_group", "N/A")
                            is_healthy = off_data.get("is_healthy", False)
                            logger.info(f"      ✓ NutriScore: {nutriscore}, NOVA: {nova}, Healthy: {is_healthy}, Score: {product.quality_score}")
                        else:
                            logger.info(f"      ✓ Beauty Score: {product.quality_score}/100")
                    else:
                        logger.info(f"      ⚠️  Product not found in OpenFoodFacts database")
                except Exception as e:
                    logger.warning(f"      ⚠️  OpenFoodFacts lookup failed: {str(e)}")

            # Fetch reviews for this product (only if requested)
            if fetch_reviews:
                try:
                    logger.info(f"   🔍 Searching for reviews of '{product.name}'...")
                    reviews_data = await self._run_in_thread(
                        self.ai_client.analyze_product_reviews,
                        influencer.name,
                        product.name,
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
                                    review_date = datetime.strptime(review_item.get("date", ""), "%Y-%m-%d")
                                else:
                                    review_date = None
                            except:
                                review_date = None

                            sentiment = review_item.get("sentiment", "neutral")
                            sentiments.append(sentiment)

                            review = ProductReview(
                                product_id=product.id,
                                author=review_item.get("author", "Anonymous"),
                                comment=review_item.get("comment", ""),
                                platform=review_item.get("platform", ""),
                                sentiment=sentiment,
                                url=review_item.get("url"),
                                date=review_date,
                            )
                            self.db.add(review)

                        # Update review count (limited to 2)
                        product.review_count = len(reviews_list)

                        # Calculate sentiment score (-1 to 1)
                        if sentiments:
                            positive = sentiments.count("positive")
                            negative = sentiments.count("negative")
                            neutral = sentiments.count("neutral")
                            total = len(sentiments)

                            # Sentiment score: (positive - negative) / total
                            product.sentiment_score = (positive - negative) / total
                            logger.info(f"      ✓ Found {product.review_count} reviews (😊 {positive} / 😐 {neutral} / 😞 {negative}) - Sentiment: {product.sentiment_score:.2f}")
                        else:
                            logger.info(f"      ✓ Found {product.review_count} reviews for '{product.name}'")
                except Exception as e:
                    # If review fetching fails, just continue without reviews
                    logger.warning(f"      ⚠️  Failed to fetch reviews for {product.name}: {str(e)}")

        self.db.commit()

    async def _save_timeline(self, influencer: Influencer, data: Dict[str, Any]):
        """Save timeline events to database."""
        # Clear existing timeline
        self.db.query(TimelineEvent).filter(TimelineEvent.influencer_id == influencer.id).delete()

        # Limit to maximum 7 timeline events to control API costs
        timeline_events = data.get("timeline", [])[:7]

        for event_data in timeline_events:
            try:
                event_date = datetime.strptime(event_data.get("date", ""), "%Y-%m-%d")
            except:
                event_date = datetime.utcnow()

            event = TimelineEvent(
                influencer_id=influencer.id,
                date=event_date,
                event_type=event_data.get("type", "achievement"),
                title=event_data.get("title", ""),
                description=event_data.get("description", ""),
                platform=event_data.get("platform", ""),
                views=event_data.get("views"),
                likes=event_data.get("likes"),
                url=event_data.get("url"),
            )
            self.db.add(event)

        self.db.commit()

    async def _save_connections(self, influencer: Influencer, data: Dict[str, Any]):
        """Save connection data to database (both influencers and entities like agencies/brands)."""
        # Clear existing connections
        self.db.query(Connection).filter(Connection.influencer_id == influencer.id).delete()

        for conn_data in data.get("connections", []):
            entity_name = conn_data.get("name", "")
            entity_type = conn_data.get("entity_type", "influencer")
            connection_type = conn_data.get("connection_type", conn_data.get("type", "collaboration"))

            # If it's an influencer, create or link to influencer record
            if entity_type == "influencer":
                # Search by name instead of ID
                connected_influencer = self.db.query(Influencer).filter(
                    Influencer.name.ilike(entity_name)
                ).first()

                if not connected_influencer:
                    logger.info(f"      Creating stub record for connected influencer: {entity_name}")
                    connected_influencer = Influencer(
                        name=entity_name,
                    )
                    self.db.add(connected_influencer)
                    self.db.flush()  # Get auto-generated ID

                    # Skip fetching profile pictures for connected influencers to avoid rate limiting
                    # Their avatars will be fetched if/when user navigates to their profile
                    logger.info(f"      ✓ Created stub record (avatar will be fetched on-demand)")

                connection = Connection(
                    influencer_id=influencer.id,
                    connected_influencer_id=connected_influencer.id,
                    entity_name=entity_name,
                    entity_type=entity_type,
                    connection_type=connection_type,
                    strength=conn_data.get("strength", 1),
                    description=conn_data.get("description", ""),
                )
            else:
                # For non-influencer entities (agencies, brands, etc.)
                connection = Connection(
                    influencer_id=influencer.id,
                    connected_influencer_id=None,
                    entity_name=entity_name,
                    entity_type=entity_type,
                    connection_type=connection_type,
                    strength=conn_data.get("strength", 1),
                    description=conn_data.get("description", ""),
                )

            self.db.add(connection)

        self.db.commit()

    async def _save_news(self, influencer: Influencer, data: Dict[str, Any]):
        """Save news and drama articles to database."""
        # Clear existing news
        self.db.query(NewsArticle).filter(NewsArticle.influencer_id == influencer.id).delete()

        for news_item in data.get("news", []):
            try:
                # Parse date if provided
                if news_item.get("date"):
                    article_date = datetime.strptime(news_item.get("date", ""), "%Y-%m-%d")
                else:
                    article_date = None
            except:
                article_date = None

            article = NewsArticle(
                influencer_id=influencer.id,
                title=news_item.get("title", ""),
                description=news_item.get("description", ""),
                article_type=news_item.get("article_type", "news"),
                date=article_date,
                source=news_item.get("source", ""),
                url=news_item.get("url"),
                sentiment=news_item.get("sentiment", "neutral"),
                severity=news_item.get("severity", 1),
            )
            self.db.add(article)

        self.db.commit()

    async def _fetch_profile_picture(self, influencer_name: str, platforms_data: Dict[str, Any]) -> str:
        """
        Fetch profile picture URL using AI data or image search fallback.

        Args:
            influencer_name: Name of the influencer
            platforms_data: Platform information including profile_picture_url

        Returns:
            Profile picture URL or None
        """
        # Try to use the profile picture URL provided by the AI
        profile_pic_url = platforms_data.get("profile_picture_url")

        if profile_pic_url and isinstance(profile_pic_url, str):
            # Validate the URL actually works
            is_valid = await self._run_in_thread(
                profile_fetcher.validate_url,
                profile_pic_url
            )
            if is_valid:
                logger.info(f"   ✓ Using AI-provided profile picture")
                return profile_pic_url

        # Fallback: Search for profile picture using image search
        logger.info(f"   ⚠ AI didn't provide valid profile picture, searching with Bing/Yandex...")

        # Get primary platform and username for more accurate search
        primary_platform = platforms_data.get("primary_platform", "")
        username = ""

        # Try to get username from the primary platform or first platform
        if platforms_data.get("platforms"):
            for platform in platforms_data["platforms"]:
                if platform.get("platform") == primary_platform:
                    username = platform.get("username", "")
                    break
            # If no primary platform match, use first platform's username
            if not username and platforms_data["platforms"]:
                username = platforms_data["platforms"][0].get("username", "")

        # Search for profile picture using username (more accurate) or name
        search_result = await self._run_in_thread(
            image_search_service.search_profile_picture,
            influencer_name,
            primary_platform,
            username
        )
        if search_result:
            logger.info(f"   ✓ Found profile picture via image search")
            return search_result

        # If all else fails, return None (will show fallback avatar)
        logger.warning(f"   ⚠ Could not find profile picture")
        return None

    async def _download_and_store_image(self, influencer: Influencer, image_url: str):
        """
        Download image from URL and store binary data in database.

        Args:
            influencer: Influencer record to update
            image_url: URL of the image to download
        """
        try:
            import requests
            from io import BytesIO

            # Download image with proper argument handling
            def download_image():
                return requests.get(
                    image_url,
                    timeout=10,
                    headers={'User-Agent': 'Mozilla/5.0'}
                )

            response = await self._run_in_thread(download_image)
            response.raise_for_status()

            # Get content type from response headers
            content_type = response.headers.get('Content-Type', 'image/jpeg')

            # If content type is not an image, try to detect from URL
            if not content_type.startswith('image/'):
                if image_url.lower().endswith('.png'):
                    content_type = 'image/png'
                elif image_url.lower().endswith('.gif'):
                    content_type = 'image/gif'
                elif image_url.lower().endswith('.webp'):
                    content_type = 'image/webp'
                else:
                    content_type = 'image/jpeg'

            # Store image data
            influencer.avatar_data = response.content
            influencer.avatar_content_type = content_type

            logger.info(f"   ✓ Stored {len(response.content)} bytes ({content_type})")

        except Exception as e:
            logger.warning(f"   ⚠ Failed to download image: {str(e)}")
            # Don't fail the whole analysis if image download fails

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

    def _build_response(self, influencer: Influencer) -> Dict[str, Any]:
        """Build complete influencer response."""
        return {
            "id": influencer.id,
            "name": influencer.name,
            "bio": influencer.bio,
            "country": influencer.country,
            "verified": influencer.verified,
            "trust_score": influencer.trust_score,
            "overall_sentiment": influencer.overall_sentiment,
            "avatar_url": influencer.avatar_url,
            "platforms": [
                {
                    "platform": p.platform_name,
                    "username": p.username,
                    "followers": p.follower_count,
                    "verified": p.verified,
                    "url": p.url,
                }
                for p in influencer.platforms
            ],
            "timeline": [
                {
                    "id": str(t.id),
                    "date": t.date.isoformat(),
                    "type": t.event_type,
                    "title": t.title,
                    "description": t.description,
                    "platform": t.platform,
                    "views": t.views,
                    "likes": t.likes,
                }
                for t in sorted(
                    influencer.timeline,
                    key=lambda x: x.date if x.date else datetime.min
                )
            ],
            "products": [
                {
                    "id": p.id,
                    "name": p.name,
                    "category": p.category,
                    "quality_score": p.quality_score,
                    "description": p.description,
                    "review_count": p.review_count,
                    "sentiment_score": p.sentiment_score,
                    "openfoodfacts_data": json.loads(p.openfoodfacts_data) if p.openfoodfacts_data else None,
                    "reviews": [
                        {
                            "author": r.author,
                            "comment": r.comment,
                            "platform": r.platform,
                            "sentiment": r.sentiment,
                            "url": r.url,
                            "date": r.date.isoformat() if r.date else None,
                        }
                        for r in p.reviews
                    ],
                }
                for p in influencer.products
            ],
            "connections": [
                {
                    "name": c.entity_name or (c.connected_influencer.name if c.connected_influencer else "Unknown"),
                    "entity_type": c.entity_type or "influencer",
                    "type": c.connection_type,
                    "strength": c.strength,
                    "description": c.description,
                }
                for c in influencer.connections
            ],
            "news": [
                {
                    "id": n.id,
                    "title": n.title,
                    "description": n.description,
                    "article_type": n.article_type,
                    "date": n.date.isoformat() if n.date else None,
                    "source": n.source,
                    "url": n.url,
                    "sentiment": n.sentiment,
                    "severity": n.severity,
                }
                for n in sorted(influencer.news_articles, key=lambda x: (x.date or datetime.min), reverse=True)
            ],
            "last_analyzed": influencer.last_analyzed.isoformat() if influencer.last_analyzed else None,
            "analysis_complete": influencer.analysis_complete,
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
        product = self.db.query(Product).filter(Product.id == product_id).first()
        if not product:
            raise ValueError(f"Product with ID {product_id} not found")

        influencer = self.db.query(Influencer).filter(Influencer.id == product.influencer_id).first()
        if not influencer:
            raise ValueError(f"Influencer not found for product {product_id}")

        # Get platform data
        platforms_data = {
            "platforms": [
                {
                    "platform": p.platform_name,
                    "username": p.username,
                    "followers": p.follower_count,
                    "url": p.url
                }
                for p in influencer.platforms
            ]
        }

        # Clear existing reviews
        self.db.query(ProductReview).filter(ProductReview.product_id == product_id).delete()

        # Fetch reviews from AI
        logger.info(f"🔍 Fetching reviews for: {product.name}")
        reviews_data = await self._run_in_thread(
            self.ai_client.analyze_product_reviews,
            influencer.name,
            product.name,
            platforms_data
        )

        # Save reviews
        if isinstance(reviews_data, dict) and reviews_data.get("reviews"):
            sentiments = []
            reviews_list = reviews_data.get("reviews", [])[:2]

            for review_item in reviews_list:
                try:
                    if review_item.get("date"):
                        review_date = datetime.strptime(review_item.get("date", ""), "%Y-%m-%d")
                    else:
                        review_date = None
                except:
                    review_date = None

                sentiment = review_item.get("sentiment", "neutral")
                sentiments.append(sentiment)

                review = ProductReview(
                    product_id=product.id,
                    author=review_item.get("author", "Anonymous"),
                    comment=review_item.get("comment", ""),
                    platform=review_item.get("platform", ""),
                    sentiment=sentiment,
                    url=review_item.get("url"),
                    date=review_date,
                )
                self.db.add(review)

            product.review_count = len(reviews_list)

            if sentiments:
                positive = sentiments.count("positive")
                negative = sentiments.count("negative")
                neutral = sentiments.count("neutral")
                total = len(sentiments)
                product.sentiment_score = (positive - negative) / total

            self.db.commit()
            logger.info(f"   ✓ Saved {len(reviews_list)} reviews")

        return {
            "product_id": product_id,
            "product_name": product.name,
            "review_count": product.review_count,
            "sentiment_score": product.sentiment_score,
            "reviews": [
                {
                    "id": r.id,
                    "author": r.author,
                    "comment": r.comment,
                    "platform": r.platform,
                    "sentiment": r.sentiment,
                    "url": r.url,
                    "date": r.date.isoformat() if r.date else None,
                }
                for r in product.reviews
            ]
        }

    async def fetch_connections(self, influencer_id: int) -> Dict[str, Any]:
        """
        Fetch network map/connections on-demand for an influencer.

        Args:
            influencer_id: ID of the influencer

        Returns:
            Dict with connections data
        """
        influencer = self.db.query(Influencer).filter(Influencer.id == influencer_id).first()
        if not influencer:
            raise ValueError(f"Influencer with ID {influencer_id} not found")

        # Get platform data
        platforms_data = {
            "platforms": [
                {
                    "platform": p.platform_name,
                    "username": p.username,
                    "followers": p.follower_count,
                    "url": p.url
                }
                for p in influencer.platforms
            ]
        }

        # Fetch connections from AI
        logger.info(f"🔍 Fetching network map for: {influencer.name}")
        connections_data = await self._run_in_thread(
            self.ai_client.analyze_connections,
            influencer.name,
            platforms_data
        )

        # Save connections
        if isinstance(connections_data, dict):
            await self._save_connections(influencer, connections_data)
            logger.info(f"   ✓ Saved network map")

        return {
            "influencer_id": influencer_id,
            "connections": [
                {
                    "id": c.id,
                    "entity_name": c.entity_name,
                    "entity_type": c.entity_type,
                    "connection_type": c.connection_type,
                    "strength": c.strength,
                    "description": c.description,
                    "connected_influencer_id": c.connected_influencer_id,
                }
                for c in influencer.connections
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
        product = self.db.query(Product).filter(Product.id == product_id).first()
        if not product:
            raise ValueError(f"Product with ID {product_id} not found")

        category = product.category.lower() if product.category else ""
        if category not in ["food", "cosmetics", "beauty"]:
            return {
                "product_id": product_id,
                "product_name": product.name,
                "category": product.category,
                "error": "Product category must be 'food', 'cosmetics', or 'beauty' for OpenFoodFacts lookup"
            }

        logger.info(f"🔍 Fetching OpenFoodFacts data for: {product.name}")

        from src.services.openfoodfacts import openfoodfacts_client

        # Determine API category
        api_category = "food" if category == "food" else "cosmetics"

        # Search for product
        def search_product():
            return openfoodfacts_client.search_product(product.name, api_category)

        off_data = await self._run_in_thread(search_product)

        if off_data:
            # Store the data as JSON
            import json
            product.openfoodfacts_data = json.dumps(off_data)
            product.quality_score = off_data.get("quality_score", 70)
            self.db.commit()

            logger.info(f"   ✓ Updated OpenFoodFacts data (quality score: {product.quality_score})")

            return {
                "product_id": product_id,
                "product_name": product.name,
                "category": product.category,
                "openfoodfacts_data": off_data,
                "quality_score": product.quality_score
            }
        else:
            return {
                "product_id": product_id,
                "product_name": product.name,
                "category": product.category,
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

    async def _save_reputation(self, influencer: Influencer, data: Dict[str, Any]):
        """Save reputation comments to database."""
        # Clear existing reputation comments
        self.db.query(ReputationComment).filter(ReputationComment.influencer_id == influencer.id).delete()

        # Save overall sentiment to influencer record
        overall_sentiment = data.get("overall_sentiment", "neutral")
        influencer.overall_sentiment = overall_sentiment

        # Limit to maximum 10 comments
        comments = data.get("comments", [])[:10]

        for comment_data in comments:
            try:
                comment_date = datetime.strptime(comment_data.get("date", ""), "%Y-%m-%d")
            except:
                comment_date = None

            comment = ReputationComment(
                influencer_id=influencer.id,
                author=comment_data.get("author", ""),
                comment=comment_data.get("comment", ""),
                platform=comment_data.get("platform", ""),
                sentiment=comment_data.get("sentiment", "neutral"),
                url=comment_data.get("url"),
                date=comment_date,
            )
            self.db.add(comment)

        self.db.commit()
