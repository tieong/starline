"""Database models and session management."""
from datetime import datetime
from typing import Optional

from sqlalchemy import (
    Boolean,
    Column,
    DateTime,
    Float,
    ForeignKey,
    Integer,
    String,
    Text,
    create_engine,
)
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

from src.config.settings import settings

# Create database engine
engine = create_engine(settings.database_url, echo=settings.debug)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


class Influencer(Base):
    """Influencer model."""

    __tablename__ = "influencers"

    id = Column(String, primary_key=True)
    name = Column(String, nullable=False, index=True)
    bio = Column(Text)
    verified = Column(Boolean, default=False)
    trust_score = Column(Integer, default=0)
    avatar_url = Column(String)
    trending_score = Column(Integer, default=0)

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


class Platform(Base):
    """Social media platform presence."""

    __tablename__ = "platforms"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(String, ForeignKey("influencers.id"), nullable=False)
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
    influencer_id = Column(String, ForeignKey("influencers.id"), nullable=False)
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
    influencer_id = Column(String, ForeignKey("influencers.id"), nullable=False)
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


class Connection(Base):
    """Social graph connections between influencers."""

    __tablename__ = "connections"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(String, ForeignKey("influencers.id"), nullable=False)
    connected_influencer_id = Column(String, ForeignKey("influencers.id"), nullable=False)
    connection_type = Column(String)  # collaboration, mention, tag, etc.
    strength = Column(Integer, default=1)  # Number of interactions
    description = Column(Text)

    created_at = Column(DateTime, default=datetime.utcnow)

    # Relationships
    influencer = relationship("Influencer", foreign_keys=[influencer_id], back_populates="connections")
    connected_influencer = relationship("Influencer", foreign_keys=[connected_influencer_id])


class Review(Base):
    """User reviews of influencers."""

    __tablename__ = "reviews"

    id = Column(Integer, primary_key=True, autoincrement=True)
    influencer_id = Column(String, ForeignKey("influencers.id"), nullable=False)
    user_name = Column(String, nullable=False)
    rating = Column(Integer, nullable=False)  # 1-5
    comment = Column(Text)
    product_name = Column(String)
    verified = Column(Boolean, default=False)

    created_at = Column(DateTime, default=datetime.utcnow)


def get_db():
    """Get database session."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def init_db():
    """Initialize database tables."""
    Base.metadata.create_all(bind=engine)
