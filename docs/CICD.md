# CI/CD Documentation

This document explains the Continuous Integration and Continuous Deployment (CI/CD) setup for the Starline project.

## Overview

The project uses GitHub Actions to automatically build and publish Docker images to GitHub Container Registry (ghcr.io) whenever code changes are pushed to the repository.

## Workflow Files

The project uses two GitHub Actions workflows:

1. **`.github/workflows/ci.yml`** - Runs quality checks (lint, type check, build) on all frontend changes
2. **`.github/workflows/publish-frontend.yml`** - Builds and publishes Docker images to ghcr.io

## How It Works

### CI Workflow (Quality Checks)

The CI workflow runs automatically on:
- **Push to main or develop** with frontend changes
- **Pull requests to main or develop** with frontend changes

**Quality Checks Performed:**

1. **ESLint**: Checks code style and identifies potential errors
   ```bash
   npm run lint
   ```

2. **TypeScript Type Check**: Validates type correctness without emitting files
   ```bash
   npx tsc --noEmit
   ```

3. **Build Test**: Ensures the application builds successfully
   ```bash
   npm run build
   ```

4. **Tests**: Runs unit/integration tests (when configured)
   ```bash
   npm test
   ```

**Path Filtering**: Only runs when files in `frontend/` directory or the workflow file itself are modified.

### Publish Workflow (Docker Build & Push)

#### 1. Triggers

The publish workflow is triggered by:

- **Push to main branch** with frontend changes: Automatically builds and publishes the image with `latest` and `main` tags
- **Push of version tags**: Publishing tags like `v1.0.0` creates versioned releases
- **Pull requests to main** with frontend changes: Builds the image for testing but does NOT publish
- **Manual workflow dispatch**: Can be triggered manually from the GitHub Actions tab

#### 2. Build Process

The publish workflow has two jobs that run sequentially:

**Job 1: Quality Checks** (runs first)
1. **Checkout**: Clones the repository code
2. **Setup Node.js**: Installs Node.js 18 with npm caching
3. **Install dependencies**: Runs `npm ci` for clean install
4. **Run ESLint**: Validates code style and quality
5. **Type check**: Runs TypeScript compiler in check-only mode
6. **Build test**: Ensures the application builds successfully

**Job 2: Build and Push** (runs only if quality checks pass)
1. **Checkout**: Clones the repository code
2. **Set up Docker Buildx**: Enables advanced Docker build features (multi-platform builds, caching)
3. **Login to ghcr.io**: Authenticates with GitHub Container Registry using the automatic `GITHUB_TOKEN`
4. **Extract metadata**: Generates appropriate tags and labels based on the git ref (branch, tag, or PR)
5. **Build and push**: Builds the Docker image and pushes it to ghcr.io
6. **Generate attestation**: Creates a cryptographic attestation for supply chain security

**Important**: If any quality check fails, the Docker build is skipped, preventing broken code from being published.

### 3. Image Tags

The workflow automatically generates multiple tags based on the event type:

#### On Push to Main Branch
- `ghcr.io/tieong/starline/frontend:latest`
- `ghcr.io/tieong/starline/frontend:main`
- `ghcr.io/tieong/starline/frontend:main-<git-sha>`

#### On Version Tag (e.g., `v1.2.3`)
- `ghcr.io/tieong/starline/frontend:v1.2.3`
- `ghcr.io/tieong/starline/frontend:1.2.3`
- `ghcr.io/tieong/starline/frontend:1.2`
- `ghcr.io/tieong/starline/frontend:1`
- `ghcr.io/tieong/starline/frontend:latest`

#### On Pull Requests
- `ghcr.io/tieong/starline/frontend:pr-<number>`
- (Build only, not pushed)

### 4. Multi-Platform Support

The workflow builds images for both:
- `linux/amd64` (Intel/AMD x86_64)
- `linux/arm64` (ARM, including Apple Silicon M1/M2/M3)

This ensures the image can run on various platforms including:
- Standard servers and cloud instances
- Apple Silicon Macs
- ARM-based cloud instances (AWS Graviton, etc.)

### 5. Build Cache

The workflow uses GitHub Actions cache to speed up builds:
- Caches Docker layers between builds
- Significantly reduces build time for subsequent runs
- Automatically managed by GitHub

## Running Quality Checks Locally

Before pushing code, you can run the same quality checks locally to catch issues early:

```bash
cd frontend

# Install dependencies
npm ci

# Run linter
npm run lint

# Fix auto-fixable linting issues
npm run lint -- --fix

# Run type checking
npx tsc --noEmit

# Test build
npm run build
```

**Recommended**: Run these checks before committing to avoid CI failures.

## Usage

### Publishing a New Version

1. **Create a version tag**:
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. **Wait for the workflow**:
   - Go to the GitHub Actions tab
   - Watch the "Publish Frontend Docker Image" workflow run
   - It typically takes 2-5 minutes

3. **Verify the image**:
   ```bash
   docker pull ghcr.io/tieong/starline/frontend:v1.0.0
   docker run -d -p 3000:80 ghcr.io/tieong/starline/frontend:v1.0.0
   ```

### Using Published Images

#### Pull and Run
```bash
# Latest version
docker pull ghcr.io/tieong/starline/frontend:latest
docker run -d -p 3000:80 ghcr.io/tieong/starline/frontend:latest

# Specific version
docker pull ghcr.io/tieong/starline/frontend:v1.0.0
docker run -d -p 3000:80 ghcr.io/tieong/starline/frontend:v1.0.0
```

