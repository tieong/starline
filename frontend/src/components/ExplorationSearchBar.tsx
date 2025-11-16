import { useState, useRef, useEffect } from 'react';
import { Search, Loader2, Network, ArrowRight } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import './ExplorationSearchBar.css';

interface ExplorationSearchBarProps {
  onStartExploration: (name: string) => void;
  isLoading?: boolean;
  placeholder?: string;
}

export const ExplorationSearchBar = ({
  onStartExploration,
  isLoading = false,
  placeholder = "Enter an influencer name to explore..."
}: ExplorationSearchBarProps) => {
  const [query, setQuery] = useState('');
  const [showSuggestion, setShowSuggestion] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    // Show suggestion when query has at least 2 characters
    setShowSuggestion(query.trim().length >= 2);
  }, [query]);

  const handleStartExploration = () => {
    if (query.trim().length >= 2) {
      onStartExploration(query.trim());
    }
  };

  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !isLoading) {
      handleStartExploration();
    }
  };

  return (
    <div className="exploration-search-bar">
      <motion.div
        className="exploration-search-input-wrapper"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        <Search className="exploration-search-icon" size={22} />
        <input
          ref={inputRef}
          type="text"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
          onKeyPress={handleKeyPress}
          placeholder={placeholder}
          className="exploration-search-input"
          disabled={isLoading}
          autoFocus
        />
        {isLoading && (
          <Loader2 className="exploration-search-loading" size={20} />
        )}
      </motion.div>

      <AnimatePresence>
        {showSuggestion && !isLoading && (
          <motion.button
            className="exploration-search-action"
            onClick={handleStartExploration}
            initial={{ opacity: 0, y: 10, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 10, scale: 0.95 }}
            whileHover={{ scale: 1.02 }}
            whileTap={{ scale: 0.98 }}
          >
            <Network size={20} className="exploration-action-icon" />
            <span>Generate exploration graph for "{query}"</span>
            <ArrowRight size={18} className="exploration-action-arrow" />
          </motion.button>
        )}
      </AnimatePresence>

      {isLoading && (
        <motion.div
          className="exploration-search-status"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
        >
          <Loader2 className="exploration-status-spinner" size={18} />
          <span>Analyzing "{query}" and discovering connections...</span>
        </motion.div>
      )}
    </div>
  );
};

