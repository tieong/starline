"""Supabase database operations wrapper.

This module provides a simplified interface for database operations using Supabase REST API,
compatible with the InfluencerAnalyzer which previously used SQLAlchemy.
"""
from typing import Optional, List, Dict, Any
from datetime import datetime
from src.services.supabase_client import supabase
from src.models.database import (
    Influencer, Platform, Product, ProductReview,
    TimelineEvent, Connection, NewsArticle, ReputationComment
)


class SupabaseDB:
    """Database operations using Supabase REST API."""
    
    # ========== Influencer Operations ==========
    
    def get_influencer_by_name(self, name: str) -> Optional[Dict]:
        """Get influencer by name."""
        response = supabase.table("influencers").select("*").ilike("name", name).execute()
        return response.data[0] if response.data else None
    
    def get_influencer_by_id(self, influencer_id: int) -> Optional[Dict]:
        """Get influencer by ID."""
        response = supabase.table("influencers").select("*").eq("id", influencer_id).execute()
        return response.data[0] if response.data else None
    
    def create_influencer(self, data: Dict[str, Any]) -> Dict:
        """Create a new influencer."""
        response = supabase.table("influencers").insert(data).execute()
        return response.data[0] if response.data else None
    
    def update_influencer(self, influencer_id: int, data: Dict[str, Any]) -> Dict:
        """Update an influencer."""
        response = supabase.table("influencers").update(data).eq("id", influencer_id).execute()
        return response.data[0] if response.data else None
    
    # ========== Platform Operations ==========
    
    def delete_platforms(self, influencer_id: int):
        """Delete all platforms for an influencer."""
        supabase.table("platforms").delete().eq("influencer_id", influencer_id).execute()
    
    def create_platform(self, data: Dict[str, Any]) -> Dict:
        """Create a new platform."""
        response = supabase.table("platforms").insert(data).execute()
        return response.data[0] if response.data else None
    
    # ========== Product Operations ==========
    
    def get_product_by_id(self, product_id: int) -> Optional[Dict]:
        """Get product by ID."""
        response = supabase.table("products").select("*").eq("id", product_id).execute()
        return response.data[0] if response.data else None
    
    def delete_products(self, influencer_id: int):
        """Delete all products for an influencer."""
        supabase.table("products").delete().eq("influencer_id", influencer_id).execute()
    
    def create_product(self, data: Dict[str, Any]) -> Dict:
        """Create a new product."""
        response = supabase.table("products").insert(data).execute()
        return response.data[0] if response.data else None
    
    def update_product(self, product_id: int, data: Dict[str, Any]) -> Dict:
        """Update a product."""
        response = supabase.table("products").update(data).eq("id", product_id).execute()
        return response.data[0] if response.data else None
    
    # ========== Product Review Operations ==========
    
    def delete_product_reviews(self, product_id: int):
        """Delete all reviews for a product."""
        supabase.table("product_reviews").delete().eq("product_id", product_id).execute()
    
    def create_product_review(self, data: Dict[str, Any]) -> Dict:
        """Create a new product review."""
        response = supabase.table("product_reviews").insert(data).execute()
        return response.data[0] if response.data else None
    
    # ========== Timeline Operations ==========
    
    def delete_timeline_events(self, influencer_id: int):
        """Delete all timeline events for an influencer."""
        supabase.table("timeline_events").delete().eq("influencer_id", influencer_id).execute()
    
    def create_timeline_event(self, data: Dict[str, Any]) -> Dict:
        """Create a new timeline event."""
        response = supabase.table("timeline_events").insert(data).execute()
        return response.data[0] if response.data else None
    
    # ========== Connection Operations ==========
    
    def delete_connections(self, influencer_id: int):
        """Delete all connections for an influencer."""
        supabase.table("connections").delete().eq("influencer_id", influencer_id).execute()
    
    def create_connection(self, data: Dict[str, Any]) -> Dict:
        """Create a new connection."""
        response = supabase.table("connections").insert(data).execute()
        return response.data[0] if response.data else None
    
    # ========== News Article Operations ==========
    
    def delete_news_articles(self, influencer_id: int):
        """Delete all news articles for an influencer."""
        supabase.table("news_articles").delete().eq("influencer_id", influencer_id).execute()
    
    def create_news_article(self, data: Dict[str, Any]) -> Dict:
        """Create a new news article."""
        response = supabase.table("news_articles").insert(data).execute()
        return response.data[0] if response.data else None
    
    # ========== Reputation Comment Operations ==========
    
    def delete_reputation_comments(self, influencer_id: int):
        """Delete all reputation comments for an influencer."""
        supabase.table("reputation_comments").delete().eq("influencer_id", influencer_id).execute()
    
    def create_reputation_comment(self, data: Dict[str, Any]) -> Dict:
        """Create a new reputation comment."""
        response = supabase.table("reputation_comments").insert(data).execute()
        return response.data[0] if response.data else None


# Global instance
supabase_db = SupabaseDB()

