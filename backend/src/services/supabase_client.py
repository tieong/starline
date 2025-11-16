"""Supabase REST API client."""
from supabase import create_client, Client
from src.config.settings import settings


# Initialize Supabase client
def get_supabase_client() -> Client:
    """Get Supabase client instance."""
    if not settings.supabase_url or not settings.supabase_anon_key:
        raise ValueError("SUPABASE_URL and SUPABASE_ANON_KEY must be set in environment variables")

    return create_client(settings.supabase_url, settings.supabase_anon_key)


# Global client instance
supabase: Client = get_supabase_client()
