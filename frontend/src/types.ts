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
  subscriberGrowth?: SubscriberGrowthPoint[];
  networkConnections?: NetworkConnection[];
  platformPresence?: PlatformPresence[];
  productsWithReviews?: Product[];
  followersByPlatform?: Record<string, number>;
  verified?: boolean;
  country?: string;
}

export interface SubscriberGrowthPoint {
  date: string;
  followers: number;
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

export interface ProductReview {
  author: string;
  comment: string;
  platform: string;
  sentiment: string;
  url?: string;
  date?: string;
}

export interface OpenFoodFactsData {
  type?: string;
  product_name?: string;
  brands?: string;
  barcode?: string;
  nutriscore?: string;
  nova_group?: number;
  ecoscore?: string;
  quality_score?: number;
  is_healthy?: boolean;
  nutriments?: any;
  ingredients_text?: string;
  allergens?: string[] | string;
  image_url?: string;
  url?: string;
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
  quality_score?: number;
  description?: string;
  review_count?: number;
  sentiment_score?: number;
  openfoodfacts_data?: OpenFoodFactsData;
  reviews?: ProductReview[];
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
  type: 'agency' | 'collaboration' | 'friendship' | 'brand' | 'partnership';
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

export interface GlobalInfluencerMarker {
  id: string;
  name: string;
  followers: number;
  lat: number;
  lng: number;
  country: string;
  platform: 'YouTube' | 'TikTok' | 'Instagram' | 'Twitch';
  color: string;
  highlight?: string;
}

export interface NetworkConnection {
  id: string;
  name: string;
  type: 'influencer' | 'agency' | 'brand' | 'event';
  color: string;
}

export interface PlatformPresence {
  platform: 'Youtube' | 'TikTok' | 'Instagram' | 'Twitter' | 'Twitch';
  handle: string;
  followers: number;
}

export interface SocialComment {
  id: string;
  influencerId: string;
  platform: string;
  author: string;
  date: string;
  content: string;
  sentiment: 'positive' | 'neutral' | 'negative';
}

// Contribution System Types
export type ContributionType =
  | 'timeline-event'
  | 'brand-signal'
  | 'network-insight'
  | 'platform-correction'
  | 'general-context';

export type ContributionStatus = 'pending' | 'approved' | 'rejected' | 'flagged';

export interface BaseContribution {
  id: string;
  type: ContributionType;
  influencerId: string;
  userId: string;
  submittedAt: string;
  status: ContributionStatus;
  confidence?: number; // 0-100
  validationResult?: ValidationResult;
}

export interface TimelineEventContribution extends BaseContribution {
  type: 'timeline-event';
  eventType: 'viral-moment' | 'collaboration' | 'controversy' | 'milestone' | 'other';
  title: string;
  description: string;
  date: string;
  evidence: {
    link?: string;
    platform?: string;
  };
}

export interface BrandSignalContribution extends BaseContribution {
  type: 'brand-signal';
  brandName: string;
  category: 'food' | 'fashion' | 'tech' | 'beauty' | 'gaming' | 'lifestyle' | 'other';
  evidence: {
    productShown: boolean;
    taggedBrand: boolean;
    affiliateLink: boolean;
    repeatedMentions: boolean;
  };
  postLink?: string;
}

export interface NetworkInsightContribution extends BaseContribution {
  type: 'network-insight';
  connectionType: 'collaboration' | 'friendship' | 'business' | 'family' | 'other';
  targetId: string; // ID of the connected influencer/brand/agency
  targetName: string;
  targetType: 'influencer' | 'brand' | 'agency';
  description: string;
  strength?: number; // 1-10
}

export interface PlatformCorrectionContribution extends BaseContribution {
  type: 'platform-correction';
  correctionType: 'missing-platform' | 'incorrect-followers' | 'incorrect-handle' | 'other';
  platform?: string;
  currentValue?: string | number;
  correctedValue: string | number;
  evidence?: string;
}

export interface GeneralContextContribution extends BaseContribution {
  type: 'general-context';
  category: string;
  content: string;
  tags?: string[];
}

export type Contribution =
  | TimelineEventContribution
  | BrandSignalContribution
  | NetworkInsightContribution
  | PlatformCorrectionContribution
  | GeneralContextContribution;

export interface ValidationResult {
  isValid: boolean;
  issues: ValidationIssue[];
  autoRouting: {
    targetSection: 'timeline' | 'collabs' | 'network' | 'sentiment' | 'platform';
    confidence: number;
  };
}

export interface ValidationIssue {
  type: 'duplicate' | 'contradiction' | 'impossible' | 'wrong-platform' | 'defamation' | 'unsafe';
  severity: 'low' | 'medium' | 'high';
  message: string;
}

export interface UserReputation {
  userId: string;
  score: number; // 0-100
  totalSubmissions: number;
  approvedSubmissions: number;
  flaggedSubmissions: number;
  badges: Badge[];
  joinedDate: string;
  contributionHistory: {
    month: string;
    count: number;
  }[];
}

export interface Badge {
  id: string;
  name: string;
  description: string;
  icon: string;
  earnedAt: string;
  rarity: 'common' | 'rare' | 'epic' | 'legendary';
}

export interface User {
  id: string;
  username: string;
  email: string;
  avatar?: string;
  reputation: UserReputation;
  createdAt: string;
}
