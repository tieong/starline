export interface Influencer {
  id: string;
  name: string;
  handle: string;
  avatar: string;
  followers: number;
  engagementRate: number;
  niche: string[];
  bio: string;
  agency?: string;
  influscoring: InfluScoring;
  stats: Stats;
  socialLinks: SocialLinks;
}

export interface InfluScoring {
  overall: number;
  reliability: number;
  controversies: number;
  authenticity: number;
  reputation: number;
  professionalism: number;
  trend: 'up' | 'down' | 'stable';
}

export interface Stats {
  avgViews: number;
  avgLikes: number;
  postingFrequency: string;
  topCountries: string[];
  audienceAge: { range: string; percentage: number }[];
  audienceGender: { male: number; female: number; other: number };
}

export interface SocialLinks {
  youtube?: string;
  instagram?: string;
  tiktok?: string;
  twitter?: string;
  twitch?: string;
}

export interface Product {
  id: string;
  name: string;
  brand: string;
  category: string;
  image: string;
  price?: number;
  promoCode?: string;
  influencerId: string;
  launchDate: string;
  status: 'active' | 'ended';
}

export interface NewsItem {
  id: string;
  influencerId: string;
  title: string;
  type: 'news' | 'drama' | 'partnership' | 'milestone';
  date: string;
  description: string;
  severity?: 'low' | 'medium' | 'high';
  source?: string;
}

export interface Relationship {
  source: string;
  target: string;
  type: 'agency' | 'collaboration' | 'friendship' | 'brand';
  strength: number;
  label?: string;
}

export interface GraphNode {
  id: string;
  name: string;
  type: 'influencer' | 'agency' | 'brand' | 'event';
  avatar?: string;
  score?: number;
  size: number;
}