#### With Docker Compose
Update your `docker-compose.yml`:
```yaml
services:
  frontend:
    image: ghcr.io/tieong/starline/frontend:latest
    # OR use a specific version:
    # image: ghcr.io/tieong/starline/frontend:v1.0.0
    container_name: starline-frontend
    ports:
      - "3000:80"
    restart: unless-stopped
```

Then run:
```bash
docker compose up -d
```

### Making Images Public

By default, images are private. To make them publicly accessible:

1. Navigate to: https://github.com/users/tieong/packages/container/starline%2Ffrontend/settings
2. Click "Change visibility" in the Danger Zone
3. Select "Public"
4. Confirm the change

Once public, anyone can pull the images without authentication.

### Authenticating for Private Images

If the images are private, users need to authenticate:

```bash
# Create a GitHub Personal Access Token with read:packages permission
# Then login:
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin

# Now you can pull private images
docker pull ghcr.io/tieong/starline/frontend:latest
```

## Security Features

### Attestations

The workflow generates build provenance attestations using GitHub's attestation action. This provides:

- **Supply chain security**: Cryptographic proof of where and how the image was built
- **Verification**: Users can verify the image came from your repository
- **Transparency**: Clear audit trail of the build process

To verify an attestation:
```bash
gh attestation verify oci://ghcr.io/tieong/starline/frontend:latest \
  --owner tieong
```

### Permissions

The workflow uses minimal required permissions:
- `contents: read` - Read repository code
- `packages: write` - Publish to GitHub Container Registry
- `attestations: write` - Create build attestations
- `id-token: write` - Generate attestation signatures

### Automatic Token

The workflow uses `GITHUB_TOKEN`, which is automatically provided by GitHub Actions. No manual secret management needed.

## Troubleshooting

### Quality Checks Fail

**ESLint Errors:**
```bash
# View linting errors
cd frontend
npm run lint

# Auto-fix issues (when possible)
npm run lint -- --fix

# Check for remaining errors
npm run lint
```

**TypeScript Errors:**
```bash
# Run type checking locally
cd frontend
npx tsc --noEmit

# Common fixes:
# - Add missing type definitions
# - Fix type mismatches
# - Update @types/* packages
```

**Build Fails:**
```bash
# Test build locally
cd frontend
npm run build

# Clean install if issues persist
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Docker Build Fails

1. Check the GitHub Actions logs for specific errors
2. Ensure quality checks passed (green checkmark)
3. Verify the Dockerfile builds locally:
   ```bash
   cd frontend
   docker build -t test .
   ```
4. Ensure all dependencies are properly specified in `package.json`

### Permission Denied When Pushing

- The workflow requires `packages: write` permission
- Check that the repository settings allow GitHub Actions to write packages
- Go to: Settings → Actions → General → Workflow permissions
- Ensure "Read and write permissions" is selected

### Image Not Found

- Check if the workflow completed successfully
- Verify the image name and tag
- If private, ensure you're authenticated
- Check package visibility settings

### Multi-Platform Build Issues

- ARM builds may take longer than x86 builds
- Check for platform-specific dependencies in Dockerfile
- Ensure base images support both platforms

## Monitoring

### Viewing Workflow Runs

1. Go to the GitHub repository
2. Click the "Actions" tab
3. Select "Publish Frontend Docker Image"
4. Click on any workflow run to see details

### Viewing Published Images

1. Go to: https://github.com/tieong?tab=packages
2. Find "starline/frontend"
3. Click to view all published versions

## Best Practices

1. **Run Checks Locally First**: Always run `npm run lint` and `npx tsc --noEmit` before pushing
2. **Semantic Versioning**: Use semantic versioning for releases (v1.0.0, v1.1.0, v2.0.0)
3. **Test Before Tagging**: Ensure all quality checks pass before creating version tags
4. **Descriptive Tags**: Use annotated tags with messages: `git tag -a v1.0.0 -m "message"`
5. **Review Workflow Logs**: Check workflow logs even when successful
6. **Pin Dependencies**: Use specific versions in package.json for reproducible builds
7. **Small Images**: Keep the Docker image size small (currently ~50MB)
8. **Fix Linting Issues**: Address ESLint warnings, not just errors
9. **Type Safety**: Maintain strict TypeScript configuration
10. **CI Green Before Merge**: Never merge PRs with failing CI checks

## Future Enhancements

Potential improvements to the CI/CD pipeline:

- [x] Add automated linting (ESLint) - ✅ Implemented
- [x] Add TypeScript type checking - ✅ Implemented
- [x] Path filtering to only run on relevant changes - ✅ Implemented
- [ ] Add unit/integration tests with Vitest or Jest
- [ ] Security scanning with Trivy or Snyk
- [ ] Code coverage reporting with Codecov
- [ ] Automated dependency updates with Dependabot or Renovate
- [ ] Deploy to staging environment (Vercel, Netlify, or cloud provider)
- [ ] Slack/Discord notifications on deployments
- [ ] Performance benchmarking with Lighthouse CI
- [ ] Bundle size tracking
- [ ] Automatic changelog generation
- [ ] E2E tests with Playwright or Cypress
- [ ] Backend service publishing when implemented

## References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [Docker Build Push Action](https://github.com/docker/build-push-action)
- [Docker Metadata Action](https://github.com/docker/metadata-action)
- [Attestation Action](https://github.com/actions/attest-build-provenance)
