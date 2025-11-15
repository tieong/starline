import { Influencer, Product, NewsItem, Relationship, GraphNode } from '../types';

export const influencers: Influencer[] = [
  {
    id: 'cyprien',
    name: 'Cyprien',
    handle: '@MonsieurDream',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Cyprien',
    followers: 14500000,
    engagementRate: 8.5,
    niche: ['Comédie', 'Sketches', 'Gaming'],
    bio: 'Créateur de contenu humoristique depuis 2007. Pionnier du YouTube français.',
    agency: 'Webedia',
    influscoring: {
      overall: 92,
      reliability: 95,
      controversies: 15,
      authenticity: 90,
      reputation: 94,
      professionalism: 96,
      trend: 'stable'
    },
    stats: {
      avgViews: 2500000,
      avgLikes: 185000,
      postingFrequency: '2-3 vidéos/mois',
      topCountries: ['France', 'Belgique', 'Suisse', 'Canada'],
      audienceAge: [
        { range: '13-17', percentage: 15 },
        { range: '18-24', percentage: 45 },
        { range: '25-34', percentage: 30 },
        { range: '35+', percentage: 10 }
      ],
      audienceGender: { male: 65, female: 33, other: 2 }
    },
    socialLinks: {
      youtube: 'MonsieurDream',
      instagram: 'cyprien',
      twitter: 'MonsieurDream'
    }
  },
  {
    id: 'squeezie',
    name: 'Squeezie',
    handle: '@SqueezieFR',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Squeezie',
    followers: 18200000,
    engagementRate: 9.2,
    niche: ['Gaming', 'Divertissement', 'Musique'],
    bio: 'Plus gros YouTubeur français. Gaming, challenges, et maintenant rappeur !',
    agency: 'Webedia',
    influscoring: {
      overall: 96,
      reliability: 98,
      controversies: 8,
      authenticity: 95,
      reputation: 97,
      professionalism: 95,
      trend: 'up'
    },
    stats: {
      avgViews: 4200000,
      avgLikes: 320000,
      postingFrequency: '3-4 vidéos/mois',
      topCountries: ['France', 'Belgique', 'Suisse', 'Québec'],
      audienceAge: [
        { range: '13-17', percentage: 35 },
        { range: '18-24', percentage: 40 },
        { range: '25-34', percentage: 20 },
        { range: '35+', percentage: 5 }
      ],
      audienceGender: { male: 72, female: 26, other: 2 }
    },
    socialLinks: {
      youtube: 'SqueezieFR',
      instagram: 'xsqueezie',
      twitter: 'xSqueezie',
      twitch: 'xSqueezie'
    }
  },
  {
    id: 'enjoyphoenix',
    name: 'EnjoyPhoenix',
    handle: '@EnjoyPhoenix',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Marie',
    followers: 3800000,
    engagementRate: 6.8,
    niche: ['Beauté', 'Lifestyle', 'Bien-être'],
    bio: 'Pionnière de la beauté sur YouTube FR. Entrepreneure et auteure.',
    agency: 'Webedia Creators',
    influscoring: {
      overall: 85,
      reliability: 88,
      controversies: 25,
      authenticity: 82,
      reputation: 85,
      professionalism: 90,
      trend: 'stable'
    },
    stats: {
      avgViews: 450000,
      avgLikes: 35000,
      postingFrequency: '1-2 vidéos/mois',
      topCountries: ['France', 'Belgique', 'Suisse', 'Maroc'],
      audienceAge: [
        { range: '13-17', percentage: 20 },
        { range: '18-24', percentage: 50 },
        { range: '25-34', percentage: 25 },
        { range: '35+', percentage: 5 }
      ],
      audienceGender: { male: 8, female: 90, other: 2 }
    },
    socialLinks: {
      youtube: 'EnjoyPhoenix',
      instagram: 'enjoyphoenix',
      twitter: 'EnjoyPhoenix'
    }
  },
  {
    id: 'norman',
    name: 'Norman Thavaud',
    handle: '@NormanFaitDesVideos',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Norman',
    followers: 12100000,
    engagementRate: 5.2,
    niche: ['Comédie', 'Sketches', 'Vlogs'],
    bio: 'Créateur de sketches cultes sur YouTube depuis 2011.',
    influscoring: {
      overall: 42,
      reliability: 35,
      controversies: 95,
      authenticity: 40,
      reputation: 28,
      professionalism: 45,
      trend: 'down'
    },
    stats: {
      avgViews: 850000,
      avgLikes: 45000,
      postingFrequency: 'Inactif',
      topCountries: ['France', 'Belgique', 'Suisse'],
      audienceAge: [
        { range: '13-17', percentage: 10 },
        { range: '18-24', percentage: 35 },
        { range: '25-34', percentage: 40 },
        { range: '35+', percentage: 15 }
      ],
      audienceGender: { male: 58, female: 40, other: 2 }
    },
    socialLinks: {
      youtube: 'NormanFaitDesVideos'
    }
  },
  {
    id: 'mcfly-carlito',
    name: 'McFly & Carlito',
    handle: '@McFlyCarlito',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=McFly',
    followers: 7300000,
    engagementRate: 11.5,
    niche: ['Divertissement', 'Challenges', 'Interviews'],
    bio: 'Duo explosif de YouTube FR. Connus pour leurs challenges délirants.',
    agency: 'Webedia',
    influscoring: {
      overall: 94,
      reliability: 96,
      controversies: 5,
      authenticity: 93,
      reputation: 95,
      professionalism: 92,
      trend: 'up'
    },
    stats: {
      avgViews: 3100000,
      avgLikes: 280000,
      postingFrequency: '2 vidéos/semaine',
      topCountries: ['France', 'Belgique', 'Suisse', 'Canada'],
      audienceAge: [
        { range: '13-17', percentage: 25 },
        { range: '18-24', percentage: 40 },
        { range: '25-34', percentage: 28 },
        { range: '35+', percentage: 7 }
      ],
      audienceGender: { male: 54, female: 44, other: 2 }
    },
    socialLinks: {
      youtube: 'McFlyCarlito',
      instagram: 'mcflycarlito',
      twitter: 'mcflycarlito'
    }
  },
  {
    id: 'natoo',
    name: 'Natoo',
    handle: '@NatooOfficiel',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Natoo',
    followers: 5200000,
    engagementRate: 7.1,
    niche: ['Comédie', 'Lifestyle', 'Vlogs'],
    bio: 'Comédienne et créatrice de contenu. Des sketches qui marquent.',
    influscoring: {
      overall: 88,
      reliability: 90,
      controversies: 12,
      authenticity: 87,
      reputation: 89,
      professionalism: 91,
      trend: 'stable'
    },
    stats: {
      avgViews: 920000,
      avgLikes: 68000,
      postingFrequency: '1 vidéo/mois',
      topCountries: ['France', 'Belgique', 'Maroc', 'Algérie'],
      audienceAge: [
        { range: '13-17', percentage: 18 },
        { range: '18-24', percentage: 48 },
        { range: '25-34', percentage: 27 },
        { range: '35+', percentage: 7 }
      ],
      audienceGender: { male: 35, female: 63, other: 2 }
    },
    socialLinks: {
      youtube: 'NatooOfficiel',
      instagram: 'natoo',
      twitter: 'Natootwit'
    }
  }
];

