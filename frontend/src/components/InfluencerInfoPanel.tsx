import { motion } from 'framer-motion';
import { X, Users, TrendingUp, ExternalLink, Eye, Heart } from 'lucide-react';
import { Influencer } from '../types';
import { Tag } from './Tag';
import { ScoreGauge } from './ScoreGauge';
import './InfluencerInfoPanel.css';

interface InfluencerInfoPanelProps {
  influencer: Influencer;
  onClose: () => void;
  onViewProfile: () => void;
}

export const InfluencerInfoPanel = ({
  influencer,
  onClose,
  onViewProfile
}: InfluencerInfoPanelProps) => {
  const formatFollowers = (num: number) => {
    if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`;
    if (num >= 1000) return `${(num / 1000).toFixed(0)}K`;
    return num.toString();
  };

  const formatNumber = (num: number) => {
    return num.toLocaleString('fr-FR');
  };

  return (
    <motion.div
      className="influencer-info-panel"
      initial={{ opacity: 0, x: 400 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: 400 }}
      transition={{ type: 'spring', damping: 25, stiffness: 200 }}
    >
      <div className="panel-header">
        <h2>Profil Influenceur</h2>
        <button onClick={onClose} className="close-button">
          <X size={20} />
        </button>
      </div>

      <div className="panel-content">
        {/* Avatar and Basic Info */}
        <div className="panel-hero">
          <img src={influencer.avatar} alt={influencer.name} className="panel-avatar" />
          <h3 className="panel-name">{influencer.name}</h3>
          <p className="panel-handle">{influencer.handle}</p>
          {influencer.agency && (
            <div className="panel-agency">
              <span>🏢</span>
              <span>{influencer.agency}</span>
            </div>
          )}
        </div>

        {/* Bio */}
        <div className="panel-section">
          <p className="panel-bio">{influencer.bio}</p>
        </div>

        {/* Main Stats */}
        <div className="panel-section">
          <h4 className="panel-section-title">Statistiques principales</h4>
          <div className="panel-stats-grid">
            <div className="panel-stat">
              <Users size={20} />
              <div>
                <div className="panel-stat-value">{formatFollowers(influencer.followers)}</div>
                <div className="panel-stat-label">Abonnés</div>
              </div>
            </div>
            <div className="panel-stat">
              <TrendingUp size={20} />
              <div>
                <div className="panel-stat-value">{influencer.engagementRate.toFixed(2)}%</div>
                <div className="panel-stat-label">Engagement</div>
              </div>
            </div>
            <div className="panel-stat">
              <Eye size={20} />
              <div>
                <div className="panel-stat-value">{formatNumber(influencer.stats.avgViews)}</div>
                <div className="panel-stat-label">Vues moyennes</div>
              </div>
            </div>
            <div className="panel-stat">
              <Heart size={20} />
              <div>
                <div className="panel-stat-value">{formatNumber(influencer.stats.avgLikes)}</div>
                <div className="panel-stat-label">Likes moyens</div>
              </div>
            </div>
          </div>
        </div>

        {/* Niches */}
        <div className="panel-section">
          <h4 className="panel-section-title">Niches</h4>
          <div className="panel-tags">
            {influencer.niche.map((tag, index) => (
              <Tag key={index} variant="blue" size="medium">
                {tag}
              </Tag>
            ))}
          </div>
        </div>

        {/* InfluScoring */}
        <div className="panel-section">
          <h4 className="panel-section-title">InfluScoring</h4>
          <div className="panel-overall-score">
            <div className="panel-score-circle">
              <span className="panel-score-number">{influencer.influscoring.overall}</span>
            </div>
            <span className="panel-score-label">Score Global</span>
          </div>
          <div className="panel-scores">
            <ScoreGauge
              label="✅ Fiabilité"
              value={influencer.influscoring.reliability}
              showValue={false}
            />
            <ScoreGauge
              label="📊 Authenticité"
              value={influencer.influscoring.authenticity}
              showValue={false}
            />
            <ScoreGauge
              label="🔍 Réputation"
              value={influencer.influscoring.reputation}
              showValue={false}
            />
          </div>
        </div>

        {/* Social Links */}
        {Object.keys(influencer.socialLinks).length > 0 && (
          <div className="panel-section">
            <h4 className="panel-section-title">Réseaux sociaux</h4>
            <div className="panel-social-links">
              {Object.entries(influencer.socialLinks).map(([platform, username]) => (
                <a
                  key={platform}
                  href={`https://${platform}.com/${username}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="panel-social-link"
                >
                  <span className="panel-social-platform">{platform}</span>
                  <ExternalLink size={14} />
                </a>
              ))}
            </div>
          </div>
        )}

        {/* CTA Button */}
        <button className="panel-cta-button" onClick={onViewProfile}>
          Voir le profil complet
        </button>
      </div>
    </motion.div>
  );
};
