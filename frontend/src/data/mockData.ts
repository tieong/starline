import { Influencer, Product, NewsItem, Relationship, GraphNode, SocialComment, NetworkConnection, PlatformPresence } from '../types';

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
    },
    subscriberGrowth: [
      { date: '2023-01', followers: 13900000 },
      { date: '2023-02', followers: 14000000 },
      { date: '2023-03', followers: 14050000 },
      { date: '2023-04', followers: 14100000 },
      { date: '2023-05', followers: 14150000 },
      { date: '2023-06', followers: 14180000 },
      { date: '2023-07', followers: 14220000 },
      { date: '2023-08', followers: 14250000 },
      { date: '2023-09', followers: 14280000 },
      { date: '2023-10', followers: 14320000 },
      { date: '2023-11', followers: 14350000 },
      { date: '2023-12', followers: 14380000 },
      { date: '2024-01', followers: 14410000 },
      { date: '2024-02', followers: 14440000 },
      { date: '2024-03', followers: 14470000 },
      { date: '2024-04', followers: 14500000 }
    ]
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
    },
    subscriberGrowth: [
      { date: '2023-01', followers: 15200000 },
      { date: '2023-02', followers: 15450000 },
      { date: '2023-03', followers: 15700000 },
      { date: '2023-04', followers: 15950000 },
      { date: '2023-05', followers: 16200000 },
      { date: '2023-06', followers: 16400000 },
      { date: '2023-07', followers: 16650000 },
      { date: '2023-08', followers: 16850000 },
      { date: '2023-09', followers: 17100000 },
      { date: '2023-10', followers: 17300000 },
      { date: '2023-11', followers: 17500000 },
      { date: '2023-12', followers: 17700000 },
      { date: '2024-01', followers: 17850000 },
      { date: '2024-02', followers: 18000000 },
      { date: '2024-03', followers: 18100000 },
      { date: '2024-04', followers: 18200000 }
    ]
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
    },
    subscriberGrowth: [
      { date: '2023-01', followers: 3700000 },
      { date: '2023-02', followers: 3710000 },
      { date: '2023-03', followers: 3720000 },
      { date: '2023-04', followers: 3730000 },
      { date: '2023-05', followers: 3740000 },
      { date: '2023-06', followers: 3745000 },
      { date: '2023-07', followers: 3750000 },
      { date: '2023-08', followers: 3755000 },
      { date: '2023-09', followers: 3762000 },
      { date: '2023-10', followers: 3770000 },
      { date: '2023-11', followers: 3775000 },
      { date: '2023-12', followers: 3780000 },
      { date: '2024-01', followers: 3785000 },
      { date: '2024-02', followers: 3790000 },
      { date: '2024-03', followers: 3795000 },
      { date: '2024-04', followers: 3800000 }
    ]
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
    },
    subscriberGrowth: [
      { date: '2023-01', followers: 12250000 },
      { date: '2023-02', followers: 12240000 },
      { date: '2023-03', followers: 12230000 },
      { date: '2023-04', followers: 12220000 },
      { date: '2023-05', followers: 12200000 },
      { date: '2023-06', followers: 12190000 },
      { date: '2023-07', followers: 12180000 },
      { date: '2023-08', followers: 12170000 },
      { date: '2023-09', followers: 12155000 },
      { date: '2023-10', followers: 12145000 },
      { date: '2023-11', followers: 12130000 },
      { date: '2023-12', followers: 12120000 },
      { date: '2024-01', followers: 12115000 },
      { date: '2024-02', followers: 12110000 },
      { date: '2024-03', followers: 12105000 },
      { date: '2024-04', followers: 12100000 }
    ]
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
    },
    subscriberGrowth: [
      { date: '2023-01', followers: 6200000 },
      { date: '2023-02', followers: 6320000 },
      { date: '2023-03', followers: 6420000 },
      { date: '2023-04', followers: 6530000 },
      { date: '2023-05', followers: 6640000 },
      { date: '2023-06', followers: 6750000 },
      { date: '2023-07', followers: 6850000 },
      { date: '2023-08', followers: 6930000 },
      { date: '2023-09', followers: 7010000 },
      { date: '2023-10', followers: 7080000 },
      { date: '2023-11', followers: 7140000 },
      { date: '2023-12', followers: 7200000 },
      { date: '2024-01', followers: 7230000 },
      { date: '2024-02', followers: 7250000 },
      { date: '2024-03', followers: 7275000 },
      { date: '2024-04', followers: 7300000 }
    ]
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
    },
    subscriberGrowth: [
      { date: '2023-01', followers: 5080000 },
      { date: '2023-02', followers: 5090000 },
      { date: '2023-03', followers: 5100000 },
      { date: '2023-04', followers: 5110000 },
      { date: '2023-05', followers: 5122000 },
      { date: '2023-06', followers: 5130000 },
      { date: '2023-07', followers: 5140000 },
      { date: '2023-08', followers: 5148000 },
      { date: '2023-09', followers: 5155000 },
      { date: '2023-10', followers: 5165000 },
      { date: '2023-11', followers: 5172000 },
      { date: '2023-12', followers: 5180000 },
      { date: '2024-01', followers: 5185000 },
      { date: '2024-02', followers: 5190000 },
      { date: '2024-03', followers: 5195000 },
      { date: '2024-04', followers: 5200000 }
    ]
  },
  {
    id: 'mrbeast',
    name: 'MrBeast',
    handle: '@MrBeast',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=MrBeast',
    followers: 279000000,
    engagementRate: 12.4,
    niche: ['Challenges', 'Philanthropie', 'Divertissement'],
    bio: 'Créateur américain connu pour ses défis monumentaux et sa philanthropie.',
    agency: 'MrBeast Studios',
    influscoring: {
      overall: 98,
      reliability: 95,
      controversies: 15,
      authenticity: 94,
      reputation: 97,
      professionalism: 95,
      trend: 'up'
    },
    stats: {
      avgViews: 85000000,
      avgLikes: 6200000,
      postingFrequency: '2 vidéos/mois',
      topCountries: ['États-Unis', 'Brésil', 'Inde', 'Mexique'],
      audienceAge: [
        { range: '13-17', percentage: 25 },
        { range: '18-24', percentage: 45 },
        { range: '25-34', percentage: 20 },
        { range: '35+', percentage: 10 }
      ],
      audienceGender: { male: 61, female: 37, other: 2 }
    },
    socialLinks: {
      youtube: 'MrBeast',
      instagram: 'mrbeast',
      tiktok: 'mrbeast',
      twitter: 'MrBeast'
    },
    subscriberGrowth: [
      { date: '2024-01', followers: 100000000 },
      { date: '2024-02', followers: 120000000 },
      { date: '2024-03', followers: 145000000 },
      { date: '2024-04', followers: 165000000 },
      { date: '2024-05', followers: 185000000 },
      { date: '2024-06', followers: 205000000 },
      { date: '2024-07', followers: 225000000 },
      { date: '2024-08', followers: 245000000 },
      { date: '2024-09', followers: 260000000 },
      { date: '2024-10', followers: 270000000 },
      { date: '2024-11', followers: 279000000 }
    ],
    networkConnections: [
      { id: 'squeezie', name: 'Squeezie', type: 'influencer', color: '#8B5CF6' },
      { id: 'pewdiepie', name: 'PewDiePie', type: 'influencer', color: '#8B5CF6' },
      { id: 'ibai', name: 'Ibai', type: 'influencer', color: '#10B981' },
      { id: 'YouTube Global', name: 'YouTube Global', type: 'brand', color: '#3B82F6' },
      { id: 'Webedia', name: 'Webedia', type: 'agency', color: '#F59E0B' }
    ],
    platformPresence: [
      { platform: 'Youtube', handle: '@MrBeast', followers: 230000000 },
      { platform: 'TikTok', handle: '@mrbeast', followers: 119300000 },
      { platform: 'Instagram', handle: '@mrbeast', followers: 59000000 },
      { platform: 'Twitter', handle: '@MrBeast', followers: 27000000 }
    ]
  },
  {
    id: 'charlidamelio',
    name: 'Charli D’Amelio',
    handle: '@charlidamelio',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Charli',
    followers: 152000000,
    engagementRate: 5.4,
    niche: ['Dance', 'Lifestyle', 'Entertainment'],
    bio: 'Première star planétaire de TikTok, danseuse et créatrice lifestyle.',
    agency: 'UTA',
    influscoring: {
      overall: 90,
      reliability: 88,
      controversies: 20,
      authenticity: 86,
      reputation: 89,
      professionalism: 91,
      trend: 'stable'
    },
    stats: {
      avgViews: 22000000,
      avgLikes: 2000000,
      postingFrequency: '6 vidéos/semaine',
      topCountries: ['États-Unis', 'Mexique', 'Brésil', 'France'],
      audienceAge: [
        { range: '13-17', percentage: 40 },
        { range: '18-24', percentage: 38 },
        { range: '25-34', percentage: 18 },
        { range: '35+', percentage: 4 }
      ],
      audienceGender: { male: 23, female: 74, other: 3 }
    },
    socialLinks: {
      tiktok: 'charlidamelio',
      instagram: 'charlidamelio',
      youtube: 'charlidamelio',
      twitter: 'charlidamelio'
    }
  },
  {
    id: 'khabylame',
    name: 'Khaby Lame',
    handle: '@Khaby.Lame',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Khaby',
    followers: 162000000,
    engagementRate: 7.6,
    niche: ['Humour', 'TikTok Hacks', 'Skits'],
    bio: 'Créateur italo-sénégalais devenu célèbre pour ses réactions silencieuses.',
    agency: 'Iron Corporation',
    influscoring: {
      overall: 92,
      reliability: 94,
      controversies: 5,
      authenticity: 91,
      reputation: 93,
      professionalism: 90,
      trend: 'stable'
    },
    stats: {
      avgViews: 28000000,
      avgLikes: 2400000,
      postingFrequency: '4 vidéos/semaine',
      topCountries: ['Italie', 'États-Unis', 'France', 'Brésil'],
      audienceAge: [
        { range: '13-17', percentage: 35 },
        { range: '18-24', percentage: 42 },
        { range: '25-34', percentage: 18 },
        { range: '35+', percentage: 5 }
      ],
      audienceGender: { male: 48, female: 49, other: 3 }
    },
    socialLinks: {
      tiktok: 'khaby.lame',
      instagram: 'khaby00',
      youtube: 'khaby_lame'
    }
  },
  {
    id: 'pewdiepie',
    name: 'PewDiePie',
    handle: '@pewdiepie',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Pewdiepie',
    followers: 111000000,
    engagementRate: 4.1,
    niche: ['Gaming', 'Commentaire', 'Vlogs'],
    bio: 'Légende de YouTube, pionnier du format Let’s Play.',
    agency: 'Revelmode',
    influscoring: {
      overall: 88,
      reliability: 85,
      controversies: 35,
      authenticity: 90,
      reputation: 82,
      professionalism: 87,
      trend: 'stable'
    },
    stats: {
      avgViews: 4500000,
      avgLikes: 380000,
      postingFrequency: '1 vidéo/semaine',
      topCountries: ['États-Unis', 'Suède', 'Royaume-Uni', 'Allemagne'],
      audienceAge: [
        { range: '13-17', percentage: 20 },
        { range: '18-24', percentage: 40 },
        { range: '25-34', percentage: 30 },
        { range: '35+', percentage: 10 }
      ],
      audienceGender: { male: 72, female: 26, other: 2 }
    },
    socialLinks: {
      youtube: 'pewdiepie',
      instagram: 'pewdiepie',
      twitter: 'pewdiepie'
    }
  },
  {
    id: 'carryminati',
    name: 'CarryMinati',
    handle: '@CarryMinati',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Carry',
    followers: 40000000,
    engagementRate: 10.8,
    niche: ['Roast', 'Gaming', 'Comedy'],
    bio: 'YouTubeur indien connu pour ses roasts et streams énergiques.',
    agency: 'TVF Play',
    influscoring: {
      overall: 89,
      reliability: 87,
      controversies: 30,
      authenticity: 88,
      reputation: 85,
      professionalism: 86,
      trend: 'up'
    },
    stats: {
      avgViews: 15000000,
      avgLikes: 1300000,
      postingFrequency: '1 vidéo/mois',
      topCountries: ['Inde', 'Pakistan', 'Émirats arabes unis', 'Bangladesh'],
      audienceAge: [
        { range: '13-17', percentage: 30 },
        { range: '18-24', percentage: 50 },
        { range: '25-34', percentage: 15 },
        { range: '35+', percentage: 5 }
      ],
      audienceGender: { male: 82, female: 16, other: 2 }
    },
    socialLinks: {
      youtube: 'CarryMinati',
      instagram: 'carryminati',
      twitter: 'CarryMinati'
    }
  },
  {
    id: 'ibai',
    name: 'Ibai Llanos',
    handle: '@IbaiLlanos',
    avatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=Ibai',
    followers: 19000000,
    engagementRate: 9.5,
    niche: ['Streaming', 'Esport', 'Événements'],
    bio: 'Streamer espagnol, animateur d’événements sportifs digitaux.',
    agency: 'Kosmos Studios',
    influscoring: {
      overall: 91,
      reliability: 93,
      controversies: 10,
      authenticity: 92,
      reputation: 90,
      professionalism: 94,
      trend: 'up'
    },
    stats: {
      avgViews: 8000000,
      avgLikes: 620000,
      postingFrequency: 'Streams quotidiens',
      topCountries: ['Espagne', 'Mexique', 'Argentine', 'Colombie'],
      audienceAge: [
        { range: '13-17', percentage: 18 },
        { range: '18-24', percentage: 46 },
        { range: '25-34', percentage: 28 },
        { range: '35+', percentage: 8 }
      ],
      audienceGender: { male: 70, female: 28, other: 2 }
    },
    socialLinks: {
      twitch: 'ibai',
      youtube: 'ibai',
      twitter: 'IbaiLlanos'
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

const minFollowers = Math.min(...influencers.map(inf => inf.followers));
const maxFollowers = Math.max(...influencers.map(inf => inf.followers));

const scaleFollowersToSize = (followers: number) => {
  if (maxFollowers === minFollowers) return 60;
  const minSize = 40;
  const maxSize = 120;
  const progress = (followers - minFollowers) / (maxFollowers - minFollowers);
  return minSize + progress * (maxSize - minSize);
};

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
  { source: 'mcfly-carlito', target: 'Prime Video', type: 'brand', strength: 0.95 },
  { source: 'mrbeast', target: 'YouTube Global', type: 'brand', strength: 1.0 },
  { source: 'mrbeast', target: 'pewdiepie', type: 'friendship', strength: 0.7, label: 'Collaborations' },
  { source: 'pewdiepie', target: 'YouTube Global', type: 'brand', strength: 0.95 },
  { source: 'carryminati', target: 'YouTube Global', type: 'brand', strength: 0.92 },
  { source: 'ibai', target: 'Twitch Global', type: 'brand', strength: 0.9 },
  { source: 'ibai', target: 'squeezie', type: 'collaboration', strength: 0.4, label: 'Événements gaming' },
  { source: 'charlidamelio', target: 'TikTok Global', type: 'brand', strength: 1.0 },
  { source: 'khabylame', target: 'TikTok Global', type: 'brand', strength: 1.0 },
  { source: 'charlidamelio', target: 'khabylame', type: 'friendship', strength: 0.5, label: 'TikTok Awards' }
];

export const graphNodes: GraphNode[] = [
  ...influencers.map(inf => ({
    id: inf.id,
    name: inf.name,
    type: 'influencer' as const,
    avatar: inf.avatar,
    score: inf.influscoring.overall,
    size: scaleFollowersToSize(inf.followers)
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
  },
  {
    id: 'YouTube Global',
    name: 'YouTube Global',
    type: 'brand' as const,
    size: 70
  },
  {
    id: 'TikTok Global',
    name: 'TikTok Global',
    type: 'brand' as const,
    size: 65
  },
  {
    id: 'Twitch Global',
    name: 'Twitch Global',
    type: 'brand' as const,
    size: 55
  }
];

export const socialComments: SocialComment[] = [
  {
    id: 'comment-1',
    influencerId: 'mrbeast',
    platform: 'YouTube',
    author: 'Casual Gamer Broad',
    date: '2024-11-10',
    content: 'I love your content! And I don\'t usually think highly of beast themed candy etc. Absolutely love this you\'re doing for those people. You\'re going to save this and you play the hero.',
    sentiment: 'positive'
  },
  {
    id: 'comment-2',
    influencerId: 'mrbeast',
    platform: 'YouTube',
    author: 'Industrial Barbies',
    date: '2024-11-08',
    content: 'I like your recently good point. I like everything you create is excellent and better than your previous video. So, here\'s another great video about this. I beg about to our Oz friend go... \'love another great please keep these content coming" - Thx.',
    sentiment: 'positive'
  },
  {
    id: 'comment-3',
    influencerId: 'mrbeast',
    platform: 'TikTok',
    author: 'oliviarX',
    date: '2024-11-05',
    content: 'Get everyone a perculate here could donate just ten% the biggest price or the charity. The house price... We feel sorry... We really need on Twitter, we got back into these challenges... a few YT streams occasionally to keep challenges, we keep another grow later down about this \"... I heard just how funny out about...',
    sentiment: 'neutral'
  },
  {
    id: 'comment-4',
    influencerId: 'mrbeast',
    platform: 'Twitter',
    author: 'Ryan Butner',
    date: '2024-11-01',
    content: 'Let everyone a hundred and break record though like this latest phase on the factory would be a massive production; he follows along the people. Some lore YouTubers views, are frankly quite calculating to have changes, they are kind enough you are consistent, art the conditions.',
    sentiment: 'negative'
  },
  {
    id: 'comment-5',
    influencerId: 'squeezie',
    platform: 'YouTube',
    author: 'PierreGaming',
    date: '2024-10-28',
    content: 'Squeezie est juste incroyable ! Ses vidéos sont toujours de qualité et divertissantes. Continue comme ça !',
    sentiment: 'positive'
  },
  {
    id: 'comment-6',
    influencerId: 'squeezie',
    platform: 'Twitter',
    author: 'MarieB92',
    date: '2024-10-25',
    content: 'Fan depuis le début, tes vidéos m\'ont accompagné pendant toute ma jeunesse. Merci pour tout !',
    sentiment: 'positive'
  }
];
