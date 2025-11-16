# Guide de Démarrage Rapide - Starline

## 🚀 Démarrage Rapide

### Option 1: Développement Local (Recommandé pour le développement)

#### 1. Configuration du Backend

```bash
cd backend

# Copier le template des variables d'environnement
cp env.template .env

# Éditer .env et remplir vos clés API
# Minimum requis: SUPABASE_URL, SUPABASE_ANON_KEY, PERPLEXITY_API_KEY ou BLACKBOX_API_KEY

# Installer les dépendances
uv sync

# Démarrer le backend
uv run python -m src.main
```

Le backend démarre sur: `http://localhost:8000`
Documentation API: `http://localhost:8000/docs`

#### 2. Configuration du Frontend

```bash
cd frontend

# Copier le template des variables d'environnement
cp env.template .env

# Installer les dépendances
npm install

# Démarrer le frontend
npm run dev
```

Le frontend démarre sur: `http://localhost:5173`

### Option 2: Docker (Recommandé pour la production)

```bash
# À la racine du projet

# 1. Configurer les variables d'environnement
cp backend/env.template backend/.env
# Éditer backend/.env avec vos clés API

# 2. Démarrer avec Docker Compose
docker-compose up --build

# Frontend: http://localhost:3000
# Backend: http://localhost:8000
# API via proxy: http://localhost:3000/api/*
```

## ✅ Vérification

### Test Backend
```bash
curl http://localhost:8000/api/health
# Devrait retourner: {"status":"healthy"}
```

### Test Frontend (en développement)
Ouvrir le navigateur sur `http://localhost:5173`

### Test Frontend (en Docker)
Ouvrir le navigateur sur `http://localhost:3000`

## 🔧 Configuration CORS

### ✨ Corrections Appliquées

1. **Backend** (`backend/src/main.py`):
   - Mode DEBUG: Autorise toutes les origines
   - Mode PRODUCTION: Origines spécifiques seulement

2. **Nginx Proxy** (`frontend/nginx.conf`):
   - Toutes les requêtes `/api/*` sont proxiées vers le backend
   - Élimine complètement les problèmes CORS en production

3. **Frontend API** (`frontend/src/services/api.ts`):
   - Développement: Utilise `http://localhost:8000`
   - Production (Docker): Utilise le proxy nginx (même origine)

### Comment ça fonctionne ?

#### En Développement Local:
```
Frontend (localhost:5173) → Backend (localhost:8000)
                            ↑
                    CORS autorisé (DEBUG=true)
```

#### En Production (Docker):
```
Browser → Nginx (localhost:3000)
           ├─ /         → Static Files
           └─ /api/*    → Backend (backend:8000)
                         ↑
                  Pas de CORS (même origine via proxy)
```

## 🐛 Résolution de Problèmes

### Problème: "CORS policy: No 'Access-Control-Allow-Origin' header"

**En développement:**
1. Vérifiez que `DEBUG=true` dans `backend/.env`
2. Redémarrez le backend
3. Vérifiez les logs: devrait afficher "CORS: All origins allowed (DEBUG MODE)"

**En Docker:**
1. Le problème ne devrait pas se produire grâce au proxy nginx
2. Vérifiez que nginx redirige bien: `docker logs starline-frontend`

### Problème: Frontend ne peut pas se connecter au backend

**En développement:**
```bash
# Vérifiez que le backend tourne
curl http://localhost:8000/api/health

# Vérifiez la variable d'environnement
cat frontend/.env | grep VITE_API_URL
# Devrait être: VITE_API_URL=http://localhost:8000
```

**En Docker:**
```bash
# Vérifiez que les conteneurs tournent
docker ps

# Vérifiez les logs du backend
docker logs starline-backend

# Vérifiez que le réseau Docker fonctionne
docker exec starline-frontend ping backend
```

### Problème: "502 Bad Gateway" en Docker

```bash
# Vérifiez que le backend est accessible depuis le frontend
docker exec starline-frontend wget -O- http://backend:8000/api/health

# Si ça ne fonctionne pas, recréez le réseau
docker-compose down
docker-compose up --build
```

## 📝 Variables d'Environnement Requises

### Backend (Minimum)
- `SUPABASE_URL`: URL de votre projet Supabase
- `SUPABASE_ANON_KEY`: Clé anonyme Supabase
- `PERPLEXITY_API_KEY` ou `BLACKBOX_API_KEY`: Clé API pour l'IA

### Frontend
- `VITE_API_URL`: URL du backend (optionnel en production Docker)

## 📚 Documentation Complète

- [Configuration CORS Détaillée](CORS_SETUP.md)
- [Configuration Supabase](SUPABASE_SETUP.md)
- [Documentation Docker](docs/DOCKER_QUICKSTART.md)

## 🎯 Prochaines Étapes

1. ✅ Backend et Frontend configurés
2. ✅ CORS résolu
3. ⏭️ Configurer Supabase (voir [SUPABASE_SETUP.md](SUPABASE_SETUP.md))
4. ⏭️ Ajouter des données de test
5. ⏭️ Déployer en production

## 💡 Conseils

- Utilisez le développement local pour itérer rapidement
- Testez avec Docker avant de déployer en production
- Activez les logs détaillés avec `DEBUG=true`
- Consultez les logs avec `docker-compose logs -f`

