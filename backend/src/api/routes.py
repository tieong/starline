"""API routes."""
from datetime import datetime
from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException, Query
from fastapi.responses import Response
from pydantic import BaseModel, Field
from sqlalchemy.orm import Session

from src.agents.analyzer import InfluencerAnalyzer
from src.models.database import Influencer, NewsArticle, get_db

router = APIRouter()


# ============= Request Models =============

class InfluencerSearchRequest(BaseModel):
    """Request model for influencer search."""
    name: str = Field(..., description="Name of the influencer to analyze", example="MrBeast")


# ============= Response Models =============

class PlatformResponse(BaseModel):
    """Social media platform information."""
    platform: str = Field(..., description="Platform name", example="youtube")
    username: str = Field(..., description="Username/handle", example="@MrBeast")
    followers: int = Field(..., description="Follower count", example=250000000)
    verified: bool = Field(..., description="Whether account is verified", example=True)
    url: str = Field(..., description="Profile URL", example="https://youtube.com/@MrBeast")

    class Config:
        json_schema_extra = {
            "example": {
                "platform": "youtube",
                "username": "@MrBeast",
                "followers": 250000000,
                "verified": True,
                "url": "https://youtube.com/@MrBeast"
            }
        }


class ProductReviewResponse(BaseModel):
    """User review of a product."""
    author: str = Field(..., description="Review author username")
    comment: str = Field(..., description="Review text")
    platform: str = Field(..., description="Platform where review was posted")
    sentiment: str = Field(..., description="Sentiment: positive, negative, or neutral")
    url: Optional[str] = Field(None, description="URL to original review")
    date: Optional[str] = Field(None, description="Review date")


class ProductResponse(BaseModel):
    """Product sold/promoted by influencer."""
    id: int = Field(..., description="Product ID")
    name: str = Field(..., description="Product name", example="Feastables Chocolate Bar")
    category: str = Field(..., description="Product category", example="food")
    quality_score: Optional[int] = Field(None, description="Quality score 0-100", example=85)
    description: str = Field(..., description="Product description")
    review_count: int = Field(0, description="Number of reviews")
    sentiment_score: Optional[float] = Field(None, description="Average sentiment -1 to 1")
    openfoodfacts_data: Optional[dict] = Field(None, description="OpenFoodFacts nutritional data (if available)")
    reviews: List[ProductReviewResponse] = Field(default_factory=list, description="User reviews")

    class Config:
        json_schema_extra = {
            "example": {
                "id": 1,
                "name": "Feastables Chocolate Bar",
                "category": "food",
                "quality_score": 85,
                "description": "Premium chocolate bar brand created by MrBeast",
                "review_count": 0,
                "sentiment_score": None,
                "openfoodfacts_data": None,
                "reviews": []
            }
        }


class TimelineEventResponse(BaseModel):
    """Timeline/milestone event."""
    id: int
    date: str = Field(..., description="Event date (ISO format)")
    type: str = Field(..., description="Event type", example="video")
    title: str = Field(..., description="Event title")
    description: str = Field(..., description="Event description")
    platform: str = Field(..., description="Platform where event occurred")
    views: Optional[int] = Field(None, description="View count if applicable")
    likes: Optional[int] = Field(None, description="Like count if applicable")
    url: Optional[str] = Field(None, description="URL to event/content")


class ConnectionResponse(BaseModel):
    """Network connection (collaborator, agency, brand, etc)."""
    name: str = Field(..., description="Entity name", example="Night Media")
    entity_type: str = Field(..., description="Entity type", example="management")
    type: str = Field(..., description="Connection type", example="managed_by")
    strength: int = Field(..., description="Connection strength 1-10", example=10)
    description: str = Field(..., description="Connection description")

    class Config:
        json_schema_extra = {
            "example": {
                "name": "Night Media",
                "entity_type": "management",
                "type": "managed_by",
                "strength": 10,
                "description": "Talent management company"
            }
        }


