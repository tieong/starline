"""Main FastAPI application."""
import logging

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from src.api.routes import router
from src.config.settings import settings
from src.models.database import init_db

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

# Set SQLAlchemy logging to DEBUG level (less verbose)
logging.getLogger('sqlalchemy.engine').setLevel(logging.WARNING)
logging.getLogger('sqlalchemy.pool').setLevel(logging.WARNING)
logging.getLogger('sqlalchemy.dialects').setLevel(logging.WARNING)

# Initialize FastAPI app
app = FastAPI(
    title=settings.app_name,
    version=settings.app_version,
    description="Real-time influencer trust rating and analysis platform",
)

# CORS middleware for frontend
# Allow all origins in debug mode, specific origins in production
allowed_origins = ["*"] if settings.debug else [
    "http://localhost:3000",
    "http://localhost:5173",
    "http://localhost:80",
    "http://frontend",
    "http://frontend:80",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routes
app.include_router(router)


@app.on_event("startup")
async def startup_event():
    """Initialize database on startup."""
    # Skip PostgreSQL init - using Supabase REST API instead
    # Tables are already created in Supabase via migrations
    # init_db()
    print(f"✅ {settings.app_name} v{settings.app_version} started")
    print(f"📚 API Documentation: http://localhost:8000/docs")
    print(f"🔗 Supabase URL: {settings.supabase_url}")
    print(f"🌐 CORS: {'All origins allowed (DEBUG MODE)' if settings.debug else 'Restricted origins'}")


if __name__ == "__main__":
    import uvicorn
    import multiprocessing

    # Use multiple workers for better concurrency
    # Dev: 8 workers for testing concurrent load
    # Prod: 4 workers or CPU count
    workers = 8 if settings.debug else min(4, multiprocessing.cpu_count())

    uvicorn.run(
        "src.main:app",
        host="0.0.0.0",
        port=8000,
        reload=settings.debug,
        workers=workers if not settings.debug else 1,  # Workers don't work with reload
    )
