import { Twitter, Linkedin, Link2 } from 'lucide-react';
import { supabase } from '../lib/supabase';
import './SocialShare.css';

interface SocialShareProps {
  influencerId: string;
  influencerName: string;
  url?: string;
}

export const SocialShare = ({ influencerId, influencerName, url }: SocialShareProps) => {
  const shareUrl = url || window.location.href;
  const shareText = `Check out ${influencerName} on Starline - AI-powered influencer intelligence platform`;

  const trackShare = async (platform: string) => {
    try {
      await supabase.from('social_shares').insert({
        influencer_id: influencerId,
        platform,
      });

      await supabase.from('engagement_events').insert({
        event_type: 'social_share',
        event_category: 'share',
        event_label: platform,
        metadata: { influencer_id: influencerId, influencer_name: influencerName },
      });
    } catch (error) {
      console.error('Failed to track share:', error);
    }
  };

  const handleTwitterShare = () => {
    trackShare('twitter');
    const twitterUrl = `https://twitter.com/intent/tweet?text=${encodeURIComponent(shareText)}&url=${encodeURIComponent(shareUrl)}`;
    window.open(twitterUrl, '_blank', 'width=550,height=420');
  };

  const handleLinkedInShare = () => {
    trackShare('linkedin');
    const linkedinUrl = `https://www.linkedin.com/sharing/share-offsite/?url=${encodeURIComponent(shareUrl)}`;
    window.open(linkedinUrl, '_blank', 'width=550,height=420');
  };

  const handleCopyLink = async () => {
    trackShare('copy_link');
    try {
      await navigator.clipboard.writeText(shareUrl);
      // Could add a toast notification here
      alert('Link copied to clipboard!');
    } catch (error) {
      console.error('Failed to copy link:', error);
    }
  };

  return (
    <div className="social-share">
      <button className="share-button" title="Share on Twitter" onClick={handleTwitterShare}>
        <Twitter size={18} />
      </button>
      <button className="share-button" title="Share on LinkedIn" onClick={handleLinkedInShare}>
        <Linkedin size={18} />
      </button>
      <button className="share-button" title="Copy link" onClick={handleCopyLink}>
        <Link2 size={18} />
      </button>
    </div>
  );
};