class NewsArticleResponse(BaseModel):
    """News article or drama."""
    id: int
    title: str = Field(..., description="Article title")
    description: str = Field(..., description="Article description")
    article_type: str = Field(..., description="Article type", example="news")
    date: Optional[str] = Field(None, description="Article date")
    source: str = Field(..., description="News source")
    url: Optional[str] = Field(None, description="Article URL")
    sentiment: str = Field(..., description="Sentiment: positive, negative, or neutral")
    severity: int = Field(..., description="Severity 1-10", example=5)


class InfluencerResponse(BaseModel):
    """Complete influencer profile."""
    id: int = Field(..., description="Influencer ID")
    name: str = Field(..., description="Influencer name", example="MrBeast")
    bio: Optional[str] = Field(None, description="Biography")
    country: Optional[str] = Field(None, description="Country", example="USA")
    verified: bool = Field(False, description="Whether influencer is verified")
    trust_score: int = Field(0, description="Trust score 0-100 (0 means not calculated yet)")
    avatar_url: Optional[str] = Field(None, description="Avatar image URL")
    platforms: List[PlatformResponse] = Field(default_factory=list, description="Social media platforms")
    timeline: List[TimelineEventResponse] = Field(default_factory=list, description="Timeline events")
    products: List[ProductResponse] = Field(default_factory=list, description="Products sold/promoted")
    connections: List[ConnectionResponse] = Field(default_factory=list, description="Network connections")
    news: List[NewsArticleResponse] = Field(default_factory=list, description="News articles")
    last_analyzed: Optional[str] = Field(None, description="Last analysis timestamp")
    analysis_complete: bool = Field(False, description="Whether analysis is complete")

    class Config:
        json_schema_extra = {
            "example": {
                "id": 1,
                "name": "MrBeast",
                "bio": "American YouTuber known for expensive stunts and philanthropy",
                "country": "USA",
                "verified": True,
                "trust_score": 95,
                "avatar_url": "https://example.com/avatar.jpg",
                "platforms": [
                    {
                        "platform": "youtube",
                        "username": "@MrBeast",
                        "followers": 250000000,
                        "verified": True,
                        "url": "https://youtube.com/@MrBeast"
                    }
                ],
                "timeline": [],
                "products": [
                    {
                        "id": 1,
                        "name": "Feastables",
                        "category": "food",
                        "quality_score": 85,
                        "description": "Premium chocolate brand",
                        "review_count": 0,
                        "sentiment_score": None,
                        "openfoodfacts_data": None,
                        "reviews": []
                    }
                ],
                "connections": [],
                "news": [],
                "last_analyzed": "2025-11-15T12:00:00",
                "analysis_complete": True
            }
        }


class TopInfluencersResponse(BaseModel):
    """Response for top influencers endpoint."""
    country: str = Field(..., description="Country filter used", example="FR")
    limit: int = Field(..., description="Limit requested", example=5)
    count: int = Field(..., description="Number of influencers returned", example=5)
    auto_discovered: bool = Field(..., description="Whether auto-discovery was triggered")
    newly_analyzed_count: Optional[int] = Field(None, description="Number of newly analyzed influencers")
    requested: int = Field(..., description="Number of influencers requested")
    influencers: List[InfluencerResponse] = Field(..., description="List of influencers")

    class Config:
        json_schema_extra = {
            "example": {
                "country": "FR",
                "limit": 5,
                "count": 5,
                "auto_discovered": False,
                "newly_analyzed_count": 0,
                "requested": 5,
                "influencers": [
                    {
                        "id": 1,
                        "name": "Tibo InShape",
                        "bio": "French fitness YouTuber",
                        "country": "France",
                        "verified": False,
                        "trust_score": 0,
                        "avatar_url": None,
                        "platforms": [
                            {
                                "platform": "youtube",
                                "username": "@TiboInShape",
                                "followers": 26800000,
                                "verified": True,
                                "url": "https://youtube.com/@TiboInShape"
                            }
                        ],
                        "timeline": [],
                        "products": [],
                        "connections": [],
                        "news": [],
                        "last_analyzed": "2025-11-15T12:00:00",
                        "analysis_complete": True
                    }
                ]
            }
        }


