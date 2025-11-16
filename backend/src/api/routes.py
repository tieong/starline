"""API routes."""
from datetime import datetime
from typing import List, Optional

from fastapi import APIRouter, HTTPException, Query
from fastapi.responses import Response
from pydantic import BaseModel, Field

from src.agents.analyzer import InfluencerAnalyzer
from src.services.supabase_client import supabase

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
    )
):
    try:
        analyzer = InfluencerAnalyzer()
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
    q: str = Query(..., description="Search query (influencer name)", example="MrBeast")
):
    # Only return influencers with completed analysis using Supabase
    response = supabase.table("influencers").select(
        "id, name, bio, country, trust_score, avatar_url, platforms(platform_name, follower_count)"
    ).ilike("name", f"%{q}%").eq("analysis_complete", True).limit(10).execute()

    return {
        "results": [
            {
                "id": inf["id"],
                "name": inf["name"],
                "bio": inf["bio"],
                "country": inf["country"],
                "trust_score": inf["trust_score"],
                "avatar_url": inf["avatar_url"],
                "platforms": [
                    {
                        "platform": p.get("platform_name"),
                        "followers": p.get("follower_count")
                    }
                    for p in inf.get("platforms", [])
                ]
            }
            for inf in response.data
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
    limit: int = Query(10, description="Maximum number of trending influencers to return", ge=1, le=100)
):
    response = supabase.table("influencers").select(
        "id, name, bio, country, trust_score, trending_score, avatar_url, platforms(platform_name, follower_count)"
    ).gt("trending_score", 0).order("trending_score", desc=True).limit(limit).execute()

    return {
        "trending": [
            {
                "id": inf["id"],
                "name": inf["name"],
                "bio": inf["bio"],
                "country": inf["country"],
                "trust_score": inf["trust_score"],
                "trending_score": inf["trending_score"],
                "avatar_url": inf["avatar_url"],
                "platforms": [
                    {
                        "platform": p.get("platform_name"),
                        "followers": p.get("follower_count")
                    }
                    for p in inf.get("platforms", [])
                ]
            }
            for inf in response.data
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
    auto_discover: bool = Query(False, description="Auto-discover new influencers if database is insufficient"),
):
    # Enforce max limit of 50
    if limit > 50:
        limit = 50
    if limit < 1:
        limit = 1

    # Map country codes to full names
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

    # Build Supabase query
    query = supabase.table("influencers").select(
        "id, name, bio, country, verified, trust_score, trending_score, avatar_url, "
        "platforms(platform_name, username, follower_count, verified, url)"
    ).eq("analysis_complete", True)

    # Filter by country if provided
    if country:
        country_filter = country_mapping.get(country.upper(), country)
        query = query.ilike("country", f"%{country_filter}%")

    # Execute query
    response = query.execute()
    influencers_data = response.data

    # Calculate total followers for each influencer and sort
    influencers_with_followers = []
    for inf in influencers_data:
        platforms = inf.get("platforms", [])
        total_followers = sum(p.get("follower_count") or 0 for p in platforms)
        influencers_with_followers.append((inf, total_followers))

    # Sort by total followers (descending)
    influencers_with_followers.sort(key=lambda x: x[1], reverse=True)

    # Take top N
    top_influencers = influencers_with_followers[:limit]

    # Format response
    return {
        "country": country or "global",
        "limit": limit,
        "count": len(top_influencers),
        "auto_discovered": False,
        "influencers": [
            {
                "id": inf["id"],
                "name": inf["name"],
                "bio": inf.get("bio"),
                "country": inf.get("country"),
                "trust_score": inf.get("trust_score", 0),
                "trending_score": inf.get("trending_score", 0),
                "verified": inf.get("verified", False),
                "avatar_url": inf.get("avatar_url"),
                "platforms": [
                    {
                        "platform": p["platform_name"],
                        "username": p.get("username"),
                        "followers": p.get("follower_count", 0),
                        "verified": p.get("verified", False),
                        "url": p.get("url")
                    }
                    for p in inf.get("platforms", [])
                ],
                "total_followers": total_followers
            }
            for inf, total_followers in top_influencers
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
):
    # Query influencer with all related data using Supabase REST API
    response = supabase.table("influencers").select(
        "id, name, bio, country, verified, trust_score, trending_score, avatar_url, last_analyzed, analysis_complete, "
        "platforms(id, platform_name, username, follower_count, verified, url), "
        "products(id, name, category, quality_score, description, review_count, sentiment_score, openfoodfacts_data), "
        "timeline:timeline_events(id, date, event_type, title, description, platform, views, likes, url), "
        "connections!connections_influencer_id_fkey(id, entity_name, entity_type, connection_type, strength, description, connected_influencer_id), "
        "news:news_articles(id, title, description, article_type, date, source, url, sentiment, severity)"
    ).eq("id", influencer_id).execute()

    if not response.data or len(response.data) == 0:
        raise HTTPException(status_code=404, detail="Influencer not found")

    influencer_data = response.data[0]

    # Format response
    return {
        "id": influencer_data["id"],
        "name": influencer_data["name"],
        "bio": influencer_data.get("bio"),
        "country": influencer_data.get("country"),
        "verified": influencer_data.get("verified", False),
        "trust_score": influencer_data.get("trust_score", 0),
        "avatar_url": influencer_data.get("avatar_url"),
        "platforms": [
            {
                "platform": p["platform_name"],
                "username": p.get("username"),
                "followers": p.get("follower_count", 0),
                "verified": p.get("verified", False),
                "url": p.get("url")
            }
            for p in influencer_data.get("platforms", [])
        ],
        "timeline": [
            {
                "id": t["id"],
                "date": t.get("date"),
                "type": t.get("event_type"),
                "title": t["title"],
                "description": t.get("description"),
                "platform": t.get("platform"),
                "views": t.get("views"),
                "likes": t.get("likes"),
                "url": t.get("url")
            }
            for t in influencer_data.get("timeline", [])
        ],
        "products": [
            {
                "id": p["id"],
                "name": p["name"],
                "category": p.get("category"),
                "quality_score": p.get("quality_score"),
                "description": p.get("description"),
                "review_count": p.get("review_count", 0),
                "sentiment_score": p.get("sentiment_score"),
                "openfoodfacts_data": p.get("openfoodfacts_data"),
                "reviews": []  # Reviews loaded separately
            }
            for p in influencer_data.get("products", [])
        ],
        "connections": [
            {
                "name": c.get("entity_name"),
                "entity_type": c.get("entity_type"),
                "type": c.get("connection_type"),
                "strength": c.get("strength", 1),
                "description": c.get("description")
            }
            for c in influencer_data.get("connections", [])
        ],
        "news": [
            {
                "id": n["id"],
                "title": n["title"],
                "description": n["description"],
                "article_type": n.get("article_type"),
                "date": n.get("date"),
                "source": n.get("source"),
                "url": n.get("url"),
                "sentiment": n.get("sentiment"),
                "severity": n.get("severity", 1)
            }
            for n in influencer_data.get("news", [])
        ],
        "last_analyzed": influencer_data.get("last_analyzed"),
        "analysis_complete": influencer_data.get("analysis_complete", False)
    }


@router.get("/api/influencers/{influencer_id}/avatar")
async def get_influencer_avatar(
    influencer_id: int
):
    """
    Get influencer's avatar image.

    Returns the stored avatar image data with appropriate content type.
    If no image is stored, returns 404.
    """
    response = supabase.table("influencers").select("avatar_data, avatar_content_type").eq("id", influencer_id).execute()
    
    if not response.data or len(response.data) == 0:
        raise HTTPException(status_code=404, detail="Influencer not found")

    influencer = response.data[0]

    if not influencer.get("avatar_data"):
        raise HTTPException(status_code=404, detail="No avatar image stored for this influencer")

    # Return image data with appropriate content type
    import base64
    avatar_data = base64.b64decode(influencer["avatar_data"]) if isinstance(influencer["avatar_data"], str) else influencer["avatar_data"]
    
    return Response(
        content=avatar_data,
        media_type=influencer.get("avatar_content_type") or "image/jpeg",
        headers={
            "Cache-Control": "public, max-age=86400",  # Cache for 24 hours
            "Content-Disposition": f'inline; filename="{influencer_id}_avatar.jpg"'
        }
    )

@router.get("/api/influencers/{influencer_id}/news")
async def get_influencer_news(
    influencer_id: int,
    limit: int = 20
):
    """Get news and drama for a specific influencer."""
    # Check if influencer exists
    influencer_response = supabase.table("influencers").select("id, name").eq("id", influencer_id).execute()

    if not influencer_response.data or len(influencer_response.data) == 0:
        raise HTTPException(status_code=404, detail="Influencer not found")

    influencer = influencer_response.data[0]

    articles_response = supabase.table("news_articles").select("*").eq(
        "influencer_id", influencer_id
    ).order("date", desc=True).order("severity", desc=True).limit(limit).execute()

    return {
        "influencer": {
            "id": influencer["id"],
            "name": influencer["name"],
        },
        "news": [
            {
                "id": article["id"],
                "title": article["title"],
                "description": article["description"],
                "article_type": article["article_type"],
                "date": article.get("date"),
                "source": article["source"],
                "url": article["url"],
                "sentiment": article["sentiment"],
                "severity": article["severity"],
            }
            for article in articles_response.data
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
    influencer_id: int
):
    try:
        analyzer = InfluencerAnalyzer()
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
    product_id: int
):
    try:
        analyzer = InfluencerAnalyzer()
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
    product_id: int
):
    try:
        analyzer = InfluencerAnalyzer()
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
    influencer_id: int
):
    try:
        analyzer = InfluencerAnalyzer()
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
    influencer_id: int
):
    try:
        analyzer = InfluencerAnalyzer()
        result = await analyzer.fetch_news(influencer_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get(
    "/api/influencers/{influencer_id}/reputation",
    summary="Get influencer reputation",
    description="""
    Retrieve cached reputation data for an influencer from the database.

    Returns:
    - Overall sentiment: "good", "neutral", or "negative"
    - Sample comments from social media representing public opinion

    Use POST /reputation/fetch to analyze and fetch new data.
    """,
    tags=["Data Retrieval"],
)
async def get_reputation(
    influencer_id: int
):
    """Get cached influencer reputation data."""
    influencer_response = supabase.table("influencers").select("id, overall_sentiment").eq("id", influencer_id).execute()
    if not influencer_response.data or len(influencer_response.data) == 0:
        raise HTTPException(status_code=404, detail=f"Influencer with ID {influencer_id} not found")

    influencer = influencer_response.data[0]
    comments_response = supabase.table("reputation_comments").select("*").eq("influencer_id", influencer_id).execute()

    return {
        "influencer_id": influencer_id,
        "overall_sentiment": influencer.get("overall_sentiment") or "neutral",
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


@router.post(
    "/api/influencers/{influencer_id}/reputation/fetch",
    summary="Fetch influencer reputation",
    description="""
    Analyze influencer reputation from social media using AI.

    This endpoint:
    - Searches Twitter/X, Reddit, YouTube, TikTok for what people say about the influencer
    - Analyzes sentiment and determines overall reputation (good/neutral/negative)
    - Extracts 8-10 representative comments
    - Saves everything to the database for future retrieval

    **Cost:** ~1,500 tokens per analysis
    """,
    tags=["On-Demand Analysis"],
)
async def fetch_reputation(
    influencer_id: int
):
    """Fetch and analyze influencer reputation via AI."""
    try:
        analyzer = InfluencerAnalyzer()
        result = await analyzer.fetch_reputation(influencer_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post(
    "/api/explore/start",
    response_model=None,
    summary="Start graph exploration from an influencer name",
    description="""
Start an iterative graph exploration from an influencer's name using AI-powered analysis.

**Workflow:**
1. Analyze the influencer if not already in the database
2. Fetch their connections (collaborators, agencies, brands)
3. Return initial graph data with the influencer and their immediate connections
4. Mark connections as "unexplored" - can be expanded later

**Use Case:** When user types "Squeezie" in search bar and clicks "Generate Graph"
    
**Returns:** Initial graph with center node and first-level connections
    """,
    tags=["Graph Exploration"],
)
async def start_exploration(
    request: InfluencerSearchRequest
):
    """Start graph exploration from an influencer name."""
    try:
        analyzer = InfluencerAnalyzer()
        
        # Step 1: Analyze influencer (basic mode to get platforms + products)
        influencer_data = await analyzer.analyze_influencer(request.name, analysis_level="basic")
        influencer_id = influencer_data["id"]
        
        # Step 2: Fetch connections if not already present
        if not influencer_data.get("connections") or len(influencer_data["connections"]) == 0:
            connections_result = await analyzer.fetch_connections(influencer_id)
            influencer_data["connections"] = connections_result.get("connections", [])
        
        # Step 3: Build graph structure
        nodes = []
        links = []
        
        # Add center node (the main influencer)
        nodes.append({
            "id": f"influencer-{influencer_id}",
            "name": influencer_data["name"],
            "type": "influencer",
            "avatar": influencer_data.get("avatar_url"),
            "score": influencer_data.get("trust_score", 0),
            "size": 100,
            "explored": True,
            "data": influencer_data
        })
        
        # Add connection nodes
        for conn in influencer_data.get("connections", []):
            entity_type = conn.get("entity_type", "influencer")
            entity_name = conn.get("name")
            
            # Create node ID based on type
            if entity_type == "influencer":
                # For influencer connections, check if they exist in database
                conn_influencer = supabase.table("influencers").select("id, name, trust_score, avatar_url").ilike("name", entity_name).execute()
                if conn_influencer.data and len(conn_influencer.data) > 0:
                    conn_id = f"influencer-{conn_influencer.data[0]['id']}"
                    node_data = {
                        "id": conn_id,
                        "name": entity_name,
                        "type": "influencer",
                        "avatar": conn_influencer.data[0].get("avatar_url"),
                        "score": conn_influencer.data[0].get("trust_score", 0),
                        "size": 60,
                        "explored": conn_influencer.data[0].get("analysis_complete", False),
                        "influencer_id": conn_influencer.data[0]["id"]
                    }
                else:
                    # Influencer not yet in database - can be explored later
                    node_id = f"influencer-pending-{entity_name.replace(' ', '-').lower()}"
                    node_data = {
                        "id": node_id,
                        "name": entity_name,
                        "type": "influencer",
                        "size": 60,
                        "explored": False,
                        "pending_name": entity_name
                    }
            else:
                # Non-influencer entities (agencies, brands, etc.)
                node_id = f"{entity_type}-{entity_name.replace(' ', '-').lower()}"
                node_data = {
                    "id": node_id,
                    "name": entity_name,
                    "type": entity_type,
                    "size": 50,
                    "explored": False  # These can't be explored further
                }
            
            nodes.append(node_data)
            
            # Create link
            links.append({
                "source": f"influencer-{influencer_id}",
                "target": node_data["id"],
                "type": conn.get("type", "collaboration"),
                "strength": conn.get("strength", 5) / 10.0,
                "label": conn.get("description", "")[:30]
            })
        
        return {
            "status": "success",
            "center_influencer_id": influencer_id,
            "center_influencer_name": influencer_data["name"],
            "nodes": nodes,
            "links": links,
            "explored_count": 1,
            "unexplored_count": sum(1 for n in nodes if not n.get("explored", True) and n["type"] == "influencer")
        }
        
    except Exception as e:
        import logging
        import traceback
        logger = logging.getLogger(__name__)
        logger.error(f"Exploration failed for '{request.name}': {str(e)}")
        logger.debug(traceback.format_exc())
        raise HTTPException(status_code=500, detail=str(e))


@router.post(
    "/api/explore/expand/{node_id}",
    response_model=None,
    summary="Expand a node in the exploration graph",
    description="""
Expand a node in the exploration graph by analyzing the influencer and fetching their connections.

**Workflow:**
1. If node is a pending influencer name: analyze them first
2. Fetch connections for the influencer
3. Return new nodes and links to add to the graph

**Use Case:** When user clicks on an unexplored node in the exploration graph

**Returns:** New nodes and links to add to the existing graph
    """,
    tags=["Graph Exploration"],
)
async def expand_node(
    node_id: str,
    influencer_name: Optional[str] = Query(None, description="Name of influencer if node is pending")
):
    """Expand a node by analyzing and fetching connections."""
    try:
        analyzer = InfluencerAnalyzer()
        
        # Parse node_id to get influencer ID or name
        if node_id.startswith("influencer-pending-"):
            # This is a pending influencer - need to analyze first
            if not influencer_name:
                raise HTTPException(status_code=400, detail="influencer_name required for pending nodes")
            
            influencer_data = await analyzer.analyze_influencer(influencer_name, analysis_level="basic")
            influencer_id = influencer_data["id"]
        elif node_id.startswith("influencer-"):
            # Extract influencer ID from node_id
            influencer_id = int(node_id.replace("influencer-", ""))
            influencer_data = await analyzer.analyze_influencer("", analysis_level="basic")  # Will use cache
        else:
            raise HTTPException(status_code=400, detail="Can only expand influencer nodes")
        
        # Fetch connections if not already present
        if not influencer_data.get("connections") or len(influencer_data["connections"]) == 0:
            connections_result = await analyzer.fetch_connections(influencer_id)
            influencer_data["connections"] = connections_result.get("connections", [])
        
        # Build new nodes and links
        new_nodes = []
        new_links = []
        
        for conn in influencer_data.get("connections", []):
            entity_type = conn.get("entity_type", "influencer")
            entity_name = conn.get("name")
            
            if entity_type == "influencer":
                conn_influencer = supabase.table("influencers").select("id, name, trust_score, avatar_url, analysis_complete").ilike("name", entity_name).execute()
                if conn_influencer.data and len(conn_influencer.data) > 0:
                    conn_id = f"influencer-{conn_influencer.data[0]['id']}"
                    node_data = {
                        "id": conn_id,
                        "name": entity_name,
                        "type": "influencer",
                        "avatar": conn_influencer.data[0].get("avatar_url"),
                        "score": conn_influencer.data[0].get("trust_score", 0),
                        "size": 60,
                        "explored": conn_influencer.data[0].get("analysis_complete", False),
                        "influencer_id": conn_influencer.data[0]["id"]
                    }
                else:
                    node_id = f"influencer-pending-{entity_name.replace(' ', '-').lower()}"
                    node_data = {
                        "id": node_id,
                        "name": entity_name,
                        "type": "influencer",
                        "size": 60,
                        "explored": False,
                        "pending_name": entity_name
                    }
            else:
                node_id = f"{entity_type}-{entity_name.replace(' ', '-').lower()}"
                node_data = {
                    "id": node_id,
                    "name": entity_name,
                    "type": entity_type,
                    "size": 50,
                    "explored": False
                }
            
            new_nodes.append(node_data)
            
            new_links.append({
                "source": f"influencer-{influencer_id}",
                "target": node_data["id"],
                "type": conn.get("type", "collaboration"),
                "strength": conn.get("strength", 5) / 10.0,
                "label": conn.get("description", "")[:30]
            })
        
        return {
            "status": "success",
            "expanded_node_id": f"influencer-{influencer_id}",
            "expanded_node_name": influencer_data["name"],
            "new_nodes": new_nodes,
            "new_links": new_links,
            "influencer_data": influencer_data
        }
        
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        import logging
        import traceback
        logger = logging.getLogger(__name__)
        logger.error(f"Expansion failed for node '{node_id}': {str(e)}")
        logger.debug(traceback.format_exc())
        raise HTTPException(status_code=500, detail=str(e))


# ============= Data Retrieval Endpoints =============

@router.get(
    "/api/influencers/{influencer_id}/timeline",
    summary="Get influencer timeline",
    description="Retrieve timeline events for an influencer",
    tags=["Data Retrieval"],
)
async def get_timeline(influencer_id: int):
    """Get timeline events for an influencer."""
    influencer_response = supabase.table("influencers").select("id").eq("id", influencer_id).execute()
    if not influencer_response.data or len(influencer_response.data) == 0:
        raise HTTPException(status_code=404, detail=f"Influencer with ID {influencer_id} not found")

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
            for t in timeline_response.data
        ]
    }


@router.get(
    "/api/influencers/{influencer_id}/connections",
    summary="Get influencer connections",
    description="Retrieve network connections for an influencer",
    tags=["Data Retrieval"],
)
async def get_connections(influencer_id: int):
    """Get network connections for an influencer."""
    influencer_response = supabase.table("influencers").select("id").eq("id", influencer_id).execute()
    if not influencer_response.data or len(influencer_response.data) == 0:
        raise HTTPException(status_code=404, detail=f"Influencer with ID {influencer_id} not found")

    connections_response = supabase.table("connections").select("*").eq("influencer_id", influencer_id).execute()

    return {
        "influencer_id": influencer_id,
        "connections": [
            {
                "name": c.get("entity_name"),
                "entity_type": c.get("entity_type"),
                "connection_type": c.get("connection_type"),
                "strength": c.get("strength"),
                "description": c.get("description"),
                "connected_influencer_id": c.get("connected_influencer_id"),
            }
            for c in connections_response.data
        ]
    }


@router.get(
    "/api/products/{product_id}/reviews",
    summary="Get product reviews",
    description="Retrieve user reviews for a product",
    tags=["Data Retrieval"],
)
async def get_product_reviews(product_id: int):
    """Get reviews for a product."""
    product_response = supabase.table("products").select("id, name").eq("id", product_id).execute()
    if not product_response.data or len(product_response.data) == 0:
        raise HTTPException(status_code=404, detail=f"Product with ID {product_id} not found")

    product = product_response.data[0]
    reviews_response = supabase.table("product_reviews").select("*").eq("product_id", product_id).execute()

    return {
        "product_id": product_id,
        "product_name": product.get("name"),
        "reviews": [
            {
                "id": r.get("id"),
                "author": r.get("author"),
                "comment": r.get("comment"),
                "platform": r.get("platform"),
                "sentiment": r.get("sentiment"),
                "url": r.get("url"),
                "date": r.get("date"),
            }
            for r in reviews_response.data
        ]
    }


@router.get(
    "/api/products/{product_id}/openfoodfacts",
    summary="Get OpenFoodFacts data",
    description="Retrieve OpenFoodFacts nutritional data for a product",
    tags=["Data Retrieval"],
)
async def get_openfoodfacts(product_id: int):
    """Get OpenFoodFacts data for a product."""
    product_response = supabase.table("products").select("id, name, category, openfoodfacts_data").eq("id", product_id).execute()
    if not product_response.data or len(product_response.data) == 0:
        raise HTTPException(status_code=404, detail=f"Product with ID {product_id} not found")

    product = product_response.data[0]
    
    import json
    openfoodfacts_data = None
    if product.get("openfoodfacts_data"):
        try:
            openfoodfacts_data = json.loads(product["openfoodfacts_data"]) if isinstance(product["openfoodfacts_data"], str) else product["openfoodfacts_data"]
        except:
            openfoodfacts_data = None

    return {
        "product_id": product_id,
        "product_name": product.get("name"),
        "category": product.get("category"),
        "openfoodfacts_data": openfoodfacts_data
    }
