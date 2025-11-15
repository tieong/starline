export interface TimelineMilestone {
  id: string;
  date: string;
  type: 'video' | 'tweet' | 'instagram' | 'tiktok' | 'collaboration' | 'achievement';
  title: string;
  description: string;
  platform: string;
  views?: number;
  likes?: number;
  url?: string;
}

export interface Influencer {
  id: string;
  name: string;
  platform: string;
  followerCount: number;
  verified: boolean;
  trustScore: number; // 0-100
  avatarUrl: string;
  bio: string;
  timeline?: TimelineMilestone[];
  trendingScore?: number; // How many times this influencer has been searched
}

export interface InfluencerConnection {
  id: string;
  name: string;
  relationship: string; // e.g., "collaborator", "mentor", "friend"
  trustScore: number;
}

export interface Review {
  id: string;
  userId: string;
  userName: string;
  rating: number; // 1-5
  comment: string;
  productName?: string;
  date: string;
  verified: boolean;
}

export interface TrustMetrics {
  overallScore: number;
  authenticity: number;
  productQuality: number;
  transparency: number;
  engagement: number;
}

export interface GraphNode {
  id: string;
  name: string;
  val: number; // size of node
  color: string;
}

export interface GraphLink {
  source: string;
  target: string;
  value: number; // strength of connection
}

export interface NetworkGraphData {
  nodes: GraphNode[];
  links: GraphLink[];
}
