import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { SearchAutocomplete } from '../components/SearchAutocomplete';
import { influencers } from '../data/mockData';
import { Influencer } from '../types';
import { Sparkles, Map, BarChart3, Users } from 'lucide-react';
import './Home.css';

export const Home = () => {
  const navigate = useNavigate();

  const handleSelectInfluencer = (influencer: Influencer) => {
    // Navigate to graph with this influencer as center
    navigate(`/graph/${influencer.id}`);
  };

  const handleRandomInfluencer = () => {
    const randomInfluencer = influencers[Math.floor(Math.random() * influencers.length)];
    navigate(`/graph/${randomInfluencer.id}`);
  };

  const handleAllInfluencers = () => {
    navigate('/influencers');
  };

  return (
    <div className="home-minimal">
      {/* Particles background - reduced to 6 for performance */}
      <div className="particles-background">
        <div className="particle"></div>
        <div className="particle"></div>
        <div className="particle"></div>
        <div className="particle"></div>
        <div className="particle"></div>
        <div className="particle"></div>
      </div>

      <motion.div
        className="home-minimal-content"
        initial={{ opacity: 0, scale: 0.95 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.6 }}
      >
        {/* Logo */}
        <div className="logo-minimal">
          <div className="logo-minimal-icon">
            <Sparkles size={36} strokeWidth={2} />
          </div>
          <h1 className="logo-minimal-text">Starline</h1>
        </div>

        {/* Tagline */}
        <motion.p
          className="tagline-minimal"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.6, delay: 0.2 }}
        >
          Explorez l'univers des influenceurs et leurs connexions
        </motion.p>

        {/* Search */}
        <motion.div
          className="search-minimal"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.3 }}
        >
          <SearchAutocomplete
            influencers={influencers}
            onSelect={handleSelectInfluencer}
            placeholder="Rechercher un influenceur..."
          />
        </motion.div>

        {/* Action Buttons */}
        <motion.div
          className="actions-minimal"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6, delay: 0.4 }}
        >
          <button className="action-button" onClick={handleAllInfluencers}>
            <Users size={18} />
            <span>Tous les influenceurs</span>
          </button>
          <button className="action-button" onClick={handleRandomInfluencer}>
            <Map size={18} />
            <span>Réseau aléatoire</span>
          </button>
          <button className="action-button" onClick={() => navigate('/graph')}>
            <BarChart3 size={18} />
            <span>Vue d'ensemble</span>
          </button>
        </motion.div>

        {/* Stats or Info */}
        <motion.div
          className="home-stats"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.6, delay: 0.5 }}
        >
          <div className="home-stat-item">
            <span className="home-stat-value">{influencers.length}</span>
            <span className="home-stat-label">Influenceurs</span>
          </div>
          <div className="home-stat-divider"></div>
          <div className="home-stat-item">
            <span className="home-stat-value">
              {Math.round(influencers.reduce((sum, inf) => sum + inf.followers, 0) / 1000000)}M+
            </span>
            <span className="home-stat-label">Abonnés totaux</span>
          </div>
          <div className="home-stat-divider"></div>
          <div className="home-stat-item">
            <span className="home-stat-value">Temps réel</span>
            <span className="home-stat-label">Données actualisées</span>
          </div>
        </motion.div>
      </motion.div>
    </div>
  );
};
