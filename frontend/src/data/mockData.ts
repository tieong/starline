import { Influencer, Product, NewsItem, Relationship, GraphNode, SocialComment } from '../types';

export const influencers: Influencer[] = [
  {
    id: 'cyprien',
    name: 'Cyprien',
    handle: '@MonsieurDream',
    avatar: '/src/data/imgs/cyprien.jpeg',
    followers: 14700000,
    engagementRate: 8.5,
    niche: ['Comedy', 'Sketches', 'Gaming'],
    bio: 'Humorous content creator since 2007. Pioneer of French YouTube.',
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
      postingFrequency: '2-3 videos/month',
      topCountries: ['France', 'Belgium', 'Switzerland', 'Canada'],
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
      { date: '2024-04', followers: 14500000 },
      { date: '2025-01', followers: 14700000 }
    ]
  },
  {
    id: 'squeezie',
    name: 'Squeezie',
    handle: '@SqueezieFR',
    avatar: '/src/data/imgs/squeezie.png',
    followers: 19000000,
    engagementRate: 9.2,
    niche: ['Gaming', 'Entertainment', 'Music'],
    bio: 'Biggest French YouTuber. Gaming, challenges, and now rapper!',
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
      postingFrequency: '3-4 videos/month',
      topCountries: ['France', 'Belgium', 'Switzerland', 'Quebec'],
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
      { date: '2024-04', followers: 18200000 },
      { date: '2025-01', followers: 19000000 }
    ]
  },
  {
    id: 'enjoyphoenix',
    name: 'EnjoyPhoenix',
    handle: '@EnjoyPhoenix',
    avatar: '/src/data/imgs/enjoyphoenix.jpeg',
    followers: 3900000,
    engagementRate: 6.8,
    niche: ['Beauty', 'Lifestyle', 'Wellness'],
    bio: 'Pioneer of beauty on French YouTube. Entrepreneur and author.',
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
      postingFrequency: '1-2 videos/month',
      topCountries: ['France', 'Belgium', 'Switzerland', 'Morocco'],
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
    avatar: '/src/data/imgs/norman.jpg',
    followers: 12000000,
    engagementRate: 5.2,
    niche: ['Comedy', 'Sketches', 'Vlogs'],
    bio: 'Creator of iconic sketches on YouTube since 2011.',
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
      postingFrequency: 'Inactive',
      topCountries: ['France', 'Belgium', 'Switzerland'],
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
    avatar: '/src/data/imgs/mcfly.jpeg',
    followers: 7800000,
    engagementRate: 11.5,
    niche: ['Entertainment', 'Challenges', 'Interviews'],
    bio: 'Explosive French YouTube duo. Known for their crazy challenges.',
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
      postingFrequency: '2 videos/week',
      topCountries: ['France', 'Belgium', 'Switzerland', 'Canada'],
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
    avatar: '/src/data/imgs/natoo.jpg',
    followers: 5300000,
    engagementRate: 7.1,
    niche: ['Comedy', 'Lifestyle', 'Vlogs'],
    bio: 'Comedian and content creator. Sketches that leave a mark.',
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
      postingFrequency: '1 video/month',
      topCountries: ['France', 'Belgium', 'Morocco', 'Algeria'],
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
    avatar: '/src/data/imgs/mrbeast.jpg',
    followers: 415000000,
    engagementRate: 12.4,
    niche: ['Challenges', 'Philanthropie', 'Divertissement'],
    bio: 'American YouTuber, media personality, and businessman known for elaborate challenges and philanthropy.',
    agency: 'Night Media',
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
      postingFrequency: '2 videos/month',
      topCountries: ['United States', 'Brazil', 'India', 'Mexico'],
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
      { date: '2024-11', followers: 279000000 },
      { date: '2025-08', followers: 415000000 }
    ],
    networkConnections: [
      { id: 'night-media', name: 'Night Media', type: 'agency', color: '#F59E0B' },
      { id: 'ksi', name: 'KSI', type: 'influencer', color: '#8B5CF6' },
      { id: 'feastables', name: 'Feastables', type: 'brand', color: '#3B82F6' },
      { id: 'amazon-prime', name: 'Amazon Prime', type: 'brand', color: '#3B82F6' },
      { id: 'team-trees', name: 'Team Trees / Team Seas', type: 'brand', color: '#10B981' }
    ],
    platformPresence: [
      { platform: 'Youtube', handle: '@MrBeast', followers: 415000000 },
      { platform: 'TikTok', handle: '@mrbeast', followers: 160000000 },
      { platform: 'Instagram', handle: '@mrbeast', followers: 90000000 },
      { platform: 'Twitter', handle: '@MrBeast', followers: 35000000 }
    ]
  },
  {
    id: 'charlidamelio',
    name: 'Charli D’Amelio',
    handle: '@charlidamelio',
    avatar: '/src/data/imgs/amelio.jpeg',
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
      postingFrequency: '6 videos/week',
      topCountries: ['United States', 'Mexico', 'Brazil', 'France'],
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
    avatar: '/src/data/imgs/khaby.jpeg',
    followers: 162000000,
    engagementRate: 7.6,
    niche: ['Humor', 'TikTok Hacks', 'Skits'],
    bio: 'Italian-Senegalese creator who became famous for his silent reactions.',
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
      postingFrequency: '4 videos/week',
      topCountries: ['Italy', 'United States', 'France', 'Brazil'],
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
    avatar: '/src/data/imgs/pewdiepie.jpeg',
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
      postingFrequency: '1 video/week',
      topCountries: ['United States', 'Sweden', 'United Kingdom', 'Germany'],
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
    avatar: '/src/data/imgs/carry.jpg',
    followers: 42000000,
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
      postingFrequency: '1 video/month',
      topCountries: ['India', 'Pakistan', 'United Arab Emirates', 'Bangladesh'],
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
    avatar: '/src/data/imgs/ibai.jpeg',
    followers: 22000000,
    engagementRate: 9.5,
    niche: ['Streaming', 'Esports', 'Events'],
    bio: 'Spanish streamer, host of digital sports events.',
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
      postingFrequency: 'Daily streams',
      topCountries: ['Spain', 'Mexico', 'Argentina', 'Colombia'],
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
  },
  {
    id: 'inoxtag',
    name: 'Inoxtag',
    handle: '@Inoxtag',
    avatar: 'https://netradio.fr/wp-content/uploads/2023/09/Inoxtag-Plus-de-Pubs-pour-des-Projets-Fous-.jpg',
    followers: 9500000,
    engagementRate: 11.2,
    niche: ['Gaming', 'Adventure', 'Challenges'],
    bio: 'Inoxtag (Inès Benazzouz) is a French social media influencer known for gaming, adventure vlogs, and spectacular challenges, inspiring millions with his authenticity and creativity.',
    agency: 'Webedia',
    influscoring: {
      overall: 94,
      reliability: 96,
      controversies: 8,
      authenticity: 95,
      reputation: 93,
      professionalism: 92,
      trend: 'up'
    },
    stats: {
      avgViews: 5800000,
      avgLikes: 450000,
      postingFrequency: '2 videos/month',
      topCountries: ['France', 'Belgium', 'Switzerland', 'Canada'],
      audienceAge: [
        { range: '13-17', percentage: 42 },
        { range: '18-24', percentage: 38 },
        { range: '25-34', percentage: 15 },
        { range: '35+', percentage: 5 }
      ],
      audienceGender: { male: 68, female: 30, other: 2 }
    },
    socialLinks: {
      youtube: 'Inoxtag',
      instagram: 'inoxtag',
      twitter: 'Inoxtag'
    },
    subscriberGrowth: [
      { date: '2023-01', followers: 4200000 },
      { date: '2023-06', followers: 5100000 },
      { date: '2023-12', followers: 6300000 },
      { date: '2024-01', followers: 6500000 },
      { date: '2024-06', followers: 7800000 },
      { date: '2024-09', followers: 8500000 },
      { date: '2025-06', followers: 9500000 }
    ],
    networkConnections: [
      { id: 'webedia', name: 'Webedia', type: 'agency', color: '#F59E0B' },
      { id: 'nil-ojeda', name: 'Nil Ojeda', type: 'influencer', color: '#8B5CF6' },
      { id: 'socialveins', name: 'Socialveins', type: 'agency', color: '#F59E0B' },
      { id: 'milfshakes', name: 'MILFSHAKES', type: 'brand', color: '#3B82F6' }
    ],
    platformPresence: [
      { platform: 'Youtube', handle: '@Inoxtag', followers: 9500000 },
      { platform: 'Instagram', handle: '@inoxtag', followers: 4000000 },
      { platform: 'Twitter', handle: '@Inoxtag', followers: 600000 }
    ]
  }
];

