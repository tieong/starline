"""OpenFoodFacts and Open Beauty Facts API client."""
import json
import logging
import requests
from typing import Any, Dict, Optional

logger = logging.getLogger(__name__)


class OpenFoodFactsClient:
    """Client for OpenFoodFacts and Open Beauty Facts APIs."""

    FOOD_API_URL = "https://world.openfoodfacts.org/api/v2/product"
    BEAUTY_API_URL = "https://world.openbeautyfacts.org/api/v2/product"

    def __init__(self):
        """Initialize the client."""
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Starline - Influencer Trust Platform - Contact: your@email.com'
        })

    def search_product(self, product_name: str, category: str = "food") -> Optional[Dict[str, Any]]:
        """
        Search for a product by name.

        Args:
            product_name: Name of the product
            category: Product category (food or cosmetics)

        Returns:
            Product data if found, None otherwise
        """
        # Try to find product by searching
        search_url = (
            "https://world.openfoodfacts.org/cgi/search.pl"
            if category == "food"
            else "https://world.openbeautyfacts.org/cgi/search.pl"
        )

        try:
            params = {
                "search_terms": product_name,
                "search_simple": 1,
                "action": "process",
                "json": 1,
                "page_size": 5
            }

            response = self.session.get(search_url, params=params, timeout=10)
            response.raise_for_status()

            data = response.json()
            products = data.get("products", [])

            if not products:
                logger.info(f"   No products found for '{product_name}' in {category} database")
                return None

            # Return the first/best match
            best_match = products[0]
            logger.info(f"   ✓ Found product: {best_match.get('product_name', 'Unknown')} (barcode: {best_match.get('code', 'N/A')})")

            return self._parse_product_data(best_match, category)

        except Exception as e:
            logger.warning(f"   Failed to search {category} product '{product_name}': {str(e)}")
            return None

    def get_product_by_barcode(self, barcode: str, category: str = "food") -> Optional[Dict[str, Any]]:
        """
        Get product details by barcode.

        Args:
            barcode: Product barcode (EAN/UPC)
            category: Product category (food or cosmetics)

        Returns:
            Product data if found, None otherwise
        """
        api_url = self.FOOD_API_URL if category == "food" else self.BEAUTY_API_URL

        try:
            response = self.session.get(f"{api_url}/{barcode}", timeout=10)
            response.raise_for_status()

            data = response.json()

            if data.get("status") != 1:
                return None

            return self._parse_product_data(data.get("product", {}), category)

        except Exception as e:
            logger.warning(f"   Failed to fetch {category} product by barcode '{barcode}': {str(e)}")
            return None

    def _parse_product_data(self, product: Dict[str, Any], category: str) -> Dict[str, Any]:
        """
        Parse product data into a standardized format.

        Args:
            product: Raw product data from API
            category: Product category

        Returns:
            Parsed product data
        """
        if category == "food":
            return self._parse_food_data(product)
        else:
            return self._parse_beauty_data(product)

    def _parse_food_data(self, product: Dict[str, Any]) -> Dict[str, Any]:
        """Parse food product data."""
        # Extract key nutrition data
        nutriments = product.get("nutriments", {})

        # Nutri-Score (A=best, E=worst)
        nutriscore = product.get("nutriscore_grade", "").upper() or None

        # NOVA group (1=unprocessed, 4=ultra-processed)
        nova_group = product.get("nova_group")

        # Ecoscore (A=best, E=worst)
        ecoscore = product.get("ecoscore_grade", "").upper() or None

        # Calculate quality score (0-100)
        quality_score = self._calculate_food_quality_score(
            nutriscore, nova_group, ecoscore, nutriments
        )

        # Determine if healthy
        is_healthy = quality_score >= 60

        return {
            "type": "food",
            "product_name": product.get("product_name"),
            "brands": product.get("brands"),
            "barcode": product.get("code"),
            "nutriscore": nutriscore,
            "nova_group": nova_group,
            "ecoscore": ecoscore,
            "quality_score": quality_score,
            "is_healthy": is_healthy,
            "nutriments": {
                "energy_kcal": nutriments.get("energy-kcal_100g"),
                "fat": nutriments.get("fat_100g"),
                "saturated_fat": nutriments.get("saturated-fat_100g"),
                "sugars": nutriments.get("sugars_100g"),
                "salt": nutriments.get("salt_100g"),
                "fiber": nutriments.get("fiber_100g"),
                "proteins": nutriments.get("proteins_100g"),
            },
            "ingredients_text": product.get("ingredients_text"),
            "allergens": product.get("allergens_tags", []),
            "image_url": product.get("image_url"),
            "url": f"https://world.openfoodfacts.org/product/{product.get('code')}",
        }

    def _parse_beauty_data(self, product: Dict[str, Any]) -> Dict[str, Any]:
        """Parse cosmetics/beauty product data."""
        # Beauty products don't have Nutri-Score, but have ingredient analysis
        ingredients_analysis = product.get("ingredients_analysis_tags", [])

        # Calculate quality score based on ingredients
        quality_score = self._calculate_beauty_quality_score(
            product, ingredients_analysis
        )

        return {
            "type": "cosmetics",
            "product_name": product.get("product_name"),
            "brands": product.get("brands"),
            "barcode": product.get("code"),
            "quality_score": quality_score,
            "ingredients_text": product.get("ingredients_text"),
            "ingredients_analysis": ingredients_analysis,
            "allergens": product.get("allergens_tags", []),
            "categories": product.get("categories_tags", []),
            "image_url": product.get("image_url"),
            "url": f"https://world.openbeautyfacts.org/product/{product.get('code')}",
        }

    def _calculate_food_quality_score(
        self,
        nutriscore: Optional[str],
        nova_group: Optional[int],
        ecoscore: Optional[str],
        nutriments: Dict[str, Any]
    ) -> int:
        """
        Calculate quality score for food products (0-100).

        Higher score = healthier product.
        """
        score = 50  # Base score

        # Nutri-Score contribution (40 points max)
        if nutriscore:
            nutriscore_scores = {"A": 40, "B": 30, "C": 20, "D": 10, "E": 0}
            score += nutriscore_scores.get(nutriscore, 0)

        # NOVA group contribution (20 points max)
        # 1=unprocessed (best), 4=ultra-processed (worst)
        if nova_group:
            nova_scores = {1: 20, 2: 15, 3: 10, 4: 0}
            score += nova_scores.get(nova_group, 0)

        # Ecoscore contribution (10 points max)
        if ecoscore:
            ecoscore_scores = {"A": 10, "B": 7, "C": 5, "D": 3, "E": 0}
            score += ecoscore_scores.get(ecoscore, 0)

        # Nutritional penalties
        if nutriments.get("sugars_100g"):
            if nutriments["sugars_100g"] > 15:  # High sugar
                score -= 10
            elif nutriments["sugars_100g"] > 10:
                score -= 5

        if nutriments.get("salt_100g"):
            if nutriments["salt_100g"] > 1.5:  # High salt
                score -= 10
            elif nutriments["salt_100g"] > 1.0:
                score -= 5

        # Cap between 0 and 100
        return max(0, min(100, score))

    def _calculate_beauty_quality_score(
        self,
        product: Dict[str, Any],
        ingredients_analysis: list
    ) -> int:
        """
        Calculate quality score for cosmetics (0-100).

        Higher score = safer/better quality product.
        """
        score = 70  # Base score for cosmetics

        # Analyze ingredients
        for tag in ingredients_analysis:
            if "palm-oil-free" in tag:
                score += 10
            elif "palm-oil" in tag:
                score -= 5

            if "vegan" in tag:
                score += 5

            if "non-vegan" in tag:
                score -= 3

        # Check for problematic ingredients
        ingredients_text = product.get("ingredients_text", "").lower()

        # Harmful ingredients (reduce score)
        harmful = ["paraben", "sulfate", "phthalate", "formaldehyde", "triclosan"]
        for ingredient in harmful:
            if ingredient in ingredients_text:
                score -= 10

        # Beneficial ingredients (increase score)
        beneficial = ["vitamin", "natural", "organic", "plant"]
        for ingredient in beneficial:
            if ingredient in ingredients_text:
                score += 5

        # Cap between 0 and 100
        return max(0, min(100, score))


# Global client instance
openfoodfacts_client = OpenFoodFactsClient()
