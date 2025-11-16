# Configuration CORS - Starline

Ce document explique comment la configuration CORS a été mise en place pour permettre la communication entre le frontend et le backend.

## 🔧 Architecture

### En Développement Local
- **Frontend**: `http://localhost:5173` (Vite dev server)
- **Backend**: `http://localhost:8000` (FastAPI)
- **CORS**: Le backend autorise toutes les origines en mode DEBUG

### En Production (Docker)
- **Frontend**: `http://localhost:3000` (Nginx sur port 80, mappé à 3000)
- **Backend**: `http://backend:8000` (dans le réseau Docker)
- **Proxy**: Nginx proxie les requêtes `/api/*` vers le backend
- **CORS**: Pas de problème car tout passe par le même domaine (nginx proxy)

## 📝 Modifications Effectuées

### 1. Backend CORS (`backend/src/main.py`)
```python
# Autorise toutes les origines en mode DEBUG
allowed_origins = ["*"] if settings.debug else [
    "http://localhost:3000",
    "http://localhost:5173",
    "http://localhost:80",
    "http://frontend",
    "http://frontend:80",
]
```

### 2. Nginx Proxy (`frontend/nginx.conf`)
```nginx
# Proxy des requêtes API vers le backend
location /api/ {
    proxy_pass http://backend:8000;
    proxy_http_version 1.1;
    # ... headers ...
}
```

### 3. Frontend API Service (`frontend/src/services/api.ts`)
```typescript
// En production: utilise le proxy nginx (même origine)
// En dev: utilise l'URL complète du backend
const API_BASE_URL = import.meta.env.PROD 
  ? '' 
  : ((import.meta as any).env?.VITE_API_URL || 'http://localhost:8000');
```

### 4. Docker Compose (`docker-compose.yml`)
```yaml
frontend:
  environment:
    VITE_API_URL: http://localhost:8000
```

## 🚀 Utilisation

### Développement Local

1. **Backend**:
```bash
cd backend
uv run python -m src.main
# Backend démarre sur http://localhost:8000
```

2. **Frontend**:
```bash
cd frontend
npm run dev
# Frontend démarre sur http://localhost:5173
```

Le frontend fera des requêtes directement à `http://localhost:8000/api/*`

### Production (Docker)

```bash
# Démarrer les services
docker-compose up --build

# Frontend: http://localhost:3000
# Backend: http://localhost:8000
# API accessible via: http://localhost:3000/api/*
```

Les requêtes API passent par le proxy nginx, donc pas de problème de CORS.

## 🔍 Vérification

### Test de CORS
```bash
# Depuis le navigateur (Console DevTools)
fetch('http://localhost:8000/api/health')
  .then(r => r.json())
  .then(console.log)
```

### Test du Proxy Nginx (en Docker)
```bash
# Devrait retourner la même chose
fetch('http://localhost:3000/api/health')
  .then(r => r.json())
  .then(console.log)
```

## 🐛 Résolution de Problèmes

### Erreur CORS en développement
- Vérifiez que `DEBUG=true` dans le backend
- Vérifiez que le backend est démarré sur le bon port (8000)
- Vérifiez les logs du backend pour voir les requêtes CORS

### Erreur 502 Bad Gateway (Docker)
- Vérifiez que le backend est démarré: `docker logs starline-backend`
- Vérifiez le réseau Docker: `docker network inspect starline_starline-network`
- Vérifiez que le service backend est accessible: `docker exec starline-frontend ping backend`

### Frontend ne peut pas atteindre le backend
- En dev: Vérifiez `VITE_API_URL` dans `.env`
- En Docker: Vérifiez que nginx proxy est configuré correctement
- Testez l'endpoint health: `/api/health`

## 📚 Ressources

- [FastAPI CORS](https://fastapi.tiangolo.com/tutorial/cors/)
- [Nginx Reverse Proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- [Vite Environment Variables](https://vitejs.dev/guide/env-and-mode.html)

