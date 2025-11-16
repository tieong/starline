"""Database models and session management."""
from datetime import datetime
from typing import Optional
import socket
from urllib.parse import urlparse, urlunparse

from sqlalchemy import (
    Boolean,
    Column,
    DateTime,
    Float,
    ForeignKey,
    Integer,
    LargeBinary,
    String,
    Text,
    create_engine,
)
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

from src.config.settings import settings


def force_ipv4_url(url: str) -> str:
    """Force IPv4 resolution for database URL (WSL2 IPv6 fix)."""
    if not url:
        return url

    parsed = urlparse(url)
    if parsed.hostname:
        try:
            # Resolve hostname to IPv4 only
            ipv4_addr = socket.getaddrinfo(
                parsed.hostname,
                None,
                socket.AF_INET,  # Force IPv4
                socket.SOCK_STREAM
            )[0][4][0]

            # Replace hostname with IPv4 address
            netloc = parsed.netloc.replace(parsed.hostname, ipv4_addr)
            new_parsed = parsed._replace(netloc=netloc)
            return urlunparse(new_parsed)
        except (socket.gaierror, IndexError):
            # If resolution fails, return original URL
            pass

    return url


# NOTE: PostgreSQL direct connection disabled - using Supabase REST API instead
# This avoids IPv4/IPv6 connectivity issues in WSL2
# Use src.services.supabase_client for database operations

# Create dummy objects for compatibility - will not connect to database
# These are only used for ORM model definitions
from sqlalchemy.orm import declarative_base as _declarative_base
Base = _declarative_base()

# Dummy engine and session - do not use for actual database operations
engine = None
SessionLocal = None


class Influencer(Base):
    """Influencer model."""

    __tablename__ = "influencers"

    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String, nullable=False, index=True, unique=True)
    bio = Column(Text)
    country = Column(String, index=True)  # ISO country code or country name
    verified = Column(Boolean, default=False)
    trust_score = Column(Integer, default=0)
    avatar_url = Column(String)
    avatar_data = Column(LargeBinary)  # Store actual image data
    avatar_content_type = Column(String)  # e.g., 'image/jpeg', 'image/png'
    trending_score = Column(Integer, default=0)
    overall_sentiment = Column(String)  # good, neutral, negative (from reputation analysis)

    # Cache control
    last_analyzed = Column(DateTime, default=datetime.utcnow)
    cache_expires = Column(DateTime)

    # Analysis status
    is_analyzing = Column(Boolean, default=False)
    analysis_complete = Column(Boolean, default=False)

    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    platforms = relationship("Platform", back_populates="influencer", cascade="all, delete-orphan")
    timeline = relationship("TimelineEvent", back_populates="influencer", cascade="all, delete-orphan")
    products = relationship("Product", back_populates="influencer", cascade="all, delete-orphan")
    connections = relationship("Connection", foreign_keys="Connection.influencer_id", back_populates="influencer", cascade="all, delete-orphan")
    news_articles = relationship("NewsArticle", back_populates="influencer", cascade="all, delete-orphan")
    reputation_comments = relationship("ReputationComment", back_populates="influencer", cascade="all, delete-orphan")


class Platform(Base):
    """Social media platform presence."""

    __tablename__ = "platforms"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(Integer, ForeignKey("influencers.id"), nullable=False)
    platform_name = Column(String, nullable=False)  # youtube, tiktok, instagram, etc.
    username = Column(String)
    follower_count = Column(Integer, default=0)
    verified = Column(Boolean, default=False)
    url = Column(String)

    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    influencer = relationship("Influencer", back_populates="platforms")


class TimelineEvent(Base):
    """Timeline/milestone events."""

    __tablename__ = "timeline_events"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(Integer, ForeignKey("influencers.id"), nullable=False)
    date = Column(DateTime, nullable=False)
    event_type = Column(String)  # video, tweet, instagram, tiktok, collaboration, achievement
    title = Column(String, nullable=False)
    description = Column(Text)
    platform = Column(String)
    views = Column(Integer)
    likes = Column(Integer)
    url = Column(String)

    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    influencer = relationship("Influencer", back_populates="timeline")


