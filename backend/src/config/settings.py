"""Application configuration settings."""

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings."""

    # API Settings
    app_name: str = "Starline Backend"
    app_version: str = "0.1.0"
    debug: bool = True

    # Database Settings
    database_url: str = ""

    # Supabase Settings
    supabase_url: str = ""
    supabase_anon_key: str = ""

    # AI Provider Settings
    ai_provider: str = "perplexity"  # Options: "blackbox" or "perplexity"

    # Blackbox AI Settings
    blackbox_api_key: str = ""
    blackbox_base_url: str = "https://api.blackbox.ai"
    blackbox_model: str = "blackboxai/openai/gpt-4"

    # Perplexity AI Settings
    perplexity_api_key: str = ""
    perplexity_base_url: str = "https://api.perplexity.ai"
    perplexity_model: str = "sonar-pro"  # Options: "sonar-pro" or "sonar"

    # External APIs
    youtube_api_key: str = ""

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
    )


settings = Settings()
