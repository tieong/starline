# Starline

**Crowdsourced Trust Ratings: Empowering Consumers to Verify Influencer Integrity**

## Overview

Starline is a web application designed to help consumers make informed decisions about influencers by providing crowdsourced trust ratings, reviews, and network visualization. The platform allows users to search for influencers, view their credibility metrics, explore their professional networks, and read authentic reviews from real consumers.


## Documentation

Additional documentation is available in the [`docs/`](docs/) directory:

- **[Docker Quick Start Guide](docs/DOCKER_QUICKSTART.md)** - Get started with Docker in minutes
- **[CI/CD Documentation](docs/CICD.md)** - Detailed guide on automated builds and deployments
- **[Development Guide](docs/CLAUDE.md)** - Project context and development guidelines
- **[Commands Reference](docs/COMMANDS.md)** - Custom commands and utilities

## Features

### 1. Search Interface
- Clean, intuitive search bar on the homepage
- Real-time search results as you type
- Filter influencers by name, platform, or bio content

### 2. Influencer Cards
- Display key information: name, platform, follower count
- Trust score prominently displayed with color coding:
  - Green (85+): Highly trustworthy
  - Yellow (70-84): Moderately trustworthy
  - Red (<70): Low trust score
- Verified badge for authenticated influencers

### 3. Detailed Influencer Pages
Each influencer has a dedicated page featuring:

#### Network Graph
- Interactive force-directed graph showing connections
- Visualize relationships with other influencers, brands, and professionals
- Click on nodes to explore connections
- Color-coded nodes:
  - Blue: Main influencer
  - Green: Other influencers
  - Purple: Professionals (trainers, consultants, etc.)
  - Orange: Brands

#### Trust Metrics
- Overall trust score
- Breakdown of specific metrics:
  - Authenticity
  - Product Quality
  - Transparency
  - Engagement
- Visual progress bars with color-coded indicators

#### Community Reviews
- User-generated reviews with star ratings
- Verified purchase badges
- Product-specific feedback
- Date and reviewer information

## Technology Stack

### Frontend
- **React 18** - UI framework
- **TypeScript** - Type safety
- **Vite** - Build tool and dev server
- **React Router** - Client-side routing
- **Tailwind CSS** - Styling
- **React Force Graph 2D** - Network visualization

## Getting Started

### Prerequisites
- Node.js 18.x or higher
- npm or yarn

### Installation

1. Clone the repository:
```bash
git clone https://github.com/tieong/starline.git
cd starline
```

2. Install frontend dependencies:
```bash
cd frontend
npm install
```

3. Start the development server:
```bash
npm run dev
```

4. Open your browser and navigate to:
```
http://localhost:5173
```

## Docker Deployment

The easiest way to run and share Starline is using Docker. This allows you to run the application in a containerized environment without installing Node.js or any dependencies.

### Prerequisites
- Docker (20.10+)
- Docker Compose v2 (or Docker Desktop)

**Note:** If you get permission errors, you may need to:
- Run commands with `sudo`, OR
- Add your user to the docker group: `sudo usermod -aG docker $USER` (then log out and back in)

### Quick Start with Docker Compose

1. Clone the repository:
```bash
git clone https://github.com/tieong/starline.git
cd starline
```

2. Build and run with Docker Compose:
```bash
docker compose up --build
```

3. Open your browser and navigate to:
```
http://localhost:3000
```

4. To stop the application:
```bash
docker compose down
```

### Useful Docker Commands

```bash
# Build the images
docker compose build

# Start in detached mode (runs in background)
docker compose up -d

# View logs
docker compose logs -f

# Stop the application
docker compose down

# Restart containers
docker compose restart

# Remove containers and images
docker compose down
docker rmi starline-frontend
```

### Manual Docker Build

If you prefer to build and run manually:

```bash
# Build the image
cd frontend
docker build -t starline-frontend .

# Run the container
docker run -d -p 3000:80 --name starline starline-frontend

# Stop the container
docker stop starline
docker rm starline
```

### Sharing with Colleagues

#### Option 1: Use Pre-built Image from GitHub Container Registry (Easiest)

The frontend is automatically built and published to GitHub Container Registry on every push to main. You and your colleagues can pull and run the latest version directly:

```bash
# Pull and run the latest version
docker run -d -p 3000:80 ghcr.io/tieong/starline/frontend:latest

# Or use a specific version tag
docker run -d -p 3000:80 ghcr.io/tieong/starline/frontend:v1.0.0
```

