"""Influencer analyzer orchestrator."""
import asyncio
import logging
from datetime import datetime, timedelta
from typing import Any, Dict

from sqlalchemy.orm import Session

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
    TimelineEvent,
)
from src.config.settings import settings
from src.services.blackbox_client import blackbox_client
from src.services.perplexity_client import perplexity_client
from src.services.profile_fetcher import profile_fetcher
from src.services.image_search import image_search_service


class InfluencerAnalyzer:
    """Orchestrates real-time influencer analysis."""

    def __init__(self, db: Session):
        """Initialize analyzer with database session."""
        self.db = db

        # Select AI provider based on settings
        if settings.ai_provider == "perplexity":
            self.ai_client = perplexity_client
        else:
            self.ai_client = blackbox_client

    async def analyze_influencer(self, influencer_name: str) -> Dict[str, Any]:
        """
        Perform complete real-time analysis of an influencer.

        Args:
            influencer_name: Name of the influencer to analyze

        Returns:
            Complete influencer profile data
        """
        logger.info(f"🔍 Starting analysis for: {influencer_name}")

        # Check if influencer exists in cache
        influencer = self.db.query(Influencer).filter(
            Influencer.name.ilike(f"%{influencer_name}%")
        ).first()

        # If cached and not expired, return cached data
        if influencer and influencer.cache_expires and influencer.cache_expires > datetime.utcnow():
            logger.info(f"✅ Returning cached data for: {influencer_name}")
            return self._build_response(influencer)

        # If analysis is in progress, return status
        if influencer and influencer.is_analyzing:
            logger.info(f"⏳ Analysis already in progress for: {influencer_name}")
            return {
                "status": "analyzing",
                "message": "Analysis in progress, please wait...",
                "influencer_id": influencer.id
            }

        # Create or update influencer record
        if not influencer:
            influencer = Influencer(
                name=influencer_name,
                is_analyzing=True,
                last_analyzed=datetime.utcnow(),
                cache_expires=datetime.utcnow() + timedelta(days=1),  # Cache for 24 hours
            )
            self.db.add(influencer)
            self.db.flush()  # Flush to get the auto-generated ID
            self.db.commit()
        else:
            influencer.is_analyzing = True
            influencer.last_analyzed = datetime.utcnow()
            self.db.commit()

        try:
            # Run all analysis tasks in parallel
            logger.info(f"📱 Step 1/6: Discovering social media platforms for {influencer_name}...")
            platforms_data = await self._run_in_thread(
                self.ai_client.analyze_influencer_platforms,
                influencer_name
            )
            logger.info(f"   ✓ Found {len(platforms_data.get('platforms', []))} platforms")

            # Validate that influencer exists - check if we found any real platforms
            if not platforms_data.get("platforms") or len(platforms_data.get("platforms", [])) == 0:
                # No platforms found = influencer doesn't exist or couldn't be verified
                logger.warning(f"❌ No platforms found for {influencer_name} - influencer may not exist")
                influencer.is_analyzing = False
                self.db.commit()

                # Clean up the influencer record if it was just created
                if not influencer.analysis_complete:
                    self.db.delete(influencer)
                    self.db.commit()

                raise Exception(f"Influencer '{influencer_name}' not found. Please verify the name and try again.")

            # Check if AI explicitly returned an error
            if platforms_data.get("error"):
                logger.warning(f"❌ Error from AI: {platforms_data.get('error')}")
                influencer.is_analyzing = False
                self.db.commit()

                if not influencer.analysis_complete:
                    self.db.delete(influencer)
                    self.db.commit()

                raise Exception(f"Influencer '{influencer_name}' not found: {platforms_data.get('error')}")

            # Save platform data
            if platforms_data.get("platforms"):
                logger.info(f"💾 Saving platform data...")
                await self._save_platforms(influencer, platforms_data)
                influencer.bio = platforms_data.get("bio", "")

                # Fetch profile picture directly from platforms
                logger.info(f"🖼️  Fetching profile picture...")
                avatar_url = await self._fetch_profile_picture(influencer_name, platforms_data)
                influencer.avatar_url = avatar_url

                # Download and store the actual image data
                if avatar_url:
                    logger.info(f"   📥 Downloading image from: {avatar_url}")
                    await self._download_and_store_image(influencer, avatar_url)

            # Run remaining analyses in parallel
            logger.info(f"🔄 Step 2/6: Running parallel analyses (products, timeline, connections, news)...")
            results = await asyncio.gather(
                self._run_in_thread(self.ai_client.analyze_products, influencer_name, platforms_data),
                self._run_in_thread(self.ai_client.analyze_breakthrough_moment, influencer_name, platforms_data),
                self._run_in_thread(self.ai_client.analyze_connections, influencer_name, platforms_data),
                self._run_in_thread(self.ai_client.analyze_news_drama, influencer_name, platforms_data),
                return_exceptions=True
            )
            logger.info(f"   ✓ Parallel analyses complete")

            products_data, timeline_data, connections_data, news_data = results

            # Save all data
            if isinstance(products_data, dict):
                logger.info(f"📦 Step 3/6: Saving products and fetching reviews...")
                await self._save_products(influencer, products_data, platforms_data)
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

            # Calculate trust score (basic for now)
            logger.info(f"🎯 Calculating trust score...")
            influencer.trust_score = self._calculate_trust_score(platforms_data, products_data)
            influencer.is_analyzing = False
            influencer.analysis_complete = True
            self.db.commit()

            logger.info(f"✅ Analysis complete for {influencer_name}! Trust score: {influencer.trust_score}")
            return self._build_response(influencer)

        except Exception as e:
            logger.error(f"❌ Analysis failed for {influencer_name}: {str(e)}")
            influencer.is_analyzing = False
            self.db.commit()
            raise Exception(f"Analysis failed: {str(e)}")

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

    async def _save_products(self, influencer: Influencer, data: Dict[str, Any], platforms_data: Dict[str, Any]):
        """Save product data to database and fetch reviews."""
        # Clear existing products and their reviews
        self.db.query(Product).filter(Product.influencer_id == influencer.id).delete()

        for product_data in data.get("products", []):
            product = Product(
                influencer_id=influencer.id,
                name=product_data.get("name", ""),
                category=product_data.get("category", ""),
                description=product_data.get("description", ""),
                quality_score=70,  # Default, will be updated by sentiment analysis
            )
            self.db.add(product)
            self.db.flush()  # Flush to get product ID

            # Fetch reviews for this product
            try:
                logger.info(f"   🔍 Searching for reviews of '{product.name}'...")
                reviews_data = await self._run_in_thread(
                    self.ai_client.analyze_product_reviews,
                    influencer.name,
                    product.name,
                    platforms_data
                )

                if isinstance(reviews_data, dict) and reviews_data.get("reviews"):
                    for review_item in reviews_data.get("reviews", []):
                        try:
                            # Parse date if provided
                            if review_item.get("date"):
                                review_date = datetime.strptime(review_item.get("date", ""), "%Y-%m-%d")
                            else:
                                review_date = None
                        except:
                            review_date = None

                        review = ProductReview(
                            product_id=product.id,
                            author=review_item.get("author", "Anonymous"),
                            comment=review_item.get("comment", ""),
                            platform=review_item.get("platform", ""),
                            sentiment=review_item.get("sentiment", "neutral"),
                            url=review_item.get("url"),
                            date=review_date,
                        )
                        self.db.add(review)

                    # Update review count
                    product.review_count = len(reviews_data.get("reviews", []))
                    logger.info(f"      ✓ Found {product.review_count} reviews for '{product.name}'")
            except Exception as e:
                # If review fetching fails, just continue without reviews
                logger.warning(f"      ⚠️  Failed to fetch reviews for {product.name}: {str(e)}")

        self.db.commit()

    async def _save_timeline(self, influencer: Influencer, data: Dict[str, Any]):
        """Save timeline events to database."""
        # Clear existing timeline
        self.db.query(TimelineEvent).filter(TimelineEvent.influencer_id == influencer.id).delete()

        for event_data in data.get("timeline", []):
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

                    # Fetch profile picture for the connected influencer
                    try:
                        logger.info(f"      Fetching profile picture for {entity_name}...")
                        # Use image search to find their profile picture
                        from src.services.image_search import image_search_service

                        def search_for_connected():
                            return image_search_service.search_profile_picture(
                                entity_name,
                                "",  # No platform info available
                                ""   # No username available
                            )

                        avatar_url = await self._run_in_thread(search_for_connected)

                        if avatar_url:
                            connected_influencer.avatar_url = avatar_url
                            logger.info(f"      Downloading image for {entity_name}...")
                            await self._download_and_store_image(connected_influencer, avatar_url)
                            logger.info(f"      ✓ Saved profile picture for {entity_name}")
                        else:
                            logger.info(f"      ⚠ Could not find profile picture for {entity_name}")
                    except Exception as e:
                        logger.warning(f"      ⚠ Failed to fetch profile picture for {entity_name}: {str(e)}")

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
            "verified": influencer.verified,
            "trust_score": influencer.trust_score,
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
                    "name": p.name,
                    "category": p.category,
                    "quality_score": p.quality_score,
                    "description": p.description,
                    "review_count": p.review_count,
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
