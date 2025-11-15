import { useState, useEffect, useRef } from 'react';
import { Search, Loader2, Sparkles } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { Influencer } from '../types';
import { apiService } from '../services/api';
import { useDataContext } from '../context/DataContext';
import './SearchAutocomplete.css';

interface SearchAutocompleteProps {
  influencers: Influencer[];
  onSelect: (influencer: Influencer) => void;
  onInfluencerDiscovered?: (influencer: Influencer) => void;
  placeholder?: string;
}

export const SearchAutocomplete = ({
  influencers,
  onSelect,
  onInfluencerDiscovered,
  placeholder = "Rechercher un influenceur..."
}: SearchAutocompleteProps) => {
  const { useMockData } = useDataContext();
  const [query, setQuery] = useState('');
  const [isOpen, setIsOpen] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(-1);
  const [isAnalyzing, setIsAnalyzing] = useState(false);
  const [analyzingName, setAnalyzingName] = useState('');
  const inputRef = useRef<HTMLInputElement>(null);
  const debounceTimerRef = useRef<NodeJS.Timeout | null>(null);

  const filteredInfluencers = influencers.filter(inf =>
    inf.name.toLowerCase().includes(query.toLowerCase()) ||
    inf.handle.toLowerCase().includes(query.toLowerCase()) ||
    inf.niche.some(n => n.toLowerCase().includes(query.toLowerCase()))
  ).slice(0, 5);

  useEffect(() => {
    setIsOpen(query.length > 0 && (filteredInfluencers.length > 0 || isAnalyzing));
    setSelectedIndex(-1);
  }, [query, filteredInfluencers.length, isAnalyzing]);

  // Auto-discovery: Analyze influencer if not found after 5 seconds of inactivity
  useEffect(() => {
    // Clear any existing timer
    if (debounceTimerRef.current) {
      clearTimeout(debounceTimerRef.current);
    }

    // Only trigger auto-discovery when:
    // 1. Using API mode (not mock data)
    // 2. Query is meaningful (>= 3 characters)
    // 3. No results found
    // 4. Not currently analyzing
    if (!useMockData && query.length >= 3 && filteredInfluencers.length === 0 && !isAnalyzing) {
      debounceTimerRef.current = setTimeout(async () => {
        setIsAnalyzing(true);
        setAnalyzingName(query);

        try {
          console.log(`Auto-discovering influencer: ${query}`);
          const apiInfluencer = await apiService.analyzeInfluencer(query, 'basic');

          // Convert API response to frontend Influencer type
          // This will be handled by the parent component through the callback
          if (onInfluencerDiscovered) {
            // Notify parent that a new influencer was discovered
            // The parent should re-fetch the influencer list
            console.log(`Successfully analyzed influencer: ${apiInfluencer.name}`);
            // We'll trigger a refresh in the parent
            window.dispatchEvent(new CustomEvent('influencer-discovered', {
              detail: { id: apiInfluencer.id, name: apiInfluencer.name }
            }));
          }
        } catch (error) {
          console.error('Failed to analyze influencer:', error);
        } finally {
          setIsAnalyzing(false);
          setAnalyzingName('');
        }
      }, 5000); // 5 seconds delay
    }

    // Cleanup on unmount or query change
    return () => {
      if (debounceTimerRef.current) {
        clearTimeout(debounceTimerRef.current);
      }
    };
  }, [query, filteredInfluencers.length, useMockData, isAnalyzing, onInfluencerDiscovered]);

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
            {isAnalyzing ? (
              <motion.div
                className="search-autocomplete-analyzing"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
              >
                <Loader2 className="search-autocomplete-analyzing-icon" size={20} />
                <div className="search-autocomplete-analyzing-text">
                  <div className="search-autocomplete-analyzing-title">
                    <Sparkles size={16} style={{ marginRight: '6px' }} />
                    Découverte en cours...
                  </div>
                  <div className="search-autocomplete-analyzing-subtitle">
                    Analyse de "{analyzingName}" avec l'IA
                  </div>
                </div>
              </motion.div>
            ) : (
              filteredInfluencers.map((influencer, index) => (
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
              ))
            )}
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};
