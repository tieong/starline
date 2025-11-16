# Starline UI Guideline (hors page 3D)

Document cree automatiquement a partir des feuilles de style dans `src/index.css`, `src/pages/*` (hors rendu 3D) et `src/components/*`. Il sert de reference pour toute generation par IA sans tenir compte de la scene 3D (`ThreeDInfluencerMap`).

## 1. Perimetre fonctionnel
- Pages couvertes : `Home`, `AllInfluencers`, `InfluencerDetail`, `NetworkGraph` (parties UI 2D), composants `InfluencerCard`, `InfluencerInfoPanel`, `ScoreGauge`, `Search*`, `Tag`.
- Elements exclus : toute classe ou logique dependant de la scene 3D (`three-d-map`, canvas WebGL).
- Ton visuel : esthetique editoriale, contrastes noir/blanc, accents arc-en-ciel (inspiration Chroma).

## 2. Design tokens existants

### 2.1 Couleurs definies dans `:root`
| Token | Valeur | Usage cle |
| --- | --- | --- |
| `--bg-main` | `#FFFFFF` | Fond global |
| `--bg-secondary` | `#FAFAFA` | Sections secondaires |
| `--primary-purple` | `#8B5CF6` | Accent gradient |
| `--primary-blue` | `#3B82F6` | Accent gradient |
| `--primary-green` | `#10B981` | Accent gradient |
| `--primary-yellow` | `#F59E0B` | Accent gradient |
| `--primary-red` | `#EF4444` | Accent gradient |
| `--black` | `#000000` | Textes contrastes |
| `--gray-900` | `#111111` | Hover sombre |
| `--gray-800` | `#1a1a1a` | Boutons pleins |
| `--gray-600` | `#525252` | Texte secondaire |
| `--gray-400` | `#9ca3af` | Placeholder, scrollbars |
| `--gray-200` | `#e5e7eb` | Separateurs |
| `--gray-100` | `#f3f4f6` | Hover clair |
| `--white` | `#FFFFFF` | Cartes |
| `--text-strong` | `#000000` | Titres |
| `--text-normal` | `#1a1a1a` | Corps |
| `--text-muted` | `#525252` | Meta |
| `--text-disabled` | `#9ca3af` | Etats desactives |
| `--surface-card` | `#FFFFFF` | Cartes principales |
| `--surface-subtle` | `#FAFAFA` | Arriere plan modules |
| `--state-hover` | `#f3f4f6` | Survol |
| `--state-selected` | `#e5e7eb` | Selection |
| `--border-main` | `#000000` | Contours 1px |
| `--border-subtle` | `#e5e7eb` | Diviseurs |

### 2.2 Tokens utilises mais non definis
Ajouter ces variables a `:root` avant toute reutilisation :
- Couleurs : `--primary-main`, `--primary-light`, `--primary-dark`, `--accent-blue`, `--surface-card-soft`.
- Ombres : `--shadow-soft`, `--shadow-card-glow`, `--shadow-floating`.
- Rayons : `--radius-card`, `--radius-pill`, `--radius-tooltip`.
- Typo : `--font-family` (utiliser `var(--font-sans)`).

### 2.3 Typographie
- `--font-serif` (`'Lora', Georgia`) pour titres `h1-h3`, logos, stats.
- `--font-sans` (`'Inter', system-ui`) pour corps, controles, boutons.
- Echelles cle : `h1 48px`, `h2 32px`, `h3 24px`, corps 16px, petit texte 14px, micro copie 11-13px uppercase (tracking 0.08-0.1em).

### 2.4 Rayon, ombre et espacement
- Rayons definis : `--radius-none: 0`, `--radius-sm: 2px`, `--radius-md: 4px`. Les autres doivent etre ajoutes (voir 2.2).
- Ombres definies : `--shadow-subtle`, `--shadow-card` (utiliser pour hover leger). Pour les cartes lumineuses, etendre avec `--shadow-soft` (valeur a definir).
- Echelle d'espacement : `--space-xs 4px`, `--space-sm 8px`, `--space-md 16px`, `--space-lg 24px`, `--space-xl 32px`, `--space-xxl 48px`, `--space-xxxl 64px`. Respecter ces increments pour marges/paddings.

## 3. Principes UI globaux
- **Structure** : conteneurs centraux max 1200px (`.all-influencers`, `.influencer-detail`). Cartes et sections utilisent bordure 1px noire, pas d'arrondi, sauf badges et pills.
- **Palette** : utiliser fonds blancs/gris clairs avec textes noirs, accentuer via gradients arc-en-ciel (combinaisons `primary-*`).
- **Typo** : alterner serif (hero, valeurs) et sans serif (meta, boutons) pour contraste editorial.
- **Iconographie** : icones (SVG) heritent `currentColor`, adapter via `color: var(--primary-main)` sur les wrappers.
- **Animations** : preferer keyframes definis (`fadeIn`, `slideUp`, `scaleIn`, `float`, `particle-float`, `pulse-glow`, `gradient-slide`, `dropdown-appear`, `shimmer`). Respecter `prefers-reduced-motion`.

## 4. Composants derives du CSS

### 4.1 Hero Home (`.home-minimal`)
- Pleine hauteur, grille de fond (double linear-gradient) opacite 0.02 pour un pattern 80px.
- Particules (`.particle`) 3px, couleurs `primary-*`, animations asynchrones 12-18s.
- Logo : icone carre 56px gradient diagonal multi-tons, texte serif 56px, glow radial 300px (`pulse-glow`).
- CTA : `.action-button` bord 2px noir, pseudo-element `::before` noir coulissant sur hover, texte blanc a l'etat survole.
- Stats : `.home-stats` carte bord 2px noir, bande superieure gradient anime (`gradient-slide`), valeurs serif 28px, labels uppercase 11px.

