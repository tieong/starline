/**
 * API Service Layer
 *
 * Handles all communication with the backend API.
 * Provides methods to fetch influencers, products, news, etc.
 */

// In production (Docker), use empty string to use same origin (nginx proxy)
// In development, use VITE_API_URL or default to localhost:8000
const API_BASE_URL = import.meta.env.PROD 
  ? '' 
  : ((import.meta as any).env?.VITE_API_URL || 'http://localhost:8000');

export interface ApiInfluencer {
  id: number;
  name: string;
  bio?: string;
  country?: string;
  verified: boolean;
  trust_score: number;
  trending_score?: number;
  avatar_url?: string;
  platforms: Array<{
    platform: string;
    username?: string;
    followers: number;
    verified: boolean;
    url?: string;
  }>;
  timeline?: Array<{
    id: number;
    date: string;
    event_type: string;
    title: string;
    description: string;
    platform: string;
    views?: number;
    likes?: number;
    url?: string;
  }>;
  products?: Array<{
    id: number;
    name: string;
    category: string;
    quality_score?: number;
    description: string;
    review_count: number;
    sentiment_score?: number;
    openfoodfacts_data?: any;
    reviews: Array<{
      author: string;
      comment: string;
      platform: string;
      sentiment: string;
      url?: string;
      date?: string;
    }>;
  }>;
  connections?: Array<{
    name: string;
    entity_type: string;
    type: string;
    strength: number;
    description: string;
  }>;
  news?: Array<{
    id: number;
    title: string;
    description: string;
    article_type: string;
    date?: string;
    source: string;
    url?: string;
    sentiment: string;
    severity: number;
  }>;
  last_analyzed?: string;
  analysis_complete: boolean;
}

export interface ApiNewsArticle {
  id: number;
  influencer_id: number;
  title: string;
  description: string;
  article_type: string;
  date?: string;
  source: string;
  url?: string;
  sentiment: string;
  severity: number;
}

export interface ApiConnection {
  name: string;
  entity_type: string;
  type: string;
  strength: number;
  description: string;
  entity_id?: number | string;
}

export interface ApiReputationComment {
  id: number;
  author: string;
  comment: string;
  platform: string;
  sentiment: string;
  url?: string;
  date?: string;
}

class ApiService {
  private baseUrl: string;

  constructor(baseUrl: string = API_BASE_URL) {
    this.baseUrl = baseUrl;
  }

  /**
   * Generic fetch wrapper with error handling
   */
  private async fetch<T>(endpoint: string, options?: RequestInit): Promise<T> {
    const url = `${this.baseUrl}${endpoint}`;

    try {
      const response = await fetch(url, {
        ...options,
        headers: {
          'Content-Type': 'application/json',
          ...options?.headers,
        },
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`API Error ${response.status}: ${errorText}`);
      }

      return await response.json();
    } catch (error) {
      console.error(`API fetch error for ${endpoint}:`, error);
      throw error;
    }
  }

  /**
   * Search influencers by name
   */
  async searchInfluencers(query: string): Promise<ApiInfluencer[]> {
    const data = await this.fetch<{ results: ApiInfluencer[] }>(
      `/api/influencers/search?q=${encodeURIComponent(query)}`
    );
    return data.results;
  }

  /**
   * Get top influencers (with optional country filter)
   */
  async getTopInfluencers(country?: string, limit: number = 10): Promise<ApiInfluencer[]> {
    const params = new URLSearchParams();
    if (country) params.append('country', country);
    params.append('limit', limit.toString());
    params.append('auto_discover', 'false'); // Don't auto-discover, use cached data only

    const data = await this.fetch<{ influencers: ApiInfluencer[] }>(
      `/api/influencers/top?${params.toString()}`
    );
    return data.influencers;
  }

  /**
   * Get trending influencers
   */
  async getTrendingInfluencers(limit: number = 10): Promise<ApiInfluencer[]> {
    const data = await this.fetch<{ trending: ApiInfluencer[] }>(
      `/api/influencers/trending?limit=${limit}`
    );
    return data.trending;
  }