class SearchResultInfluencer(BaseModel):
    """Influencer search result (simplified profile)."""
    id: int = Field(..., description="Influencer ID")
    name: str = Field(..., description="Influencer name", example="MrBeast")
    bio: Optional[str] = Field(None, description="Biography")
    country: Optional[str] = Field(None, description="Country", example="USA")
    trust_score: int = Field(0, description="Trust score 0-100")
    avatar_url: Optional[str] = Field(None, description="Avatar image URL")
    platforms: List[dict] = Field(default_factory=list, description="Simplified platform list")

    class Config:
        json_schema_extra = {
            "example": {
                "id": 1,
                "name": "MrBeast",
                "bio": "American YouTuber known for expensive stunts",
                "country": "USA",
                "trust_score": 95,
                "avatar_url": "https://example.com/avatar.jpg",
                "platforms": [
                    {"platform": "youtube", "followers": 250000000}
                ]
            }
        }


class SearchInfluencersResponse(BaseModel):
    """Response for search endpoint."""
    results: List[SearchResultInfluencer] = Field(..., description="Search results")

    class Config:
        json_schema_extra = {
            "example": {
                "results": [
                    {
                        "id": 1,
                        "name": "MrBeast",
                        "bio": "American YouTuber",
                        "country": "USA",
                        "trust_score": 95,
                        "avatar_url": "https://example.com/avatar.jpg",
                        "platforms": [
                            {"platform": "youtube", "followers": 250000000}
                        ]
                    }
                ]
            }
        }


class TrendingInfluencer(BaseModel):
    """Trending influencer (includes trending_score)."""
    id: int = Field(..., description="Influencer ID")
    name: str = Field(..., description="Influencer name", example="MrBeast")
    bio: Optional[str] = Field(None, description="Biography")
    country: Optional[str] = Field(None, description="Country", example="USA")
    trust_score: int = Field(0, description="Trust score 0-100")
    trending_score: int = Field(0, description="Trending score (higher = more trending)")
    avatar_url: Optional[str] = Field(None, description="Avatar image URL")
    platforms: List[dict] = Field(default_factory=list, description="Simplified platform list")


class TrendingInfluencersResponse(BaseModel):
    """Response for trending endpoint."""
    trending: List[TrendingInfluencer] = Field(..., description="Trending influencers")

    class Config:
        json_schema_extra = {
            "example": {
                "trending": [
                    {
                        "id": 1,
                        "name": "MrBeast",
                        "bio": "American YouTuber",
                        "country": "USA",
                        "trust_score": 95,
                        "trending_score": 100,
                        "avatar_url": "https://example.com/avatar.jpg",
                        "platforms": [
                            {"platform": "youtube", "followers": 250000000}
                        ]
                    }
                ]
            }
        }


@router.get("/")
async def root():
    """Root endpoint."""
    return {
        "message": "Starline Backend API",
        "version": "0.1.0",
        "docs": "/docs"
    }


@router.get("/health")
async def health_check():
    """Health check endpoint."""
    return {"status": "healthy"}


@router.post(
    "/api/influencers/analyze",
    response_model=None,  # Dynamic response based on analysis_level
    summary="Analyze an influencer",
    description="""
Analyze an influencer in real-time using AI-powered web search.

**Analysis Levels:**
- `platforms_only`: Only platforms and profile picture (for top lists) - ~1,200 tokens
- `basic`: Platforms + products + trust score (for profile view) - ~2,100 tokens
- `full`: Everything (timeline, news, connections) - ~4,000+ tokens

**Workflow:**
1. Checks if influencer is cached and analysis is complete
2. If not cached, triggers real-time AI analysis via Perplexity
3. Returns complete profile data based on analysis_level

**Note:** For top influencer lists, use `platforms_only` to minimize token usage.
Products, timeline, and other data can be fetched on-demand when viewing the profile.
""",
    tags=["Influencers"],
)
async def analyze_influencer(
    request: InfluencerSearchRequest,
    analysis_level: str = Query(
        "basic",
        description="Analysis depth: 'platforms_only', 'basic', or 'full'",
        enum=["platforms_only", "basic", "full"]
    ),
    db: Session = Depends(get_db)
):
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.analyze_influencer(request.name, analysis_level=analysis_level)
        return result
    except Exception as e:
        import logging
        import traceback
        logger = logging.getLogger(__name__)

        error_msg = str(e)
        error_traceback = traceback.format_exc()

        # Log the error with full details
        logger.error(f"API /analyze failed for '{request.name}': {error_msg}")
        logger.debug(f"Full traceback:\n{error_traceback}")

        # Return 404 for "not found" errors, 500 for other errors
        if "not found" in error_msg.lower():
            raise HTTPException(status_code=404, detail=error_msg)
        else:
            raise HTTPException(status_code=500, detail=error_msg)


