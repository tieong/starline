import { motion } from 'framer-motion';
import { NetworkConnection } from '../types';
import './NetworkConnections.css';

interface NetworkConnectionsProps {
  connections: NetworkConnection[];
}

export const NetworkConnections = ({ connections }: NetworkConnectionsProps) => {
  if (!connections || connections.length === 0) {
    return null;
  }

  return (
    <div className="network-connections">
      <div className="connections-visual">
        {connections.map((connection, index) => {
          const angle = (index / connections.length) * 360;
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
    </div>
  );
};


