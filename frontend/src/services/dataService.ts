/**
 * Data Service Abstraction
 *
 * Provides a unified interface for fetching data from either mock data or real API.
 * This allows seamless switching between data sources without changing component code.
 */

import { apiService, ApiInfluencer, ApiNewsArticle, ApiConnection, ApiReputationComment } from './api';
import { Influencer, Product, NewsItem, Relationship, GraphNode, SocialComment } from '../types';
import { influencers, products, newsItems, relationships, graphNodes, socialComments } from '../data/mockData';

/**
 * Convert API influencer to frontend Influencer type
 */
function convertApiInfluencer(apiInf: ApiInfluencer): Influencer {
  // Calculate follower counts
  const followersByPlatform = apiInf.platforms.reduce((acc, p) => {
    acc[p.platform] = p.followers;
    return acc;
  }, {} as Record<string, number>);

  const totalFollowers = apiInf.platforms.reduce((sum, p) => sum + p.followers, 0);

  // Build social links from platforms
  const socialLinks: any = {};
  apiInf.platforms.forEach(p => {
    if (p.username) {
      socialLinks[p.platform] = p.username;
    }
  });

  // Calculate engagement rate (mock value for now - could be enhanced)
  const engagementRate = Math.random() * 10 + 2; // 2-12%

  // Determine niche based on bio or use default
  const niche = apiInf.bio ? [extractNicheFromBio(apiInf.bio)] : ['General'];

  // Map trust_score (0-100) to influscoring (0-10)
  const influscoring = {
    overall: Math.round(apiInf.trust_score / 10),
    reliability: Math.round(apiInf.trust_score / 10),
    controversies: Math.max(0, 10 - Math.round(apiInf.trust_score / 10)),
    authenticity: Math.round(apiInf.trust_score / 10),
    reputation: Math.round(apiInf.trust_score / 10),
    professionalism: Math.round(apiInf.trust_score / 10),
    trend: 'stable' as const,
  };

  // Build subscriber growth (mock data if not available)
  const subscriberGrowth = generateMockGrowth(totalFollowers);

  return {
    id: apiInf.id.toString(),
    name: apiInf.name,
    handle: socialLinks.twitter || socialLinks.youtube || `@${apiInf.name.replace(/\s+/g, '')}`,
    avatar: apiInf.avatar_url || `/api/influencers/${apiInf.id}/avatar`,
    followers: totalFollowers,
    followersByPlatform,
    engagementRate,
    niche,
    bio: apiInf.bio || '',
    agency: extractAgencyFromConnections(apiInf.connections || []),
    influscoring,
    stats: {
      avgViews: Math.round(totalFollowers * 0.1), // Estimate
      avgLikes: Math.round(totalFollowers * 0.02), // Estimate
      postingFrequency: 'Weekly',
      topCountries: [apiInf.country || 'Unknown'],
      audienceAge: [
        { range: '18-24', percentage: 25 },
        { range: '25-34', percentage: 40 },
        { range: '35-44', percentage: 20 },
        { range: '45+', percentage: 15 },
      ],
      audienceGender: { male: 55, female: 44, other: 1 },
    },
    socialLinks,
    subscriberGrowth,
    verified: apiInf.verified,
    country: apiInf.country,
  };
}

/**
 * Extract niche from bio text
 */
function extractNicheFromBio(bio: string): string {
  const lowerBio = bio.toLowerCase();
  if (lowerBio.includes('gaming') || lowerBio.includes('gamer')) return 'Gaming';
  if (lowerBio.includes('fitness') || lowerBio.includes('workout')) return 'Fitness';
  if (lowerBio.includes('beauty') || lowerBio.includes('makeup')) return 'Beauty';
  if (lowerBio.includes('tech') || lowerBio.includes('technology')) return 'Tech';
  if (lowerBio.includes('lifestyle')) return 'Lifestyle';
  if (lowerBio.includes('food') || lowerBio.includes('cooking')) return 'Food';
  if (lowerBio.includes('travel')) return 'Travel';
  if (lowerBio.includes('music')) return 'Music';
  if (lowerBio.includes('comedy') || lowerBio.includes('entertainment')) return 'Comedy';
  return 'General';
}

