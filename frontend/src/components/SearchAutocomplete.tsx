import { useState, useEffect, useRef } from 'react';
import { Search } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { Influencer } from '../types';
import './SearchAutocomplete.css';

interface SearchAutocompleteProps {
  influencers: Influencer[];
  onSelect: (influencer: Influencer) => void;
  placeholder?: string;
}

export const SearchAutocomplete = ({
  influencers,
  onSelect,
  placeholder = "Rechercher un influenceur..."
}: SearchAutocompleteProps) => {
  const [query, setQuery] = useState('');
  const [isOpen, setIsOpen] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(-1);
  const inputRef = useRef<HTMLInputElement>(null);

  const filteredInfluencers = influencers.filter(inf =>
    inf.name.toLowerCase().includes(query.toLowerCase()) ||
    inf.handle.toLowerCase().includes(query.toLowerCase()) ||
    inf.niche.some(n => n.toLowerCase().includes(query.toLowerCase()))
  ).slice(0, 5);

  useEffect(() => {
    setIsOpen(query.length > 0 && filteredInfluencers.length > 0);
    setSelectedIndex(-1);
  }, [query, filteredInfluencers.length]);

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (!isOpen) return;

    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault();
        setSelectedIndex(prev =>
          prev < filteredInfluencers.length - 1 ? prev + 1 : prev
        );
        break;
      case 'ArrowUp':
        e.preventDefault();
        setSelectedIndex(prev => (prev > 0 ? prev - 1 : -1));
        break;
      case 'Enter':
        e.preventDefault();
        if (selectedIndex >= 0) {
          handleSelect(filteredInfluencers[selectedIndex]);
        } else if (filteredInfluencers.length > 0) {
          handleSelect(filteredInfluencers[0]);
        }
        break;
      case 'Escape':
        setIsOpen(false);
        inputRef.current?.blur();
        break;
    }
  };

  const handleSelect = (influencer: Influencer) => {
    setQuery(influencer.name);
    setIsOpen(false);
    onSelect(influencer);
  };

  const formatFollowers = (num: number) => {
    if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`;
    if (num >= 1000) return `${(num / 1000).toFixed(0)}K`;
    return num.toString();
  };

  return (
    <div className="search-autocomplete">
      <motion.div
        className="search-autocomplete-input-wrapper"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        <Search className="search-autocomplete-icon" size={22} />
        <input
          ref={inputRef}
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onKeyDown={handleKeyDown}
          placeholder={placeholder}
          className="search-autocomplete-input"
          autoFocus
        />
      </motion.div>

      <AnimatePresence>
        {isOpen && (
          <motion.div
            className="search-autocomplete-dropdown"
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -10 }}
            transition={{ duration: 0.2 }}
          >
            {filteredInfluencers.map((influencer, index) => (
              <motion.button
                key={influencer.id}
                className={`search-autocomplete-item ${selectedIndex === index ? 'selected' : ''}`}
                onClick={() => handleSelect(influencer)}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                transition={{ delay: index * 0.05 }}
                whileHover={{ backgroundColor: 'var(--state-hover)' }}
              >
                <img
                  src={influencer.avatar}
                  alt={influencer.name}
                  className="search-autocomplete-avatar"
                />
                <div className="search-autocomplete-info">
                  <div className="search-autocomplete-name">{influencer.name}</div>
                  <div className="search-autocomplete-meta">
                    {influencer.handle} • {formatFollowers(influencer.followers)} abonnés
                  </div>
                </div>
                <div
                  className="search-autocomplete-score"
                  style={{
                    background: influencer.influscoring.overall >= 85
                      ? 'var(--accent-teal)'
                      : influencer.influscoring.overall >= 70
                      ? 'var(--accent-blue)'
                      : 'var(--accent-yellow)'
                  }}
                >
                  {influencer.influscoring.overall}
                </div>
              </motion.button>
            ))}
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};
