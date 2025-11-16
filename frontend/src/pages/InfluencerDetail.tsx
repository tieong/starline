import { useState, useEffect } from 'react';
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
  Globe,
  Loader2,
  Sparkles
} from 'lucide-react';
import { DataSourceToggle } from '../components/DataSourceToggle';
import { dataService } from '../services/dataService';
import { apiService } from '../services/api';
import { useDataContext } from '../context/DataContext';
import { Influencer, Product, NewsItem, SocialComment } from '../types';
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
  const { useMockData } = useDataContext();

  const [influencer, setInfluencer] = useState<Influencer | null>(null);
  const [influencerProducts, setInfluencerProducts] = useState<Product[]>([]);
  const [influencerNews, setInfluencerNews] = useState<NewsItem[]>([]);
  const [influencerTimeline, setInfluencerTimeline] = useState<any[]>([]);
  const [influencerComments, setInfluencerComments] = useState<SocialComment[]>([]);
  const [allInfluencers, setAllInfluencers] = useState<Influencer[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [fetchingNews, setFetchingNews] = useState(false);
  const [fetchingTimeline, setFetchingTimeline] = useState(false);
  const [fetchingReputation, setFetchingReputation] = useState(false);

  // Handler to fetch news on-demand
  const handleFetchNews = async () => {
    if (!id || useMockData) return;
    setFetchingNews(true);
    try {
      await apiService.fetchNews(parseInt(id));
      const news = await dataService.getNewsItems(useMockData, parseInt(id));
      setInfluencerNews(news);
    } catch (error) {
      console.error('Failed to fetch news:', error);
    } finally {
      setFetchingNews(false);
    }
  };

  // Handler to fetch reputation on-demand
  const handleFetchReputation = async () => {
    if (!id || useMockData) return;
    setFetchingReputation(true);
    try {
      await apiService.fetchReputation(parseInt(id));
      const comments = await dataService.getSocialComments(useMockData, parseInt(id));
      setInfluencerComments(comments);
    } catch (error) {
      console.error('Failed to fetch reputation:', error);
    } finally {
      setFetchingReputation(false);
    }
  };

  // Handler to fetch timeline on-demand
  const handleFetchTimeline = async () => {
    if (!id || useMockData) return;
    setFetchingTimeline(true);
    try {
      await apiService.fetchTimeline(parseInt(id));
      const timeline = await apiService.getInfluencerTimeline(parseInt(id));
      setInfluencerTimeline(timeline);
    } catch (error) {
      console.error('Failed to fetch timeline:', error);
    } finally {
      setFetchingTimeline(false);
    }
  };

  // Load influencer data when ID or data source changes
  useEffect(() => {
    const loadInfluencer = async () => {
      if (!id) return;

      setLoading(true);
      setError(null);
      try {
        const influencerId = useMockData ? id : parseInt(id);
        const influencerData = await dataService.getInfluencer(useMockData, influencerId);

        if (!influencerData) {
          setError('Influencer not found');
          return;
        }

        setInfluencer(influencerData);

        // Load related data and influencers for comparison
        const [products, news, comments, influencersForComparison, timeline] = await Promise.all([
          dataService.getProducts(useMockData, influencerId),
          dataService.getNewsItems(useMockData, influencerId),
          dataService.getSocialComments(useMockData, influencerId),
          dataService.getInfluencers(useMockData),
          useMockData ? Promise.resolve([]) : apiService.getInfluencerTimeline(influencerId).catch(() => []),
        ]);

        setInfluencerProducts(products);
        setInfluencerNews(news);
        setInfluencerComments(comments);
        setAllInfluencers(influencersForComparison);
        setInfluencerTimeline(timeline);

        // Auto-fetch news, reputation, and timeline if empty in API mode
        if (!useMockData) {
          // Trigger news fetch if empty
          if (news.length === 0) {
            handleFetchNews();
          }

          // Trigger reputation fetch if empty
          if (comments.length === 0) {
            handleFetchReputation();
          }

          // Trigger timeline fetch if empty
          if (timeline.length === 0) {
            handleFetchTimeline();
          }
        }
      } catch (err) {
        console.error('Failed to load influencer:', err);
        setError('Failed to load influencer data');
      } finally {
        setLoading(false);
      }
    };

    loadInfluencer();
  }, [id, useMockData]);

  if (loading) {
    return (
      <div className="influencer-detail">
        <div className="loading-state">
          <h2>Loading influencer...</h2>
        </div>
      </div>
    );
  }

  if (error || !influencer) {
    return (
      <div className="not-found">
        <h2>{error || 'Influencer not found'}</h2>
        <button onClick={() => navigate('/')}>Back to home</button>
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
      {/* Data Source Toggle */}
      <div className="data-source-toggle-container">
        <DataSourceToggle />
      </div>

      <motion.button
        className="back-button"
        onClick={() => navigate('/')}
        initial={{ opacity: 0, x: -20 }}
        animate={{ opacity: 1, x: 0 }}
      >
        <ArrowLeft size={20} />
        <span>Back</span>
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
                  <span className="agency-label">Agency</span>
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
                  <div className="hero-stat-label">Followers</div>
                </div>
              </div>
              <div className="hero-stat-card">
                <TrendingUp size={20} className="stat-icon" />
                <div className="stat-content">
                  <div className="hero-stat-value">{influencer.engagementRate.toFixed(2)}%</div>
                  <div className="hero-stat-label">Engagement</div>
                </div>
              </div>
              <div className="hero-stat-card">
                <TrendIcon size={20} className="stat-icon" />
                <div className="stat-content">
                  <div className="hero-stat-value">{formatFollowers(influencer.stats.avgViews)}</div>
                  <div className="hero-stat-label">Avg views</div>
                </div>
              </div>
              <div className="hero-stat-card">
                <Package size={20} className="stat-icon" />
                <div className="stat-content">
                  <div className="hero-stat-value">{influencer.stats.postingFrequency}</div>
                  <div className="hero-stat-label">Frequency</div>
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
            allInfluencers={allInfluencers}
          />
        </motion.section>
      )}

      {/* News Timeline - Shown First */}
      <motion.section
        className="section news-section"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5, delay: 0.15 }}
      >
        <div className="section-header">
          <Newspaper className="section-icon" size={28} />
          <div className="section-header-text">
            <h2>News & Timeline</h2>
            {(influencerNews.length > 0 || influencerTimeline.length > 0) && (
              <p className="section-subtitle">
                {influencerNews.length + influencerTimeline.length} recent event{influencerNews.length + influencerTimeline.length > 1 ? 's' : ''}
              </p>
            )}
          </div>
        </div>
        {(fetchingNews || fetchingTimeline) ? (
          <div className="empty-state">
            <Loader2 className="empty-state-icon spinning" size={48} />
            <h3 className="empty-state-title">Analysis in progress...</h3>
            <p className="empty-state-description">
              Searching for recent news and events
            </p>
          </div>
        ) : (influencerNews.length === 0 && influencerTimeline.length === 0) ? (
          <div className="empty-state">
            <Newspaper className="empty-state-icon" size={48} />
            <h3 className="empty-state-title">No news available</h3>
            <p className="empty-state-description">
              {useMockData
                ? "No news is available in the demo data"
                : "Fetch the latest news and events for this influencer"}
            </p>
            {!useMockData && (
              <button className="analyze-button" onClick={handleFetchNews}>
                <Sparkles size={20} />
                <span>Fetch news</span>
              </button>
            )}
          </div>
        ) : (
          <div className="news-timeline">
            {/* Combine and sort news items and timeline events by date */}
            {[
              ...influencerNews.map(news => ({ ...news, source_type: 'news' })),
              ...influencerTimeline.map(event => ({
                ...event,
                source_type: 'timeline',
                // Map timeline fields to news fields for consistent display
                title: event.event || event.title,
                description: event.description || event.summary,
                date: event.date || event.timestamp,
                type: event.event_type || event.type || 'event',
              }))
            ]
              .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
              .map((item, index) => (
                <motion.div
                  key={`${item.source_type}-${item.id || index}`}
                  className="news-item"
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: index * 0.1 }}
                >
                  <div className="news-marker" />
                  <div className="news-content">
                    <div className="news-header">
                      <div className="news-title-row">
                        <h3 className="news-title">{item.title}</h3>
                        <div className="news-meta">
                          <Tag variant={getSeverityColor(item.severity)} size="small">
                            {item.type}
                          </Tag>
                        </div>
                      </div>
                      <span className="news-date">
                        {new Date(item.date).toLocaleDateString('en-US', {
                          day: 'numeric',
                          month: 'long',
                          year: 'numeric'
                        })}
                      </span>
                    </div>
                    <p className="news-description">{item.description}</p>
                    {item.source && (
                      <p className="news-source">Source · {item.source}</p>
                    )}
                  </div>
                </motion.div>
              ))}
          </div>
        )}
      </motion.section>

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
                    <p className="section-subtitle">{influencerProducts.length} product{influencerProducts.length > 1 ? 's' : ''}</p>
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
                      {product.price && typeof product.price === 'number' && (
                        <p className="product-compact-price">${product.price.toFixed(2)}</p>
                      )}
                    </div>
                  </motion.div>
                ))}
              </div>
            </motion.section>
          )}

          {/* User Comments from Social Media */}
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
                {influencerComments.length > 0 && (
                  <p className="section-subtitle">{influencerComments.length} comment{influencerComments.length > 1 ? 's' : ''}</p>
                )}
              </div>
            </div>
            {fetchingReputation ? (
              <div className="empty-state">
                <Loader2 className="empty-state-icon spinning" size={48} />
                <h3 className="empty-state-title">Analysis in progress...</h3>
                <p className="empty-state-description">
                  Gathering comments from social media
                </p>
              </div>
            ) : influencerComments.length === 0 ? (
              <div className="empty-state">
                <MessageCircle className="empty-state-icon" size={48} />
                <h3 className="empty-state-title">No comments available</h3>
                <p className="empty-state-description">
                  {useMockData
                    ? "No comments are available in the demo data"
                    : "Analyze this influencer's reputation on social media"}
                </p>
                {!useMockData && (
                  <button className="analyze-button" onClick={handleFetchReputation}>
                    <Sparkles size={20} />
                    <span>Analyze reputation</span>
                  </button>
                )}
              </div>
            ) : (
              <SocialComments comments={influencerComments} />
            )}
          </motion.section>
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
              <p className="section-subtitle">{influencer.platformPresence.length} platforms</p>
            </div>
          </div>
          <PlatformPresence platforms={influencer.platformPresence} />
        </motion.section>
      )}

    </div>
  );
};
