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
  const { useMockData, toggleDataSource, apiConnectionStatus } = useDataContext();

  // Determine indicator status
  const getIndicatorStatus = () => {
    if (useMockData) return 'mock';
    return apiConnectionStatus === 'connected' ? 'api-connected' : 'api-disconnected';
  };

  const getIndicatorText = () => {
    if (useMockData) return 'Using Mock Data';
    if (apiConnectionStatus === 'connected') return 'Using Real API';
    if (apiConnectionStatus === 'disconnected') return 'API Disconnected';
    return 'Checking API...';
  };

  return (
    <div className="data-source-toggle">
      <button 
        className="toggle-container"
        onClick={toggleDataSource}
        aria-label={useMockData ? 'Switch to Real API Data' : 'Switch to Mock Data'}
      >
        <motion.div
          className="toggle-slider"
          initial={false}
          animate={{ 
            x: useMockData ? 0 : '100%'
          }}
          transition={{ 
            type: 'spring', 
            stiffness: 400, 
            damping: 30,
            mass: 0.8
          }}
        />
        <span className={`toggle-option ${useMockData ? 'active' : ''}`}>
          <Database size={14} />
          <span className="toggle-label">Mock</span>
        </span>
        <span className={`toggle-option ${!useMockData ? 'active' : ''}`}>
          <CloudCog size={14} />
          <span className="toggle-label">API</span>
        </span>
      </button>
      <div className="data-source-indicator">
        <span className={`indicator-dot ${getIndicatorStatus()}`} />
        <span className="indicator-text">
          {getIndicatorText()}
        </span>
      </div>
    </div>
  );
}