/**
 * Extract agency from connections
 */
function extractAgencyFromConnections(connections: ApiConnection[]): string | undefined {
  const agency = connections.find(c => c.entity_type === 'management' || c.entity_type === 'agency');
  return agency?.name;
}

/**
 * Generate mock subscriber growth data
 */
function generateMockGrowth(currentFollowers: number): Array<{ date: string; followers: number }> {
  const growth = [];
  const months = 16;
  const startFollowers = Math.round(currentFollowers * 0.6); // Start at 60% of current

  for (let i = 0; i < months; i++) {
    const date = new Date();
    date.setMonth(date.getMonth() - (months - i - 1));
    const dateStr = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`;

    // Gradual growth from start to current
    const progress = i / (months - 1);
    const followers = Math.round(startFollowers + (currentFollowers - startFollowers) * progress);

    growth.push({ date: dateStr, followers });
  }

  return growth;
}

/**
 * Convert API news to frontend NewsItem
 */
function convertApiNews(apiNews: ApiNewsArticle, influencerId?: string): NewsItem {
  // Map severity number (1-10) to severity type
  const severityMap: Record<number, 'low' | 'medium' | 'high'> = {
    1: 'low', 2: 'low', 3: 'low',
    4: 'medium', 5: 'medium', 6: 'medium', 7: 'medium',
    8: 'high', 9: 'high', 10: 'high'
  };

  return {
    id: apiNews.id.toString(),
    influencerId: influencerId || apiNews.influencer_id?.toString() || '0',
    title: apiNews.title,
    type: apiNews.article_type as any,
    date: apiNews.date || new Date().toISOString(),
    description: apiNews.description,
    severity: severityMap[Math.min(10, Math.max(1, apiNews.severity))] || 'medium',
    source: apiNews.source,
  };
}

/**
 * Convert API reputation comments to SocialComment
 */
function convertApiReputation(apiComment: ApiReputationComment, influencerId: string): SocialComment {
  return {
    id: apiComment.id.toString(),
    influencerId,
    platform: apiComment.platform as any,
    author: apiComment.author,
    date: apiComment.date || new Date().toISOString(),
    content: apiComment.comment,
    sentiment: apiComment.sentiment as any,
  };
}

/**
 * Data Service Class
 */
class DataService {
  /**
   * Get all influencers or search by query
   */
  async getInfluencers(useMock: boolean, query?: string): Promise<Influencer[]> {
    if (useMock) {
      if (!query) return influencers;
      const lowerQuery = query.toLowerCase();
      return influencers.filter(inf =>
        inf.name.toLowerCase().includes(lowerQuery) ||
        inf.handle.toLowerCase().includes(lowerQuery)
      );
    }

    try {
      if (query) {
        const apiInfluencers = await apiService.searchInfluencers(query);
        return apiInfluencers.map(convertApiInfluencer);
      } else {
        // Get top influencers if no query
        const apiInfluencers = await apiService.getTopInfluencers(undefined, 20);
        return apiInfluencers.map(convertApiInfluencer);
      }
    } catch (error) {
      console.error('Failed to fetch influencers from API:', error);
      throw error;
    }
  }

  /**
   * Get single influencer by ID
   */
  async getInfluencer(useMock: boolean, id: number | string): Promise<Influencer | undefined> {
    const numericId = typeof id === 'string' ? parseInt(id) : id;
    const stringId = typeof id === 'number' ? id.toString() : id;

    if (useMock) {
      return influencers.find(inf => inf.id === stringId);
    }

    try {
      const apiInfluencer = await apiService.getInfluencer(numericId);
      return convertApiInfluencer(apiInfluencer);
    } catch (error) {
      console.error(`Failed to fetch influencer ${id} from API:`, error);
      throw error;
    }
  }

  /**
   * Get trending influencers
   */
  async getTrendingInfluencers(useMock: boolean, limit: number = 10): Promise<Influencer[]> {
    if (useMock) {
      // Sort by engagement rate and take top N
      return [...influencers]
        .sort((a, b) => b.engagementRate - a.engagementRate)
        .slice(0, limit);
    }

    try {
      const apiInfluencers = await apiService.getTrendingInfluencers(limit);
      return apiInfluencers.map(convertApiInfluencer);
    } catch (error) {
      console.error('Failed to fetch trending influencers from API:', error);
      throw error;
    }
  }

  /**
   * Get top influencers by country
   */
  async getTopInfluencers(useMock: boolean, country?: string, limit: number = 10): Promise<Influencer[]> {
    if (useMock) {
      let filtered = influencers;
      if (country) {
        filtered = influencers.filter(inf => inf.country === country);
      }
      return filtered
        .sort((a, b) => b.followers - a.followers)
        .slice(0, limit);
    }

    try {
      const apiInfluencers = await apiService.getTopInfluencers(country, limit);
      return apiInfluencers.map(convertApiInfluencer);
    } catch (error) {
      console.error('Failed to fetch top influencers from API:', error);
      throw error;
    }
  }

  /**
   * Get products for an influencer
   */
  async getProducts(useMock: boolean, influencerId: number | string): Promise<Product[]> {
    const numericId = typeof influencerId === 'string' ? parseInt(influencerId) : influencerId;
    const stringId = typeof influencerId === 'number' ? influencerId.toString() : influencerId;

    if (useMock) {
      return products.filter(p => p.influencerId === stringId);
    }

    try {
      // Products are embedded in the influencer response
      const apiInfluencer = await apiService.getInfluencer(numericId);
      return apiInfluencer.products?.map(p => ({
        id: p.id.toString(),
        name: p.name,
        brand: 'Brand', // Not available from API
        category: p.category,
        image: '/placeholder-product.jpg', // Not available from API
        price: undefined, // Not available from API
        promoCode: undefined,
        influencerId: stringId,
        launchDate: new Date().toISOString(),
        status: 'active' as const,
      })) || [];
    } catch (error) {
      console.error(`Failed to fetch products for influencer ${influencerId}:`, error);
      return [];
    }
  }

  /**
   * Get news items for an influencer
   */
  async getNewsItems(useMock: boolean, influencerId: number | string): Promise<NewsItem[]> {
    const numericId = typeof influencerId === 'string' ? parseInt(influencerId) : influencerId;
    const stringId = typeof influencerId === 'number' ? influencerId.toString() : influencerId;

    if (useMock) {
      return newsItems.filter(n => n.influencerId === stringId);
    }

    try {
      const apiNews = await apiService.getInfluencerNews(numericId);
      return apiNews.map(n => convertApiNews(n, stringId));
    } catch (error) {
      console.error(`Failed to fetch news for influencer ${influencerId}:`, error);
      return [];
    }
  }

  /**
   * Get social comments (reputation) for an influencer
   */
  async getSocialComments(useMock: boolean, influencerId: number | string): Promise<SocialComment[]> {
    const numericId = typeof influencerId === 'string' ? parseInt(influencerId) : influencerId;
    const stringId = typeof influencerId === 'number' ? influencerId.toString() : influencerId;

    if (useMock) {
      return socialComments.filter(c => c.influencerId === stringId);
    }

    try {
      const reputation = await apiService.getInfluencerReputation(numericId);
      return reputation.comments.map(c => convertApiReputation(c, stringId));
    } catch (error) {
      console.error(`Failed to fetch reputation for influencer ${influencerId}:`, error);
      return [];
    }
  }

  /**
   * Get graph nodes and relationships
   * If influencerId is provided, builds graph centered around that influencer
   */
  async getGraphData(useMock: boolean, influencerId?: number | string): Promise<{
    nodes: GraphNode[];
    relationships: Relationship[];
  }> {
    if (useMock) {
      return { nodes: graphNodes, relationships };
    }

    try {
      const nodes: GraphNode[] = [];
      const relationships: Relationship[] = [];
      const nodeMap = new Map<string, boolean>(); // Track created nodes

      // Helper function to fetch and process an influencer's connections
      const processInfluencerConnections = async (
        infId: number,
        infName: string,
        infAvatarUrl: string | undefined,
        infTrustScore: number,
        fetchConnectedInfluencers: boolean = false
      ) => {
        // Validate influencer ID
        if (isNaN(infId) || infId <= 0) {
          console.error('Invalid influencer ID passed to processInfluencerConnections:', infId);
          return [];
        }

        const nodeId = `influencer-${infId}`;

        // Create influencer node if it doesn't exist
        if (!nodeMap.has(nodeId)) {
          nodes.push({
            id: nodeId,
            name: infName,
            type: 'influencer',
            avatar: infAvatarUrl || `/api/influencers/${infId}/avatar`,
            score: infTrustScore,
            size: Math.max(30, Math.min(80, infTrustScore)),
          });
          nodeMap.set(nodeId, true);
        }

        // Fetch connections for this influencer
        try {
          let connections = await apiService.getInfluencerConnections(infId);

          // If connections are empty, trigger a fetch
          if (connections.length === 0) {
            console.log(`No connections found for influencer ${infId}, triggering fetch...`);
            try {
              await apiService.fetchConnections(infId);
              connections = await apiService.getInfluencerConnections(infId);
              console.log(`Fetched connections for influencer ${infId}:`, connections.length);
            } catch (error) {
              console.error(`Failed to fetch connections for influencer ${infId}:`, error);
            }
          }

          const connectedInfluencerIds: number[] = [];

          // Create nodes and relationships from connections
          connections.forEach(conn => {
            const connId = `${conn.entity_type}-${conn.name.replace(/\s+/g, '-').toLowerCase()}`;

            // Create node for connected entity if it doesn't exist
            if (!nodeMap.has(connId)) {
              let nodeType: 'influencer' | 'agency' | 'brand' | 'event' = 'brand';
              if (conn.entity_type === 'management' || conn.entity_type === 'agency') {
                nodeType = 'agency';
              } else if (conn.entity_type === 'influencer') {
                nodeType = 'influencer';
                // Track influencer IDs to fetch their connections too
                // Validate that entity_id is a valid number
                if (fetchConnectedInfluencers && conn.entity_id != null) {
                  const numId = typeof conn.entity_id === 'number' ? conn.entity_id : parseInt(String(conn.entity_id));
                  if (!isNaN(numId) && numId > 0) {
                    connectedInfluencerIds.push(numId);
                  } else {
                    console.warn('Invalid entity_id for influencer connection:', conn.entity_id);
                  }
                }
              } else if (conn.entity_type === 'event') {
                nodeType = 'event';
              }

              nodes.push({
                id: connId,
                name: conn.name,
                type: nodeType,
                size: Math.max(40, Math.min(70, conn.strength * 100)),
              });
              nodeMap.set(connId, true);
            }

            // Create relationship if it doesn't already exist
            const existingRel = relationships.find(r =>
              r.source === nodeId && r.target === connId
            );
            if (!existingRel) {
              relationships.push({
                source: nodeId,
                target: connId,
                type: conn.type || conn.entity_type,
                strength: conn.strength,
                label: conn.description,
              });
            }
          });

          return connectedInfluencerIds;
        } catch (error) {
          console.error(`Failed to process connections for influencer ${infId}:`, error);
          return [];
        }
      };

      // If specific influencer ID provided, fetch their detailed network
      if (influencerId) {
        const numericId = typeof influencerId === 'string' ? parseInt(influencerId) : influencerId;

        try {
          const centralInfluencer = await apiService.getInfluencer(numericId);

          // Process central influencer with 2nd level connections
          const connectedInfluencerIds = await processInfluencerConnections(
            centralInfluencer.id,
            centralInfluencer.name,
            centralInfluencer.avatar_url,
            centralInfluencer.trust_score,
            true // Fetch connected influencers
          );

          // Fetch connections for connected influencers (2nd level)
          console.log('Fetching connections for connected influencers:', connectedInfluencerIds);
          for (const connectedInflId of connectedInfluencerIds.slice(0, 5)) {
            // Skip invalid IDs
            if (isNaN(connectedInflId) || connectedInflId <= 0) {
              console.warn('Skipping invalid influencer ID:', connectedInflId);
              continue;
            }

            try {
              // Fetch influencer data to get proper name and info
              const connectedInf = await apiService.getInfluencer(connectedInflId);
              await processInfluencerConnections(
                connectedInf.id,
                connectedInf.name,
                connectedInf.avatar_url,
                connectedInf.trust_score,
                false // Don't fetch 3rd level
              );
            } catch (error) {
              console.error(`Failed to fetch influencer ${connectedInflId}:`, error);
            }
          }
        } catch (error) {
          console.error('Failed to fetch detailed network for central influencer:', error);
        }
      } else {
        // No specific influencer - show top influencers with basic network
        const apiInfluencers = await apiService.getTopInfluencers(undefined, 50);
        console.log('[DataService] Fetched influencers with scores:', apiInfluencers.slice(0, 5).map(inf => ({
          name: inf.name,
          trust_score: inf.trust_score
        })));

        // Create basic nodes for all influencers
        for (const inf of apiInfluencers) {
          const nodeId = `influencer-${inf.id}`;
          if (!nodeMap.has(nodeId)) {
            nodes.push({
              id: nodeId,
              name: inf.name,
              type: 'influencer',
              avatar: inf.avatar_url || `/api/influencers/${inf.id}/avatar`,
              score: inf.trust_score,
              size: Math.max(30, Math.min(80, inf.trust_score)),
            });
            nodeMap.set(nodeId, true);
          }

          // If they have cached connections, use them (don't fetch)
          if (inf.connections && inf.connections.length > 0) {
            inf.connections.forEach(conn => {
              const connId = `${conn.entity_type}-${conn.name.replace(/\s+/g, '-').toLowerCase()}`;

              if (!nodeMap.has(connId)) {
                let nodeType: 'influencer' | 'agency' | 'brand' | 'event' = 'brand';
                if (conn.entity_type === 'management' || conn.entity_type === 'agency') {
                  nodeType = 'agency';
                } else if (conn.entity_type === 'influencer') {
                  nodeType = 'influencer';
                } else if (conn.entity_type === 'event') {
                  nodeType = 'event';
                }

                nodes.push({
                  id: connId,
                  name: conn.name,
                  type: nodeType,
                  size: Math.max(40, Math.min(70, conn.strength * 100)),
                });
                nodeMap.set(connId, true);
              }

              relationships.push({
                source: nodeId,
                target: connId,
                type: conn.type || conn.entity_type,
                strength: conn.strength,
                label: conn.description,
              });
            });
          }
        }
      }

      console.log('Graph data built from API:', {
        nodeCount: nodes.length,
        relationshipCount: relationships.length,
        nodes: nodes.slice(0, 5),
        relationships: relationships.slice(0, 5)
      });

      // Ensure we have valid data before returning
      if (nodes.length === 0) {
        console.warn('No nodes found, returning mock data');
        return { nodes: graphNodes, relationships };
      }

      return { nodes, relationships };
    } catch (error) {
      console.error('Failed to build graph from API:', error);
      // Fallback to mock data if API fails
      return { nodes: graphNodes, relationships };
    }
  }
}

export const dataService = new DataService();