### 4.2 Recherche
- `.search-bar` : input pill 56px, ombre `var(--shadow-card-glow)`, focus ring combine (shadow + outline 2px `--primary-main`).
- `.search-autocomplete` : input 64px bord 2px noir, droplist pleine largeur avec `dropdown-appear`. Items 64px de haut, highlight bar vertical 3px gradient purple->blue, avatar 48px cercle, score carre 36px bord noir.

### 4.3 Cartes influenceurs
- `.influencer-card` : carte blanche, rayon `var(--radius-card)` (definir ~12px si besoin), bande superieure gradient `primary-main` -> `accent-blue`.
- Avatar 120px cercle, badge score flottant 56px (animation `float`). Stats dans bande grise douce `var(--surface-card-soft)` radius tooltip.
- Tags : `.tag` border 1px noir, versions pleines (orange/blue/teal/yellow/red) utilisant tokens `primary-*`.

### 4.4 Panel info (`.influencer-info-panel`)
- Panneau lateral 450px fixe, bord gauche noir, bouton close carre 36px.
- Sections separentes par bordure `--border-subtle`. Grille stats 2 colonnes, cartes `surface-card-soft`.
- CTA principal : bouton plein noir, bord 1px noir, hover gris-800.

### 4.5 Page detail
- `.hero-section` gradient soft (blanc -> `surface-card-soft`), avatar 200px, stats pill, liens sociaux pills `primary-light`.
- `ScoreGauge` : barre 8px sur fond soft, remplissage degrade + effet shimmer.
- `news-item` : cartes timeline `surface-card-soft`, border-left 4px `--primary-main`, hover translation 4px.
- CTA general : boutons pill gradient `primary-main` -> `accent-blue`.

### 4.6 Page liste (`AllInfluencers`)
- Header titre 40px degrade `primary-main` -> `accent-blue`, sous-titre gris.
- Filtres : carte `surface-card`, rayon `radius-card`, tag cloud wrap, boutons inline type lien.
- Grille cartes : `grid-template-columns: repeat(auto-fill, minmax(320px, 1fr))`, gap `space-xl`.

### 4.7 Network Graph (UI 2D)
- Header sticky fond blanc, bord bas 1px noir. Boutons toggles border 1px noir, rayon nul.
- `graph-view-toggle` segments uppercase 12px. Boutons `graph-controls` 32px de haut, hover leger (etat hover + shadow-card).
- Overlays (`.map-overlay`, `.graph-legend`, `.map-tooltip`) : cartes blanches bord noir, rayon nul, typographie sans serif uppercase pour titres.
- Panneau info noeud : carte radius card, ombre glow, boutons pill (`view-profile-btn` gradient `primary-main`, `close` fond soft).
- Couleurs de nodes/legend : usent `currentColor` avec `box-shadow`.

## 5. Accessibilite et comportements
- Contraste minimum : textes primaires sur blanc >= 7:1 (noir). Les gradients accent doivent conserver texte blanc avec ombre.
- Mouvement : respecter media query `prefers-reduced-motion` (deja en place pour particules et glow).
- Focus states : reproduire combos `border + shadow` (`search-autocomplete-input:focus`, `action-button` hover).
- Responsive : a <768px, colonnes deviennent verticales (flex ou grid 1fr). Maintenir paddings `space-md`.

## 6. Checklist pour contributions IA
1. Ne pas utiliser la scene 3D ni `three-d-map` pour generer du contenu.
2. Reutiliser les tokens definis ci-dessus; si un token requis n'existe pas, l'ajouter dans `:root` en priorite.
3. Respecter les echelles d'espacement et la typographie (serif pour hero/stats, sans serif pour UI).
4. Maintenir bordures 1px noires et cartes blanches avec ombres subtiles.
5. Utiliser les animations utilitaires existantes plutot que de nouvelles definitions, sauf besoin justifie.

## 7. Directive `frontend-design`
- **But** : toute interface generee doit viser une qualite production avec un parti pris visuel fort (minimal brutaliste, luxe editorial, retro-futuriste, etc.). Identifier le contexte, le public et la contrainte avant de designer.
- **Axe creatif** : choisir une direction esthetique singuliere (jamais generique) et la pousser jusqu’au bout : compositions asymetriques, overlaps controles, fonds texturés, gradients mesh, etc.
- **Typographie** : privilegier des couples de polices distinctifs. On peut reutiliser `--font-serif` / `--font-sans` pour compatibilite, mais encourager l’introduction de nouvelles fontes premium (avec fallbacks web-safe) pour les projets futurs; bannir les combinaisons trop vues (Inter/Roboto/Arial sans personnalisation).
- **Palette** : sortir des purple gradients standard. Pour chaque brief, definir un trio couleur principal + accents. Documenter les nouveaux tokens couleur utilises.
- **Mouvement** : orchestrer quelques animations memorables (stagger reveal, transitions fluide) plutot qu’une pluie de micro-effets. Toujours respecter `prefers-reduced-motion`.
- **Composition** : alterner densite et vides, jouer avec diagonales, cartes superposees, bordures graphiques. Les layouts doivent surprendre tout en restant fonctionnels.
- **Memo** : ce skill remplace les esthetiques “AI slop”. Chaque livraison doit etre differenciée, raffinee et alignée avec les contraintes CSS presentes dans ce repo.

Ce document doit accompagner les prompts pour guider l'IA afin de produire des interfaces coherentes avec le CSS actuel, sans elements 3D.