@router.get(
    "/api/influencers/search",
    response_model=None,
    summary="Search influencers",
    description="""
Search for influencers in the database by name.

**Note:** Only returns influencers with completed analyses (cached data).
For new influencer analysis, use the `/api/influencers/analyze` endpoint.

**Returns:** List of matching influencers with basic information (platforms, trust score, etc.)
""",
    tags=["Influencers"],
)
async def search_influencers(
    q: str = Query(..., description="Search query (influencer name)", example="MrBeast"),
    db: Session = Depends(get_db)
):
    # Only return influencers with completed analysis
    # Avoid partial matches for very short queries
    influencers = db.query(Influencer).filter(
        Influencer.name.ilike(f"%{q}%"),
        Influencer.analysis_complete == True  # Only show completed analyses
    ).limit(10).all()

    return {
        "results": [
            {
                "id": inf.id,
                "name": inf.name,
                "bio": inf.bio,
                "country": inf.country,
                "trust_score": inf.trust_score,
                "avatar_url": inf.avatar_url,
                "platforms": [
                    {
                        "platform": p.platform_name,
                        "followers": p.follower_count
                    }
                    for p in inf.platforms
                ]
            }
            for inf in influencers
        ]
    }


@router.get(
    "/api/influencers/trending",
    response_model=None,
    summary="Get trending influencers",
    description="""
Get trending influencers sorted by trending score.

**Returns:** List of influencers with trending scores, ordered by trending_score (highest first).

**Note:** Only returns influencers with trending_score > 0.
""",
    tags=["Influencers"],
)
async def get_trending(
    limit: int = Query(10, description="Maximum number of trending influencers to return", ge=1, le=100),
    db: Session = Depends(get_db)
):
    influencers = db.query(Influencer).filter(
        Influencer.trending_score > 0
    ).order_by(
        Influencer.trending_score.desc()
    ).limit(limit).all()

    return {
        "trending": [
            {
                "id": inf.id,
                "name": inf.name,
                "bio": inf.bio,
                "country": inf.country,
                "trust_score": inf.trust_score,
                "trending_score": inf.trending_score,
                "avatar_url": inf.avatar_url,
                "platforms": [
                    {
                        "platform": p.platform_name,
                        "followers": p.follower_count
                    }
                    for p in inf.platforms
                ]
            }
            for inf in influencers
        ]
    }


