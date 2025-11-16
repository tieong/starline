#!/bin/bash

# Script de test CORS pour Starline
# Vérifie que le backend et le frontend communiquent correctement

echo "🧪 Test de Configuration CORS - Starline"
echo "========================================"
echo ""

# Couleurs pour les messages
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test 1: Backend Health
echo "📡 Test 1: Backend Health Check"
if curl -s http://localhost:8000/api/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Backend accessible sur http://localhost:8000${NC}"
    RESPONSE=$(curl -s http://localhost:8000/api/health)
    echo "   Réponse: $RESPONSE"
else
    echo -e "${RED}❌ Backend non accessible sur http://localhost:8000${NC}"
    echo "   Vérifiez que le backend est démarré"
fi
echo ""

# Test 2: Backend CORS Headers
echo "📡 Test 2: Vérification des Headers CORS"
CORS_HEADER=$(curl -s -I -H "Origin: http://localhost:5173" http://localhost:8000/api/health | grep -i "access-control-allow-origin")
if [ -n "$CORS_HEADER" ]; then
    echo -e "${GREEN}✅ Headers CORS présents${NC}"
    echo "   $CORS_HEADER"
else
    echo -e "${YELLOW}⚠️  Headers CORS non trouvés (peut être normal si DEBUG=false)${NC}"
fi
echo ""

# Test 3: Frontend Development Server
echo "🌐 Test 3: Frontend Development Server"
if curl -s http://localhost:5173 > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Frontend accessible sur http://localhost:5173${NC}"
else
    echo -e "${YELLOW}⚠️  Frontend dev server non accessible${NC}"
    echo "   Ceci est normal si vous utilisez Docker"
fi
echo ""

# Test 4: Docker Frontend
echo "🐳 Test 4: Docker Frontend (Production)"
if curl -s http://localhost:3000 > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Frontend Docker accessible sur http://localhost:3000${NC}"
else
    echo -e "${YELLOW}⚠️  Frontend Docker non accessible${NC}"
    echo "   Ceci est normal en développement local"
fi
echo ""

# Test 5: Nginx Proxy (si Docker)
echo "🔀 Test 5: Nginx Proxy (Docker seulement)"
if curl -s http://localhost:3000/api/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Nginx proxy fonctionne${NC}"
    RESPONSE=$(curl -s http://localhost:3000/api/health)
    echo "   Réponse via proxy: $RESPONSE"
else
    echo -e "${YELLOW}⚠️  Nginx proxy non accessible${NC}"
    echo "   Démarrez Docker avec: docker-compose up"
fi
echo ""

# Test 6: Backend Documentation
echo "📚 Test 6: Documentation API"
if curl -s http://localhost:8000/docs > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Documentation accessible sur http://localhost:8000/docs${NC}"
else
    echo -e "${RED}❌ Documentation non accessible${NC}"
fi
echo ""

# Résumé
echo "========================================"
echo "📋 RÉSUMÉ"
echo "========================================"
echo ""
echo "URLs à retenir:"
echo "  • Backend API:         http://localhost:8000"
echo "  • Backend Docs:        http://localhost:8000/docs"
echo "  • Frontend Dev:        http://localhost:5173"
echo "  • Frontend Docker:     http://localhost:3000"
echo "  • API via Nginx:       http://localhost:3000/api/*"
echo ""
echo "Pour résoudre les problèmes:"
echo "  1. Consultez: QUICKSTART.md"
echo "  2. Consultez: CORS_SETUP.md"
echo "  3. Vérifiez les logs: docker-compose logs -f"
echo ""

