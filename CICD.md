# CI/CD Documentation

This document explains the Continuous Integration and Continuous Deployment (CI/CD) setup for the Starline project.

## Overview

The project uses GitHub Actions to automatically build and publish Docker images to GitHub Container Registry (ghcr.io) whenever code changes are pushed to the repository.

## Workflow File

Location: `.github/workflows/publish-frontend.yml`

## How It Works

### 1. Triggers

The workflow is triggered by:

- **Push to main branch**: Automatically builds and publishes the image with `latest` and `main` tags
- **Push of version tags**: Publishing tags like `v1.0.0` creates versioned releases
- **Pull requests to main**: Builds the image for testing but does NOT publish
- **Manual workflow dispatch**: Can be triggered manually from the GitHub Actions tab

### 2. Build Process

The workflow performs the following steps:

1. **Checkout**: Clones the repository code
2. **Set up Docker Buildx**: Enables advanced Docker build features (multi-platform builds, caching)
3. **Login to ghcr.io**: Authenticates with GitHub Container Registry using the automatic `GITHUB_TOKEN`
4. **Extract metadata**: Generates appropriate tags and labels based on the git ref (branch, tag, or PR)
5. **Build and push**: Builds the Docker image and pushes it to ghcr.io
6. **Generate attestation**: Creates a cryptographic attestation for supply chain security

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

### Build Fails

1. Check the GitHub Actions logs for specific errors
2. Verify the Dockerfile builds locally:
   ```bash
   cd frontend
   docker build -t test .
   ```
3. Ensure all dependencies are properly specified in `package.json`

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

1. **Semantic Versioning**: Use semantic versioning for releases (v1.0.0, v1.1.0, v2.0.0)
2. **Test Before Tagging**: Ensure the code works before creating version tags
3. **Descriptive Tags**: Use annotated tags with messages: `git tag -a v1.0.0 -m "message"`
4. **Review Workflow Logs**: Check workflow logs even when successful
5. **Pin Dependencies**: Use specific versions in package.json for reproducible builds
6. **Small Images**: Keep the Docker image size small (currently ~50MB)

## Future Enhancements

Potential improvements to the CI/CD pipeline:

- [ ] Add automated testing before building
- [ ] Security scanning with Trivy or similar
- [ ] Automated dependency updates with Dependabot
- [ ] Deploy to staging environment
- [ ] Slack/Discord notifications on successful deployments
- [ ] Performance benchmarking
- [ ] Automatic changelog generation
- [ ] Backend service publishing when implemented

## References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [Docker Build Push Action](https://github.com/docker/build-push-action)
- [Docker Metadata Action](https://github.com/docker/metadata-action)
- [Attestation Action](https://github.com/actions/attest-build-provenance)
