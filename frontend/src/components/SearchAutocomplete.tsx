import { useState, useEffect, useRef } from 'react';
import { Search, Loader2, Sparkles, Network } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { Influencer } from '../types';
import { apiService } from '../services/api';
import { useDataContext } from '../context/DataContext';
import { useNavigate } from 'react-router-dom';
import './SearchAutocomplete.css';

interface SearchAutocompleteProps {
  influencers: Influencer[];
  onSelect: (influencer: Influencer) => void;
  onInfluencerDiscovered?: (influencer: Influencer) => void;
  placeholder?: string;
  enableExploration?: boolean;
}

export const SearchAutocomplete = ({
  influencers,
  onSelect,
  onInfluencerDiscovered,
  placeholder = "Search for an influencer...",
  enableExploration = false
}: SearchAutocompleteProps) => {
  const { useMockData } = useDataContext();
  const navigate = useNavigate();
  const [query, setQuery] = useState('');
  const [isOpen, setIsOpen] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(-1);
  const [isAnalyzing, setIsAnalyzing] = useState(false);
  const [analyzingName, setAnalyzingName] = useState('');
  const [apiSuggestions, setApiSuggestions] = useState<Array<any>>([]);
  const [loadingSuggestions, setLoadingSuggestions] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);
  const debounceTimerRef = useRef<NodeJS.Timeout | null>(null);
  const suggestionTimerRef = useRef<NodeJS.Timeout | null>(null);

  // Filter local influencers for mock data mode
  const filteredInfluencers = useMockData ? influencers.filter(inf =>
    inf.name.toLowerCase().includes(query.toLowerCase()) ||
    inf.handle.toLowerCase().includes(query.toLowerCase()) ||
    inf.niche.some(n => n.toLowerCase().includes(query.toLowerCase()))
  ).slice(0, 5) : [];

  // Fetch API suggestions in real-time (for API mode)
  useEffect(() => {
    if (suggestionTimerRef.current) {
      clearTimeout(suggestionTimerRef.current);
    }

    // Only search API if in API mode and query is meaningful
    if (!useMockData && query.length >= 2) {
      setLoadingSuggestions(true);
      suggestionTimerRef.current = setTimeout(async () => {
        try {
          const result = await apiService.suggestInfluencers(query);
          setApiSuggestions(result.suggestions);
        } catch (error) {
          console.error('Failed to fetch suggestions:', error);
          setApiSuggestions([]);
        } finally {
          setLoadingSuggestions(false);
        }
      }, 300); // 300ms debounce for faster response
    } else {
      setApiSuggestions([]);
      setLoadingSuggestions(false);
    }

    return () => {
      if (suggestionTimerRef.current) {
        clearTimeout(suggestionTimerRef.current);
      }
    };
  }, [query, useMockData]);

  // Combined results: mock data influencers + API suggestions
  const allResults = useMockData ? filteredInfluencers : apiSuggestions;
  const hasResults = allResults.length > 0;

  useEffect(() => {
    setIsOpen(query.length > 0 && (hasResults || isAnalyzing || loadingSuggestions));
    setSelectedIndex(-1);
  }, [query, hasResults, isAnalyzing, loadingSuggestions]);

  // Manual analyze function (user confirms they want to analyze)
  const handleAnalyzeNewInfluencer = async () => {
    if (!query || query.length < 2 || useMockData) return;
    
    setIsAnalyzing(true);
    setAnalyzingName(query);

    try {
      console.log(`User confirmed: analyzing new influencer: ${query}`);
      const apiInfluencer = await apiService.analyzeInfluencer(query, 'basic');

      if (onInfluencerDiscovered) {
        console.log(`Successfully analyzed influencer: ${apiInfluencer.name}`);
        window.dispatchEvent(new CustomEvent('influencer-discovered', {
          detail: { id: apiInfluencer.id, name: apiInfluencer.name }
        }));
      }
      
      // Navigate to the new influencer
      navigate(`/influencer/${apiInfluencer.id}`);
    } catch (error) {
      console.error('Failed to analyze influencer:', error);
      alert(`Failed to analyze "${query}". Please check the spelling or try another name.`);
    } finally {
      setIsAnalyzing(false);
      setAnalyzingName('');
      setQuery('');
      setIsOpen(false);
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (!isOpen && e.key === 'Enter' && enableExploration && !useMockData && query.length >= 2) {
      // Si pas de dropdown ouvert et exploration activée, démarrer l'exploration
      e.preventDefault();
      handleStartExploration();
      return;
    }

    if (!isOpen) return;

    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault();
        setSelectedIndex(prev =>
          prev < allResults.length - 1 ? prev + 1 : prev
        );
        break;
      case 'ArrowUp':
        e.preventDefault();
        setSelectedIndex(prev => (prev > 0 ? prev - 1 : -1));
        break;
      case 'Enter':
        e.preventDefault();
        if (selectedIndex >= 0) {
          handleSelect(allResults[selectedIndex]);
        } else if (allResults.length > 0) {
          handleSelect(allResults[0]);
        } else if (enableExploration && !useMockData && query.length >= 2) {
          // Si aucun résultat et exploration activée, démarrer l'exploration
          handleStartExploration();
        }
        break;
      case 'Escape':
        setIsOpen(false);
        inputRef.current?.blur();
        break;
    }
  };

  const handleSelect = (influencer: Influencer | any) => {
    setQuery(influencer.name);
    setIsOpen(false);
    
    // If it's an API suggestion, navigate to the profile directly
    if (!useMockData && influencer.id && influencer.exists) {
      navigate(`/influencer/${influencer.id}`);
    } else if (onSelect) {
      onSelect(influencer);
    }
  };

  const handleStartExploration = () => {
    if (query.trim().length < 2 || useMockData) return;
    
    // Naviguer vers la page d'exploration avec animation
    navigate(`/explore/${encodeURIComponent(query.trim())}`);
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
            {loadingSuggestions ? (
              <motion.div
                className="search-autocomplete-analyzing"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
              >
                <Loader2 className="search-autocomplete-analyzing-icon" size={20} />
                <div className="search-autocomplete-analyzing-text">
                  <div className="search-autocomplete-analyzing-subtitle">
                    Searching...
                  </div>
                </div>
              </motion.div>
            ) : isAnalyzing ? (
              <motion.div
                className="search-autocomplete-analyzing"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
              >
                <Loader2 className="search-autocomplete-analyzing-icon" size={20} />
                <div className="search-autocomplete-analyzing-text">
                  <div className="search-autocomplete-analyzing-title">
                    <Sparkles size={16} style={{ marginRight: '6px' }} />
                    Discovering...
                  </div>
                  <div className="search-autocomplete-analyzing-subtitle">
                    Analyzing "{analyzingName}" with AI
                  </div>
                </div>
              </motion.div>
            ) : (
              <>
                {/* Show "Did you mean?" header for fuzzy matches */}
                {!useMockData && allResults.length > 0 && allResults[0].match_type === 'fuzzy' && (
                  <div className="search-autocomplete-did-you-mean">
                    Did you mean...?
                  </div>
                )}
                
                {allResults.map((result: any, index: number) => {
                  // Handle both mock data influencers and API suggestions
                  const influencer = useMockData ? result : {
                    id: result.id?.toString() || '',
                    name: result.name,
                    avatar: result.avatar_url || '/default-avatar.png',
                    handle: `@${result.name}`,
                    followers: 0,
                    influscoring: { overall: Math.round(result.trust_score / 10) }
                  };
                  
                  const isFuzzyMatch = !useMockData && result.match_type === 'fuzzy';
                  
                  return (
                    <motion.button
                      key={result.id || index}
                      className={`search-autocomplete-item ${selectedIndex === index ? 'selected' : ''} ${isFuzzyMatch ? 'fuzzy-match' : ''}`}
                      onClick={() => handleSelect(result)}
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
                        <div className="search-autocomplete-name">
                          {influencer.name}
                          {isFuzzyMatch && <span className="fuzzy-badge">Similar</span>}
                        </div>
                        {useMockData && (
                          <div className="search-autocomplete-meta">
                            {influencer.handle} • {formatFollowers(influencer.followers)} followers
                          </div>
                        )}
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
            
            {/* Option pour analyser un nouvel influencer si aucune suggestion */}
            {!isAnalyzing && !loadingSuggestions && allResults.length === 0 && !useMockData && query.length >= 3 && (
              <motion.div
                className="search-autocomplete-no-results"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
              >
                <div className="search-autocomplete-no-results-text">
                  <Sparkles size={18} style={{ marginRight: '8px' }} />
                  No influencer found matching "{query}"
                </div>
                <motion.button
                  className="search-autocomplete-item search-autocomplete-analyze"
                  onClick={handleAnalyzeNewInfluencer}
                  whileHover={{ backgroundColor: 'var(--state-hover)' }}
                >
                  <Sparkles className="search-autocomplete-analyze-icon" size={20} />
                  <div className="search-autocomplete-info">
                    <div className="search-autocomplete-name">Analyze "{query}" with AI</div>
                    <div className="search-autocomplete-meta">
                      Discover this influencer using AI-powered search
                    </div>
                  </div>
                </motion.button>
                
                {enableExploration && (
                  <motion.button
                    className="search-autocomplete-item search-autocomplete-explore"
                    onClick={handleStartExploration}
                    whileHover={{ backgroundColor: 'var(--state-hover)' }}
                  >
                    <Network className="search-autocomplete-explore-icon" size={20} />
                    <div className="search-autocomplete-info">
                      <div className="search-autocomplete-name">Generate network graph</div>
                      <div className="search-autocomplete-meta">
                        Explore "{query}" and their connections
                      </div>
                    </div>
                  </motion.button>
                )}
              </motion.div>
            )}
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
};