@router.get(
    "/api/influencers/top",
    response_model=None,
    summary="Get top influencers",
    description="""
Get top N influencers globally or by country (default: 5).

**Analysis Level:** Uses `platforms_only` mode for auto-discovered influencers to minimize token usage (~1,200 tokens per influencer).
When viewing individual profiles, the frontend automatically fetches products and calculates trust score.

**Query Parameters:**
- `country`: ISO country code (FR, US, UK) or full name (France, United States) - optional
- `limit`: Number of influencers to return (default: 5, max: 50)
- `auto_discover`: Auto-discover new influencers if database is insufficient (default: true)

**Workflow:**
1. Query database for cached influencers matching filters
2. If insufficient results and auto_discover=true:
   - Discover top influencers via AI
   - Analyze them with platforms_only mode
   - Return combined results

**Returns:** Influencers sorted by total followers (descending).

**Response Fields:**
- `auto_discovered`: Whether new influencers were discovered during this request
- `newly_analyzed_count`: Number of newly analyzed influencers
- `count`: Actual number of influencers returned
- `requested`: Number requested (may differ from count if some analyses failed)
""",
    tags=["Influencers"],
)
async def get_top_influencers(
    country: str = Query(None, description="Country filter (ISO code or full name)", example="FR"),
    limit: int = Query(5, description="Number of influencers to return", ge=1, le=50),
    auto_discover: bool = Query(True, description="Auto-discover new influencers if database is insufficient"),
    db: Session = Depends(get_db)
):
    # Enforce max limit of 50
    if limit > 50:
        limit = 50
    if limit < 1:
        limit = 1

    # Build query
    query = db.query(Influencer).filter(
        Influencer.analysis_complete == True  # Only completed analyses
    )

    # Filter by country if provided
    if country:
        # Map country codes to full names (database stores full country names)
        country_mapping = {
            "FR": "France",
            "US": "United States",
            "USA": "United States",
            "UK": "United Kingdom",
            "GB": "United Kingdom",
            "CA": "Canada",
            "DE": "Germany",
            "ES": "Spain",
            "IT": "Italy",
            "JP": "Japan",
            "BR": "Brazil",
            "MX": "Mexico",
            "IN": "India",
            "AU": "Australia",
            "NL": "Netherlands",
            "SE": "Sweden",
            "NO": "Norway",
            "DK": "Denmark",
            "FI": "Finland",
        }

        # Use mapping if available, otherwise use the value as-is (for full names like "France")
        country_filter = country_mapping.get(country.upper(), country)
        query = query.filter(Influencer.country.ilike(f"%{country_filter}%"))

    # Get all matching influencers (we'll sort by follower count in Python)
    influencers = query.all()

    # Calculate total followers for each influencer and sort
    influencers_with_followers = []
    for inf in influencers:
        total_followers = sum(p.follower_count or 0 for p in inf.platforms)
        influencers_with_followers.append((inf, total_followers))

    # Sort by total followers (descending)
    influencers_with_followers.sort(key=lambda x: x[1], reverse=True)

    # Take top N
    influencers = [inf for inf, _ in influencers_with_followers[:limit]]

    # If we have enough results, return them
    if len(influencers) >= limit or not auto_discover:
        return {
            "country": country or "global",
            "limit": limit,
            "count": len(influencers),
            "auto_discovered": False,
            "influencers": [
                {
                    "id": inf.id,
                    "name": inf.name,
                    "bio": inf.bio,
                    "country": inf.country,
                    "trust_score": inf.trust_score,
                    "trending_score": inf.trending_score,
                    "verified": inf.verified,
                    "avatar_url": inf.avatar_url,
                    "platforms": [
                        {
                            "platform": p.platform_name,
                            "username": p.username,
                            "followers": p.follower_count,
                            "verified": p.verified,
                            "url": p.url
                        }
                        for p in inf.platforms
                    ],
                    "total_followers": sum(p.follower_count or 0 for p in inf.platforms)
                }
                for inf in influencers
            ]
        }

    # Auto-discover and analyze new influencers
    import asyncio
    import logging
    from src.services.perplexity_client import perplexity_client

    logger = logging.getLogger(__name__)

    # Calculate how many we need to discover
    needed = limit - len(influencers)

    logger.info(f"Need {needed} influencers, discovering exactly {needed} (no buffer)...")

    # Discover top influencers using AI - request exactly what we need
    def discover():
        return perplexity_client.discover_top_influencers(country, needed)

    discovered_data = await asyncio.to_thread(discover)
    discovered_influencers = discovered_data.get("influencers", [])

    logger.info(f"Perplexity returned {len(discovered_influencers)} influencers")

    # Analyze each discovered influencer (no retries - fail fast)
    analyzer = InfluencerAnalyzer(db)
    newly_analyzed = []

    for inf_data in discovered_influencers:
        try:
            # Check if already exists
            existing = db.query(Influencer).filter(
                Influencer.name.ilike(inf_data["name"])
            ).first()

            if existing and existing.analysis_complete:
                newly_analyzed.append(existing)
                logger.info(f"✓ {inf_data['name']} already analyzed ({len(newly_analyzed)}/{needed})")
                continue

            # Analyze the influencer (single attempt, fail fast)
            # Use "platforms_only" for top lists - only get platforms and photos, no products
            logger.info(f"Analyzing {inf_data['name']} ({len(newly_analyzed) + 1}/{needed})...")
            result = await analyzer.analyze_influencer(inf_data["name"], analysis_level="platforms_only")

            # Fetch the analyzed influencer from database
            inf = db.query(Influencer).filter(
                Influencer.name.ilike(inf_data["name"])
            ).first()

            if inf and inf.analysis_complete:
                newly_analyzed.append(inf)
                logger.info(f"✓ Successfully analyzed {inf_data['name']} ({len(newly_analyzed)}/{needed})")
            else:
                logger.error(f"✗ Analysis incomplete for {inf_data['name']}")

        except Exception as e:
            # Log and continue to next influencer - no retries
            logger.error(f"✗ Failed to analyze {inf_data.get('name')}: {str(e)}")
            # Don't break - continue to try other influencers

    # Combine existing and newly analyzed influencers
    all_influencers = list(influencers) + newly_analyzed

    # Calculate total followers and sort
    influencers_with_followers_combined = []
    for inf in all_influencers:
        total_followers = sum(p.follower_count or 0 for p in inf.platforms)
        influencers_with_followers_combined.append((inf, total_followers))

    # Sort by total followers (descending)
    influencers_with_followers_combined.sort(key=lambda x: x[1], reverse=True)

    # Take top N
    all_influencers = [inf for inf, _ in influencers_with_followers_combined[:limit]]

    # Log error if we couldn't get the full amount (no retries/buffer - we want to see failures)
    if len(all_influencers) < limit:
        failed_count = limit - len(all_influencers)
        logger.error(f"❌ Only got {len(all_influencers)}/{limit} influencers - {failed_count} analyses FAILED")
        logger.error(f"Check logs above to see which influencers failed and why")

    return {
        "country": country or "global",
        "limit": limit,
        "count": len(all_influencers),
        "auto_discovered": len(newly_analyzed) > 0,
        "newly_analyzed_count": len(newly_analyzed),
        "requested": limit,
        "influencers": [
            {
                "id": inf.id,
                "name": inf.name,
                "bio": inf.bio,
                "country": inf.country,
                "trust_score": inf.trust_score,
                "trending_score": inf.trending_score,
                "verified": inf.verified,
                "avatar_url": inf.avatar_url,
                "platforms": [
                    {
                        "platform": p.platform_name,
                        "username": p.username,
                        "followers": p.follower_count,
                        "verified": p.verified,
                        "url": p.url
                    }
                    for p in inf.platforms
                ],
                "total_followers": sum(p.follower_count or 0 for p in inf.platforms)
            }
            for inf in all_influencers
        ]
    }


