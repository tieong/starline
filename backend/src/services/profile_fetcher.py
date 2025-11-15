"""Service to validate profile picture URLs from social media platforms."""
import logging
import requests
from typing import Optional

logger = logging.getLogger(__name__)


class ProfilePictureFetcher:
    """Validates profile picture URLs from various social media platforms."""

    def __init__(self):
        """Initialize the fetcher."""
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        })

    def validate_url(self, url: str) -> bool:
        """
        Validate that a profile picture URL is accessible.

        Args:
            url: The profile picture URL to validate

        Returns:
            True if URL is accessible (HTTP 200), False otherwise
        """
        if not url or not isinstance(url, str):
            return False

        # Skip placeholder URLs
        if "placeholder" in url.lower() or "example.com" in url.lower():
            return False

        # Skip Instagram/Facebook/TikTok lookaside crawler blocker URLs
        # These URLs return 200 but serve a blocker page instead of actual images
        blocked_patterns = [
            "lookaside.fbsbx.com",  # Facebook/Instagram crawler blocker
            "lookaside.instagram.com",  # Instagram crawler blocker
            "scontent.cdninstagram.com",  # Instagram CDN (often blocked)
            "p16-sign",  # TikTok CDN (blocks crawlers)
            "p77-sign",  # TikTok CDN (blocks crawlers)
            "tiktokcdn.com",  # TikTok CDN (often blocked)
            "tiktok.com/avatar",  # TikTok direct avatar links (blocked)
        ]

        url_lower = url.lower()
        for pattern in blocked_patterns:
            if pattern in url_lower:
                logger.info(f"   ⚠ Skipping blocked CDN URL (Instagram/TikTok/FB): {url[:60]}...")
                return False

        try:
            # Test if the URL is accessible
            response = self.session.head(url, timeout=5, allow_redirects=True)

            if response.status_code == 200:
                # Check if it's actually an image
                content_type = response.headers.get('content-type', '').lower()
                if 'image' in content_type:
                    logger.info(f"   ✓ AI-provided URL is valid: {url[:80]}...")
                    return True
                else:
                    logger.warning(f"   ✗ URL is not an image (content-type: {content_type}): {url[:80]}...")
                    return False
            else:
                logger.warning(f"   ✗ URL returned {response.status_code}: {url[:80]}...")
                return False

        except Exception as e:
            logger.warning(f"   ✗ Error validating URL: {str(e)}")
            return False



# Global instance
profile_fetcher = ProfilePictureFetcher()
