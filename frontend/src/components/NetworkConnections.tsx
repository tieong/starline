import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { Network, ExternalLink } from 'lucide-react';
import { NetworkConnection } from '../types';
import './NetworkConnections.css';

interface NetworkConnectionsProps {
  connections: NetworkConnection[];
  influencerId: string;
}

export const NetworkConnections = ({ connections, influencerId }: NetworkConnectionsProps) => {
  const navigate = useNavigate();

  if (!connections || connections.length === 0) {
    return null;
  }

  // Limiter à 8 connexions max pour la preview
  const displayConnections = connections.slice(0, 8);

  const handleViewFullNetwork = () => {
    navigate(`/graph/${influencerId}`);
  };

  return (
    <div className="network-connections">
      <div className="connections-visual">
        {displayConnections.map((connection, index) => {
          const angle = (index / displayConnections.length) * 360;
          const radius = 45;
          const x = 50 + radius * Math.cos((angle * Math.PI) / 180);
          const y = 50 + radius * Math.sin((angle * Math.PI) / 180);
          
          return (
            <motion.div
              key={connection.id}
              className="connection-node"
              style={{
                left: `${x}%`,
                top: `${y}%`,
                backgroundColor: connection.color
              }}
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: index * 0.1, duration: 0.3 }}
              whileHover={{ scale: 1.3 }}
            >
              <div className="connection-line" style={{
                transform: `rotate(${angle + 180}deg)`,
                backgroundColor: connection.color
              }} />
              <div className="connection-tooltip">
                {connection.name}
              </div>
            </motion.div>
          );
        })}
        
        {/* Central node */}
        <div className="connection-node-center">
          <div className="center-pulse" />
        </div>
      </div>

      {/* View Full Network Button */}
      <motion.button
        className="view-full-network-button"
        onClick={handleViewFullNetwork}
        whileHover={{ scale: 1.02 }}
        whileTap={{ scale: 0.98 }}
      >
        <Network size={16} />
        <span>View full network graph</span>
        <ExternalLink size={14} />
      </motion.button>

      {connections.length > 8 && (
        <p className="connections-count-hint">
          +{connections.length - 8} more connection{connections.length - 8 > 1 ? 's' : ''}
        </p>
      )}
    </div>
  );
};


