# Script de test CORS pour Starline (PowerShell)
# Vérifie que le backend et le frontend communiquent correctement

Write-Host "🧪 Test de Configuration CORS - Starline" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: Backend Health
Write-Host "📡 Test 1: Backend Health Check" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8000/api/health" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Backend accessible sur http://localhost:8000" -ForegroundColor Green
        Write-Host "   Réponse: $($response.Content)" -ForegroundColor Gray
    }
} catch {
    Write-Host "❌ Backend non accessible sur http://localhost:8000" -ForegroundColor Red
    Write-Host "   Vérifiez que le backend est démarré" -ForegroundColor Gray
}
Write-Host ""

# Test 2: Backend CORS Headers
Write-Host "📡 Test 2: Vérification des Headers CORS" -ForegroundColor Yellow
try {
    $headers = @{
        "Origin" = "http://localhost:5173"
    }
    $response = Invoke-WebRequest -Uri "http://localhost:8000/api/health" -Headers $headers -Method Options -UseBasicParsing -TimeoutSec 5
    $corsHeader = $response.Headers["Access-Control-Allow-Origin"]
    if ($corsHeader) {
        Write-Host "✅ Headers CORS présents" -ForegroundColor Green
        Write-Host "   Access-Control-Allow-Origin: $corsHeader" -ForegroundColor Gray
    }
} catch {
    Write-Host "⚠️  Headers CORS non trouvés (peut être normal si DEBUG=false)" -ForegroundColor Yellow
}
Write-Host ""

# Test 3: Frontend Development Server
Write-Host "🌐 Test 3: Frontend Development Server" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:5173" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Frontend accessible sur http://localhost:5173" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️  Frontend dev server non accessible" -ForegroundColor Yellow
    Write-Host "   Ceci est normal si vous utilisez Docker" -ForegroundColor Gray
}
Write-Host ""

# Test 4: Docker Frontend
Write-Host "🐳 Test 4: Docker Frontend (Production)" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Frontend Docker accessible sur http://localhost:3000" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️  Frontend Docker non accessible" -ForegroundColor Yellow
    Write-Host "   Ceci est normal en développement local" -ForegroundColor Gray
}
Write-Host ""

# Test 5: Nginx Proxy (si Docker)
Write-Host "🔀 Test 5: Nginx Proxy (Docker seulement)" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000/api/health" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Nginx proxy fonctionne" -ForegroundColor Green
        Write-Host "   Réponse via proxy: $($response.Content)" -ForegroundColor Gray
    }
} catch {
    Write-Host "⚠️  Nginx proxy non accessible" -ForegroundColor Yellow
    Write-Host "   Démarrez Docker avec: docker-compose up" -ForegroundColor Gray
}
Write-Host ""

# Test 6: Backend Documentation
Write-Host "📚 Test 6: Documentation API" -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8000/docs" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "✅ Documentation accessible sur http://localhost:8000/docs" -ForegroundColor Green
    }
} catch {
    Write-Host "❌ Documentation non accessible" -ForegroundColor Red
}
Write-Host ""

# Résumé
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "📋 RÉSUMÉ" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "URLs à retenir:"
Write-Host "  • Backend API:         http://localhost:8000"
Write-Host "  • Backend Docs:        http://localhost:8000/docs"
Write-Host "  • Frontend Dev:        http://localhost:5173"
Write-Host "  • Frontend Docker:     http://localhost:3000"
Write-Host "  • API via Nginx:       http://localhost:3000/api/*"
Write-Host ""
Write-Host "Pour résoudre les problèmes:"
Write-Host "  1. Consultez: QUICKSTART.md"
Write-Host "  2. Consultez: CORS_SETUP.md"
Write-Host "  3. Vérifiez les logs: docker-compose logs -f"
Write-Host ""