export const products: Product[] = [
  {
    id: 'p1',
    name: 'Palette Sunset Dream',
    brand: 'EnjoyPhoenix Beauty',
    category: 'Maquillage',
    image: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400',
    price: 29.99,
    promoCode: 'PHOENIX20',
    influencerId: 'enjoyphoenix',
    launchDate: '2024-03-15',
    status: 'active'
  },
  {
    id: 'p2',
    name: 'Casque Gaming RGB X7',
    brand: 'Squeezie x Razer',
    category: 'Gaming',
    image: 'https://images.unsplash.com/photo-1599669454699-248893623440?w=400',
    price: 149.99,
    promoCode: 'SQUEEZIE15',
    influencerId: 'squeezie',
    launchDate: '2024-01-20',
    status: 'active'
  },
  {
    id: 'p3',
    name: 'Livre "Les Chroniques de Cyprien"',
    brand: 'Éditions Kana',
    category: 'Livre',
    image: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400',
    price: 19.99,
    influencerId: 'cyprien',
    launchDate: '2023-11-10',
    status: 'active'
  },
  {
    id: 'p4',
    name: 'Collection Streetwear "MC"',
    brand: 'McFly & Carlito',
    category: 'Mode',
    image: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400',
    price: 45.00,
    promoCode: 'MC2024',
    influencerId: 'mcfly-carlito',
    launchDate: '2024-02-01',
    status: 'active'
  },
  {
    id: 'p5',
    name: 'Sérum Anti-Imperfections',
    brand: 'EnjoyPhoenix x Typology',
    category: 'Soin',
    image: 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400',
    price: 34.90,
    influencerId: 'enjoyphoenix',
    launchDate: '2023-09-20',
    status: 'ended'
  }
];

