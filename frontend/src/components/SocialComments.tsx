import { motion } from 'framer-motion';
import { MessageCircle } from 'lucide-react';
import { SocialComment } from '../types';
import { Tag } from './Tag';
import './SocialComments.css';

interface SocialCommentsProps {
  comments: SocialComment[];
}

export const SocialComments = ({ comments }: SocialCommentsProps) => {
  if (!comments || comments.length === 0) {
    return null;
  }

  const formatDate = (dateStr: string) => {
    const date = new Date(dateStr);
    const month = date.toLocaleDateString('en-US', { month: 'short' });
    const day = date.getDate();
    const year = date.getFullYear();
    return `${month} ${day}, ${year}`;
  };

  const getSentimentColor = (sentiment: string) => {
    switch (sentiment) {
      case 'positive':
        return 'teal';
      case 'negative':
        return 'red';
      default:
        return 'default';
    }
  };

  const getSentimentIcon = (sentiment: string) => {
    switch (sentiment) {
      case 'positive':
        return '👍';
      case 'negative':
        return '👎';
      default:
        return '💬';
    }
  };

  return (
    <div className="social-comments">
      {comments.map((comment, index) => (
        <motion.div
          key={comment.id}
          className="comment-card"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: index * 0.1 }}
        >
          <div className="comment-header">
            <div className="comment-author-row">
              <MessageCircle size={16} className="comment-icon" />
              <span className="comment-author">{comment.author}</span>
              <Tag variant={getSentimentColor(comment.sentiment)} size="small">
                {getSentimentIcon(comment.sentiment)} {comment.platform}
              </Tag>
            </div>
            <span className="comment-date">{formatDate(comment.date)}</span>
          </div>
          <p className="comment-content">{comment.content}</p>
        </motion.div>
      ))}
    </div>
  );
};