export const products: Product[] = [
  {
    id: 'p1',
    name: 'Palette Sunset Dream',
    brand: 'EnjoyPhoenix Beauty',
    category: 'Makeup',
    image: 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400',
    price: 29.99,
    promoCode: 'PHOENIX20',
    influencerId: 'enjoyphoenix',
    launchDate: '2024-03-15',
    status: 'active'
  },
  {
    id: 'p2',
    name: 'RGB X7 Gaming Headset',
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
    name: 'Book "The Chronicles of Cyprien"',
    brand: 'Éditions Kana',
    category: 'Book',
    image: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400',
    price: 19.99,
    influencerId: 'cyprien',
    launchDate: '2023-11-10',
    status: 'active'
  },
  {
    id: 'p4',
    name: 'Streetwear Collection "MC"',
    brand: 'McFly & Carlito',
    category: 'Fashion',
    image: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400',
    price: 45.00,
    promoCode: 'MC2024',
    influencerId: 'mcfly-carlito',
    launchDate: '2024-02-01',
    status: 'active'
  },
  {
    id: 'p5',
    name: 'Anti-Blemish Serum',
    brand: 'EnjoyPhoenix x Typology',
    category: 'Skincare',
    image: 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400',
    price: 34.90,
    influencerId: 'enjoyphoenix',
    launchDate: '2023-09-20',
    status: 'ended'
  },
  {
    id: 'p6',
    name: 'Feastables',
    brand: 'Feastables',
    category: 'food',
    image: 'https://images.openfoodfacts.org/images/products/123/000/016/8045/front_en.34.400.jpg',
    price: 2.99,
    influencerId: 'mrbeast',
    launchDate: '2022-01-29',
    status: 'active',
    openfoodfacts_data: {
      type: 'food',
      product_name: 'Feastables - Milk Chocolate',
      brands: 'Feastables, MrBeast',
      barcode: '1230000168045',
      nutriscore: 'e',
      nova_group: 4,
      ecoscore: 'e',
      quality_score: 40,
      is_healthy: false,
      nutriments: {
        energy_kcal: 554,
        fat: 34.4,
        saturated_fat: 20.7,
        sugars: 42.7,
        salt: 0.19,
        fiber: 2.2,
        proteins: 7.4
      },
      ingredients_text: 'Zucker, _Vollmilchpulver_, Kakaobutter, Kakaomasse, Emulgator (Sojalecithine), Vanilleextrakt. Kakao: 32%',
      allergens: ['en:milk', 'en:soybeans'],
      image_url: 'https://images.openfoodfacts.org/images/products/123/000/016/8045/front_en.34.400.jpg',
      url: 'https://world.openfoodfacts.org/product/1230000168045'
    }
  },
  {
    id: 'p7',
    name: 'MrBeast Official Merch',
    brand: 'MrBeast',
    category: 'merch',
    image: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=400',
    price: 29.99,
    influencerId: 'mrbeast',
    launchDate: '2019-06-01',
    status: 'active'
  },
  {
    id: 'p8',
    name: 'Instinct (Manga)',
    brand: 'Inoxtag',
    category: 'publishing',
    image: 'https://images.unsplash.com/photo-1612036782180-6f0b6cd846fe?w=400',
    price: 15.99,
    influencerId: 'inoxtag',
    launchDate: '2023-10-15',
    status: 'active'
  },
  {
    id: 'p9',
    name: 'Inoxtag x Air Up',
    brand: 'Air Up',
    category: 'food',
    image: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400',
    price: 34.99,
    influencerId: 'inoxtag',
    launchDate: '2024-01-20',
    status: 'active'
  }
];

