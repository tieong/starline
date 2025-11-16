# 🔧 Changements Techniques - Détails

## Fichiers Modifiés

### 1. `backend/src/main.py` - Configuration CORS Backend

#### ✏️ Changement 1 : CORS Dynamique

```python
# ❌ AVANT (ligne 30-37)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "http://localhost:5173"],  # Frontend URLs
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

```python
# ✅ APRÈS (lignes 30-46)
# CORS middleware for frontend
# Allow all origins in debug mode, specific origins in production
allowed_origins = ["*"] if settings.debug else [
    "http://localhost:3000",
    "http://localhost:5173",
    "http://localhost:80",
    "http://frontend",
    "http://frontend:80",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

**Pourquoi ce changement ?**
- En mode DEBUG, autorise TOUTES les origines (`["*"]`)
- En production, limite aux origines spécifiques
- Ajoute les URLs Docker (`http://frontend`, etc.)

#### ✏️ Changement 2 : Message de Log

```python
# ✅ AJOUTÉ (ligne 61)
print(f"🌐 CORS: {'All origins allowed (DEBUG MODE)' if settings.debug else 'Restricted origins'}")
```

**Pourquoi ce changement ?**
- Indique clairement si CORS est en mode permissif ou restrictif
- Aide au débogage

---

### 2. `frontend/nginx.conf` - Proxy Nginx

#### ✏️ Changement : Ajout du Proxy API

```nginx
# ✅ AJOUTÉ (lignes 13-26)
# Proxy API requests to backend
location /api/ {
    proxy_pass http://backend:8000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_cache_bypass $http_upgrade;
    proxy_read_timeout 300s;
    proxy_connect_timeout 75s;
}
```

**Pourquoi ce changement ?**
- Toutes les requêtes `/api/*` sont redirigées vers le backend
- Élimine complètement les problèmes CORS en production
- Les requêtes semblent venir du même domaine

**Flux des requêtes :**
```
Browser → http://localhost:3000/api/health
              ↓
       Nginx intercepte `/api/*`
              ↓
       Redirige vers http://backend:8000/api/health
              ↓
       Backend traite la requête
              ↓
       Nginx retourne la réponse
              ↓
       Browser reçoit la réponse (même origine ✓)
```

---

### 3. `frontend/src/services/api.ts` - Configuration API Frontend

#### ✏️ Changement : URL API Dynamique

```typescript
// ❌ AVANT (ligne 8)
const API_BASE_URL = (import.meta as any).env?.VITE_API_URL || 'http://localhost:8000';
```

```typescript
// ✅ APRÈS (lignes 8-12)
// In production (Docker), use empty string to use same origin (nginx proxy)
// In development, use VITE_API_URL or default to localhost:8000
const API_BASE_URL = import.meta.env.PROD 
  ? '' 
  : ((import.meta as any).env?.VITE_API_URL || 'http://localhost:8000');
```

**Pourquoi ce changement ?**
- En **production** (`PROD=true`) : Utilise une chaîne vide = même origine (nginx proxy)
- En **développement** (`PROD=false`) : Utilise `http://localhost:8000` directement

**Exemples de requêtes :**

En développement :
```typescript
// API_BASE_URL = 'http://localhost:8000'
fetch('http://localhost:8000/api/health')  // ✓ CORS autorisé
```

En production :
```typescript
// API_BASE_URL = ''
fetch('/api/health')  // ✓ Même origine via nginx proxy
```

---

### 4. `docker-compose.yml` - Variables d'Environnement

#### ✏️ Changement : Configuration Frontend

```yaml
# ❌ AVANT
frontend:
  build:
    context: ./frontend
    dockerfile: Dockerfile
  container_name: starline-frontend
  ports:
    - "3000:80"
```

```yaml
# ✅ APRÈS
frontend:
  build:
    context: ./frontend
    dockerfile: Dockerfile
    args:
      VITE_API_URL: http://localhost:8000
  container_name: starline-frontend
  environment:
    VITE_API_URL: http://localhost:8000
  ports:
    - "3000:80"
```

**Pourquoi ce changement ?**
- Définit explicitement l'URL de l'API
- `args`: Variables au moment du build
- `environment`: Variables à l'exécution
- Facilite la configuration sans modifier le code

---

## Fichiers Créés

### Documentation

| Fichier | Description |
|---------|-------------|
| `CORS_SETUP.md` | Guide détaillé de la configuration CORS |
| `QUICKSTART.md` | Guide de démarrage rapide complet |
| `CORRECTIONS_CORS_FR.md` | Résumé des corrections en français |
| `CHANGEMENTS_TECHNIQUES.md` | Ce fichier - détails techniques |

### Templates

| Fichier | Description |
|---------|-------------|
| `backend/env.template` | Template des variables d'environnement backend |
| `frontend/env.template` | Template des variables d'environnement frontend |

### Scripts de Test

| Fichier | Description |
|---------|-------------|
| `test-cors.sh` | Script de test CORS pour Linux/Mac |
| `test-cors.ps1` | Script de test CORS pour Windows PowerShell |

---

## Diagramme de l'Architecture

### Mode Développement Local

```
┌────────────────────────────────────────────────────────────────┐
│                      Machine de Développement                  │
│                                                                │
│  ┌──────────────────┐           ┌──────────────────┐         │
│  │   Frontend Vite  │           │   Backend FastAPI│         │
│  │  localhost:5173  │           │  localhost:8000  │         │
│  │                  │           │                  │         │
│  │  API_BASE_URL =  │           │  CORS: ["*"]     │         │
│  │ "localhost:8000" │  ────>    │  (DEBUG=true)    │         │
│  │                  │  <────    │                  │         │
│  └──────────────────┘           └──────────────────┘         │
│         ↑                                                      │
│         │                                                      │
│    ┌─────────┐                                                │
│    │ Browser │                                                │
│    └─────────┘                                                │
└────────────────────────────────────────────────────────────────┘

Flux :
1. Browser ouvre http://localhost:5173
2. Frontend fait des requêtes à http://localhost:8000/api/*
3. Backend autorise toutes les origines (DEBUG=true)
4. Réponses retournées avec headers CORS
```

### Mode Production Docker

```
┌────────────────────────────────────────────────────────────────┐
│                         Réseau Docker                          │
│                                                                │
│  ┌──────────────────┐           ┌──────────────────┐         │
│  │   Frontend       │           │   Backend        │         │
│  │   Nginx:80       │           │   FastAPI:8000   │         │
│  │                  │           │                  │         │
│  │  Static: /       │           │  API Endpoints   │         │
│  │  Proxy: /api/*   │  ────>    │                  │         │
│  │      ↓           │  <────    │                  │         │
│  │  backend:8000    │           │                  │         │
│  └──────────────────┘           └──────────────────┘         │
│         ↑                                                      │
│         │                                                      │
│    ┌─────────┐                                                │
│    │ Browser │                                                │
│    └─────────┘                                                │
└────────────────────────────────────────────────────────────────┘
         ↑
    Port Mapping
         │
    localhost:3000

Flux :
1. Browser ouvre http://localhost:3000
2. Nginx sert les fichiers statiques pour "/"
3. Pour "/api/*", nginx proxie vers http://backend:8000
4. Browser pense que tout vient de localhost:3000
5. Pas de CORS car même origine !
```

---

## Tests de Vérification

### Test 1 : Backend CORS Headers

```bash
curl -I -H "Origin: http://localhost:5173" http://localhost:8000/api/health

# Devrait retourner :
HTTP/1.1 200 OK
access-control-allow-origin: *
access-control-allow-credentials: true
...
```

### Test 2 : Nginx Proxy

```bash
curl http://localhost:3000/api/health

# Devrait retourner :
{"status":"healthy"}
```

### Test 3 : Frontend Fetch

Ouvrir la console du navigateur sur `http://localhost:3000` :

```javascript
fetch('/api/health')
  .then(r => r.json())
  .then(console.log)

// Devrait afficher :
// {status: "healthy"}
// Sans erreur CORS !
```

---

## Variables d'Environnement

### Backend (`backend/.env`)

```bash
# Obligatoires
DEBUG=true
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-key
PERPLEXITY_API_KEY=your-key

# Optionnelles
AI_PROVIDER=perplexity
DATABASE_URL=postgresql://...
```

### Frontend (`frontend/.env`)

```bash
# Optionnel - sera défini automatiquement
VITE_API_URL=http://localhost:8000
```

---

## Commandes Utiles

### Développement

```bash
# Backend
cd backend
uv run python -m src.main

# Frontend
cd frontend
npm run dev

# Test CORS
./test-cors.sh  # ou test-cors.ps1 sur Windows
```

### Production Docker

```bash
# Démarrer
docker-compose up --build

# Logs
docker-compose logs -f

# Arrêter
docker-compose down

# Rebuild complet
docker-compose down -v
docker-compose up --build
```

---

## Résolution de Problèmes Techniques

### Problème : CORS Error en développement

**Symptôme :**
```
Access to fetch at 'http://localhost:8000/api/health' from origin 
'http://localhost:5173' has been blocked by CORS policy
```

**Solution :**
1. Vérifiez que `DEBUG=true` dans `backend/.env`
2. Redémarrez le backend
3. Vérifiez les logs : devrait afficher "CORS: All origins allowed"

### Problème : 502 Bad Gateway en Docker

**Symptôme :**
```
nginx: [error] ... upstream prematurely closed connection
```

**Solution :**
```bash
# Vérifiez que le backend est accessible
docker exec starline-frontend wget -O- http://backend:8000/api/health

# Si erreur, vérifiez le backend
docker logs starline-backend

# Recréez les conteneurs
docker-compose down
docker-compose up --build
```

### Problème : Frontend ne trouve pas l'API

**Symptôme :**
```
Failed to fetch
net::ERR_CONNECTION_REFUSED
```

**Solution en dev :**
```bash
# Vérifiez que le backend tourne
curl http://localhost:8000/api/health

# Vérifiez la config
cat frontend/.env
```

**Solution en Docker :**
```bash
# Vérifiez le réseau
docker network inspect starline_starline-network

# Vérifiez les conteneurs
docker ps

# Testez depuis le frontend vers le backend
docker exec starline-frontend ping backend
```

---

## Références

- [FastAPI CORS Middleware](https://fastapi.tiangolo.com/tutorial/cors/)
- [Nginx Reverse Proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- [Vite Environment Variables](https://vitejs.dev/guide/env-and-mode.html)
- [Docker Compose Networking](https://docs.docker.com/compose/networking/)

