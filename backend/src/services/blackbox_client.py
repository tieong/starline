"""Blackbox AI API client."""
import json
import logging
from typing import Any, Dict, List, Optional

from openai import OpenAI

from src.config.settings import settings

logger = logging.getLogger(__name__)


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
        logger.info(f"   🤖 Blackbox: Searching for platforms...")
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
        logger.info(f"   🤖 Blackbox: Analyzing products...")
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
        logger.info(f"   🤖 Blackbox: Researching breakthrough moments...")
        prompt = f"""Research how '{influencer_name}' became famous.

Platform data: {json.dumps(platforms_data, indent=2)}

Find:
1. Their first viral video/post/content
2. The breakthrough moment that launched their career
3. Top 5-6 most significant GROWTH milestones (chronological order)
4. Major collaborations or turning points that drove growth

CRITICAL INSTRUCTIONS FOR GROWTH TIMELINE:
- Timeline should show POSITIVE growth events only (viral videos, subscriber milestones, major achievements)
- HIGH VIEW COUNTS = SUCCESS = POSITIVE GROWTH (e.g., a video with 2M views is a MILESTONE, not a problem)
- DO NOT interpret viral content or high engagement as negative events
- Focus on upward progression: channel launches, viral hits, subscriber milestones, major collabs, awards
- Avoid controversies or negative events unless they led to significant growth
- Timeline should demonstrate their rise to success

FORMATTING:
- Limit timeline to 5-6 most significant events only (no more than 6)
- ENSURE the most recent event is from 2024 or 2025 if the influencer is still active
- Include their latest major milestone or achievement to show current activity

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
        logger.info(f"   🤖 Blackbox: Finding connections (influencers, agencies, brands)...")
        prompt = f"""Find the TOP 8 MOST SIGNIFICANT connections for '{influencer_name}'.

Platform data: {json.dumps(platforms_data, indent=2)}

PRIORITY ORDER (most important first):
1. **Primary Management/Agency** - Who manages their career? (1 max)
2. **Frequent Collaborators** - Other influencers they work with regularly (2-3 max)
3. **Major Brand Deals** - Big sponsorships/partnerships (1-2 max)
4. **Creative Partners** - Studios, networks, production companies (1-2 max)
5. **Other significant connections** - Record labels, investors, etc. (1-2 max)

CRITICAL REQUIREMENTS:
- Limit to TOP 8 connections maximum (quality over quantity)
- Sort by strength (most significant first)
- VERIFY that connections are REAL and CURRENT (not outdated)
- Use actual names, not generic terms (e.g., "Gotaga" not "Gaming Partner")
- Include only well-documented, verifiable relationships

For EACH connection, provide:
- name: EXACT full name of the entity/person (searchable on social media)
- entity_type: One of: "influencer", "ad_agency", "brand", "management", "record_label", "network", "studio", "other"
- connection_type: One of: "collaboration", "sponsorship", "managed_by", "signed_to", "partnership", "contracted_to", "owned_by"
- strength: 1-10 (10 = core relationship like manager, 8-9 = frequent collaborator, 5-7 = regular partnership, 1-4 = occasional)
- description: Brief, specific description (e.g., "Co-founder of gaming collective" not just "Gaming partner")

Return ONLY valid JSON (MAXIMUM 8 connections):
{{
    "connections": [
        {{
            "name": "Night Media",
            "entity_type": "management",
            "connection_type": "managed_by",
            "strength": 10,
            "description": "Primary talent management company"
        }},
        {{
            "name": "MrBeast",
            "entity_type": "influencer",
            "connection_type": "collaboration",
            "strength": 9,
            "description": "Frequent video collaborator and business partner"
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
        logger.info(f"   🤖 Blackbox: Searching for news and drama...")
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

    def discover_top_influencers(self, country: str = None, limit: int = 10) -> Dict[str, Any]:
        """
        Discover top/trending influencers globally or by country.

        Args:
            country: Country name (optional, global if not provided)
            limit: Number of influencers to discover

        Returns:
            Dict with list of influencer names
        """
        from datetime import datetime
        current_year = datetime.now().year

        location = f"in {country}" if country else "globally"
        logger.info(f"   🤖 Blackbox: Searching for top {limit} influencers of {current_year} {location}...")

        # Build search query
        if country:
            search_query = f"Top {limit} social media influencers of {current_year} in {country}"
        else:
            search_query = f"Top {limit} social media influencers of {current_year}"

        prompt = f"""Find: "{search_query}"

Based on current information, list the top {limit} social media influencers.

DEFINITION: "Influencer" means someone who became famous THROUGH social media platforms (YouTube, TikTok, Instagram, Twitter/X).

REQUIREMENTS:
1. Use ONLY information from current {current_year} sources
2. Only include people who became famous through social media (NOT traditional celebrities, athletes, or movie/TV actors)
3. EXCLUDE: Movie actors, TV stars, athletes, musicians who became famous through traditional media
4. INCLUDE: YouTubers, TikTokers, Instagram creators, Twitter personalities who built their fame online
5. MINIMUM FOLLOWER THRESHOLD: Only include influencers with at least 10,000 total followers across all platforms (this prevents volatility and ensures established presence)
6. Include influencers across different platforms (YouTube, TikTok, Instagram, Twitter)
7. Provide a diverse mix from different niches (gaming, beauty, lifestyle, comedy, tech, etc.)
8. Use their most commonly known name/handle

For each influencer, provide:
- name: Their most searchable name that will work when searching platforms
  * CRITICAL: Use the name format they actually use on YouTube/Instagram/TikTok
  * For French influencers: Use their stage name with proper spacing
  * Examples of CORRECT names:
    - "Tibo InShape" (NOT "Tiboinshape" or "Tibo Inshape")
    - "Squeezie" (NOT "Lucas Hauchard")
    - "Nabilla" (NOT "Nabilla Vergara" or "Nabilla Benattia")
    - "Norman" (NOT "Norman Thavaud")
    - "Cyprien" (NOT "Cyprien Iov")
  * If unsure, use their single-word stage name or most common username
  * The name MUST be searchable on YouTube, Instagram, and TikTok
- primary_platform: Their main platform (youtube, tiktok, instagram, twitter)
- estimated_followers: Total followers across all platforms (approximate)
- niche: Content category (gaming, beauty, comedy, tech, lifestyle, etc.)

Return ONLY valid JSON with NO additional text:
{{
    "influencers": [
        {{
            "name": "MrBeast",
            "primary_platform": "youtube",
            "estimated_followers": 250000000,
            "niche": "entertainment"
        }}
    ]
}}

CRITICAL: Return ONLY the JSON object. Do NOT include any explanatory text before or after."""

        messages = [
            {"role": "system", "content": "You are an AI assistant that discovers trending social media influencers. Focus ONLY on people who became famous through social media platforms (YouTube, TikTok, Instagram, Twitter), NOT traditional celebrities, athletes, or movie/TV actors. Always return valid JSON with real influencer names."},
            {"role": "user", "content": prompt}
        ]

        response = self.chat(messages, temperature=0.3, max_tokens=1200)

        try:
            if "```json" in response:
                json_str = response.split("```json")[1].split("```")[0].strip()
            elif "```" in response:
                json_str = response.split("```")[1].split("```")[0].strip()
            else:
                json_str = response.strip()

            return json.loads(json_str)
        except json.JSONDecodeError:
            return {"influencers": []}


# Global client instance
blackbox_client = BlackboxClient()