@router.get(
    "/api/influencers/{influencer_id}",
    response_model=None,
    summary="Get influencer by ID",
    description="""
Get detailed influencer profile by ID.

**Returns:** Complete influencer profile including platforms, products, timeline, connections, and news.

**Note:** If the influencer was fetched via platforms_only mode (trust_score === 0),
the frontend will automatically trigger a basic analysis to fetch products and calculate trust score.

**Triggers:**
- If products are empty, frontend fetches them on-demand
- If trust_score is 0, frontend calculates it on-demand
""",
    tags=["Influencers"],
    responses={
        200: {
            "description": "Influencer profile",
            "content": {
                "application/json": {
                    "example": {
                        "id": 1,
                        "name": "MrBeast",
                        "bio": "American YouTuber known for expensive stunts and philanthropy",
                        "country": "USA",
                        "verified": True,
                        "trust_score": 95,
                        "avatar_url": "https://example.com/avatar.jpg",
                        "platforms": [
                            {
                                "platform": "youtube",
                                "username": "@MrBeast",
                                "followers": 250000000,
                                "verified": True,
                                "url": "https://youtube.com/@MrBeast"
                            }
                        ],
                        "products": [
                            {
                                "id": 1,
                                "name": "Feastables",
                                "category": "food",
                                "quality_score": 85,
                                "description": "Premium chocolate brand",
                                "review_count": 0,
                                "openfoodfacts_data": None,
                                "reviews": []
                            }
                        ],
                        "timeline": [],
                        "connections": [],
                        "news": [],
                        "last_analyzed": "2025-11-15T12:00:00",
                        "analysis_complete": True
                    }
                }
            }
        },
        404: {"description": "Influencer not found"}
    }
)
async def get_influencer(
    influencer_id: int,
    db: Session = Depends(get_db)
):
    influencer = db.query(Influencer).filter(
        Influencer.id == influencer_id
    ).first()

    if not influencer:
        raise HTTPException(status_code=404, detail="Influencer not found")

    analyzer = InfluencerAnalyzer(db)
    return analyzer._build_response(influencer)


