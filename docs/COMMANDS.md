# Starline - Command Reference

## Docker Commands

### First Time Setup
```bash
cd starline
docker compose up --build
```
Access at: `http://localhost:3000`

### Daily Use
```bash
# Start
docker compose up -d

# Stop
docker compose down

# View logs
docker compose logs -f

# Restart
docker compose restart
```

### Cleanup
```bash
# Remove containers
docker compose down

# Remove containers and image
docker compose down
docker rmi starline-frontend
```

## Development Commands (Without Docker)

### First Time Setup
```bash
cd frontend
npm install
npm run dev
```
Access at: `http://localhost:5173`

### Daily Use
```bash
# Start dev server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint
```

## Sharing with Colleagues

### Option 1: Share Project (Recommended)
Just share the entire `starline/` folder. They run:
```bash
docker compose up --build
```

### Option 2: Export Docker Image
```bash
# Build and save
docker build -t starline-frontend ./frontend
docker save starline-frontend > starline.tar

# They load and run
docker load < starline.tar
docker run -d -p 3000:80 starline-frontend
```

### Option 3: Push to Docker Hub
```bash
# Tag and push
docker tag starline-frontend yourusername/starline:latest
docker push yourusername/starline:latest

# They pull and run
docker pull yourusername/starline:latest
docker run -d -p 3000:80 yourusername/starline:latest
```

## Troubleshooting

### Port Already in Use
Edit `docker-compose.yml` and change:
```yaml
ports:
  - "8080:80"  # Changed from 3000
```

### Docker Permission Denied (Linux)
```bash
# Quick fix
sudo docker compose up

# Permanent fix
sudo usermod -aG docker $USER
# Then logout and login again
```

### Fresh Start
```bash
docker compose down
docker rmi starline-frontend
docker compose up --build
```
