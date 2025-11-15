/**
 * API client for backend communication
 */

const API_BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000';

export interface InfluencerSearchResult {
  id: string;
  name: string;
  bio: string;
  trust_score: number;
  avatar_url: string;
  platforms: Array<{
    platform: string;
    followers: number;
  }>;
}

export interface TrendingInfluencer extends InfluencerSearchResult {
  trending_score: number;
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
    name: string;
    category: string;
    quality_score: number;
    description: string;
  }>;
  connections: Array<{
    name: string;
    type: string;
    strength: number;
    description: string;
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
   */
  async analyzeInfluencer(name: string): Promise<InfluencerDetail | { status: string; message: string }> {
    const response = await fetch(`${this.baseUrl}/api/influencers/analyze`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ name }),
    });

    if (!response.ok) {
      throw new Error('Failed to analyze influencer');
    }

    return response.json();
  }
}

export const apiClient = new ApiClient();
