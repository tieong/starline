import { motion } from 'framer-motion';
import { TrendingUp, TrendingDown, Minus, Users } from 'lucide-react';
import { Influencer } from '../types';
import { Tag } from './Tag';
import './InfluencerCard.css';

interface InfluencerCardProps {
  influencer: Influencer;
  onClick: () => void;
  delay?: number;
}

export const InfluencerCard = ({ influencer, onClick, delay = 0 }: InfluencerCardProps) => {
  const formatFollowers = (num: number) => {
    if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`;
    if (num >= 1000) return `${(num / 1000).toFixed(0)}K`;
    return num.toString();
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

  const getTrendIcon = () => {
    switch (influencer.influscoring.trend) {
      case 'up':
        return <TrendingUp size={16} className="trend-icon trend-up" />;
      case 'down':
        return <TrendingDown size={16} className="trend-icon trend-down" />;
      default:
        return <Minus size={16} className="trend-icon trend-stable" />;
    }
  };

  return (
    <motion.div
      className="influencer-card"
      onClick={onClick}
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.4, delay }}
      whileHover={{ y: -8, transition: { duration: 0.2 } }}
      whileTap={{ scale: 0.98 }}
    >
      <div className="card-header">
        <img src={influencer.avatar} alt={influencer.name} className="avatar" />
        <div
          className="score-badge score-badge-animated"
          style={{
            background: getScoreGradient(influencer.influscoring.overall),
            backgroundSize: '200% 200%'
          }}
        >
          <span className="score-value">{influencer.influscoring.overall}</span>
          {getTrendIcon()}
        </div>
      </div>

      <div className="card-content">
        <h3 className="influencer-name">{influencer.name}</h3>
        <p className="influencer-handle">{influencer.handle}</p>

        <div className="stats">
          <div className="stat">
            <Users size={14} />
            <span>{formatFollowers(influencer.followers)}</span>
          </div>
          <div className="stat">
            <span className="stat-label">Engagement</span>
            <span className="stat-value">{influencer.engagementRate.toFixed(2)}%</span>
          </div>
        </div>

        <div className="tags">
          {influencer.niche.slice(0, 3).map((tag, index) => (
            <Tag key={index} variant="default" size="small">
              {tag}
            </Tag>
          ))}
        </div>

        {influencer.agency && (
          <div className="agency">
            <span className="agency-icon">🏢</span>
            <span className="agency-name">{influencer.agency}</span>
          </div>
        )}
      </div>
    </motion.div>
  );
};
