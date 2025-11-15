"""Image search service for finding profile pictures."""
import concurrent.futures
import logging
import re
from typing import Dict, List, Optional, Tuple
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

        logger.info(f"      🔍 Searching across 5 search engines in parallel: {query}")

        # Extract key identifiers from name/username for URL validation
        name_parts = self._extract_name_identifiers(influencer_name, username)

        # Run all search engines in parallel
        search_engines = {
            'Google': self._search_google,
            'Bing': self._search_bing,
            'Kagi': self._search_kagi,
            'Yandex': self._search_yandex,
            'DuckDuckGo': self._search_duckduckgo,
        }

        results = {}

        # Execute all searches concurrently
        with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
            future_to_engine = {
                executor.submit(search_func, query, name_parts): engine_name
                for engine_name, search_func in search_engines.items()
            }

            for future in concurrent.futures.as_completed(future_to_engine):
                engine_name = future_to_engine[future]
                try:
                    image_url = future.result()
                    if image_url:
                        results[engine_name] = image_url
                        logger.info(f"      ✓ {engine_name} found: {image_url[:60]}...")
                    else:
                        logger.debug(f"      ⚠ {engine_name}: No valid results")
                except Exception as e:
                    logger.warning(f"      ⚠ {engine_name} failed: {str(e)}")

        if not results:
            logger.warning(f"      ⚠ No search engines found a valid profile picture")
            return None

        # Score and pick the best result
        logger.info(f"      📊 Comparing {len(results)} results...")
        best_url = self._pick_best_result(results, name_parts, platform)

        return best_url

    def _pick_best_result(self, results: Dict[str, str], name_parts: List[str], platform: str = "") -> str:
        """
        Score all results and pick the best one.

        Args:
            results: Dict mapping engine name to image URL
            name_parts: List of name identifiers to look for
            platform: Optional platform name

        Returns:
            Best scoring image URL
        """
        scores = {}

        for engine_name, url in results.items():
            score = 0
            url_lower = url.lower()

            # Score 1: Count how many name identifiers appear in URL
            identifier_matches = 0
            matched_identifiers = []
            for identifier in name_parts:
                if identifier in url_lower:
                    identifier_matches += 1
                    matched_identifiers.append(identifier)

            score += identifier_matches * 30  # 30 points per identifier match

            # Score 2: Prefer platform CDNs (official sources)
            platform_cdns = {
                'youtube': ['yt3.googleusercontent.com', 'ytimg.com', 'youtube.com'],
                'instagram': ['cdninstagram.com', 'instagram.com'],
                'twitter': ['twimg.com', 'twitter.com', 'x.com'],
                'tiktok': ['tiktokcdn.com', 'tiktok.com'],
                'twitch': ['static-cdn.jtvnw.net', 'twitch.tv'],
                'facebook': ['fbcdn.net', 'facebook.com'],
            }

            # Check if URL is from the primary platform CDN
            if platform and platform.lower() in platform_cdns:
                for cdn in platform_cdns[platform.lower()]:
                    if cdn in url_lower:
                        score += 50  # Big bonus for official platform CDN
                        break

            # Check if URL is from any known platform CDN
            for platform_name, cdns in platform_cdns.items():
                for cdn in cdns:
                    if cdn in url_lower:
                        score += 25  # Bonus for any platform CDN
                        break

            # Score 3: Penalize generic image hosting sites and blocked CDNs
            generic_hosts = ['imgur', 'purepeople', 'gettyimages', 'shutterstock', 'wikimedia']
            for generic in generic_hosts:
                if generic in url_lower:
                    score -= 20  # Penalty for generic image sites

            # Heavily penalize Instagram lookaside/blocked URLs
            blocked_instagram = ['lookaside.fbsbx.com', 'lookaside.instagram.com', 'scontent.cdninstagram.com']
            for blocked in blocked_instagram:
                if blocked in url_lower:
                    score -= 100  # Heavy penalty - these don't work

            # Score 4: Prefer URLs with "profile" or "avatar" in them
            if 'profile' in url_lower or 'avatar' in url_lower:
                score += 10

            # Score 5: Search engine reliability bonus
            engine_reliability = {
                'Google': 10,
                'Bing': 8,
                'Kagi': 7,
                'Yandex': 5,
                'DuckDuckGo': 3,
            }
            score += engine_reliability.get(engine_name, 0)

            scores[engine_name] = score
            logger.info(f"         {engine_name}: {score} points (matched: {', '.join(matched_identifiers) if matched_identifiers else 'none'})")

        # Pick the highest scoring result
        best_engine = max(scores, key=scores.get)
        best_url = results[best_engine]
        logger.info(f"      🏆 Best result: {best_engine} ({scores[best_engine]} points)")

        return best_url

    def _extract_name_identifiers(self, influencer_name: str, username: str = "") -> list:
        """
        Extract key identifiers from influencer name and username for URL validation.

        Args:
            influencer_name: Full name of influencer
            username: Optional username/handle

        Returns:
            List of lowercase identifier strings to check in URLs
        """
        identifiers = []

        # Add username without @ symbol
        if username:
            clean_username = username.lstrip("@").lower()
            identifiers.append(clean_username)

        # Add full name (no spaces, lowercase)
        clean_name = influencer_name.lower().replace(" ", "")
        identifiers.append(clean_name)

        # Add individual name parts (if multi-word name)
        name_parts = influencer_name.lower().split()
        if len(name_parts) > 1:
            # Add last name (usually most distinctive)
            identifiers.append(name_parts[-1])
            # Add first name
            identifiers.append(name_parts[0])

        return identifiers

    def _url_contains_identifier(self, url: str, identifiers: list) -> bool:
        """
        Check if URL contains any of the name identifiers.

        Args:
            url: Image URL to check
            identifiers: List of name identifiers

        Returns:
            True if URL contains at least one identifier
        """
        url_lower = url.lower()

        for identifier in identifiers:
            if identifier in url_lower:
                logger.debug(f"         ✓ Found '{identifier}' in URL")
                return True

        return False

    def _search_google(self, query: str, name_parts: list) -> Optional[str]:
        """Search Google Images for profile picture."""
        url = f"https://www.google.com/search?q={quote_plus(query)}&tbm=isch"

        response = requests.get(url, headers=self.headers, timeout=self.timeout)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')

        # Google uses various data attributes for images
        # Try to find images in img tags
        img_tags = soup.find_all('img')

        for img in img_tags[1:15]:  # Skip first (Google logo), check next 14
            # Try multiple attributes where Google stores image URLs
            for attr in ['src', 'data-src', 'data-iurl']:
                src = img.get(attr)
                if src and self._is_valid_image_url(src) and not src.startswith('data:'):
                    # Validate URL contains influencer name
                    if self._url_contains_identifier(src, name_parts):
                        return src

        # Try finding images in script tags (Google often embeds data in JS)
        scripts = soup.find_all('script')
        for script in scripts:
            if script.string:
                # Look for image URLs in JavaScript
                image_urls = re.findall(r'https?://[^\s<>"\\]+?\.(?:jpg|jpeg|png|webp)', script.string)
                for img_url in image_urls[:10]:
                    if self._is_valid_image_url(img_url) and self._url_contains_identifier(img_url, name_parts):
                        return img_url

        return None

    def _search_kagi(self, query: str, name_parts: list) -> Optional[str]:
        """Search Kagi Images for profile picture."""
        url = f"https://kagi.com/images?q={quote_plus(query)}"

        response = requests.get(url, headers=self.headers, timeout=self.timeout)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')

        # Kagi uses specific classes for image results
        img_containers = soup.find_all('a', class_='thumbnail-wrapper')

        for container in img_containers[:10]:
            img_tag = container.find('img')
            if img_tag:
                for attr in ['src', 'data-src']:
                    src = img_tag.get(attr)
                    if src and self._is_valid_image_url(src) and not src.startswith('data:'):
                        if self._url_contains_identifier(src, name_parts):
                            return src

        # Fallback: try any img tags
        img_tags = soup.find_all('img')
        for img in img_tags[:15]:
            src = img.get('src')
            if src and self._is_valid_image_url(src) and not src.startswith('data:'):
                if self._url_contains_identifier(src, name_parts):
                    return src

        return None

    def _search_bing(self, query: str, name_parts: list) -> Optional[str]:
        """Search Bing Images for profile picture."""
        url = f"https://www.bing.com/images/search?q={quote_plus(query)}&first=1"

        response = requests.get(url, headers=self.headers, timeout=self.timeout)
        response.raise_for_status()

        # Parse HTML to find image URLs
        soup = BeautifulSoup(response.text, 'html.parser')

        # Bing stores image data in m attribute
        img_tags = soup.find_all('a', class_='iusc')

        for img_tag in img_tags[:15]:
            m_attr = img_tag.get('m')
            if m_attr:
                # Parse the JSON-like m attribute
                import json
                try:
                    m_data = json.loads(m_attr)
                    image_url = m_data.get('murl') or m_data.get('turl')
                    if image_url and self._is_valid_image_url(image_url):
                        # Validate URL contains influencer name
                        if self._url_contains_identifier(image_url, name_parts):
                            return image_url
                except:
                    continue

        # Fallback: try to find img tags directly
        img_tags = soup.find_all('img', class_='mimg')
        for img in img_tags[:10]:
            src = img.get('src')
            if src and self._is_valid_image_url(src) and not src.startswith('data:'):
                if self._url_contains_identifier(src, name_parts):
                    return src

        return None

    def _search_yandex(self, query: str, name_parts: list) -> Optional[str]:
        """Search Yandex Images for profile picture."""
        url = f"https://yandex.com/images/search?text={quote_plus(query)}"

        response = requests.get(url, headers=self.headers, timeout=self.timeout)
        response.raise_for_status()

        soup = BeautifulSoup(response.text, 'html.parser')

        # Yandex uses serp-item class for image results
        img_containers = soup.find_all('div', class_='serp-item')

        for container in img_containers[:15]:
            # Look for img tag
            img_tag = container.find('img')
            if img_tag:
                src = img_tag.get('src')
                if src and self._is_valid_image_url(src) and not src.startswith('data:'):
                    # Yandex often uses protocol-relative URLs
                    if src.startswith('//'):
                        src = 'https:' + src
                    # Validate URL contains influencer name
                    if self._url_contains_identifier(src, name_parts):
                        return src

        return None

    def _search_duckduckgo(self, query: str, name_parts: list) -> Optional[str]:
        """Search DuckDuckGo Images for profile picture."""
        url = f"https://duckduckgo.com/?q={quote_plus(query)}&iax=images&ia=images"

        response = requests.get(url, headers=self.headers, timeout=self.timeout)
        response.raise_for_status()

        # DuckDuckGo loads images via JavaScript, so scraping is harder
        # Try to find image URLs in the page source
        image_urls = re.findall(r'https?://[^\s<>"]+?\.(?:jpg|jpeg|png|webp)', response.text)

        for url in image_urls[:20]:
            if self._is_valid_image_url(url) and 'logo' not in url.lower():
                # Validate URL contains influencer name
                if self._url_contains_identifier(url, name_parts):
                    return url

        return None

    def _is_valid_image_url(self, url: str) -> bool:
        """Check if URL looks like a valid image URL."""
        if not url or len(url) < 10:
            return False

        lower_url = url.lower()

        # Filter out Instagram/Facebook blocked URLs early
        blocked_patterns = ['lookaside.fbsbx.com', 'lookaside.instagram.com', 'scontent.cdninstagram.com']
        if any(pattern in lower_url for pattern in blocked_patterns):
            return False

        # Check if it's a reasonable image URL
        image_extensions = ('.jpg', '.jpeg', '.png', '.webp', '.gif')

        # Must be http/https
        if not (url.startswith('http://') or url.startswith('https://')):
            return False

        # Should have image extension or be from known CDN
        has_extension = any(ext in lower_url for ext in image_extensions)
        is_cdn = any(cdn in lower_url for cdn in ['cdn', 'img', 'image', 'media', 'photo'])

        return has_extension or is_cdn


# Global instance
image_search_service = ImageSearchService()
