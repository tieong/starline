"""Blackbox AI API client."""
import json
from typing import Any, Dict, List, Optional

from openai import OpenAI

from src.config.settings import settings


class BlackboxClient:
    """Client for interacting with Blackbox AI API."""

    def __init__(self):
        """Initialize Blackbox AI client."""
        self.client = OpenAI(
            api_key=settings.blackbox_api_key,
            base_url=settings.blackbox_base_url,
        )
        self.model = settings.blackbox_model

    def chat(
        self,
        messages: List[Dict[str, str]],
        temperature: float = 0.7,
        max_tokens: int = 2000,
        json_mode: bool = False,
    ) -> str:
        """
        Send a chat completion request to Blackbox AI.

        Args:
            messages: List of message dicts with 'role' and 'content'
            temperature: Sampling temperature (0-1)
            max_tokens: Maximum tokens in response
            json_mode: Whether to request JSON output

        Returns:
            Response content as string
        """
        try:
            response = self.client.chat.completions.create(
                model=self.model,
                messages=messages,
                temperature=temperature,
                max_tokens=max_tokens,
            )
            return response.choices[0].message.content
        except Exception as e:
            raise Exception(f"Blackbox AI API error: {str(e)}")

    def analyze_influencer_platforms(self, influencer_name: str) -> Dict[str, Any]:
        """
        Discover all social media platforms for an influencer.

        Args:
            influencer_name: Name of the influencer

        Returns:
            Dict with platform information
        """
        prompt = f"""Find all social media accounts for the influencer '{influencer_name}'.

CRITICAL REQUIREMENTS:
1. ONLY return data if this is a REAL, VERIFIED influencer with actual social media presence
2. If you cannot find ANY social media accounts, return {{"platforms": [], "error": "Influencer not found"}}
3. DO NOT make up or hallucinate data - if unsure, return empty platforms array
4. ALL platforms MUST belong to the SAME person/influencer
5. Verify identity by cross-referencing between platforms (similar content, same person in photos/videos, mutual references)
6. If you find accounts with the same name but belonging to different people, ONLY include the main influencer's accounts
7. The influencer MUST have at least one verified platform or significant follower count (>10,000) to be considered real

Search across YouTube, TikTok, Instagram, Twitter/X, and other relevant platforms.

For each platform found, provide:
1. Platform name (youtube, tiktok, instagram, twitter, etc.)
2. Username/handle (must be the SAME person across all platforms)
3. Approximate follower count
4. Whether the account is verified
5. Direct profile URL

PROFILE PICTURE REQUIREMENT:
⚠️ CRITICAL: DO NOT make up or guess profile picture URLs!
- If you cannot find a REAL, WORKING profile picture URL, set profile_picture_url to null
- DO NOT generate fake YouTube CDN URLs or any other fake URLs
- DO NOT use placeholder text like "ACTUAL_PROFILE_IMAGE_URL" or "COMPLETE_URL_HERE"
- DO NOT use unavatar.io or any proxy service
- The URL MUST be a complete, working image URL that you can actually verify
- If in doubt, set it to null - the system will find it automatically

Return ONLY a valid JSON object in this exact format:
{{
    "platforms": [
        {{
            "platform": "youtube",
            "username": "@username",
            "followers": 1000000,
            "verified": true,
            "url": "https://youtube.com/@username"
        }}
    ],
    "primary_platform": "youtube",
    "total_followers": 5000000,
    "bio": "Short bio description",
    "country": "USA",
    "profile_picture_url": "https://yt3.googleusercontent.com/ACTUAL_COMPLETE_CDN_URL"
}}

COUNTRY DETECTION:
- Detect the influencer's primary country based on:
  1. Where they are based/live (mentioned in bio or about section)
  2. Their nationality
  3. Location tags in their content
- Return the country name (e.g., "USA", "United Kingdom", "Japan", "Brazil")
- If you cannot determine the country, set it to null

If you cannot find a real profile picture URL, set profile_picture_url to null.

If the influencer is not found, return:
{{
    "platforms": [],
    "error": "Influencer not found"
}}"""

        messages = [
            {"role": "system", "content": "You are an AI assistant that researches social media influencers. CRITICAL: Only return data for REAL influencers with verifiable social media presence. If you cannot find the influencer or verify their identity, return empty platforms array with an error message. DO NOT hallucinate or make up data. Verify all platforms belong to the SAME person by cross-referencing content, appearance, and mutual platform references. Never mix accounts from different people with the same name. Always return valid JSON."},
            {"role": "user", "content": prompt}
        ]

        response = self.chat(messages, temperature=0.3, max_tokens=2000)

        # Try to parse JSON from response
        try:
            # Extract JSON from markdown code blocks if present
            if "```json" in response:
                json_str = response.split("```json")[1].split("```")[0].strip()
            elif "```" in response:
                json_str = response.split("```")[1].split("```")[0].strip()
            else:
                json_str = response.strip()

            return json.loads(json_str)
        except json.JSONDecodeError:
            return {
                "platforms": [],
                "error": f"Failed to parse response: {response[:200]}"
            }

    def analyze_products(self, influencer_name: str, platforms_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Analyze products sold/promoted by influencer.

        Args:
            influencer_name: Name of the influencer
            platforms_data: Platform information from previous analysis

        Returns:
            Dict with product information
        """
        prompt = f"""Analyze products sold or promoted by '{influencer_name}'.

Based on their social media presence: {json.dumps(platforms_data, indent=2)}

Find their TOP 2 MOST SIGNIFICANT products/brands:
1. Products they sell (merch, food, cosmetics, etc.)
2. Major sponsorships/brand deals
3. Product categories

IMPORTANT: Return ONLY the 2 most significant products, not all of them.

For each product, provide:
- Name
- Category (food, cosmetics, merch, electronics, etc.)
- Brief description

Return ONLY valid JSON:
{{
    "products": [
        {{
            "name": "Product Name",
            "category": "food",
            "description": "Brief description"
        }}
    ]
}}"""

        messages = [
            {"role": "system", "content": "You are an AI assistant that analyzes influencer products. Always return valid JSON."},
            {"role": "user", "content": prompt}
        ]

        response = self.chat(messages, temperature=0.3, max_tokens=1500)

        try:
            if "```json" in response:
                json_str = response.split("```json")[1].split("```")[0].strip()
            elif "```" in response:
                json_str = response.split("```")[1].split("```")[0].strip()
            else:
                json_str = response.strip()

            return json.loads(json_str)
        except json.JSONDecodeError:
            return {"products": []}

    def analyze_breakthrough_moment(self, influencer_name: str, platforms_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Find the breakthrough moment/content that made the influencer famous.

        Args:
            influencer_name: Name of the influencer
            platforms_data: Platform information

        Returns:
            Dict with breakthrough information and timeline
        """
        prompt = f"""Research how '{influencer_name}' became famous.

Platform data: {json.dumps(platforms_data, indent=2)}

Find:
1. Their first viral video/post/content
2. The breakthrough moment that launched their career
3. Top 5-6 most significant milestones in their growth (chronological order)
4. Major collaborations or turning points

IMPORTANT: Limit timeline to 5-6 most significant events only (no more than 6).

Return ONLY valid JSON:
{{
    "breakthrough": {{
        "date": "2017-01-15",
        "title": "Breakthrough content title",
        "description": "What happened",
        "platform": "youtube",
        "views": 1000000
    }},
    "timeline": [
        {{
            "date": "2015-06-20",
            "type": "video",
            "title": "Channel started",
            "description": "Description",
            "platform": "youtube",
            "views": 5000
        }}
    ]
}}"""

        messages = [
            {"role": "system", "content": "You are an AI assistant that researches influencer success stories. Always return valid JSON with dates in YYYY-MM-DD format."},
            {"role": "user", "content": prompt}
        ]

        response = self.chat(messages, temperature=0.3, max_tokens=2000)

        try:
            if "```json" in response:
                json_str = response.split("```json")[1].split("```")[0].strip()
            elif "```" in response:
                json_str = response.split("```")[1].split("```")[0].strip()
            else:
                json_str = response.strip()

            return json.loads(json_str)
        except json.JSONDecodeError:
            return {"breakthrough": None, "timeline": []}

    def analyze_connections(self, influencer_name: str, platforms_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Find influencer's connections including other influencers, agencies, brands, and business entities.

        Args:
            influencer_name: Name of the influencer
            platforms_data: Platform information

        Returns:
            Dict with connection information
        """
        prompt = f"""Find ALL connections for '{influencer_name}' including:
1. Other influencers they collaborate with
2. Ad agencies representing them
3. Brands they're sponsored by or partnered with
4. Management companies managing them
5. Record labels (if musician)
6. Networks or media companies they work with
7. Any other business entities they're connected to

Platform data: {json.dumps(platforms_data, indent=2)}

For EACH connection, provide:
- name: Full name of the entity/person
- entity_type: One of: "influencer", "ad_agency", "brand", "management", "record_label", "network", "studio", "other"
- connection_type: One of: "collaboration", "sponsorship", "managed_by", "signed_to", "partnership", "contracted_to", "owned_by"
- strength: 1-10 (how strong/significant is this relationship?)
- description: Brief description of the relationship

Return ONLY valid JSON:
{{
    "connections": [
        {{
            "name": "Night Media",
            "entity_type": "management",
            "connection_type": "managed_by",
            "strength": 10,
            "description": "Talent management company representing the influencer"
        }},
        {{
            "name": "MrBeast",
            "entity_type": "influencer",
            "connection_type": "collaboration",
            "strength": 8,
            "description": "Frequent collaborator on videos"
        }},
        {{
            "name": "GFuel",
            "entity_type": "brand",
            "connection_type": "sponsorship",
            "strength": 7,
            "description": "Long-term brand sponsorship deal"
        }}
    ]
}}"""

        messages = [
            {"role": "system", "content": "You are an AI assistant that analyzes influencer networks. Always return valid JSON."},
            {"role": "user", "content": prompt}
        ]

        response = self.chat(messages, temperature=0.3, max_tokens=1500)

        try:
            if "```json" in response:
                json_str = response.split("```json")[1].split("```")[0].strip()
            elif "```" in response:
                json_str = response.split("```")[1].split("```")[0].strip()
            else:
                json_str = response.strip()

            return json.loads(json_str)
        except json.JSONDecodeError:
            return {"connections": []}

    def analyze_news_drama(self, influencer_name: str, platforms_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Find recent news, drama, and controversies about the influencer.

        Args:
            influencer_name: Name of the influencer
            platforms_data: Platform information

        Returns:
            Dict with news and drama information
        """
        prompt = f"""Research all recent and significant news, drama, and controversies about '{influencer_name}'.

Platform data: {json.dumps(platforms_data, indent=2)}

Find:
1. Recent news articles about them (within last 2 years)
2. Any drama, controversies, or scandals they were involved in
3. Major achievements or positive news
4. Collaborations that made headlines
5. Any legal issues or public disputes

For each item, provide:
- title: Concise headline
- description: Detailed explanation of what happened
- article_type: One of: "news", "drama", "controversy", "achievement", "collaboration", "legal"
- date: When it happened (YYYY-MM-DD format)
- source: Where this information comes from (e.g., "YouTube", "Twitter", "News Article")
- url: Link to source if available (or null)
- sentiment: "positive", "negative", or "neutral"
- severity: 1-10 (how significant is this event? 10 = major scandal, 1 = minor mention)

Return ONLY valid JSON:
{{
    "news": [
        {{
            "title": "Brief headline",
            "description": "Detailed explanation of the event",
            "article_type": "drama",
            "date": "2024-01-15",
            "source": "Twitter",
            "url": "https://twitter.com/...",
            "sentiment": "negative",
            "severity": 7
        }}
    ]
}}

IMPORTANT: Focus on recent events (last 2 years) and significant events that define their public image."""

        messages = [
            {"role": "system", "content": "You are an AI assistant that researches influencer news and drama. Always return valid JSON with dates in YYYY-MM-DD format. Use web search to find current, accurate information."},
            {"role": "user", "content": prompt}
        ]

        response = self.chat(messages, temperature=0.3, max_tokens=3000)

        try:
            if "```json" in response:
                json_str = response.split("```json")[1].split("```")[0].strip()
            elif "```" in response:
                json_str = response.split("```")[1].split("```")[0].strip()
            else:
                json_str = response.strip()

            return json.loads(json_str)
        except json.JSONDecodeError:
            return {"news": []}

    def analyze_product_reviews(self, influencer_name: str, product_name: str, platforms_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Find real user reviews and comments about an influencer's product from social media.

        Args:
            influencer_name: Name of the influencer
            product_name: Name of the product
            platforms_data: Platform information

        Returns:
            Dict with user reviews from social media
        """
        prompt = f"""Search social media for REAL user reviews and comments about "{product_name}" by {influencer_name}.

Platform data: {json.dumps(platforms_data, indent=2)}

CRITICAL REQUIREMENTS:
1. Search Twitter/X, Reddit, YouTube comments, TikTok comments for mentions of this product
2. Find ACTUAL user comments - DO NOT make up fake reviews
3. Include both positive and negative feedback
4. Only return real, verifiable comments you can find
5. If you cannot find any reviews, return empty array

For each review found, provide:
- author: Username or display name of the reviewer
- comment: The actual text of their comment/review
- platform: Where it was posted (twitter, reddit, youtube, tiktok)
- sentiment: "positive", "negative", or "neutral" based on the comment
- url: Link to the comment if available (or null)
- date: When it was posted (YYYY-MM-DD format, or null if unknown)

Return ONLY valid JSON:
{{
    "reviews": [
        {{
            "author": "username123",
            "comment": "Actual comment text here",
            "platform": "twitter",
            "sentiment": "positive",
            "url": "https://twitter.com/...",
            "date": "2024-01-15"
        }}
    ]
}}

IMPORTANT: Only return REAL comments you can verify. Limit to MAXIMUM 5 reviews (most relevant/recent only)."""

        messages = [
            {"role": "system", "content": "You are an AI assistant that searches social media for product reviews. CRITICAL: Only return REAL, VERIFIABLE comments from actual users. DO NOT make up fake reviews. If you cannot find reviews, return an empty array. Always return valid JSON."},
            {"role": "user", "content": prompt}
        ]

        response = self.chat(messages, temperature=0.2, max_tokens=2000)

        try:
            if "```json" in response:
                json_str = response.split("```json")[1].split("```")[0].strip()
            elif "```" in response:
                json_str = response.split("```")[1].split("```")[0].strip()
            else:
                json_str = response.strip()

            return json.loads(json_str)
        except json.JSONDecodeError:
            return {"reviews": []}

    def analyze_reputation(self, influencer_name: str, platforms_data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Analyze the influencer's reputation based on social media sentiment.

        Args:
            influencer_name: Name of the influencer
            platforms_data: Platform information

        Returns:
            Dict with overall sentiment and social media comments
        """
        prompt = f"""Analyze the general reputation and public sentiment around '{influencer_name}' based on social media.

Platform data: {json.dumps(platforms_data, indent=2)}

Search Twitter/X, Reddit, YouTube comments, TikTok for what people say about this influencer.

For each comment found, provide:
- author: Username or display name
- comment: The actual text of their comment
- platform: Where it was posted (twitter, reddit, youtube, tiktok)
- sentiment: "positive", "negative", or "neutral"
- url: Link to the comment if available (or null)
- date: When it was posted (YYYY-MM-DD format, or null if unknown)

Return ONLY valid JSON:
{{
    "overall_sentiment": "good",
    "comments": [
        {{
            "author": "username123",
            "comment": "Actual comment text here",
            "platform": "twitter",
            "sentiment": "positive",
            "url": "https://twitter.com/...",
            "date": "2024-01-15"
        }}
    ]
}}

overall_sentiment must be one of: "good", "neutral", "negative"
IMPORTANT: Limit to MAXIMUM 8-10 most representative comments."""

        messages = [
            {"role": "system", "content": "You are an AI assistant that analyzes influencer reputation from social media. Always return valid JSON."},
            {"role": "user", "content": prompt}
        ]

        response = self.chat(messages, temperature=0.2, max_tokens=1500)

        try:
            if "```json" in response:
                json_str = response.split("```json")[1].split("```")[0].strip()
            elif "```" in response:
                json_str = response.split("```")[1].split("```")[0].strip()
            else:
                json_str = response.strip()

            return json.loads(json_str)
        except json.JSONDecodeError:
            return {"overall_sentiment": "neutral", "comments": []}


# Global client instance
blackbox_client = BlackboxClient()
