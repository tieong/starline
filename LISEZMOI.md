# 🌟 Starline - Guide de Démarrage Rapide

> ✅ **Les problèmes CORS ont été corrigés !** Votre backend et frontend communiquent maintenant correctement.

---

## 🚀 Démarrage en 3 Minutes

### Option 1 : Développement Local (Recommandé)

#### Étape 1 : Backend
```bash
cd backend
cp env.template .env
# Éditez .env et ajoutez vos clés API
uv run python -m src.main
```
✅ Backend sur : http://localhost:8000

#### Étape 2 : Frontend
```bash
cd frontend
npm install
npm run dev
```
✅ Frontend sur : http://localhost:5173

#### Étape 3 : Tester
```powershell
# Windows
.\test-cors.ps1

# Linux/Mac
./test-cors.sh
```

---

### Option 2 : Docker (Simple et Rapide)

```bash
# 1. Configurer
cp backend/env.template backend/.env
# Éditez backend/.env

# 2. Lancer
docker-compose up --build

# ✅ Frontend : http://localhost:3000
# ✅ Backend : http://localhost:8000
```

---

## 📋 Variables d'Environnement Requises

Créez `backend/.env` avec au minimum :

```bash
DEBUG=true
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre-cle-anon
PERPLEXITY_API_KEY=votre-cle-perplexity
```

---

## ✅ Vérification Rapide

### Test 1 : Backend fonctionne ?
```bash
curl http://localhost:8000/api/health
```
Attendu : `{"status":"healthy"}`

### Test 2 : CORS configuré ?
Vérifiez les logs du backend, vous devriez voir :
```
✅ Starline Backend v0.1.0 started
🌐 CORS: All origins allowed (DEBUG MODE)
```

### Test 3 : Frontend accessible ?
Ouvrez votre navigateur sur :
- Dev : http://localhost:5173
- Docker : http://localhost:3000

Pas d'erreur CORS dans la console ? ✅ Parfait !

---

## 📚 Documentation

| Fichier | Description | Importance |
|---------|-------------|------------|
| **[QUICKSTART.md](QUICKSTART.md)** | Guide complet de démarrage | ⭐⭐⭐ |
| **[RESUME_CORRECTIONS.md](RESUME_CORRECTIONS.md)** | Résumé des corrections CORS | ⭐⭐⭐ |
| **[CORS_SETUP.md](CORS_SETUP.md)** | Détails techniques CORS | ⭐⭐ |
| **[CHANGEMENTS_TECHNIQUES.md](CHANGEMENTS_TECHNIQUES.md)** | Changements de code | ⭐⭐ |
| **[README.md](README.md)** | Documentation principale (anglais) | ⭐⭐ |

---

## 🆘 Problèmes Fréquents

### ❌ "CORS policy: No 'Access-Control-Allow-Origin'"

**Solution :**
1. Vérifiez `DEBUG=true` dans `backend/.env`
2. Redémarrez le backend
3. Vérifiez les logs

### ❌ "Connection refused" ou "Failed to fetch"

**Solution :**
```bash
# Vérifiez que le backend tourne
curl http://localhost:8000/api/health

# Si erreur, vérifiez .env
cat backend/.env
```

### ❌ "502 Bad Gateway" (Docker)

**Solution :**
```bash
# Vérifiez les logs
docker-compose logs -f backend

# Recréez tout
docker-compose down
docker-compose up --build
```

---

## 🔧 Commandes Utiles

### Développement
```bash
# Backend
cd backend && uv run python -m src.main

# Frontend
cd frontend && npm run dev

# Test CORS
./test-cors.ps1  # Windows
./test-cors.sh   # Linux/Mac
```

### Docker
```bash
# Démarrer
docker-compose up --build

# Arrêter
docker-compose down

# Logs
docker-compose logs -f

# Rebuild complet
docker-compose down -v
docker-compose up --build
```

---

## 📊 Architecture

### Développement Local
```
Frontend (5173) ←→ Backend (8000)
     ↑                  ↑
     └── Pas de CORS (DEBUG=true) ──┘
```

### Production Docker
```
Browser → Nginx (3000) → Backend (8000)
              ↑
         Proxy /api/*
         (même origine)
```

---

## 🎯 Prochaines Étapes

1. ✅ Backend et Frontend configurés
2. ✅ CORS résolu
3. ⏭️ Configurer Supabase (voir [SUPABASE_SETUP.md](SUPABASE_SETUP.md))
4. ⏭️ Ajouter des données de test
5. ⏭️ Déployer en production

---

## 📞 Besoin d'Aide ?

1. **Consultez** [QUICKSTART.md](QUICKSTART.md) pour le guide complet
2. **Vérifiez** [RESUME_CORRECTIONS.md](RESUME_CORRECTIONS.md) pour les corrections
3. **Testez** avec les scripts `test-cors.ps1` ou `test-cors.sh`
4. **Regardez** les logs : `docker-compose logs -f`

---

## ✨ Ce Qui a Été Corrigé

| Problème | Solution | Status |
|----------|----------|--------|
| CORS bloque les requêtes | Mode DEBUG autorise tout | ✅ |
| Frontend ne trouve pas backend | Proxy nginx ajouté | ✅ |
| Config manquante | Templates .env créés | ✅ |
| Pas de documentation | 5+ guides créés | ✅ |

---

## 🎉 Tout Fonctionne ?

Si vous voyez ceci dans vos logs :
```
✅ Starline Backend v0.1.0 started
🌐 CORS: All origins allowed (DEBUG MODE)
```

Et que le test CORS passe :
```
✅ Backend accessible sur http://localhost:8000
✅ Headers CORS présents
```

**Félicitations ! Votre configuration est correcte ! 🎊**

---

**Made with ❤️ for Starline**