To use with Docker Compose, update your `docker-compose.yml`:
```yaml
services:
  frontend:
    image: ghcr.io/tieong/starline/frontend:latest
    container_name: starline-frontend
    ports:
      - "3000:80"
    restart: unless-stopped
```

Available tags:
- `latest` - Latest build from main branch
- `main` - Latest build from main branch
- `v*` - Specific version tags (e.g., v1.0.0)
- `main-<sha>` - Build from specific commit

#### Option 2: Share via Docker Hub
```bash
# Tag the image
docker tag starline-frontend yourusername/starline-frontend:latest

# Push to Docker Hub
docker push yourusername/starline-frontend:latest

# Colleagues can pull and run
docker pull yourusername/starline-frontend:latest
docker run -d -p 3000:80 yourusername/starline-frontend:latest
```

#### Option 3: Export/Import Docker Image
```bash
# Save the image to a tar file
docker save starline-frontend > starline-frontend.tar

# Share the tar file with colleagues

# Colleagues can load the image
docker load < starline-frontend.tar
docker run -d -p 3000:80 starline-frontend
```

#### Option 4: Use Docker Compose with Local Build
Simply share the entire project directory with colleagues. They just need to run:
```bash
docker compose up --build
```


## CI/CD Pipeline

The project includes automated quality checks and Docker image publishing via GitHub Actions.

### Automated Quality Checks

Every push and pull request to main automatically runs:
1. **ESLint** - Code style and quality checks
2. **TypeScript Type Check** - Type safety validation
3. **Build Test** - Ensures the application compiles successfully

Only when all checks pass, the workflow proceeds to build and publish.

### Automated Publishing

Every push to the main branch automatically:
1. Runs all quality checks (lint, type check, build)
2. Builds the frontend Docker image (multi-platform: amd64 + arm64)
3. Runs security attestation checks
4. Publishes to GitHub Container Registry (ghcr.io)
5. Tags the image appropriately

### Workflow Triggers

The publish workflow runs on:
- **Push to main** - Publishes with `latest` and `main` tags
- **Version tags** - Pushing tags like `v1.0.0` creates versioned releases
- **Pull requests** - Builds (but doesn't publish) for testing
- **Manual dispatch** - Can be triggered manually from GitHub Actions

### Creating a Release

To publish a new version:

```bash
# Tag your commit with a version
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

This will automatically publish images with tags:
- `ghcr.io/tieong/starline/frontend:v1.0.0`
- `ghcr.io/tieong/starline/frontend:1.0`
- `ghcr.io/tieong/starline/frontend:1`
- `ghcr.io/tieong/starline/frontend:latest`

### Image Visibility

By default, GitHub Container Registry images are private. To make them public:

1. Go to https://github.com/users/tieong/packages/container/starline%2Ffrontend
2. Click "Package settings"
3. Scroll to "Danger Zone"
4. Click "Change visibility" and select "Public"

## Features in Detail

### Home Page (`/`)
- Displays "Starline" title with gradient styling
- Tagline explaining the platform's purpose
- Search bar for finding influencers
- Grid of search results showing:
  - Avatar
  - Name and verification status
  - Platform
  - Bio snippet
  - Follower count
  - Trust score

### Influencer Detail Page (`/influencer/:id`)
- Full influencer profile with:
  - Large avatar
  - Complete bio
  - Detailed statistics
- Interactive network graph showing connections
- Trust metrics with percentage breakdowns
- Community reviews section with:
  - Star ratings
  - Comments
  - Product information
  - Verification status

## Mock Data

The application currently uses mock data including:
- 5 sample influencers across different platforms
- Network graphs showing relationships
- Trust metrics for each influencer
- Community reviews with ratings

## Future Enhancements

### Backend Integration
- RESTful API for influencer data
- Database for storing user reviews
- Authentication system
- Real-time trust score calculations

### Additional Features
- User accounts for submitting reviews
- Advanced search filters (platform, trust score range, follower count)
- Comparison tool for multiple influencers
- Report generation
- Mobile app
- Social sharing capabilities
- Notification system for influencer updates

### Data & Analytics
- Machine learning for fraud detection
- Sentiment analysis on reviews
- Trend analysis and reporting
- API for third-party integrations

## Contributing

This project is part of a challenge submission. Contributions are welcome after the initial submission.

## License

MIT License

## Challenge Information

This project was created for the "Crowdsourced Trust Ratings: Empowering Consumers to Verify Influencer Integrity" challenge, aiming to provide transparency in the influencer marketing space and help consumers make informed purchasing decisions.
