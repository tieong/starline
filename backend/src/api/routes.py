"""API routes."""
from typing import List

from fastapi import APIRouter, Depends, HTTPException
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
    id: str
    name: str
    bio: str | None = None
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
    db: Session = Depends(get_db)
):
    """
    Analyze an influencer in real-time.

    This endpoint will:
    1. Check if the influencer is cached
    2. If not, trigger real-time AI analysis
    3. Return complete profile data
    """
    try:
        analyzer = InfluencerAnalyzer(db)
        result = await analyzer.analyze_influencer(request.name)
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


@router.get("/api/influencers/{influencer_id}")
async def get_influencer(
    influencer_id: str,
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


@router.get("/api/news")
async def get_all_news(
    limit: int = 50,
    influencer_id: str = None,
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
    influencer_id: str,
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
