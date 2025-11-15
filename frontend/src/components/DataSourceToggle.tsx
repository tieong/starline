/**
 * Data Source Toggle Component
 *
 * Allows users to switch between mock data and real API data.
 */

import { Database, CloudCog } from 'lucide-react';
import { motion } from 'framer-motion';
import { useDataContext } from '../context/DataContext';
import './DataSourceToggle.css';

export function DataSourceToggle() {
  const { useMockData, toggleDataSource } = useDataContext();

  return (
    <div className="data-source-toggle">
      <button
        className={`toggle-button ${useMockData ? 'mock-active' : 'api-active'}`}
        onClick={toggleDataSource}
        title={useMockData ? 'Switch to Real API Data' : 'Switch to Mock Data'}
      >
        <motion.div
          className="toggle-slider"
          animate={{ x: useMockData ? 0 : 28 }}
          transition={{ type: 'spring', stiffness: 300, damping: 30 }}
        />
        <div className="toggle-option">
          <Database size={16} />
          <span className="toggle-label">Mock</span>
        </div>
        <div className="toggle-option">
          <CloudCog size={16} />
          <span className="toggle-label">API</span>
        </div>
      </button>
      <div className="data-source-indicator">
        <span className={`indicator-dot ${useMockData ? 'mock' : 'api'}`} />
        <span className="indicator-text">
          {useMockData ? 'Using Mock Data' : 'Using Real API'}
        </span>
      </div>
    </div>
  );
}
