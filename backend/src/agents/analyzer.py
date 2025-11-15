"""Influencer analyzer orchestrator."""
import asyncio
from datetime import datetime, timedelta
from typing import Any, Dict

from sqlalchemy.orm import Session

from src.models.database import (
    Connection,
    Influencer,
    Platform,
    Product,
    TimelineEvent,
)
from src.services.blackbox_client import blackbox_client


class InfluencerAnalyzer:
    """Orchestrates real-time influencer analysis."""

    def __init__(self, db: Session):
        """Initialize analyzer with database session."""
        self.db = db
        self.blackbox = blackbox_client

    async def analyze_influencer(self, influencer_name: str) -> Dict[str, Any]:
        """
        Perform complete real-time analysis of an influencer.

        Args:
            influencer_name: Name of the influencer to analyze

        Returns:
            Complete influencer profile data
        """
        # Check if influencer exists in cache
        influencer = self.db.query(Influencer).filter(
            Influencer.name.ilike(f"%{influencer_name}%")
        ).first()

        # If cached and not expired, return cached data
        if influencer and influencer.cache_expires and influencer.cache_expires > datetime.utcnow():
            return self._build_response(influencer)

        # If analysis is in progress, return status
        if influencer and influencer.is_analyzing:
            return {
                "status": "analyzing",
                "message": "Analysis in progress, please wait...",
                "influencer_id": influencer.id
            }

        # Create or update influencer record
        if not influencer:
            influencer = Influencer(
                id=influencer_name.lower().replace(" ", "_"),
                name=influencer_name,
                is_analyzing=True,
                last_analyzed=datetime.utcnow(),
                cache_expires=datetime.utcnow() + timedelta(days=1),  # Cache for 24 hours
            )
            self.db.add(influencer)
            self.db.commit()
        else:
            influencer.is_analyzing = True
            influencer.last_analyzed = datetime.utcnow()
            self.db.commit()

        try:
            # Run all analysis tasks in parallel
            platforms_data = await self._run_in_thread(
                self.blackbox.analyze_influencer_platforms,
                influencer_name
            )

            # Save platform data
            if platforms_data.get("platforms"):
                await self._save_platforms(influencer, platforms_data)
                influencer.bio = platforms_data.get("bio", "")

            # Run remaining analyses in parallel
            results = await asyncio.gather(
                self._run_in_thread(self.blackbox.analyze_products, influencer_name, platforms_data),
                self._run_in_thread(self.blackbox.analyze_breakthrough_moment, influencer_name, platforms_data),
                self._run_in_thread(self.blackbox.analyze_connections, influencer_name, platforms_data),
                return_exceptions=True
            )

            products_data, timeline_data, connections_data = results

            # Save all data
            if isinstance(products_data, dict):
                await self._save_products(influencer, products_data)

            if isinstance(timeline_data, dict):
                await self._save_timeline(influencer, timeline_data)

            if isinstance(connections_data, dict):
                await self._save_connections(influencer, connections_data)

            # Calculate trust score (basic for now)
            influencer.trust_score = self._calculate_trust_score(platforms_data, products_data)
            influencer.is_analyzing = False
            influencer.analysis_complete = True
            self.db.commit()

            return self._build_response(influencer)

        except Exception as e:
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

    async def _save_products(self, influencer: Influencer, data: Dict[str, Any]):
        """Save product data to database."""
        for product_data in data.get("products", []):
            product = Product(
                influencer_id=influencer.id,
                name=product_data.get("name", ""),
                category=product_data.get("category", ""),
                description=product_data.get("description", ""),
                quality_score=70,  # Default, will be updated by sentiment analysis
            )
            self.db.add(product)

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
        """Save connection data to database."""
        for conn_data in data.get("connections", []):
            # Create connected influencer if doesn't exist
            connected_name = conn_data.get("name", "")
            connected_id = connected_name.lower().replace(" ", "_")

            connected_influencer = self.db.query(Influencer).filter(
                Influencer.id == connected_id
            ).first()

            if not connected_influencer:
                connected_influencer = Influencer(
                    id=connected_id,
                    name=connected_name,
                )
                self.db.add(connected_influencer)
                self.db.commit()

            connection = Connection(
                influencer_id=influencer.id,
                connected_influencer_id=connected_influencer.id,
                connection_type=conn_data.get("type", "collaboration"),
                strength=conn_data.get("strength", 1),
                description=conn_data.get("description", ""),
            )
            self.db.add(connection)

        self.db.commit()

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
                for t in sorted(influencer.timeline, key=lambda x: x.date)
            ],
            "products": [
                {
                    "name": p.name,
                    "category": p.category,
                    "quality_score": p.quality_score,
                    "description": p.description,
                }
                for p in influencer.products
            ],
            "connections": [
                {
                    "name": c.connected_influencer.name,
                    "type": c.connection_type,
                    "strength": c.strength,
                    "description": c.description,
                }
                for c in influencer.connections
            ],
            "last_analyzed": influencer.last_analyzed.isoformat() if influencer.last_analyzed else None,
            "analysis_complete": influencer.analysis_complete,
        }
