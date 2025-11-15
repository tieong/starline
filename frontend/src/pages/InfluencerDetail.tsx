import { useParams, useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import {
  ArrowLeft,
  Users,
  TrendingUp,
  Shield,
  Package,
  Newspaper,
  Network,
  ExternalLink
} from 'lucide-react';
import { influencers, products, newsItems } from '../data/mockData';
import { Tag } from '../components/Tag';
import { ScoreGauge } from '../components/ScoreGauge';
import './InfluencerDetail.css';

export const InfluencerDetail = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();

  const influencer = influencers.find(inf => inf.id === id);
  const influencerProducts = products.filter(p => p.influencerId === id);
  const influencerNews = newsItems.filter(n => n.influencerId === id);

  if (!influencer) {
    return (
      <div className="not-found">
        <h2>Influenceur non trouvé</h2>
        <button onClick={() => navigate('/')}>Retour à l'accueil</button>
      </div>
    );
  }

  const formatFollowers = (num: number) => {
    if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`;
    if (num >= 1000) return `${(num / 1000).toFixed(0)}K`;
    return num.toString();
  };

  const getNewsIcon = (type: string) => {
    switch (type) {
      case 'drama':
        return '⚠️';
      case 'partnership':
        return '🤝';
      case 'milestone':
        return '🎉';
      default:
        return '📰';
    }
  };

  const getSeverityColor = (severity?: string) => {
    switch (severity) {
      case 'high':
        return 'red';
      case 'medium':
        return 'yellow';
      case 'low':
        return 'blue';
      default:
        return 'default';
    }
  };

  return (
    <div className="influencer-detail">
      <motion.button
        className="back-button"
        onClick={() => navigate('/')}
        initial={{ opacity: 0, x: -20 }}
        animate={{ opacity: 1, x: 0 }}
        whileHover={{ x: -5 }}
      >
        <ArrowLeft size={20} />
        <span>Retour</span>
      </motion.button>

      {/* Hero Section */}
      <motion.section
        className="hero-section"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        <div className="hero-content">
          <img src={influencer.avatar} alt={influencer.name} className="hero-avatar" />
          <div className="hero-info">
            <h1 className="hero-name">{influencer.name}</h1>
            <p className="hero-handle">{influencer.handle}</p>
            <p className="hero-bio">{influencer.bio}</p>

            <div className="hero-stats">
              <div className="hero-stat">
                <Users size={24} />
                <div>
                  <div className="hero-stat-value">{formatFollowers(influencer.followers)}</div>
                  <div className="hero-stat-label">Abonnés</div>
                </div>
              </div>
              <div className="hero-stat">
                <TrendingUp size={24} />
                <div>
                  <div className="hero-stat-value">{influencer.engagementRate}%</div>
                  <div className="hero-stat-label">Engagement</div>
                </div>
              </div>
            </div>

            <div className="hero-tags">
              {influencer.niche.map((tag, index) => (
                <Tag key={index} variant="blue" size="medium">
                  {tag}
                </Tag>
              ))}
            </div>

            <div className="social-links">
              {Object.entries(influencer.socialLinks).map(([platform, username]) => (
                <a
                  key={platform}
                  href={`https://${platform}.com/${username}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="social-link"
                >
                  <span className="social-platform">{platform}</span>
                  <ExternalLink size={14} />
                </a>
              ))}
            </div>
          </div>
        </div>
      </motion.section>

      {/* InfluScoring Section */}
      <motion.section
        className="section scoring-section"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5, delay: 0.1 }}
      >
        <div className="section-header">
          <Shield className="section-icon" />
          <h2>InfluScoring</h2>
        </div>
        <div className="scoring-content">
          <div className="overall-score">
            <div className="overall-score-circle">
              <motion.svg viewBox="0 0 200 200" className="score-ring">
                <circle
                  cx="100"
                  cy="100"
                  r="90"
                  fill="none"
                  stroke="var(--surface-card-soft)"
                  strokeWidth="12"
                />
                <motion.circle
                  cx="100"
                  cy="100"
                  r="90"
                  fill="none"
                  stroke="var(--primary-main)"
                  strokeWidth="12"
                  strokeLinecap="round"
                  strokeDasharray={`${2 * Math.PI * 90}`}
                  initial={{ strokeDashoffset: 2 * Math.PI * 90 }}
                  animate={{
                    strokeDashoffset: 2 * Math.PI * 90 * (1 - influencer.influscoring.overall / 100)
                  }}
                  transition={{ duration: 1.5, ease: 'easeOut' }}
                  style={{ transform: 'rotate(-90deg)', transformOrigin: 'center' }}
                />
              </motion.svg>
              <div className="score-number">{influencer.influscoring.overall}</div>
            </div>
            <div className="overall-score-label">Score Global</div>
          </div>

          <div className="score-details">
            <ScoreGauge
              label="✅ Fiabilité"
              value={influencer.influscoring.reliability}
            />
            <ScoreGauge
              label="⚠️ Controverses"
              value={100 - influencer.influscoring.controversies}
              color={
                influencer.influscoring.controversies < 20
                  ? 'var(--accent-teal)'
                  : influencer.influscoring.controversies < 50
                  ? 'var(--accent-yellow)'
                  : 'var(--accent-red)'
              }
            />
            <ScoreGauge
              label="📊 Authenticité"
              value={influencer.influscoring.authenticity}
            />
            <ScoreGauge
              label="🔍 Réputation"
              value={influencer.influscoring.reputation}
            />
            <ScoreGauge
              label="💼 Professionnalisme"
              value={influencer.influscoring.professionalism}
            />
          </div>
        </div>
      </motion.section>

      {/* Products Section */}
      {influencerProducts.length > 0 && (
        <motion.section
          className="section products-section"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.2 }}
        >
          <div className="section-header">
            <Package className="section-icon" />
            <h2>Produits & Collaborations</h2>
          </div>
          <div className="products-grid">
            {influencerProducts.map((product, index) => (
              <motion.div
                key={product.id}
                className="product-card"
                initial={{ opacity: 0, scale: 0.9 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: index * 0.1 }}
                whileHover={{ y: -5 }}
              >
                <img src={product.image} alt={product.name} className="product-image" />
                <div className="product-info">
                  <h3 className="product-name">{product.name}</h3>
                  <p className="product-brand">{product.brand}</p>
                  {product.price && (
                    <p className="product-price">{product.price.toFixed(2)}€</p>
                  )}
                  {product.promoCode && (
                    <Tag variant="orange" size="small">
                      Code: {product.promoCode}
                    </Tag>
                  )}
                  <Tag variant={product.status === 'active' ? 'teal' : 'default'} size="small">
                    {product.status === 'active' ? 'Actif' : 'Terminé'}
                  </Tag>
                </div>
              </motion.div>
            ))}
          </div>
        </motion.section>
      )}

      {/* News Timeline */}
      {influencerNews.length > 0 && (
        <motion.section
          className="section news-section"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.3 }}
        >
          <div className="section-header">
            <Newspaper className="section-icon" />
            <h2>Actualités & Timeline</h2>
          </div>
          <div className="news-timeline">
            {influencerNews.map((news, index) => (
              <motion.div
                key={news.id}
                className="news-item"
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.1 }}
              >
                <div className="news-icon">{getNewsIcon(news.type)}</div>
                <div className="news-content">
                  <div className="news-header">
                    <h3 className="news-title">{news.title}</h3>
                    <div className="news-meta">
                      <Tag variant={getSeverityColor(news.severity)} size="small">
                        {news.type}
                      </Tag>
                      <span className="news-date">
                        {new Date(news.date).toLocaleDateString('fr-FR')}
                      </span>
                    </div>
                  </div>
                  <p className="news-description">{news.description}</p>
                  {news.source && (
                    <p className="news-source">Source: {news.source}</p>
                  )}
                </div>
              </motion.div>
            ))}
          </div>
        </motion.section>
      )}

      {/* Relationship Graph Teaser */}
      <motion.section
        className="section graph-section"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5, delay: 0.4 }}
      >
        <div className="section-header">
          <Network className="section-icon" />
          <h2>Réseau & Relations</h2>
        </div>
        <div className="graph-teaser">
          <p>Explorez le réseau de {influencer.name} et ses connexions avec d'autres influenceurs, agences et marques.</p>
          <button className="cta-button" onClick={() => navigate(`/graph/${influencer.id}`)}>
            Voir le graphe interactif
          </button>
        </div>
      </motion.section>
    </div>
  );
};