export const newsItems: NewsItem[] = [
  {
    id: 'n1',
    influencerId: 'squeezie',
    title: 'Squeezie announces new rap album for May 2025',
    type: 'news',
    date: '2024-11-10',
    description: 'The YouTuber confirms he is working on a second album after the success of "Oxyz".',
    source: 'Twitter'
  },
  {
    id: 'n2',
    influencerId: 'norman',
    title: 'Norman Case: Investigation still ongoing',
    type: 'drama',
    date: '2024-10-15',
    description: 'Accusations against Norman are still under judicial investigation.',
    severity: 'high',
    source: 'Media'
  },
  {
    id: 'n3',
    influencerId: 'mcfly-carlito',
    title: 'Partnership with Amazon Prime for original series',
    type: 'partnership',
    date: '2024-11-01',
    description: 'McFly & Carlito are developing an exclusive entertainment series for Prime Video.',
    source: 'Prime Video'
  },
  {
    id: 'n4',
    influencerId: 'cyprien',
    title: 'Cyprien surpasses 15 years of YouTube career',
    type: 'milestone',
    date: '2024-10-28',
    description: 'The creator celebrates 15 years of videos with a nostalgic best-of.',
    source: 'YouTube'
  },
  {
    id: 'n5',
    influencerId: 'enjoyphoenix',
    title: 'Launch of her own natural cosmetics brand',
    type: 'partnership',
    date: '2024-09-12',
    description: 'Marie Lopez launches "Phoenix Beauty", her organic and vegan cosmetics brand.',
    source: 'Instagram'
  },
  {
    id: 'n6',
    influencerId: 'natoo',
    title: 'New collaboration with Netflix France',
    type: 'partnership',
    date: '2024-08-20',
    description: 'Natoo joins the cast of a Netflix comedy scheduled for 2025.',
    source: 'Netflix'
  },
  {
    id: 'n7',
    influencerId: 'mrbeast',
    title: 'First YouTuber to Reach 300 Million Subscribers',
    type: 'milestone',
    date: '2024-07-10',
    description: 'Achieved a historic milestone by becoming the first individual YouTuber to surpass 300 million subscribers.',
    source: 'YouTube'
  },
  {
    id: 'n8',
    influencerId: 'mrbeast',
    title: 'Most Subscribed YouTube Channel',
    type: 'milestone',
    date: '2024-06-02',
    description: 'Surpassed T-Series to become the most subscribed channel on YouTube, reaching 267 million subscribers.',
    source: 'YouTube'
  },
  {
    id: 'n31',
    influencerId: 'mrbeast',
    title: 'First YouTuber to Reach 400 Million Subscribers',
    type: 'milestone',
    date: '2025-08-01',
    description: 'MrBeast becomes the first creator to surpass 400 million subscribers on YouTube, reaching around 415 million and extending his lead as the biggest channel on the platform.',
    source: 'YouTube'
  },
  {
    id: 'n9',
    influencerId: 'mrbeast',
    title: '$456,000 Squid Game In Real Life!',
    type: 'news',
    date: '2021-11-24',
    description: 'Uploaded a recreation of \'Squid Game\' with a $456,000 prize, which became one of the most-watched YouTube videos of 2021, earning over 130 million views in a week.',
    source: 'YouTube'
  },
  {
    id: 'n10',
    influencerId: 'mrbeast',
    title: 'Giving Away $10,000 to a Homeless Man',
    type: 'news',
    date: '2017-06-11',
    description: 'Secured his first major brand deal and gave away the entire $10,000 sponsorship in a philanthropic stunt, pioneering his signature large-scale giveaway format.',
    source: 'YouTube'
  },
  {
    id: 'n11',
    influencerId: 'mrbeast',
    title: 'I Counted To 100,000!',
    type: 'milestone',
    date: '2017-01-08',
    description: 'Uploaded the viral video counting to 100,000, which propelled MrBeast into the YouTube spotlight and established his reputation for endurance-based stunts.',
    source: 'YouTube'
  },
  {
    id: 'n12',
    influencerId: 'mrbeast',
    title: 'First YouTube Video (Let\'s Play Minecraft)',
    type: 'milestone',
    date: '2012-02-19',
    description: 'MrBeast launched his YouTube channel \'MrBeast6000\' at age 13, posting gaming videos and commentary, laying the foundation for his future career.',
    source: 'YouTube'
  },
  {
    id: 'n13',
    influencerId: 'inoxtag',
    title: 'Release of \'Kaizen\' Everest Documentary',
    type: 'news',
    date: '2024-09-14',
    description: 'Premiered the \'Kaizen\' documentary in cinemas and on YouTube, breaking records with over 11 million views in 24 hours and surpassing 45 million views, marking the peak of his influence and inspiring millions.',
    source: 'YouTube'
  },
  {
    id: 'n14',
    influencerId: 'inoxtag',
    title: 'Announced Everest Climb Challenge',
    type: 'news',
    date: '2024-02-15',
    description: 'Inoxtag announced his plan to climb Mount Everest within a year, generating massive buzz and anticipation across all social platforms.',
    source: 'YouTube'
  },
  {
    id: 'n15',
    influencerId: 'inoxtag',
    title: 'Reached 5 Million YouTube Subscribers',
    type: 'milestone',
    date: '2021-07-01',
    description: 'Hit the major milestone of 5 million subscribers, solidifying his status as a top French YouTuber.',
    source: 'YouTube'
  },
  {
    id: 'n16',
    influencerId: 'inoxtag',
    title: 'Joined Croûton eSports Team',
    type: 'partnership',
    date: '2019-03-10',
    description: 'Inoxtag co-founded the Croûton eSports team, collaborating with other major French creators and expanding his reach beyond solo content.',
    source: 'YouTube'
  },
  {
    id: 'n17',
    influencerId: 'inoxtag',
    title: 'First Viral Gaming Videos',
    type: 'milestone',
    date: '2017-01-15',
    description: 'His comedic and energetic gaming videos went viral, marking his breakthrough and leading to rapid subscriber growth.',
    source: 'YouTube'
  },
  {
    id: 'n18',
    influencerId: 'inoxtag',
    title: 'YouTube Channel Launch',
    type: 'milestone',
    date: '2015-06-20',
    description: 'Inoxtag launched his YouTube channel, initially focusing on gaming content and building a young, engaged audience.',
    source: 'YouTube'
  },
  {
    id: 'n19',
    influencerId: 'cyprien',
    title: 'YouTube channel launch',
    type: 'milestone',
    date: '2007-05-12',
    description: 'Cyprien launched his YouTube channel, becoming one of the pioneers of French YouTube with humorous sketches.',
    source: 'YouTube'
  },
  {
    id: 'n20',
    influencerId: 'cyprien',
    title: 'Reaches 10 million subscribers',
    type: 'milestone',
    date: '2015-09-15',
    description: 'First French YouTuber to reach 10 million subscribers, marking a historic milestone for French-speaking YouTube.',
    source: 'YouTube'
  },
  {
    id: 'n21',
    influencerId: 'squeezie',
    title: 'Release of album "Oxyz"',
    type: 'news',
    date: '2024-01-19',
    description: 'Squeezie releases his first rap album "Oxyz", which meets immense critical and commercial success.',
    source: 'Spotify'
  },
  {
    id: 'n22',
    influencerId: 'squeezie',
    title: 'Twitch viewer record',
    type: 'milestone',
    date: '2020-10-10',
    description: 'Breaks French record for concurrent viewers on Twitch with over 400,000 viewers during a gaming event.',
    source: 'Twitch'
  },
  {
    id: 'n23',
    influencerId: 'norman',
    title: 'Viral video "Les Mamans"',
    type: 'milestone',
    date: '2011-03-02',
    description: 'The video "Les Mamans" goes viral and propels Norman to French YouTube stardom.',
    source: 'YouTube'
  },
  {
    id: 'n24',
    influencerId: 'natoo',
    title: 'Launch of her fashion brand',
    type: 'partnership',
    date: '2023-06-15',
    description: 'Natoo launches her own eco-responsible clothing line in collaboration with a French brand.',
    source: 'Instagram'
  },
  {
    id: 'n25',
    influencerId: 'natoo',
    title: 'First leading role in cinema',
    type: 'news',
    date: '2022-11-08',
    description: 'Natoo lands her first leading role in a French comedy released in theaters.',
    source: 'Cinema'
  },
  {
    id: 'n26',
    influencerId: 'pewdiepie',
    title: '100 Million Subscribers Milestone',
    type: 'milestone',
    date: '2019-08-25',
    description: 'PewDiePie becomes the first individual creator to reach 100 million subscribers on YouTube.',
    source: 'YouTube'
  },
  {
    id: 'n27',
    influencerId: 'khabylame',
    title: 'Most Followed Person on TikTok',
    type: 'milestone',
    date: '2022-06-22',
    description: 'Khaby Lame surpasses Charli D\'Amelio to become the most-followed person on TikTok with 142 million followers.',
    source: 'TikTok'
  },
  {
    id: 'n28',
    influencerId: 'charlidamelio',
    title: 'First Person to Hit 100M on TikTok',
    type: 'milestone',
    date: '2020-11-22',
    description: 'Charli D\'Amelio becomes the first person ever to reach 100 million followers on TikTok.',
    source: 'TikTok'
  },
  {
    id: 'n29',
    influencerId: 'carryminati',
    title: 'YouTube vs TikTok Controversy',
    type: 'drama',
    date: '2020-05-08',
    description: 'CarryMinati\'s roast video becomes the most-liked non-music video on YouTube before being taken down, sparking massive debate.',
    severity: 'medium',
    source: 'YouTube'
  },
  {
    id: 'n30',
    influencerId: 'ibai',
    title: 'La Velada del Año III',
    type: 'news',
    date: '2023-07-01',
    description: 'Ibai organizes La Velada del Año III, a boxing event that breaks all viewership records on Twitch with over 3 million viewers.',
    source: 'Twitch'
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
  { source: 'cyprien', target: 'squeezie', type: 'friendship', strength: 0.9, label: 'Close friends' },
  { source: 'cyprien', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'squeezie', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'enjoyphoenix', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'mcfly-carlito', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'squeezie', target: 'mcfly-carlito', type: 'collaboration', strength: 0.85, label: 'Common videos' },
  { source: 'cyprien', target: 'mcfly-carlito', type: 'friendship', strength: 0.7 },
  { source: 'natoo', target: 'enjoyphoenix', type: 'friendship', strength: 0.8, label: 'Mutual support' },
  { source: 'norman', target: 'cyprien', type: 'friendship', strength: 0.3, label: 'Former collaborators' },
  { source: 'enjoyphoenix', target: 'Typology', type: 'brand', strength: 0.9 },
  { source: 'squeezie', target: 'Razer', type: 'brand', strength: 0.85 },
  { source: 'mcfly-carlito', target: 'Prime Video', type: 'brand', strength: 0.95 },
  { source: 'mrbeast', target: 'Night Media', type: 'agency', strength: 1.0 },
  { source: 'mrbeast', target: 'KSI', type: 'collaboration', strength: 0.9, label: 'Frequent collaborator' },
  { source: 'mrbeast', target: 'Feastables', type: 'brand', strength: 0.9, label: 'Founder' },
  { source: 'mrbeast', target: 'Amazon Prime', type: 'partnership', strength: 0.8 },
  { source: 'mrbeast', target: 'Team Trees', type: 'partnership', strength: 0.8, label: 'Environmental initiatives' },
  { source: 'pewdiepie', target: 'YouTube Global', type: 'brand', strength: 0.95 },
  { source: 'carryminati', target: 'YouTube Global', type: 'brand', strength: 0.92 },
  { source: 'ibai', target: 'Twitch Global', type: 'brand', strength: 0.9 },
  { source: 'ibai', target: 'squeezie', type: 'collaboration', strength: 0.4, label: 'Gaming events' },
  { source: 'charlidamelio', target: 'TikTok Global', type: 'brand', strength: 1.0 },
  { source: 'khabylame', target: 'TikTok Global', type: 'brand', strength: 1.0 },
  { source: 'charlidamelio', target: 'khabylame', type: 'friendship', strength: 0.5, label: 'TikTok Awards' },
  { source: 'inoxtag', target: 'Webedia', type: 'agency', strength: 1.0 },
  { source: 'inoxtag', target: 'Nil Ojeda', type: 'collaboration', strength: 0.9, label: 'Frequent collaborator' },
  { source: 'inoxtag', target: 'Socialveins', type: 'partnership', strength: 0.8 },
  { source: 'inoxtag', target: 'MILFSHAKES', type: 'brand', strength: 0.7 }
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
  },
  {
    id: 'Night Media',
    name: 'Night Media',
    type: 'agency' as const,
    size: 50
  },
  {
    id: 'KSI',
    name: 'KSI',
    type: 'influencer' as const,
    size: 60
  },
  {
    id: 'Feastables',
    name: 'Feastables',
    type: 'brand' as const,
    size: 45
  },
  {
    id: 'Amazon Prime',
    name: 'Amazon Prime',
    type: 'brand' as const,
    size: 50
  },
  {
    id: 'Team Trees',
    name: 'Team Trees',
    type: 'brand' as const,
    size: 40
  },
  {
    id: 'Nil Ojeda',
    name: 'Nil Ojeda',
    type: 'influencer' as const,
    size: 45
  },
  {
    id: 'Socialveins',
    name: 'Socialveins',
    type: 'agency' as const,
    size: 40
  },
  {
    id: 'MILFSHAKES',
    name: 'MILFSHAKES',
    type: 'brand' as const,
    size: 35
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
    content: 'Squeezie is just amazing! His videos are always quality and entertaining. Keep it up!',
    sentiment: 'positive'
  },
  {
    id: 'comment-6',
    influencerId: 'squeezie',
    platform: 'Twitter',
    author: 'MarieB92',
    date: '2024-10-25',
    content: 'Fan since the beginning, your videos accompanied me throughout my youth. Thank you for everything!',
    sentiment: 'positive'
  },
  {
    id: 'comment-7',
    influencerId: 'cyprien',
    platform: 'YouTube',
    author: 'JulienP',
    date: '2024-10-20',
    content: 'Cyprien is a French YouTube legend. His sketches are always hilarious and relevant!',
    sentiment: 'positive'
  },
  {
    id: 'comment-8',
    influencerId: 'inoxtag',
    platform: 'YouTube',
    author: 'LucasM',
    date: '2024-09-15',
    content: 'The Kaizen documentary is incredible! I cried several times. Thank you Inox for this inspiring adventure!',
    sentiment: 'positive'
  },
  {
    id: 'comment-9',
    influencerId: 'inoxtag',
    platform: 'Instagram',
    author: 'ChloeD',
    date: '2024-09-16',
    content: 'You are a real source of inspiration for an entire generation. Keep it up!',
    sentiment: 'positive'
  },
  {
    id: 'comment-10',
    influencerId: 'natoo',
    platform: 'YouTube',
    author: 'SophieL',
    date: '2024-08-12',
    content: 'Natoo, your videos are so funny! You always manage to make me laugh even in difficult times.',
    sentiment: 'positive'
  },
  {
    id: 'comment-11',
    influencerId: 'enjoyphoenix',
    platform: 'Instagram',
    author: 'CamilleR',
    date: '2024-07-18',
    content: 'Your beauty tips are always top-notch! Thank you for your kindness and authenticity.',
    sentiment: 'positive'
  },
  {
    id: 'comment-12',
    influencerId: 'mcfly-carlito',
    platform: 'YouTube',
    author: 'ThomasB',
    date: '2024-06-22',
    content: 'McFly and Carlito, you are the best! Your videos are always quality and we feel the good vibes.',
    sentiment: 'positive'
  },
  {
    id: 'comment-13',
    influencerId: 'pewdiepie',
    platform: 'YouTube',
    author: 'BroArmy2024',
    date: '2024-05-10',
    content: 'Been watching since 2012. You\'re still the king of YouTube. Keep it up!',
    sentiment: 'positive'
  },
  {
    id: 'comment-14',
    influencerId: 'khabylame',
    platform: 'TikTok',
    author: 'SarahK',
    date: '2024-04-15',
    content: 'Your videos always make me laugh! Simple but so effective. Love your content!',
    sentiment: 'positive'
  },
  {
    id: 'comment-15',
    influencerId: 'charlidamelio',
    platform: 'TikTok',
    author: 'DanceQueen',
    date: '2024-03-20',
    content: 'You inspire so many people to dance! Your moves are incredible!',
    sentiment: 'positive'
  },
  {
    id: 'comment-16',
    influencerId: 'carryminati',
    platform: 'YouTube',
    author: 'RohanS',
    date: '2024-02-28',
    content: 'Carry bhai, your roasts are legendary! Keep making amazing content for us!',
    sentiment: 'positive'
  },
  {
    id: 'comment-17',
    influencerId: 'ibai',
    platform: 'Twitch',
    author: 'PabloM',
    date: '2024-01-15',
    content: '¡La Velada fue increíble! Gracias por crear estos eventos tan especiales para la comunidad.',
    sentiment: 'positive'
  },
  {
    id: 'comment-18',
    influencerId: 'norman',
    platform: 'YouTube',
    author: 'AnthoV',
    date: '2024-01-05',
    content: 'Even after all these years, your videos remain iconic. A true pioneer!',
    sentiment: 'positive'
  }
];