export const newsItems: NewsItem[] = [
  {
    id: 'n1',
    influencerId: 'squeezie',
    title: 'Squeezie annonce un nouvel album rap pour mai 2025',
    type: 'news',
    date: '2024-11-10',
    description: 'Le YouTubeur confirme travailler sur un deuxième album après le succès de "Oxyz".',
    source: 'Twitter'
  },
  {
    id: 'n2',
    influencerId: 'norman',
    title: 'Affaire Norman : enquête toujours en cours',
    type: 'drama',
    date: '2024-10-15',
    description: 'Les accusations portées contre Norman font toujours l\'objet d\'une enquête judiciaire.',
    severity: 'high',
    source: 'Médias'
  },
  {
    id: 'n3',
    influencerId: 'mcfly-carlito',
    title: 'Partenariat avec Amazon Prime pour une série originale',
    type: 'partnership',
    date: '2024-11-01',
    description: 'McFly & Carlito développent une série de divertissement exclusive pour Prime Video.',
    source: 'Prime Video'
  },
  {
    id: 'n4',
    influencerId: 'cyprien',
    title: 'Cyprien dépasse les 15 ans de carrière sur YouTube',
    type: 'milestone',
    date: '2024-10-28',
    description: 'Le créateur célèbre 15 ans de vidéos avec un best-of nostalgique.',
    source: 'YouTube'
  },
  {
    id: 'n5',
    influencerId: 'enjoyphoenix',
    title: 'Lancement de sa propre marque de cosmétiques naturels',
    type: 'partnership',
    date: '2024-09-12',
    description: 'Marie Lopez lance "Phoenix Beauty", sa marque de cosmétiques bio et vegan.',
    source: 'Instagram'
  },
  {
    id: 'n6',
    influencerId: 'natoo',
    title: 'Nouvelle collaboration avec Netflix France',
    type: 'partnership',
    date: '2024-08-20',
    description: 'Natoo rejoint le casting d\'une comédie Netflix prévue pour 2025.',
    source: 'Netflix'
  }
];

export const relationships: Relationship[] = [
  { source: 'cyprien', target: 'squeezie', type: 'friendship', strength: 0.9, label: 'Amis proches' },
  { source: 'cyprien', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'squeezie', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'enjoyphoenix', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'mcfly-carlito', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'squeezie', target: 'mcfly-carlito', type: 'collaboration', strength: 0.85, label: 'Vidéos communes' },
  { source: 'cyprien', target: 'mcfly-carlito', type: 'friendship', strength: 0.7 },
  { source: 'natoo', target: 'enjoyphoenix', type: 'friendship', strength: 0.8, label: 'Soutien mutuel' },
  { source: 'norman', target: 'cyprien', type: 'friendship', strength: 0.3, label: 'Anciens collaborateurs' },
  { source: 'enjoyphoenix', target: 'Typology', type: 'brand', strength: 0.9 },
  { source: 'squeezie', target: 'Razer', type: 'brand', strength: 0.85 },
  { source: 'mcfly-carlito', target: 'Prime Video', type: 'brand', strength: 0.95 }
];

export const graphNodes: GraphNode[] = [
  ...influencers.map(inf => ({
    id: inf.id,
    name: inf.name,
    type: 'influencer' as const,
    avatar: inf.avatar,
    score: inf.influscoring.overall,
    size: Math.log(inf.followers) * 8
  })),
  {
    id: 'Webedia',
    name: 'Webedia',
    type: 'agency' as const,
    size: 60
  },
  {
    id: 'Typology',
    name: 'Typology',
    type: 'brand' as const,
    size: 40
  },
  {
    id: 'Razer',
    name: 'Razer',
    type: 'brand' as const,
    size: 45
  },
  {
    id: 'Prime Video',
    name: 'Prime Video',
    type: 'brand' as const,
    size: 50
  }
];
