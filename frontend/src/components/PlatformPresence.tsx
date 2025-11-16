import { motion } from 'framer-motion';
import { ExternalLink, Youtube as YoutubeIcon, Twitter, Instagram } from 'lucide-react';
import { PlatformPresence as PlatformPresenceType } from '../types';
import './PlatformPresence.css';

interface PlatformPresenceProps {
  platforms: PlatformPresenceType[];
}

export const PlatformPresence = ({ platforms }: PlatformPresenceProps) => {
  if (!platforms || platforms.length === 0) {
    return null;
  }

  const formatFollowers = (num: number) => {
    if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`;
    if (num >= 1000) return `${(num / 1000).toFixed(1)}K`;
    return num.toString();
  };

  const getPlatformIcon = (platform: string) => {
    switch (platform.toLowerCase()) {
      case 'youtube':
        return <YoutubeIcon size={24} />;
      case 'twitter':
        return <Twitter size={24} />;
      case 'instagram':
        return <Instagram size={24} />;
      case 'tiktok':
        return (
          <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
            <path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.2 1.74 2.89 2.89 0 0 1 2.31-4.64 2.93 2.93 0 0 1 .88.13V9.4a6.84 6.84 0 0 0-1-.05A6.33 6.33 0 0 0 5 20.1a6.34 6.34 0 0 0 10.86-4.43v-7a8.16 8.16 0 0 0 4.77 1.52v-3.4a4.85 4.85 0 0 1-1-.1z"/>
          </svg>
        );
      case 'twitch':
        return (
          <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
            <path d="M11.571 4.714h1.715v5.143H11.57zm4.715 0H18v5.143h-1.714zM6 0L1.714 4.286v15.428h5.143V24l4.286-4.286h3.428L22.286 12V0zm14.571 11.143l-3.428 3.428h-3.429l-3 3v-3H6.857V1.714h13.714Z"/>
          </svg>
        );
      default:
        return <ExternalLink size={24} />;
    }
  };

  const getPlatformColor = (platform: string) => {
    switch (platform.toLowerCase()) {
      case 'youtube':
        return '#FF0000';
      case 'twitter':
        return '#1DA1F2';
      case 'instagram':
        return '#E4405F';
      case 'tiktok':
        return '#000000';
      case 'twitch':
        return '#9146FF';
      default:
        return 'var(--text-strong)';
    }
  };

  return (
    <div className="platform-presence">
      {platforms.map((platform, index) => (
        <motion.div
          key={platform.platform}
          className="platform-card"
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: index * 0.1 }}
          whileHover={{ y: -4 }}
        >
          <div className="platform-header">
            <div 
              className="platform-icon" 
              style={{ color: getPlatformColor(platform.platform) }}
            >
              {getPlatformIcon(platform.platform)}
            </div>
            <ExternalLink size={16} className="platform-link-icon" />
          </div>
          <div className="platform-info">
            <h4 className="platform-name">{platform.platform}</h4>
            <p className="platform-handle">{platform.handle}</p>
          </div>
          <div className="platform-stats">
            <span className="platform-followers">{formatFollowers(platform.followers)}</span>
            <span className="platform-label">Followers</span>
          </div>
        </motion.div>
      ))}
    </div>
  );
};