@router.get("/api/influencers/{influencer_id}/avatar")
async def get_influencer_avatar(
    influencer_id: int,
    db: Session = Depends(get_db)
):
    """
    Get influencer's avatar image.

    Returns the stored avatar image data with appropriate content type.
    If no image is stored, returns 404.
    """
    influencer = db.query(Influencer).filter(
        Influencer.id == influencer_id
    ).first()

    if not influencer:
        raise HTTPException(status_code=404, detail="Influencer not found")

    if not influencer.avatar_data:
        raise HTTPException(status_code=404, detail="No avatar image stored for this influencer")

    # Return image data with appropriate content type
    return Response(
        content=influencer.avatar_data,
        media_type=influencer.avatar_content_type or "image/jpeg",
        headers={
            "Cache-Control": "public, max-age=86400",  # Cache for 24 hours
            "Content-Disposition": f'inline; filename="{influencer_id}_avatar.jpg"'
        }
    )


@router.get(
    "/api/news",
    response_model=None,
    summary="Get news and drama articles",
    description="""
Get news and drama articles across all influencers.

**Filters:**
- `limit`: Maximum number of articles (default: 50)
- `influencer_id`: Filter by specific influencer
- `article_type`: Filter by type (news, drama, controversy, achievement, collaboration, legal)
- `sentiment`: Filter by sentiment (positive, negative, neutral)

**Sorting:** Articles are sorted by date (newest first) and severity (highest first).

**Returns:** List of news articles with metadata (title, description, sentiment, severity, source, etc.)
""",
    tags=["News"],
)
async def get_all_news(
    limit: int = Query(50, description="Maximum number of articles", ge=1, le=200),
    influencer_id: int = Query(None, description="Filter by influencer ID"),
    article_type: str = Query(None, description="Filter by article type", enum=["news", "drama", "controversy", "achievement", "collaboration", "legal"]),
    sentiment: str = Query(None, description="Filter by sentiment", enum=["positive", "negative", "neutral"]),
    db: Session = Depends(get_db)
):
    query = db.query(NewsArticle)

    # Apply filters
    if influencer_id:
        query = query.filter(NewsArticle.influencer_id == influencer_id)
    if article_type:
        query = query.filter(NewsArticle.article_type == article_type)
    if sentiment:
        query = query.filter(NewsArticle.sentiment == sentiment)

    # Order by date (newest first) and severity (highest first)
    articles = query.order_by(
        NewsArticle.date.desc().nullslast(),
        NewsArticle.severity.desc()
    ).limit(limit).all()

    return {
        "news": [
            {
                "id": article.id,
                "influencer_id": article.influencer_id,
                "title": article.title,
                "description": article.description,
                "article_type": article.article_type,
                "date": article.date.isoformat() if article.date else None,
                "source": article.source,
                "url": article.url,
                "sentiment": article.sentiment,
                "severity": article.severity,
                "created_at": article.created_at.isoformat(),
            }
            for article in articles
        ]
    }


@router.get("/api/influencers/{influencer_id}/news")
async def get_influencer_news(
    influencer_id: int,
    limit: int = 20,
    db: Session = Depends(get_db)
):
    """Get news and drama for a specific influencer."""
    # Check if influencer exists
    influencer = db.query(Influencer).filter(
        Influencer.id == influencer_id
    ).first()

    if not influencer:
        raise HTTPException(status_code=404, detail="Influencer not found")

    articles = db.query(NewsArticle).filter(
        NewsArticle.influencer_id == influencer_id
    ).order_by(
        NewsArticle.date.desc().nullslast(),
        NewsArticle.severity.desc()
    ).limit(limit).all()

    return {
        "influencer": {
            "id": influencer.id,
            "name": influencer.name,
        },
        "news": [
            {
                "id": article.id,
                "title": article.title,
                "description": article.description,
                "article_type": article.article_type,
                "date": article.date.isoformat() if article.date else None,
                "source": article.source,
                "url": article.url,
                "sentiment": article.sentiment,
                "severity": article.severity,
            }
            for article in articles
        ]
    }


