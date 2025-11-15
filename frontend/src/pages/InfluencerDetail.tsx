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
  ExternalLink,
  TrendingUp as TrendIcon,
  MessageCircle,
  Globe
} from 'lucide-react';
import { influencers, products, newsItems, socialComments } from '../data/mockData';
import { Tag } from '../components/Tag';
import { ScoreGauge } from '../components/ScoreGauge';
import { InfluencerComparison } from '../components/InfluencerComparison';
import { NetworkConnections } from '../components/NetworkConnections';
import { SocialComments } from '../components/SocialComments';
import { PlatformPresence } from '../components/PlatformPresence';
import './InfluencerDetail.css';

export const InfluencerDetail = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();

  const influencer = influencers.find(inf => inf.id === id);
  const influencerProducts = products.filter(p => p.influencerId === id);
  const influencerNews = newsItems.filter(n => n.influencerId === id);
  const influencerComments = socialComments.filter(c => c.influencerId === id);

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
        <div className="hero-gradient-bar" />
        <div className="hero-content">
          <div className="hero-left">
            <div className="hero-avatar-wrapper">
              <img src={influencer.avatar} alt={influencer.name} className="hero-avatar" />
              <div className="hero-score-badge">
                <span className="hero-score-value">{influencer.influscoring.overall}</span>
                <span className="hero-score-label">Score</span>
              </div>
            </div>
          </div>

          <div className="hero-info">
            <div className="hero-header">
              <div>
                <h1 className="hero-name">{influencer.name}</h1>
                <p className="hero-handle">{influencer.handle}</p>
              </div>
              {influencer.agency && (
                <div className="hero-agency-badge">
                  <span className="agency-label">Agence</span>
                  <span className="agency-name">{influencer.agency}</span>
                </div>
              )}
            </div>

            <p className="hero-bio">{influencer.bio}</p>

            <div className="hero-stats-grid">
              <div className="hero-stat-card">
                <Users size={20} className="stat-icon" />
                <div className="stat-content">
                  <div className="hero-stat-value">{formatFollowers(influencer.followers)}</div>
                  <div className="hero-stat-label">Abonnés</div>
                </div>
              </div>
              <div className="hero-stat-card">
                <TrendingUp size={20} className="stat-icon" />
                <div className="stat-content">
                  <div className="hero-stat-value">{influencer.engagementRate}%</div>
                  <div className="hero-stat-label">Engagement</div>
                </div>
              </div>
              <div className="hero-stat-card">
                <TrendIcon size={20} className="stat-icon" />
                <div className="stat-content">
                  <div className="hero-stat-value">{formatFollowers(influencer.stats.avgViews)}</div>
                  <div className="hero-stat-label">Vues moy.</div>
                </div>
              </div>
              <div className="hero-stat-card">
                <Package size={20} className="stat-icon" />
                <div className="stat-content">
                  <div className="hero-stat-value">{influencer.stats.postingFrequency}</div>
                  <div className="hero-stat-label">Fréquence</div>
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

      {/* Subscriber Growth Chart with Comparison */}
      {influencer.subscriberGrowth && influencer.subscriberGrowth.length > 0 && (
        <motion.section
          className="section chart-section"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
        >
          <InfluencerComparison
            currentInfluencer={influencer}
            allInfluencers={influencers}
          />
        </motion.section>
      )}

      {/* Two Column Layout */}
      <div className="detail-two-column">
        {/* Left Column */}
        <div className="detail-column-left">
          {/* Network Connections */}
          {influencer.networkConnections && influencer.networkConnections.length > 0 && (
            <motion.section
              className="section network-section"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5, delay: 0.2 }}
            >
              <div className="section-header">
                <Network className="section-icon" size={28} />
                <div className="section-header-text">
                  <h2>Network Connections</h2>
                  <p className="section-subtitle">Click on influencer nodes to navigate</p>
                </div>
              </div>
              <NetworkConnections connections={influencer.networkConnections} />
            </motion.section>
          )}
        </div>

        {/* Right Column */}
        <div className="detail-column-right">
          {/* Products Section */}
          {influencerProducts.length > 0 && (
            <motion.section
              className="section products-section"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5, delay: 0.3 }}
            >
              <div className="section-header">
                <Package className="section-icon" size={28} />
                <div className="section-header-text">
                  <h2>Products & Sponsorships</h2>
                  <p className="section-subtitle">{influencerProducts.length} produit{influencerProducts.length > 1 ? 's' : ''}</p>
                </div>
              </div>
              <div className="products-list">
                {influencerProducts.slice(0, 3).map((product, index) => (
                  <motion.div
                    key={product.id}
                    className="product-item"
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ delay: index * 0.1 }}
                  >
                    <div className="product-compact-info">
                      <div className="product-compact-header">
                        <h4 className="product-compact-name">{product.name}</h4>
                        <Tag variant={product.status === 'active' ? 'teal' : 'default'} size="small">
                          {product.status === 'active' ? 'Active' : 'Ended'}
                        </Tag>
                      </div>
                      <p className="product-compact-brand">{product.brand}</p>
                      {product.price && (
                        <p className="product-compact-price">${product.price.toFixed(2)}</p>
                      )}
                    </div>
                  </motion.div>
                ))}
              </div>
            </motion.section>
          )}

          {/* User Comments from Social Media */}
          {influencerComments.length > 0 && (
            <motion.section
              className="section comments-section"
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5, delay: 0.4 }}
            >
              <div className="section-header">
                <MessageCircle className="section-icon" size={28} />
                <div className="section-header-text">
                  <h2>User Comments from Social Media</h2>
                  <p className="section-subtitle">{influencerComments.length} comment{influencerComments.length > 1 ? 's' : ''}</p>
                </div>
              </div>
              <SocialComments comments={influencerComments} />
            </motion.section>
          )}
        </div>
      </div>

      {/* Platform Presence */}
      {influencer.platformPresence && influencer.platformPresence.length > 0 && (
        <motion.section
          className="section platform-section"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.5 }}
        >
          <div className="section-header">
            <Globe className="section-icon" size={28} />
            <div className="section-header-text">
              <h2>Platform Presence</h2>
              <p className="section-subtitle">{influencer.platformPresence.length} plateformes</p>
            </div>
          </div>
          <PlatformPresence platforms={influencer.platformPresence} />
        </motion.section>
      )}

      {/* News Timeline */}
      {influencerNews.length > 0 && (
        <motion.section
          className="section news-section"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5, delay: 0.4 }}
        >
          <div className="section-header">
            <Newspaper className="section-icon" size={28} />
            <div className="section-header-text">
              <h2>Actualités & Timeline</h2>
              <p className="section-subtitle">{influencerNews.length} événement{influencerNews.length > 1 ? 's' : ''} récent{influencerNews.length > 1 ? 's' : ''}</p>
            </div>
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
                <div className="news-marker" />
                <div className="news-content">
                  <div className="news-header">
                    <div className="news-title-row">
                      <h3 className="news-title">{news.title}</h3>
                      <div className="news-meta">
                        <Tag variant={getSeverityColor(news.severity)} size="small">
                          {news.type}
                        </Tag>
                      </div>
                    </div>
                    <span className="news-date">
                      {new Date(news.date).toLocaleDateString('fr-FR', {
                        day: 'numeric',
                        month: 'long',
                        year: 'numeric'
                      })}
                    </span>
                  </div>
                  <p className="news-description">{news.description}</p>
                  {news.source && (
                    <p className="news-source">Source · {news.source}</p>
                  )}
                </div>
              </motion.div>
            ))}
          </div>
        </motion.section>
      )}

    </div>
  );
};
