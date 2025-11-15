# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Starline is a React-based influencer intelligence platform that provides AI-powered scoring, relationship visualization, and news tracking for social media influencers. The application is built in French and features a modern, responsive design.

## Development Commands

```bash
# Install dependencies
npm install

# Start development server (runs on http://localhost:5173)
npm run dev

# Build for production (TypeScript compilation + Vite build)
npm run build

# Preview production build
npm run preview
```

## Architecture

### Routing Structure

The application uses React Router with the following routes defined in `src/App.tsx`:
- `/` - Home page with featured influencers
- `/influencers` - Grid view of all influencers
- `/influencer/:id` - Detailed influencer profile page
- `/graph/:id?` - Interactive network graph (optional influencer ID for centered view)

### Data Layer

Currently using **mock data** from `src/data/mockData.ts`. This exports:
- `influencers` - Array of influencer profiles with complete metadata
- `products` - Influencer product collaborations
- `newsItems` - Timeline events (news, drama, partnerships, milestones)
- `relationships` - Connections between influencers, agencies, brands
- `graphNodes` - Nodes for D3 network visualization

**Important:** The app is designed to migrate to a real backend API. When implementing API integration, replace imports from `mockData.ts` with API calls while maintaining the same TypeScript interfaces defined in `src/types.ts`.

### Type System

All data structures are defined in `src/types.ts`:
- `Influencer` - Complete influencer profile including stats, social links, and InfluScoring
- `InfluScoring` - AI scoring metrics (overall, reliability, controversies, authenticity, etc.)
- `Product` - Influencer product collaborations
- `NewsItem` - Timeline events with severity levels
- `Relationship` - Graph edges with type and strength
- `GraphNode` - D3 visualization nodes

### Component Architecture

**Pages** (in `src/pages/`):
- Each page has a corresponding CSS file with the same name
- Pages handle routing, data fetching, and layout composition

**Components** (in `src/components/`):
- Reusable UI components with co-located CSS files
- Components are presentational and receive data via props
- Key components:
  - `InfluencerCard` - Card display for influencer previews
  - `SearchAutocomplete` - Intelligent search with autocomplete
  - `ScoreGauge` - Circular gauge for InfluScoring metrics
  - `InfluencerInfoPanel` - Sidebar panel showing influencer details in graph view
  - `Tag` - Reusable tag/badge component for niches and categories

### D3 Network Graph

The `NetworkGraph` page (`src/pages/NetworkGraph.tsx`) implements an interactive force-directed graph:
- Uses D3.js for force simulation and zoom behavior
- Nodes represent influencers, agencies, brands, and events
- Edges represent relationships with varying strength
- Supports pan, zoom (0.5x to 3x), and node selection
- Can be centered on a specific influencer via route parameter
- Integrates with `InfluencerInfoPanel` for node details

**Key D3 patterns:**
- Force simulation with charge, link, and center forces
- Zoom behavior with scale extent limits
- SVG rendering with groups for nodes and links
- Drag behavior for node repositioning

### Styling System

The app uses CSS custom properties (CSS variables) defined in `src/index.css`:
- Design system based on **Chroma-inspired rainbow accents** (purple, blue, green, yellow, red)
- Monochrome scale from white to black
- Global variables prefixed with `--` (e.g., `--primary-purple`, `--text-strong`)
- Component-level CSS files use these variables for consistency

**Design principles:**
- Clean, minimalist design with high contrast
- Responsive layouts using flexbox and grid
- Smooth animations via Framer Motion
- Accessible color contrast for text

## Key Technologies

- **React 18** - UI framework with TypeScript
- **Vite** - Build tool and dev server
- **React Router** - Client-side routing
- **D3.js** - Data visualization (network graph)
- **Framer Motion** - Declarative animations
- **Lucide React** - Icon library

## TypeScript Configuration

Strict mode enabled with:
- `noUnusedLocals: true`
- `noUnusedParameters: true`
- `noFallthroughCasesInSwitch: true`

All source files must pass TypeScript compilation before build.

## Backend Integration Notes

When connecting to the backend API (referenced in git history as planned):
1. Create an API service layer (e.g., `src/services/api.ts`)
2. Replace `mockData.ts` imports with API calls
3. Maintain existing TypeScript interfaces in `types.ts`
4. Add loading states and error handling to pages
5. Consider adding environment variables for API endpoints (use Vite's `import.meta.env`)
