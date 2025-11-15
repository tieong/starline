import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import { SearchBar } from '../components/SearchBar';
import { InfluencerCard } from '../components/InfluencerCard';
import { Tag } from '../components/Tag';
import { influencers } from '../data/mockData';
import { ArrowLeft, Filter } from 'lucide-react';
import './AllInfluencers.css';

export const AllInfluencers = () => {
  const navigate = useNavigate();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedNiche, setSelectedNiche] = useState<string | null>(null);

  const allNiches = Array.from(
    new Set(influencers.flatMap(inf => inf.niche))
  ).sort();

  const filteredInfluencers = influencers.filter(inf => {
    const matchesSearch = inf.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
                         inf.handle.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesNiche = !selectedNiche || inf.niche.includes(selectedNiche);
    return matchesSearch && matchesNiche;
  });

  const datasetForInsights = filteredInfluencers.length > 0 ? filteredInfluencers : influencers;
  const datasetSize = datasetForInsights.length || 1;
  const averageScore = Math.round(
    datasetForInsights.reduce((sum, inf) => sum + inf.influscoring.overall, 0) / datasetSize
  );
  const averageEngagementRate = (
    datasetForInsights.reduce((sum, inf) => sum + inf.engagementRate, 0) / datasetSize
  ).toFixed(1);
  const totalFollowersDisplayed = new Intl.NumberFormat('fr-FR', {
    notation: 'compact',
    maximumFractionDigits: 1
  }).format(datasetForInsights.reduce((sum, inf) => sum + inf.followers, 0));
  const activeFilterLabel = selectedNiche ?? 'Toutes les niches';

  return (
    <div className="all-influencers">
      <motion.button
        className="back-button-top"
        onClick={() => navigate('/')}
        initial={{ opacity: 0, x: -20 }}
        animate={{ opacity: 1, x: 0 }}
        whileHover={{ x: -5 }}
      >
        <ArrowLeft size={20} />
        <span>Retour</span>
      </motion.button>

      <motion.header
        className="all-influencers-header"
        initial={{ opacity: 0, y: -30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.6 }}
      >
        <span className="header-eyebrow">Base Starline</span>
        <h1>Tous les Influenceurs</h1>
        <p className="subtitle">
          Explorez et comparez tous les influenceurs de notre base
        </p>
      </motion.header>

      <motion.div
        className="stats-bar"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 0.5, delay: 0.2 }}
      >
        <div className="stat-item">
          <span className="stat-value">{filteredInfluencers.length}</span>
          <span className="stat-label">Influenceurs</span>
        </div>
        <div className="stat-item">
          <span className="stat-value">{averageScore}</span>
          <span className="stat-label">Score moyen</span>
        </div>
        <div className="stat-item">
          <span className="stat-value">{averageEngagementRate}%</span>
          <span className="stat-label">Engagement</span>
        </div>
      </motion.div>

      <motion.div
        className="search-section"
        initial={{ opacity: 0, scale: 0.95 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.5, delay: 0.2 }}
      >
        <SearchBar
          value={searchQuery}
          onChange={setSearchQuery}
          placeholder="Rechercher un influenceur..."
        />

        <div className="filters">
          <div className="filter-header">
            <Filter size={16} />
            <span>Filtrer par niche</span>
          </div>
          <div className="filter-tags">
            <Tag
              variant={selectedNiche === null ? 'blue' : 'default'}
              size="medium"
            >
              <button
                onClick={() => setSelectedNiche(null)}
                className="filter-button"
              >
                Tous
              </button>
            </Tag>
            {allNiches.map(niche => (
              <Tag
                key={niche}
                variant={selectedNiche === niche ? 'blue' : 'default'}
                size="medium"
              >
                <button
                  onClick={() => setSelectedNiche(niche)}
                  className="filter-button"
                >
                  {niche}
                </button>
              </Tag>
            ))}
          </div>
        </div>
      </motion.div>

      <div className="results-section">
        <motion.div
          className="results-header"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.4 }}
        >
          <h2>
            {filteredInfluencers.length} influenceur{filteredInfluencers.length > 1 ? 's' : ''} trouvé{filteredInfluencers.length > 1 ? 's' : ''}
          </h2>
        </motion.div>

        <div className="influencer-grid">
          {filteredInfluencers.map((influencer, index) => (
            <InfluencerCard
              key={influencer.id}
              influencer={influencer}
              onClick={() => navigate(`/influencer/${influencer.id}`)}
              delay={index * 0.1}
            />
          ))}
        </div>

        {filteredInfluencers.length === 0 && (
          <motion.div
            className="no-results"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
          >
            <p>Aucun influenceur trouvé pour cette recherche</p>
          </motion.div>
        )}
      </div>
    </div>
  );
};
