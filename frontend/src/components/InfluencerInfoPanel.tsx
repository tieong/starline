import { motion } from 'framer-motion';
import { X, Users, TrendingUp, ExternalLink, Eye, Heart, CheckCircle, BarChart3, Search, Building2 } from 'lucide-react';
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

  const getScoreGradient = (score: number) => {
    // Gradient animé selon le score - version lumineuse et colorée
    if (score >= 85) {
      // Excellent: vert émeraude lumineux
      return 'linear-gradient(135deg, #34D399, #10B981, #6EE7B7, #A7F3D0)';
    } else if (score >= 70) {
      // Bon: bleu ciel vibrant
      return 'linear-gradient(135deg, #60A5FA, #3B82F6, #93C5FD, #BFDBFE)';
    } else if (score >= 50) {
      // Moyen: jaune/orange lumineux
      return 'linear-gradient(135deg, #FBBF24, #F59E0B, #FCD34D, #FDE68A)';
    } else {
      // Faible: rouge corail
      return 'linear-gradient(135deg, #F87171, #EF4444, #FCA5A5, #FECACA)';
    }
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
        <h2>Influencer Profile</h2>
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
              <Building2 size={16} />
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
          <h4 className="panel-section-title">Key stats</h4>
          <div className="panel-stats-grid">
            <div className="panel-stat">
              <Users size={20} />
              <div>
                <div className="panel-stat-value">{formatFollowers(influencer.followers)}</div>
                <div className="panel-stat-label">Followers</div>
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
                <div className="panel-stat-label">Avg views</div>
              </div>
            </div>
            <div className="panel-stat">
              <Heart size={20} />
              <div>
                <div className="panel-stat-value">{formatNumber(influencer.stats.avgLikes)}</div>
                <div className="panel-stat-label">Avg likes</div>
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
            <div 
              className="panel-score-circle panel-score-circle-animated"
              style={{
                background: getScoreGradient(influencer.influscoring.overall),
                backgroundSize: '200% 200%'
              }}
            >
              <span className="panel-score-number">{influencer.influscoring.overall}</span>
            </div>
            <span className="panel-score-label">Overall score</span>
          </div>
          <div className="panel-scores">
            <div className="panel-score-item">
              <div className="panel-score-label-wrapper">
                <CheckCircle size={16} />
                <span>Reliability</span>
              </div>
              <ScoreGauge
                label=""
                value={influencer.influscoring.reliability}
                showValue={true}
              />
            </div>
            <div className="panel-score-item">
              <div className="panel-score-label-wrapper">
                <BarChart3 size={16} />
                <span>Authenticity</span>
              </div>
              <ScoreGauge
                label=""
                value={influencer.influscoring.authenticity}
                showValue={true}
              />
            </div>
            <div className="panel-score-item">
              <div className="panel-score-label-wrapper">
                <Search size={16} />
                <span>Reputation</span>
              </div>
              <ScoreGauge
                label=""
                value={influencer.influscoring.reputation}
                showValue={true}
              />
            </div>
          </div>
        </div>

        {/* Social Links */}
        {Object.keys(influencer.socialLinks).length > 0 && (
          <div className="panel-section">
            <h4 className="panel-section-title">Social networks</h4>
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
          View full profile
        </button>
      </div>
    </motion.div>
  );
};
