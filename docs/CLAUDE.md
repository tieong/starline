# Starline - Project Context & Development Guide

## Original Prompt

**Date:** November 15, 2025

**User Request:**
> You'll focus on the frontend for now, the objective is to create a website with just a simple search bar and above the title of the app "Starline", then once you type something in the search bar it show you influencers and when you click on one of these influencers it show you a graph of who is he connected to when you click on the node of the influencer it show you how credible he is, what other people think of what they bought if he sell something and so on.
>
> The whole point is to make this for a challenge named:
> **Crowdsourced Trust Ratings: Empowering Consumers to Verify Influencer Integrity**

## Project Overview

Starline is a web application designed to address the growing need for transparency in influencer marketing. It empowers consumers to make informed decisions by providing crowdsourced trust ratings, detailed credibility metrics, network visualization, and authentic community reviews of influencers.

### Problem Statement

In the current digital landscape, consumers struggle to:
- Verify influencer authenticity and credibility
- Understand influencer connections and potential conflicts of interest
- Access genuine reviews about products promoted by influencers
- Make informed purchasing decisions based on influencer recommendations

### Solution

Starline provides a comprehensive platform where users can:
1. **Search for influencers** across different platforms (Instagram, YouTube, TikTok, etc.)
2. **View trust scores** calculated from multiple metrics
3. **Explore network graphs** showing influencer connections to brands, other influencers, and professionals
4. **Read community reviews** from real consumers about products and services promoted by influencers
5. **Access detailed credibility metrics** including authenticity, product quality, transparency, and engagement scores

## Technical Architecture

### Frontend (Current Implementation)

**Technology Stack:**
- **Framework:** React 18 with TypeScript
- **Build Tool:** Vite
- **Routing:** React Router v6
- **Styling:** Tailwind CSS v3
- **Visualization:** React Force Graph 2D (for network graphs)
- **Deployment:** Docker + nginx

**Key Components:**

1. **Home Page** (`src/pages/Home.tsx`)
   - Search interface with real-time filtering
   - Grid display of influencer cards
   - Trust score visualization with color coding

2. **Influencer Detail Page** (`src/pages/InfluencerDetail.tsx`)
   - Interactive force-directed network graph
   - Trust metrics breakdown (Authenticity, Product Quality, Transparency, Engagement)
   - Community reviews section with star ratings
   - Verified purchase badges

3. **Type Definitions** (`src/types.ts`)
   - Influencer interface
   - Review interface
   - Trust metrics interface
   - Network graph data structures

4. **Mock Data** (`src/mockData.ts`)
   - 5 sample influencers with varying trust scores
   - Network relationship data
   - Community reviews with ratings
   - Trust metrics for demonstration

### Current Features

#### Search & Discovery
- Real-time search across influencer names, platforms, and bios
- Visual trust score indicators (Green: 85+, Yellow: 70-84, Red: <70)
- Follower count display
- Platform badges
- Verification status indicators

#### Influencer Profiles
- Full bio and statistics
- Trust score breakdown with visual progress bars
- Interactive network visualization showing:
  - Connections to other influencers
  - Relationships with brands
  - Professional network (trainers, consultants, etc.)
- Community review system with:
  - 5-star ratings
  - Verified purchase badges
  - Product-specific feedback
  - Timestamps

#### Network Graph Features
- Click-to-explore node interactions
- Color-coded relationships:
  - Blue: Main influencer
  - Green: Other influencers
  - Purple: Professionals
  - Orange: Brands
- Visual representation of connection strength

## Data Model

### Influencer
```typescript
{
  id: string
  name: string
  platform: string
  followerCount: number
  verified: boolean
  trustScore: number (0-100)
  avatarUrl: string
  bio: string
}
```

### Trust Metrics
```typescript
{
  overallScore: number
  authenticity: number
  productQuality: number
  transparency: number
  engagement: number
}
```

### Review
```typescript
{
  id: string
  userId: string
  userName: string
  rating: number (1-5)
  comment: string
  productName?: string
  date: string
  verified: boolean
}
```

### Network Graph
```typescript
{
  nodes: Array<{
    id: string
    name: string
    val: number  // size
    color: string
  }>
  links: Array<{
    source: string
    target: string
    value: number  // strength
  }>
}
```

## Development Setup

### Local Development
```bash
cd frontend
npm install
npm run dev
# Access at http://localhost:5173
```

### Docker Development
```bash
# Using Make
make build
make up
# Access at http://localhost:3000

# Or using Docker Compose
docker compose up --build
```

## Project Structure

