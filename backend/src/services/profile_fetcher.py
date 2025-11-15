"""Service to validate profile picture URLs from social media platforms."""
import requests
from typing import Optional


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

        try:
            # Test if the URL is accessible
            response = self.session.head(url, timeout=5, allow_redirects=True)

            if response.status_code == 200:
                # Check if it's actually an image
                content_type = response.headers.get('content-type', '').lower()
                if 'image' in content_type:
                    return True
                else:
                    print(f"URL is not an image: {url} (content-type: {content_type})")
                    return False
            else:
                print(f"URL returned {response.status_code}: {url}")
                return False

        except Exception as e:
            print(f"Error validating URL {url}: {e}")
            return False



# Global instance
profile_fetcher = ProfilePictureFetcher()
