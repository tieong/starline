# Starline - Plateforme d'Intelligence d'Influenceurs

Une application React moderne pour analyser et découvrir des influenceurs avec scoring IA, graphe de relations interactif et timeline d'actualités.

## ✨ Fonctionnalités

- 🔍 **Recherche intelligente** : Trouvez des influenceurs par nom ou niche
- 📊 **InfluScoring** : Système de notation complet avec métriques de fiabilité
- 🎨 **Design Soft Pastel** : Interface rassurante avec neumorphisme léger
- 🕸️ **Graphe Interactif** : Visualisez les relations entre influenceurs, agences et marques
- 📰 **Timeline d'Actualités** : Suivez les derniers événements et partenariats
- 🎁 **Catalogue Produits** : Découvrez les collaborations et codes promo
- ⚡ **Animations Fluides** : Micro-interactions avec Framer Motion
- 📱 **Responsive** : Design adapté à tous les écrans

## 🚀 Démarrage Rapide

### Installation

```bash
npm install
```

### Développement

```bash
npm run dev
```

Ouvrez [http://localhost:5173](http://localhost:5173) dans votre navigateur.

### Build Production

```bash
npm run build
```

### Preview Production

```bash
npm run preview
```

## 🎨 Charte Graphique

L'application utilise une palette **Soft Pastel Science** :

- **Primary** : Violet doux (#A57AE9)
- **Background** : Lavande clair (#F4F0FF)
- **Accent** : Orange, Bleu, Teal, Jaune
- **Style** : Neumorphisme léger, bordures arrondies, ombres douces

## 📦 Technologies

- **React 18** avec TypeScript
- **Vite** pour le build ultra-rapide
- **Framer Motion** pour les animations
- **D3.js** pour le graphe interactif
- **React Router** pour la navigation
- **Lucide React** pour les icônes

## 🗂️ Structure du Projet

```
src/
├── components/        # Composants réutilisables
│   ├── SearchBar.tsx
│   ├── Tag.tsx
│   ├── InfluencerCard.tsx
│   └── ScoreGauge.tsx
├── pages/            # Pages de l'application
│   ├── Home.tsx
│   ├── InfluencerDetail.tsx
│   └── NetworkGraph.tsx
├── data/             # Données mock
│   └── mockData.ts
├── types.ts          # Définitions TypeScript
├── App.tsx           # Composant principal
├── main.tsx          # Point d'entrée
└── index.css         # Styles globaux
```

## 🎯 Pages

1. **Accueil** (`/`) : Recherche et grille d'influenceurs
2. **Profil Influenceur** (`/influencer/:id`) : Détails complets avec scoring, produits et news
3. **Graphe de Relations** (`/graph/:id?`) : Carte interactive des connexions

## 🔮 Prochaines Évolutions

- Intégration API backend réelle
- Système de recherche avancée avec filtres
- Comparaison de plusieurs influenceurs
- Export de rapports PDF
- Notifications temps réel
- Mode sombre

## 📄 Licence

Ce projet est sous licence MIT.