```
starline/
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   │   ├── Home.tsx              # Search and results page
│   │   │   └── InfluencerDetail.tsx  # Detailed influencer view
│   │   ├── types.ts                  # TypeScript type definitions
│   │   ├── mockData.ts               # Sample data for testing
│   │   ├── App.tsx                   # Main app with routing
│   │   ├── main.tsx                  # Entry point
│   │   └── index.css                 # Tailwind imports
│   ├── Dockerfile                    # Multi-stage Docker build
│   ├── nginx.conf                    # Production nginx config
│   └── package.json
├── backend/                          # (To be implemented)
├── docker-compose.yml                # Orchestration
├── Makefile                          # Convenient commands
├── README.md                         # Full documentation
├── DOCKER_QUICKSTART.md              # Quick start guide
└── CLAUDE.md                         # This file
```

## Future Development Roadmap

### Backend (High Priority)
- [ ] RESTful API for influencer data
- [ ] Database integration (PostgreSQL recommended)
- [ ] User authentication system
- [ ] Review submission and moderation
- [ ] Real-time trust score calculation algorithm
- [ ] API rate limiting and security

### Enhanced Features
- [ ] User accounts and profiles
- [ ] Advanced search filters:
  - Platform-specific filtering
  - Trust score range
  - Follower count range
  - Location/region
- [ ] Influencer comparison tool (side-by-side)
- [ ] Trending influencers dashboard
- [ ] Report generation and analytics
- [ ] Social sharing capabilities
- [ ] Email notifications for influencer updates
- [ ] Mobile responsive improvements
- [ ] PWA support for mobile app-like experience

### Data & Analytics
- [ ] Machine learning for fraud detection
- [ ] Sentiment analysis on reviews
- [ ] Trend analysis and reporting
- [ ] Trust score prediction algorithms
- [ ] API for third-party integrations
- [ ] Data export functionality (CSV, JSON)

### Community Features
- [ ] User reputation system
- [ ] Review helpfulness voting
- [ ] Comment threads on reviews
- [ ] Influencer response capability
- [ ] Dispute resolution system

### Admin Panel
- [ ] Content moderation dashboard
- [ ] User management
- [ ] Analytics and insights
- [ ] Report handling
- [ ] System health monitoring

## Design Decisions

### Why Multi-Stage Docker Build?
- Reduces final image size from ~1GB to ~50MB
- Separates build dependencies from runtime
- Faster deployment and distribution
- Production-ready with nginx

### Why Mock Data Initially?
- Allows frontend development without backend dependency
- Easy to test and demonstrate features
- Clear data structure for backend implementation
- Facilitates rapid iteration

### Why React Force Graph?
- Interactive and performant visualization
- Handles complex network relationships
- Easy to customize and style
- Good developer experience

### Why Tailwind CSS?
- Rapid UI development
- Consistent design system
- Small production bundle
- Highly customizable
- No unused CSS in production

## Key Considerations for Future Development

### Trust Score Algorithm
Consider implementing a weighted algorithm based on:
- Review authenticity (verified purchases: 30%)
- Product satisfaction ratings (25%)
- Transparency in sponsorship disclosure (20%)
- Engagement rate vs follower count ratio (15%)
- Response to negative feedback (10%)

### Data Privacy
- GDPR compliance for EU users
- Clear privacy policy
- User data deletion requests
- Anonymized review options
- Secure data storage

### Scalability
- CDN for static assets
- Database indexing for fast searches
- Caching layer (Redis recommended)
- Horizontal scaling capability
- Load balancing for high traffic

### Security
- Input validation and sanitization
- XSS protection
- CSRF tokens
- Rate limiting
- SQL injection prevention
- Secure authentication (JWT recommended)

## Contributing Guidelines

When continuing development:

1. **Maintain Type Safety:** All new code should use TypeScript
2. **Follow Component Structure:** Keep components focused and reusable
3. **Update Mock Data:** When adding features, update mockData.ts accordingly
4. **Document Changes:** Update README.md and this file for significant changes
5. **Test Thoroughly:** Ensure new features work in both dev and Docker environments
6. **Preserve Design System:** Stick to the existing color scheme and component patterns

## Color Scheme

Trust Score Colors:
- **Green (#10b981):** 85+ - Highly trustworthy
- **Yellow (#eab308):** 70-84 - Moderately trustworthy
- **Red (#ef4444):** <70 - Low trust score

Brand Colors:
- **Primary:** Blue gradient (#3b82f6 to #8b5cf6)
- **Background:** Soft gradients (blue-50, white, purple-50)
- **Accents:** Platform-specific and relationship-type specific

## Contact & Support

This project was created for the "Crowdsourced Trust Ratings: Empowering Consumers to Verify Influencer Integrity" challenge.

For questions or contributions related to this codebase, refer to the project documentation and implementation notes above.

---

**Last Updated:** November 15, 2025
**Current Version:** 1.0.0 (Frontend MVP)
**Status:** Frontend complete, Backend pending implementation