@router.post(
    "/api/influencers/{influencer_id}/timeline/fetch",
    response_model=None,
    summary="Fetch timeline events on-demand",
    description="""
Fetch timeline events on-demand for an influencer using AI analysis.

**Use Cases:**
- When timeline data is not yet available (platforms_only or basic analysis)
- When timeline data needs updating

**Returns:** Updated timeline events with metadata (date, type, title, description, views, likes, etc.)

**Note:** This is an expensive operation (~1,500 tokens) - only call when necessary.
""",
    tags=["On-Demand Analysis"],
)
async def fetch_timeline(
    influencer_id: int,
    db: Session = Depends(get_db)
):
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.fetch_timeline(influencer_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post(
    "/api/products/{product_id}/reviews/fetch",
    response_model=None,
    summary="Fetch product reviews on-demand",
    description="""
Fetch product reviews on-demand using AI-powered web search.

**Use Cases:**
- When review data is not yet available
- When reviews need updating

**Returns:** Updated product reviews from social media (Twitter, Reddit, YouTube, TikTok, etc.) with sentiment analysis.

**Note:** This operation searches social media for user reviews and analyzes sentiment (~1,000-1,500 tokens).
""",
    tags=["On-Demand Analysis"],
)
async def fetch_product_reviews(
    product_id: int,
    db: Session = Depends(get_db)
):
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.fetch_product_reviews(product_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post(
    "/api/products/{product_id}/openfoodfacts/fetch",
    response_model=None,
    summary="Fetch OpenFoodFacts data",
    description="""
Fetch nutritional and safety data from OpenFoodFacts API.

**Product Categories Supported:**
- Food products: NutriScore, NOVA group, Ecoscore, ingredients, allergens, nutritional values
- Cosmetics: Safety ratings, ingredient analysis, hazardous substances

**Returns:** Nutritional/safety data stored in product.openfoodfacts_data field as JSON.

**Note:** Only works for products with category: food, cosmetics, or beauty.
Fast operation (external API call, no AI tokens used).
""",
    tags=["On-Demand Analysis"],
)
async def fetch_openfoodfacts_data(
    product_id: int,
    db: Session = Depends(get_db)
):
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.fetch_openfoodfacts_data(product_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post(
    "/api/influencers/{influencer_id}/connections/fetch",
    response_model=None,
    summary="Fetch network connections on-demand",
    description="""
Fetch network map/connections on-demand using AI analysis.

**Use Cases:**
- When viewing detailed influencer profile page
- When connection data is not yet available (platforms_only or basic analysis)

**Returns Network Connections:**
- Other influencers (collaborators, friends, partners)
- Agencies (talent management, MCNs)
- Brands (sponsors, partnerships)
- Management companies
- Record labels, networks, and other entities

**Connection Metadata:**
- Entity name and type
- Connection type (collaboration, sponsorship, managed_by, etc.)
- Connection strength (1-10)
- Description

**Note:** This is an expensive operation (~1,500 tokens) - only call when necessary.
""",
    tags=["On-Demand Analysis"],
)
async def fetch_connections(
    influencer_id: int,
    db: Session = Depends(get_db)
):
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.fetch_connections(influencer_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post(
    "/api/influencers/{influencer_id}/news/fetch",
    response_model=None,
    summary="Fetch news and drama on-demand",
    description="""
Fetch news and drama articles on-demand using AI analysis.

**Use Cases:**
- When viewing detailed influencer profile page
- When news data is not yet available (platforms_only or basic analysis)

**Returns News Articles:**
- Recent news about the influencer
- Drama and controversies
- Achievements and milestones
- Collaborations and partnerships
- Legal issues

**Article Metadata:**
- Title and description
- Article type (news, drama, controversy, achievement, collaboration, legal)
- Publication date and source
- Sentiment (positive, negative, neutral)
- Severity score (1-10)
- Source URL

**Note:** This is an expensive operation (~1,500 tokens) - only call when necessary.
""",
    tags=["On-Demand Analysis"],
)
async def fetch_news(
    influencer_id: int,
    db: Session = Depends(get_db)
):
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.fetch_news(influencer_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