class Product(Base):
    """Products sold/promoted by influencer."""

    __tablename__ = "products"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(Integer, ForeignKey("influencers.id"), nullable=False)
    name = Column(String, nullable=False)
    category = Column(String)  # food, cosmetics, merch, etc.
    quality_score = Column(Integer)  # 0-100
    openfoodfacts_data = Column(Text)  # JSON string
    sentiment_score = Column(Float)  # -1 to 1
    review_count = Column(Integer, default=0)
    description = Column(Text)

    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    influencer = relationship("Influencer", back_populates="products")
    reviews = relationship("ProductReview", back_populates="product", cascade="all, delete-orphan")


class ProductReview(Base):
    """User reviews/comments from social media about influencer products."""

    __tablename__ = "product_reviews"

    id = Column(Integer, primary_key=True, autoincrement=True)
    product_id = Column(Integer, ForeignKey("products.id"), nullable=False)
    author = Column(String)  # Username/name of reviewer
    comment = Column(Text, nullable=False)  # The actual review/comment
    platform = Column(String)  # twitter, reddit, youtube, tiktok, etc.
    sentiment = Column(String)  # positive, negative, neutral
    url = Column(String)  # Link to the comment/review if available
    date = Column(DateTime)  # When the comment was posted

    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    product = relationship("Product", back_populates="reviews")


class Connection(Base):
    """Social graph connections between influencers and entities (other influencers, agencies, brands, etc.)."""

    __tablename__ = "connections"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(Integer, ForeignKey("influencers.id"), nullable=False)

    # Can connect to either an influencer or an entity (agency, brand, etc.)
    connected_influencer_id = Column(Integer, ForeignKey("influencers.id"), nullable=True)

    # For non-influencer entities (ad agencies, brands, management companies, etc.)
    entity_name = Column(String)  # Name of the entity if not an influencer
    entity_type = Column(String)  # influencer, ad_agency, brand, management, record_label, network, etc.

    connection_type = Column(String)  # collaboration, sponsorship, managed_by, signed_to, partnership, etc.
    strength = Column(Integer, default=1)  # Number of interactions or deal size
    description = Column(Text)

    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    influencer = relationship("Influencer", foreign_keys=[influencer_id], back_populates="connections")
    connected_influencer = relationship("Influencer", foreign_keys=[connected_influencer_id])


class NewsArticle(Base):
    """News and drama articles about influencers."""

    __tablename__ = "news_articles"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(Integer, ForeignKey("influencers.id"), nullable=False)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=False)
    article_type = Column(String)  # news, drama, controversy, achievement, collaboration
    date = Column(DateTime)  # When the event/news happened
    source = Column(String)  # Source of the news
    url = Column(String)  # Link to the article/source
    sentiment = Column(String)  # positive, negative, neutral
    severity = Column(Integer, default=1)  # 1-10, how significant is this news/drama

    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    influencer = relationship("Influencer", back_populates="news_articles")


class ReputationComment(Base):
    """Social media comments about an influencer's reputation."""

    __tablename__ = "reputation_comments"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(Integer, ForeignKey("influencers.id"), nullable=False)
    author = Column(String)  # Username/name of commenter
    comment = Column(Text, nullable=False)  # The actual comment
    platform = Column(String)  # twitter, reddit, youtube, tiktok, etc.
    sentiment = Column(String)  # positive, negative, neutral
    url = Column(String)  # Link to the comment if available
    date = Column(DateTime)  # When the comment was posted

    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    influencer = relationship("Influencer", back_populates="reputation_comments")


class Review(Base):
    """User reviews of influencers."""

    __tablename__ = "reviews"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(Integer, ForeignKey("influencers.id"), nullable=False)
    user_name = Column(String, nullable=False)
    rating = Column(Integer, nullable=False)  # 1-5
    comment = Column(Text)
    product_name = Column(String)
    verified = Column(Boolean, default=False)

    created_at = Column(DateTime, default=datetime.utcnow)


def get_db():
    """Get database session - DEPRECATED: Use Supabase REST API instead."""
    # This function is kept for backward compatibility
    # Routes should use supabase_client instead
    raise NotImplementedError(
        "PostgreSQL direct connection is disabled. "
        "Use 'from src.services.supabase_client import supabase' instead"
    )
    yield


def init_db():
    """Initialize database tables - DISABLED: Tables created via Supabase migrations."""
    # Tables are already created in Supabase via SQL migrations
    # This function does nothing to avoid connection issues
    pass
