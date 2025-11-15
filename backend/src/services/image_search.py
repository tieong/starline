"""Image search service for finding profile pictures."""
import logging
import re
from typing import Optional
from urllib.parse import quote_plus

import requests
from bs4 import BeautifulSoup

logger = logging.getLogger(__name__)


class ImageSearchService:
    """Service for searching profile pictures using various search engines."""

    def __init__(self):
        """Initialize image search service."""
        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
        }
        self.timeout = 10

    def search_profile_picture(self, influencer_name: str, platform: str = "", username: str = "") -> Optional[str]:
        """
        Search for influencer profile picture using multiple search engines.

        Args:
            influencer_name: Name of the influencer
            platform: Optional platform name to refine search
            username: Optional username/handle for more specific search

        Returns:
            URL of the first image found, or None
        """
        # Build search query - prioritize username over name for accuracy
        if username:
            # Use username which is more unique (e.g., @AntoineDaniel instead of Antoine Daniel)
            base_query = username.lstrip("@")
            if platform:
                query = f'"{base_query}" {platform} profile picture'
            else:
                query = f'"{base_query}" youtuber influencer profile'
        elif platform:
            # Add quotes around name for exact matching + specify it's a content creator
            query = f'"{influencer_name}" {platform} youtuber content creator profile'
        else:
            query = f'"{influencer_name}" youtuber influencer profile picture'

        logger.info(f"      🔍 Searching for profile picture: {query}")

        # Try multiple search engines in order
        search_engines = [
            self._search_bing,
            self._search_yandex,
            self._search_duckduckgo,
        ]

        for search_func in search_engines:
            try:
                image_url = search_func(query)
                if image_url:
                    logger.info(f"      ✓ Found profile picture via {search_func.__name__}")
                    return image_url
            except Exception as e:
                logger.warning(f"      ⚠ {search_func.__name__} failed: {str(e)}")
                continue

        logger.warning(f"      ⚠ Could not find profile picture for {influencer_name}")
        return None

    def _search_bing(self, query: str) -> Optional[str]:
        """Search Bing Images for profile picture."""
        url = f"https://www.bing.com/images/search?q={quote_plus(query)}&first=1"

        response = requests.get(url, headers=self.headers, timeout=self.timeout)
        response.raise_for_status()

        # Parse HTML to find image URLs
        soup = BeautifulSoup(response.text, 'html.parser')

        # Bing stores image data in m attribute
        img_tags = soup.find_all('a', class_='iusc')

        for img_tag in img_tags:
            m_attr = img_tag.get('m')
            if m_attr:
                # Parse the JSON-like m attribute
                import json
                try:
                    m_data = json.loads(m_attr)
                    image_url = m_data.get('murl') or m_data.get('turl')
                    if image_url and self._is_valid_image_url(image_url):
                        return image_url
                except:
                    continue

        # Fallback: try to find img tags directly
        img_tags = soup.find_all('img', class_='mimg')
        for img in img_tags[:5]:
            src = img.get('src')
            if src and self._is_valid_image_url(src) and not src.startswith('data:'):
                return src

        return None

    def _search_yandex(self, query: str) -> Optional[str]:
        """Search Yandex Images for profile picture."""
        url = f"https://yandex.com/images/search?text={quote_plus(query)}"

        response = requests.get(url, headers=self.headers, timeout=self.timeout)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')

        # Yandex uses serp-item class for image results
        img_containers = soup.find_all('div', class_='serp-item')

        for container in img_containers[:5]:
            # Look for img tag
            img_tag = container.find('img')
            if img_tag:
                src = img_tag.get('src')
                if src and self._is_valid_image_url(src) and not src.startswith('data:'):
                    # Yandex often uses protocol-relative URLs
                    if src.startswith('//'):
                        src = 'https:' + src
                    return src

        return None

    def _search_duckduckgo(self, query: str) -> Optional[str]:
        """Search DuckDuckGo Images for profile picture."""
        url = f"https://duckduckgo.com/?q={quote_plus(query)}&iax=images&ia=images"

        response = requests.get(url, headers=self.headers, timeout=self.timeout)
        response.raise_for_status()

        # DuckDuckGo loads images via JavaScript, so scraping is harder
        # Try to find image URLs in the page source
        image_urls = re.findall(r'https?://[^\s<>"]+?\.(?:jpg|jpeg|png|webp)', response.text)

        for url in image_urls[:10]:
            if self._is_valid_image_url(url) and 'logo' not in url.lower():
                return url

        return None

    def _is_valid_image_url(self, url: str) -> bool:
        """Check if URL looks like a valid image URL."""
        if not url or len(url) < 10:
            return False

        # Check if it's a reasonable image URL
        image_extensions = ('.jpg', '.jpeg', '.png', '.webp', '.gif')
        lower_url = url.lower()

        # Must be http/https
        if not (url.startswith('http://') or url.startswith('https://')):
            return False

        # Should have image extension or be from known CDN
        has_extension = any(ext in lower_url for ext in image_extensions)
        is_cdn = any(cdn in lower_url for cdn in ['cdn', 'img', 'image', 'media', 'photo'])

        return has_extension or is_cdn


# Global instance
image_search_service = ImageSearchService()
