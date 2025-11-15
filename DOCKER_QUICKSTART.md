# Starline - Quick Start Guide for Colleagues

This guide will help you get Starline running on your machine in minutes using Docker.

## What You Need

- Docker Desktop (Windows/Mac) or Docker Engine (Linux)
- 5 minutes of your time

## Installation Steps

1. Navigate to the project:
```bash
cd starline
```

2. Build and run:
```bash
docker compose up --build
```

3. Open your browser to:
```
http://localhost:3000
```

That's it! The application is now running.

## Common Commands

```bash
# Start in background
docker compose up -d

# Stop the application
docker compose down

# View logs
docker compose logs -f

# Restart after changes
docker compose restart
```

## Troubleshooting

### Permission Denied (Linux only)

If you see a permission error:

**Quick fix:** Run with sudo:
```bash
sudo docker compose up
```

**Permanent fix:** Add yourself to the docker group:
```bash
sudo usermod -aG docker $USER
```
Then log out and log back in.

### Port Already in Use

If port 3000 is already in use, edit `docker-compose.yml`:
```yaml
ports:
  - "8080:80"  # Change 3000 to 8080 (or any other port)
```

### Build Errors

If the build fails:
1. Make sure you have internet connection
2. Try removing old containers: `docker compose down`
3. Remove old image: `docker rmi starline-frontend`
4. Rebuild: `docker compose up --build`

## What's Running?

- **Frontend**: React application with search and influencer details
- **Port**: 3000 (nginx serves the built app)
- **Container**: starline-frontend

## Features to Try

1. **Search**: Type "tech", "fitness", or any influencer name
2. **View Details**: Click on any influencer card
3. **Network Graph**: Click on nodes to see connections
4. **Reviews**: Scroll down to see community reviews

## Stopping the Application

```bash
docker compose down
```

This stops and removes the containers. Your images remain for faster startup next time.

## Need Help?

- Check the main README.md for detailed documentation
- View logs: `docker compose logs -f`
- Clean slate: Remove everything and rebuild
  ```bash
  docker compose down
  docker rmi starline-frontend
  docker compose up --build
  ```
