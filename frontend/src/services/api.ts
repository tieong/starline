/**
 * API client for backend communication
 */

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000';

export interface InfluencerSearchResult {
  id: string;
  name: string;
  bio: string;
  country?: string;
  trust_score: number;
  avatar_url: string;
  platforms: Array<{
    platform: string;
    followers: number;
  }>;
}

export interface TrendingInfluencer extends InfluencerSearchResult {
  trending_score: number;
  verified?: boolean;
  total_followers?: number;
}

export interface InfluencerDetail {
  id: string;
  name: string;
  bio: string;
  verified: boolean;
  trust_score: number;
  avatar_url: string;
  platforms: Array<{
    platform: string;
    username: string;
    followers: number;
    verified: boolean;
    url: string;
  }>;
  timeline: Array<{
    id: string;
    date: string;
    type: string;
    title: string;
    description: string;
    platform: string;
    views?: number;
    likes?: number;
  }>;
  products: Array<{
    id: number;
    name: string;
    category: string;
    quality_score: number;
    description: string;
    review_count: number;
    openfoodfacts_data?: string | null;
    reviews: Array<{
      author: string;
      comment: string;
      platform: string;
      sentiment: string;
      url: string | null;
      date: string | null;
    }>;
  }>;
  connections: Array<{
    name: string;
    entity_type: string;
    type: string;
    strength: number;
    description: string;
  }>;
  news: Array<{
    id: number;
    title: string;
    description: string;
    article_type: string;
    date: string | null;
    source: string;
    url: string | null;
    sentiment: string;
    severity: number;
  }>;
  last_analyzed: string | null;
  analysis_complete: boolean;
}

class ApiClient {
  private baseUrl: string;

  constructor(baseUrl: string = API_BASE_URL) {
    this.baseUrl = baseUrl;
  }

  /**
   * Search for influencers
   */
  async searchInfluencers(query: string): Promise<InfluencerSearchResult[]> {
    const response = await fetch(
      `${this.baseUrl}/api/influencers/search?q=${encodeURIComponent(query)}`
    );

    if (!response.ok) {
      throw new Error('Failed to search influencers');
    }

    const data = await response.json();
    return data.results || [];
  }

  /**
   * Get trending influencers
   */
  async getTrendingInfluencers(limit: number = 10): Promise<TrendingInfluencer[]> {
    const response = await fetch(
      `${this.baseUrl}/api/influencers/trending?limit=${limit}`
    );

    if (!response.ok) {
      throw new Error('Failed to fetch trending influencers');
    }

    const data = await response.json();
    return data.trending || [];
  }

  /**
   * Get influencer details by ID
   */
  async getInfluencer(id: string): Promise<InfluencerDetail> {
    const response = await fetch(`${this.baseUrl}/api/influencers/${id}`);

    if (!response.ok) {
      if (response.status === 404) {
        throw new Error('Influencer not found');
      }
      throw new Error('Failed to fetch influencer details');
    }

    return response.json();
  }

  /**
   * Analyze an influencer (triggers real-time AI analysis)
   * @param name - Influencer name
   * @param analysisLevel - "platforms_only" (top lists), "basic" (profile view), or "full" (everything)
   */
  async analyzeInfluencer(
    name: string,
    analysisLevel: 'platforms_only' | 'basic' | 'full' = 'basic'
  ): Promise<InfluencerDetail | { status: string; message: string }> {
    const params = new URLSearchParams();
    params.set('analysis_level', analysisLevel);

    const response = await fetch(
      `${this.baseUrl}/api/influencers/analyze?${params.toString()}`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ name }),
      }
    );

    if (!response.ok) {
      throw new Error('Failed to analyze influencer');
    }

    return response.json();
  }

  /**
   * Get top influencers globally or by country
   */
  async getTopInfluencers(options?: {
    country?: string;
    limit?: number;
    auto_discover?: boolean;
  }): Promise<{
    country: string;
    limit: number;
    count: number;
    auto_discovered: boolean;
    newly_analyzed_count?: number;
    influencers: TrendingInfluencer[];
  }> {
    const params = new URLSearchParams();
    if (options?.country) params.set('country', options.country);
    if (options?.limit) params.set('limit', options.limit.toString());
    if (options?.auto_discover !== undefined) params.set('auto_discover', options.auto_discover.toString());

    const response = await fetch(
      `${this.baseUrl}/api/influencers/top${params.toString() ? `?${params.toString()}` : ''}`
    );

    if (!response.ok) {
      throw new Error('Failed to fetch top influencers');
    }

    return response.json();
  }

  /**
   * Fetch timeline events on-demand for an influencer
   */
  async fetchTimeline(influencerId: string): Promise<any> {
    const response = await fetch(
      `${this.baseUrl}/api/influencers/${influencerId}/timeline/fetch`,
      { method: 'POST' }
    );

    if (!response.ok) {
      throw new Error('Failed to fetch timeline');
    }

    return response.json();
  }

  /**
   * Fetch network connections on-demand for an influencer
   */
  async fetchConnections(influencerId: string): Promise<any> {
    const response = await fetch(
      `${this.baseUrl}/api/influencers/${influencerId}/connections/fetch`,
      { method: 'POST' }
    );

    if (!response.ok) {
      throw new Error('Failed to fetch connections');
    }

    return response.json();
  }

  /**
   * Fetch product reviews on-demand
   */
  async fetchProductReviews(productId: number): Promise<any> {
    const response = await fetch(
      `${this.baseUrl}/api/products/${productId}/reviews/fetch`,
      { method: 'POST' }
    );

    if (!response.ok) {
      throw new Error('Failed to fetch product reviews');
    }

    return response.json();
  }

  /**
   * Fetch OpenFoodFacts data on-demand for a product
   */
  async fetchOpenFoodFacts(productId: number): Promise<any> {
    const response = await fetch(
      `${this.baseUrl}/api/products/${productId}/openfoodfacts/fetch`,
      { method: 'POST' }
    );

    if (!response.ok) {
      throw new Error('Failed to fetch OpenFoodFacts data');
    }

    return response.json();
  }

  /**
   * Fetch news and drama on-demand for an influencer
   */
  async fetchNews(influencerId: string): Promise<any> {
    const response = await fetch(
      `${this.baseUrl}/api/influencers/${influencerId}/news/fetch`,
      { method: 'POST' }
    );

    if (!response.ok) {
      throw new Error('Failed to fetch news');
    }

    return response.json();
  }
}

export const apiClient = new ApiClient();
