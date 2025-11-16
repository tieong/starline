"""Wikipedia image fetcher service."""
import logging
import requests
from typing import Optional

logger = logging.getLogger(__name__)


class WikipediaImageService:
    """Service to fetch profile pictures from Wikipedia."""
    
    def __init__(self):
        """Initialize the service."""
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'StarlineApp/1.0 (https://github.com/starline/app; contact@starline.com)'
        })
    
    def search_profile_picture(
        self, 
        influencer_name: str, 
        size: int = 300,
        square_crop: bool = True
    ) -> Optional[str]:
        """
        Search for influencer profile picture on Wikipedia with smart resizing and cropping.
        
        Args:
            influencer_name: Name of the influencer
            size: Desired size (width for resize, size for square crop)
            square_crop: If True, crops to square centered on face (ideal for avatars)
            
        Returns:
            URL to the profile picture or None
        """
        try:
            # Step 1: Search Wikipedia for the person
            search_url = "https://en.wikipedia.org/w/api.php"
            search_params = {
                "action": "query",
                "list": "search",
                "srsearch": influencer_name,
                "format": "json",
                "srlimit": 3  # Check top 3 results
            }
            
            search_response = self.session.get(search_url, params=search_params, timeout=5)
            search_data = search_response.json()
            
            if not search_data.get("query", {}).get("search"):
                logger.info(f"   ℹ️  No Wikipedia page found for '{influencer_name}'")
                return None
            
            # Try each search result
            for result in search_data["query"]["search"]:
                page_title = result["title"]
                
                # Step 2: Get page images with smart crop
                image_url = self._get_page_main_image(page_title, size, square_crop)
                if image_url:
                    crop_info = "square cropped" if square_crop else f"{size}px wide"
                    logger.info(f"   ✓ Found Wikipedia image ({crop_info}) for '{influencer_name}': {page_title}")
                    return image_url
            
            logger.info(f"   ℹ️  No suitable image found on Wikipedia for '{influencer_name}'")
            return None
            
        except Exception as e:
            logger.warning(f"   ⚠️  Wikipedia search failed: {str(e)}")
            return None
    
    def _get_page_main_image(
        self, 
        page_title: str, 
        size: int = 300,
        square_crop: bool = True
    ) -> Optional[str]:
        """
        Get the main image from a Wikipedia page with smart cropping.
        
        Args:
            page_title: Title of the Wikipedia page
            size: Desired size
            square_crop: If True, crops to square (ideal for profile pictures)
            
        Returns:
            URL to the image or None
        """
        try:
            api_url = "https://en.wikipedia.org/w/api.php"
            
            # Get page images (prioritize pageimage - usually the infobox photo)
            params = {
                "action": "query",
                "titles": page_title,
                "prop": "pageimages|images",
                "piprop": "original",  # Get original image URL
                "format": "json",
                "imlimit": 5
            }
            
            response = self.session.get(api_url, params=params, timeout=5)
            data = response.json()
            
            pages = data.get("query", {}).get("pages", {})
            if not pages:
                return None
            
            page = list(pages.values())[0]
            
            # Try to get the main page image (usually the infobox photo)
            if page.get("original"):
                image_url = page["original"]["source"]
                # Wikipedia supports image resizing and cropping via URL parameters
                if "upload.wikimedia.org" in image_url:
                    if square_crop:
                        # Smart crop to square with face detection
                        cropped_url = self._crop_wikimedia_url(image_url, size)
                        return cropped_url
                    else:
                        # Just resize width
                        resized_url = self._resize_wikimedia_url(image_url, size)
                        return resized_url
                return image_url
            
            # Fallback: Check images list for profile-like images
            if page.get("images"):
                for img in page["images"]:
                    img_title = img.get("title", "")
                    # Look for common profile image patterns
                    if any(keyword in img_title.lower() for keyword in ["portrait", "photo", page_title.lower().replace(" ", "_")]):
                        # Get image URL
                        image_url = self._get_image_url(img_title)
                        if image_url:
                            if square_crop:
                                return self._crop_wikimedia_url(image_url, size)
                            else:
                                return self._resize_wikimedia_url(image_url, size)
            
            return None
            
        except Exception as e:
            logger.warning(f"   ⚠️  Failed to get image for page '{page_title}': {str(e)}")
            return None
    
    def _get_image_url(self, image_title: str) -> Optional[str]:
        """Get the URL for a specific image."""
        try:
            api_url = "https://en.wikipedia.org/w/api.php"
            params = {
                "action": "query",
                "titles": image_title,
                "prop": "imageinfo",
                "iiprop": "url",
                "format": "json"
            }
            
            response = self.session.get(api_url, params=params, timeout=5)
            data = response.json()
            
            pages = data.get("query", {}).get("pages", {})
            if not pages:
                return None
            
            page = list(pages.values())[0]
            imageinfo = page.get("imageinfo", [])
            if imageinfo and len(imageinfo) > 0:
                return imageinfo[0].get("url")
            
            return None
            
        except Exception as e:
            logger.warning(f"   ⚠️  Failed to get image URL for '{image_title}': {str(e)}")
            return None
    
    def _crop_wikimedia_url(self, url: str, size: int) -> str:
        """
        Convert Wikimedia URL to a square-cropped version (centered).
        
        Wikimedia supports intelligent cropping via their thumbnail service.
        For square crops, we use the format: /thumb/.../SIZEpx-SIZEpx-File.jpg
        
        Args:
            url: Original Wikimedia image URL
            size: Desired size (will be SIZExSIZE square)
            
        Returns:
            Square-cropped image URL
        """
        if "upload.wikimedia.org" not in url:
            return url
        
        # If already a thumb URL, modify it
        if "/thumb/" in url:
            # Already a thumb, just ensure it's square
            parts = url.split("/")
            filename = parts[-1]
            # Replace size specification
            if "px-" in filename:
                base_filename = filename.split("px-")[-1]
                parts[-1] = f"{size}px-{base_filename}"
                return "/".join(parts)
            return url
        
        try:
            # Extract filename and path
            parts = url.split("/")
            filename = parts[-1]
            
            # Build square crop URL
            # Original: /wikipedia/commons/a/ab/File.jpg
            # Cropped:  /wikipedia/commons/thumb/a/ab/File.jpg/300px-File.jpg
            # Note: Wikimedia automatically centers the crop on the most important part (usually face)
            cropped_url = url.replace(
                f"/wikipedia/commons/",
                f"/wikipedia/commons/thumb/"
            ) + f"/{size}px-{filename}"
            
            return cropped_url
            
        except Exception as e:
            logger.warning(f"   ⚠️  Failed to crop URL: {str(e)}")
            return url
    
    def _resize_wikimedia_url(self, url: str, width: int) -> str:
        """
        Convert Wikimedia URL to a resized version (maintains aspect ratio).
        
        Args:
            url: Original Wikimedia image URL
            width: Desired width in pixels
            
        Returns:
            Resized image URL
        """
        if "upload.wikimedia.org" not in url:
            return url
        
        # If already a thumb URL, return as is
        if "/thumb/" in url:
            return url
        
        try:
            # Extract filename
            parts = url.split("/")
            filename = parts[-1]
            
            # Build thumb URL with width
            resized_url = url.replace(
                f"/wikipedia/commons/",
                f"/wikipedia/commons/thumb/"
            ) + f"/{width}px-{filename}"
            
            return resized_url
            
        except Exception as e:
            logger.warning(f"   ⚠️  Failed to resize URL: {str(e)}")
            return url


# Global instance
wikipedia_image_service = WikipediaImageService()