  /**
   * Get single influencer by ID
   */
  async getInfluencer(id: number): Promise<ApiInfluencer> {
    return await this.fetch<ApiInfluencer>(`/api/influencers/${id}`);
  }

  /**
   * Get influencer avatar URL
   */
  getAvatarUrl(id: number): string {
    return `${this.baseUrl}/api/influencers/${id}/avatar`;
  }

  /**
   * Get influencer news articles
   */
  async getInfluencerNews(id: number, limit: number = 20): Promise<ApiNewsArticle[]> {
    const data = await this.fetch<{ news: ApiNewsArticle[] }>(
      `/api/influencers/${id}/news?limit=${limit}`
    );
    return data.news;
  }

  /**
   * Get influencer timeline events
   */
  async getInfluencerTimeline(id: number): Promise<any[]> {
    const data = await this.fetch<{ timeline: any[] }>(
      `/api/influencers/${id}/timeline`
    );
    return data.timeline;
  }

  /**
   * Get influencer connections
   */
  async getInfluencerConnections(id: number): Promise<ApiConnection[]> {
    const data = await this.fetch<{ connections: ApiConnection[] }>(
      `/api/influencers/${id}/connections`
    );
    return data.connections;
  }

  /**
   * Get influencer reputation comments
   */
  async getInfluencerReputation(id: number): Promise<{
    overall_sentiment: string;
    comments: ApiReputationComment[];
  }> {
    return await this.fetch(
      `/api/influencers/${id}/reputation`
    );
  }

  /**
   * Fetch timeline on-demand (triggers AI analysis)
   */
  async fetchTimeline(id: number): Promise<any> {
    return await this.fetch(
      `/api/influencers/${id}/timeline/fetch`,
      { method: 'POST' }
    );
  }

  /**
   * Fetch connections on-demand (triggers AI analysis)
   */
  async fetchConnections(id: number): Promise<any> {
    return await this.fetch(
      `/api/influencers/${id}/connections/fetch`,
      { method: 'POST' }
    );
  }

  /**
   * Fetch news on-demand (triggers AI analysis)
   */
  async fetchNews(id: number): Promise<any> {
    return await this.fetch(
      `/api/influencers/${id}/news/fetch`,
      { method: 'POST' }
    );
  }

  /**
   * Fetch reputation on-demand (triggers AI analysis)
   */
  async fetchReputation(id: number): Promise<any> {
    return await this.fetch(
      `/api/influencers/${id}/reputation/fetch`,
      { method: 'POST' }
    );
  }

  /**
   * Analyze a new influencer
   */
  async analyzeInfluencer(name: string, analysisLevel: 'platforms_only' | 'basic' | 'full' = 'basic'): Promise<ApiInfluencer> {
    return await this.fetch(
      `/api/influencers/analyze?analysis_level=${analysisLevel}`,
      {
        method: 'POST',
        body: JSON.stringify({ name }),
      }
    );
  }

  /**
   * Start graph exploration from an influencer name
   */
  async startExploration(name: string): Promise<{
    status: string;
    center_influencer_id: number;
    center_influencer_name: string;
    nodes: Array<any>;
    links: Array<any>;
    explored_count: number;
    unexplored_count: number;
  }> {
    return await this.fetch(
      `/api/explore/start`,
      {
        method: 'POST',
        body: JSON.stringify({ name }),
      }
    );
  }

  /**
   * Expand a node in the exploration graph
   */
  async expandNode(nodeId: string, influencerName?: string): Promise<{
    status: string;
    expanded_node_id: string;
    expanded_node_name: string;
    new_nodes: Array<any>;
    new_links: Array<any>;
    influencer_data: ApiInfluencer;
  }> {
    const params = new URLSearchParams();
    if (influencerName) {
      params.append('influencer_name', influencerName);
    }
    
    const url = `/api/explore/expand/${encodeURIComponent(nodeId)}${params.toString() ? '?' + params.toString() : ''}`;
    return await this.fetch(url, { method: 'POST' });
  }
}

// Export singleton instance
export const apiService = new ApiService();
