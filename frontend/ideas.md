# Projet Starline - Plateforme d'Intelligence d'Influenceurs (AI-Powered)

## 🎯 Vision Générale
Système d'analyse d'influenceurs en temps réel propulsé par l'IA, capable de découvrir automatiquement les profils sociaux, analyser les produits, construire des graphes de relations, et identifier les moments clés de carrière.

**Concept clé** : L'utilisateur recherche un influenceur (ex: "Cyprien") → Le système analyse en temps réel toutes les données disponibles en ~30 secondes → Retourne un profil complet avec scoring, produits, réseau et historique.

---

## 📊 Fonctionnalités Principales

### 1. **Profil Influenceur (Paper)**
Fiche détaillée pour chaque influenceur contenant :
- Photo et informations de base
- Statistiques clés (followers, engagement rate, etc.)
- Score de sécurité (InfluScoring)
- Dernières actualités et dramas
- Produits associés
- Agence de représentation (si applicable)

### 2. **InfluScoring - Système de Notation**
Score indiquant si un influenceur est "safe" pour une collaboration :
- ✅ Score de fiabilité
- ⚠️ Historique de controverses
- 📊 Taux d'engagement authentique
- 🔍 Analyse de réputation
- 💼 Professionnalisme

### 3. **Carte Interactive des Relations**
Visualisation graphique des connexions entre influenceurs :
- **Réseau d'influence** : liens entre influenceurs
- **Collaborations** : projets communs
- **Agences** : affiliations professionnelles
- **Marques** : partenariats
- Navigation intuitive avec zoom et filtres

### 4. **Timeline d'Actualités**
- 📰 Dernières news
- 🔥 Dramas récents
- 🚀 Nouveaux partenariats
- 📈 Évolution de la popularité

### 5. **Catalogue Produits**
Liste des produits promus par l'influenceur :
- Collaborations de marque
- Produits personnels
- Codes promo actifs
- Historique des campagnes

---

## 🎨 Design & Interface

### Style Visuel
- Design soft avec palette pastel (voir `object.md`)
- Neumorphisme léger
- Interface rassurante et pédagogique
- Animations fluides

### Composants Principaux
- **Cards influenceurs** : style "paper" avec ombres douces
- **Graph interactif** : nœuds et connexions animés
- **Pills de tags** : catégories, niches, statuts
- **Timeline** : affichage chronologique des événements
- **Tooltips informatifs** : contexte au survol

---

## 🗺️ Architecture de la Carte Interactive

### Types de Nœuds
1. **Influenceurs** (nœuds principaux)
2. **Agences** (nœuds organisationnels)
3. **Marques** (nœuds commerciaux)
4. **Événements** (dramas, collaborations)

### Types de Liens
- Relation professionnelle (agence)
- Collaboration ponctuelle
- Amitié/réseau personnel
- Affiliation de marque

### Interactions
- Clic sur nœud → Affichage du paper
- Zoom/Pan pour navigation
- Filtres par catégorie, score, date
- Recherche rapide

-