import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { ComparisonChart } from './ComparisonChart';
import { Influencer } from '../types';
import './InfluencerComparison.css';
import { Plus, Search } from 'lucide-react';

interface InfluencerComparisonProps {
  currentInfluencer: Influencer;
  allInfluencers: Influencer[];
}

export const InfluencerComparison = ({ 
  currentInfluencer, 
  allInfluencers 
}: InfluencerComparisonProps) => {
  const [selectedInfluencer, setSelectedInfluencer] = useState<Influencer | null>(null);
  const [showSelector, setShowSelector] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');

  // Filter influencers based on search and exclude current
  const filteredInfluencers = allInfluencers.filter(inf => 
    inf.id !== currentInfluencer.id &&
    (inf.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
     inf.handle.toLowerCase().includes(searchQuery.toLowerCase()))
  );

  const handleSelectInfluencer = (influencer: Influencer) => {
    setSelectedInfluencer(influencer);
    setShowSelector(false);
    setSearchQuery('');
  };

  const handleRemoveComparison = () => {
    setSelectedInfluencer(null);
  };

  const getInfluencerColor = (index: number) => {
    const colors = [
      'var(--primary-purple)',
      'var(--primary-blue)',
      'var(--primary-green)',
      'var(--accent-pink)',
      'var(--accent-orange)'
    ];
    return colors[index % colors.length];
  };

  if (!currentInfluencer.subscriberGrowth || currentInfluencer.subscriberGrowth.length === 0) {
    return null;
  }

  return (
    <div className="influencer-comparison">
      {selectedInfluencer ? (
        <ComparisonChart
          influencer1={{
            name: currentInfluencer.name,
            data: currentInfluencer.subscriberGrowth,
            color: getInfluencerColor(0)
          }}
          influencer2={{
            name: selectedInfluencer.name,
            data: selectedInfluencer.subscriberGrowth || [],
            color: getInfluencerColor(1)
          }}
          onRemoveComparison={handleRemoveComparison}
        />
      ) : (
        <div className="comparison-placeholder">
          <ComparisonChart
            influencer1={{
              name: currentInfluencer.name,
              data: currentInfluencer.subscriberGrowth,
              color: getInfluencerColor(0)
            }}
          />
          
          <motion.button
            className="add-comparison-btn"
            onClick={() => setShowSelector(true)}
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
          >
            <Plus size={20} />
            <span>Add an influencer to compare</span>
          </motion.button>
        </div>
      )}

      <AnimatePresence>
        {showSelector && (
          <motion.div
            className="selector-overlay"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setShowSelector(false)}
          >
            <motion.div
              className="selector-modal"
              initial={{ y: 50, opacity: 0 }}
              animate={{ y: 0, opacity: 1 }}
              exit={{ y: 50, opacity: 0 }}
              onClick={(e) => e.stopPropagation()}
            >
              <div className="selector-header">
                <h3 className="selector-title">Choose an influencer</h3>
                <div className="selector-search">
                  <Search size={18} />
                  <input
                    type="text"
                    placeholder="Search by name..."
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    autoFocus
                  />
                </div>
              </div>

              <div className="selector-list">
                {filteredInfluencers.length > 0 ? (
                  filteredInfluencers.map((influencer, index) => (
                    <motion.div
                      key={influencer.id}
                      className="selector-item"
                      onClick={() => handleSelectInfluencer(influencer)}
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: index * 0.05 }}
                      whileHover={{ x: 4, backgroundColor: 'var(--surface-hover)' }}
                    >
                      <img 
                        src={influencer.avatar} 
                        alt={influencer.name}
                        className="selector-avatar"
                      />
                      <div className="selector-info">
                        <span className="selector-name">{influencer.name}</span>
                        <span className="selector-handle">@{influencer.handle}</span>
                      </div>
                      <div className="selector-stats">
                        <span className="selector-followers">
                          {(influencer.followers >= 1000000 
                            ? `${(influencer.followers / 1000000).toFixed(1)}M`
                            : `${(influencer.followers / 1000).toFixed(0)}K`
                          )}
                        </span>
                        {influencer.subscriberGrowth && influencer.subscriberGrowth.length > 0 && (
                          <span className="selector-growth">
                            {(() => {
                              const first = influencer.subscriberGrowth[0].followers;
                              const last = influencer.subscriberGrowth[influencer.subscriberGrowth.length - 1].followers;
                              const growth = ((last - first) / first) * 100;
                              return `${growth > 0 ? '+' : ''}${growth.toFixed(1)}%`;
                            })()}
                          </span>
                        )}
                      </div>
                    </motion.div>
                  ))
                ) : (
                  <div className="selector-empty">
                    <p>No influencer found</p>
                  </div>
                )}
              </div>

              <div className="selector-footer">
                <button 
                  className="selector-cancel"
                  onClick={() => setShowSelector(false)}
                >
                  Cancel
                </button>
              </div>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};


