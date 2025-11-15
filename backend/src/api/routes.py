"""API routes."""
from typing import List

from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import Response
from pydantic import BaseModel
from sqlalchemy.orm import Session

from src.agents.analyzer import InfluencerAnalyzer
from src.models.database import Influencer, NewsArticle, get_db

router = APIRouter()


class InfluencerSearchRequest(BaseModel):
    """Request model for influencer search."""
    name: str


class InfluencerResponse(BaseModel):
    """Response model for influencer data."""
    id: int
    name: str
    bio: str | None = None
    country: str | None = None
    verified: bool
    trust_score: int
    avatar_url: str | None = None
    platforms: List[dict]
    timeline: List[dict]
    products: List[dict]
    connections: List[dict]
    last_analyzed: str | None
    analysis_complete: bool


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


@router.post("/api/influencers/analyze")
async def analyze_influencer(
    request: InfluencerSearchRequest,
    analysis_level: str = "basic",
    db: Session = Depends(get_db)
):
    """
    Analyze an influencer in real-time.

    Query parameters:
    - analysis_level: "basic" (platforms, products, connections) or "full" (adds timeline, news, reviews)

    This endpoint will:
    1. Check if the influencer is cached
    2. If not, trigger real-time AI analysis
    3. Return profile data based on analysis_level

    Note: Use "basic" for initial discovery (saves ~60% tokens), then fetch timeline/reviews on-demand.
    """
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.analyze_influencer(request.name, analysis_level=analysis_level)
        return result
    except Exception as e:
        error_msg = str(e)
        # Return 404 for "not found" errors, 500 for other errors
        if "not found" in error_msg.lower():
            raise HTTPException(status_code=404, detail=error_msg)
        else:
            raise HTTPException(status_code=500, detail=error_msg)


@router.get("/api/influencers/search")
async def search_influencers(
    q: str,
    db: Session = Depends(get_db)
):
    """
    Search for influencers in the database.

    Returns cached influencers matching the query.
    Only returns completed analyses.
    """
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


@router.get("/api/influencers/trending")
async def get_trending(
    limit: int = 10,
    db: Session = Depends(get_db)
):
    """Get trending influencers."""
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


@router.get("/api/influencers/top")
async def get_top_influencers(
    country: str = None,
    limit: int = 10,
    auto_discover: bool = True,
    db: Session = Depends(get_db)
):
    """
    Get top N influencers globally or by country.

    Query parameters:
    - country: ISO country code or country name (optional, returns global if not provided)
    - limit: Number of influencers to return (default: 10, max: 50)
    - auto_discover: If true, automatically discover and analyze new influencers if database has insufficient results (default: true)

    Returns influencers sorted by trending_score (descending).
    If auto_discover is enabled and database is empty/insufficient, this endpoint will:
    1. Use AI to discover top trending influencers
    2. Analyze them in real-time
    3. Return the results
    """
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
        query = query.filter(Influencer.country.ilike(country))

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

    # Request extra influencers as buffer (50% more) to account for failures
    discover_count = int(needed * 1.5) + 2  # Request 50% more + 2 as buffer

    logger.info(f"Need {needed} influencers, discovering {discover_count} to account for potential failures...")

    # Discover top influencers using AI
    def discover():
        return perplexity_client.discover_top_influencers(country, discover_count)

    discovered_data = await asyncio.to_thread(discover)
    discovered_influencers = discovered_data.get("influencers", [])

    logger.info(f"Perplexity returned {len(discovered_influencers)} influencers")

    # Analyze each discovered influencer with retry logic
    analyzer = InfluencerAnalyzer(db)
    newly_analyzed = []
    max_retries = 2  # Retry failed analyses up to 2 times

    for inf_data in discovered_influencers:
        # Stop if we have enough
        if len(newly_analyzed) + len(influencers) >= limit:
            break

        retries = 0
        while retries <= max_retries:
            try:
                # Check if already exists
                existing = db.query(Influencer).filter(
                    Influencer.name.ilike(inf_data["name"])
                ).first()

                if existing and existing.analysis_complete:
                    newly_analyzed.append(existing)
                    logger.info(f"✓ {inf_data['name']} already analyzed ({len(newly_analyzed)}/{needed})")
                    break

                # Analyze the influencer
                logger.info(f"Analyzing {inf_data['name']} (attempt {retries + 1}/{max_retries + 1})...")
                result = await analyzer.analyze_influencer(inf_data["name"])

                # Fetch the analyzed influencer from database
                inf = db.query(Influencer).filter(
                    Influencer.name.ilike(inf_data["name"])
                ).first()

                if inf and inf.analysis_complete:
                    newly_analyzed.append(inf)
                    logger.info(f"✓ Successfully analyzed {inf_data['name']} ({len(newly_analyzed)}/{needed})")
                    break
                else:
                    raise Exception("Analysis incomplete")

            except Exception as e:
                retries += 1
                if retries > max_retries:
                    logger.warning(f"✗ Failed to analyze {inf_data.get('name')} after {max_retries + 1} attempts: {str(e)}")
                    break
                else:
                    logger.warning(f"⚠ Analysis failed for {inf_data.get('name')}, retrying ({retries}/{max_retries})...")
                    await asyncio.sleep(2)  # Wait 2 seconds before retry

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

    # Log warning if we couldn't get the full amount
    if len(all_influencers) < limit:
        logger.warning(f"⚠ Only got {len(all_influencers)}/{limit} influencers (some analyses may have failed)")

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


@router.get("/api/influencers/{influencer_id}")
async def get_influencer(
    influencer_id: int,
    db: Session = Depends(get_db)
):
    """Get detailed influencer profile by ID."""
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


@router.get("/api/news")
async def get_all_news(
    limit: int = 50,
    influencer_id: int = None,
    article_type: str = None,
    sentiment: str = None,
    db: Session = Depends(get_db)
):
    """
    Get news and drama articles.

    Query parameters:
    - limit: Maximum number of articles to return (default: 50)
    - influencer_id: Filter by specific influencer
    - article_type: Filter by type (news, drama, controversy, achievement, collaboration, legal)
    - sentiment: Filter by sentiment (positive, negative, neutral)
    """
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


@router.post("/api/influencers/{influencer_id}/timeline/fetch")
async def fetch_timeline(
    influencer_id: int,
    db: Session = Depends(get_db)
):
    """
    Fetch timeline events on-demand for an influencer.

    This endpoint triggers AI analysis to fetch and store timeline events.
    Use when timeline data is not yet available or needs updating.
    """
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.fetch_timeline(influencer_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/api/products/{product_id}/reviews/fetch")
async def fetch_product_reviews(
    product_id: int,
    db: Session = Depends(get_db)
):
    """
    Fetch product reviews on-demand.

    This endpoint triggers AI analysis to fetch and store product reviews.
    Use when review data is not yet available or needs updating.
    """
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.fetch_product_reviews(product_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/api/products/{product_id}/openfoodfacts/fetch")
async def fetch_openfoodfacts_data(
    product_id: int,
    db: Session = Depends(get_db)
):
    """
    Fetch OpenFoodFacts nutritional/safety data for a product on-demand.

    This endpoint queries OpenFoodFacts API for:
    - Food products: NutriScore, NOVA group, Ecoscore, ingredients, allergens
    - Cosmetics: Safety ratings, ingredient analysis

    Only works for products with category: food, cosmetics, or beauty.
    """
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.fetch_openfoodfacts_data(product_id)
        return result
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
