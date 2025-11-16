import { motion } from 'framer-motion';
import { Package, Star, TrendingUp, ThumbsUp, ThumbsDown, MessageCircle, ExternalLink } from 'lucide-react';
import { Tag } from './Tag';
import './ProductCard.css';

interface ProductReview {
  author: string;
  comment: string;
  platform: string;
  sentiment: string;
  url?: string;
  date?: string;
}

interface OpenFoodFactsData {
  type?: string;
  product_name?: string;
  brands?: string;
  barcode?: string;
  nutriscore?: string;  // Note: field name is 'nutriscore' not 'nutriscore_grade'
  nova_group?: number;
  ecoscore?: string;     // Note: field name is 'ecoscore' not 'ecoscore_grade'
  quality_score?: number;
  is_healthy?: boolean;
  nutriments?: any;
  ingredients_text?: string;
  allergens?: string[] | string;  // Can be array or string
  image_url?: string;
  url?: string;
}

interface ProductCardProps {
  product: {
    id: string | number;
    name: string;
    brand?: string;
    category: string;
    quality_score?: number;
    description?: string;
    review_count?: number;
    sentiment_score?: number;
    openfoodfacts_data?: OpenFoodFactsData;
    reviews?: ProductReview[];
    status?: string;
    price?: number;
  };
  expanded?: boolean;
}

export const ProductCard = ({ product, expanded = false }: ProductCardProps) => {
  const hasOpenFoodFacts = product.openfoodfacts_data !== null && product.openfoodfacts_data !== undefined;
  const hasReviews = product.reviews && product.reviews.length > 0;

  const getNutriScoreColor = (grade?: string) => {
    if (!grade) return 'var(--accent-gray)';
    switch (grade.toUpperCase()) {
      case 'A': return 'var(--accent-teal)';
      case 'B': return 'var(--accent-blue)';
      case 'C': return 'var(--accent-yellow)';
      case 'D': return 'var(--accent-orange)';
      case 'E': return 'var(--accent-red)';
      default: return 'var(--accent-gray)';
    }
  };

  const getSentimentIcon = (sentiment: string) => {
    const s = sentiment.toLowerCase();
    if (s.includes('positive') || s === 'good') return <ThumbsUp size={16} className="sentiment-icon positive" />;
    if (s.includes('negative') || s === 'bad') return <ThumbsDown size={16} className="sentiment-icon negative" />;
    return <MessageCircle size={16} className="sentiment-icon neutral" />;
  };

  const getSentimentClass = (sentiment: string) => {
    const s = sentiment.toLowerCase();
    if (s.includes('positive') || s === 'good') return 'positive';
    if (s.includes('negative') || s === 'bad') return 'negative';
    return 'neutral';
  };

  return (
    <motion.div
      className={`product-card ${expanded ? 'expanded' : ''}`}
      initial={{ opacity: 0, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
    >
      <div className="product-card-header">
        <div className="product-card-title-row">
          <Package size={20} className="product-icon" />
          <div className="product-card-title">
            <h4>{product.name}</h4>
            {product.brand && <p className="product-brand">{product.brand}</p>}
          </div>
          {product.status && (
            <Tag variant={product.status === 'active' ? 'teal' : 'default'} size="small">
              {product.status === 'active' ? 'Active' : 'Ended'}
            </Tag>
          )}
        </div>
        {product.category && (
          <p className="product-category">{product.category}</p>
        )}
      </div>

      {product.description && (
        <p className="product-description">{product.description}</p>
      )}

      {/* OpenFoodFacts Data */}
      {hasOpenFoodFacts && product.openfoodfacts_data && (
        <div className="product-openfoodfacts">
          <div className="openfoodfacts-header">
            <ExternalLink size={16} />
            <h5>OpenFoodFacts Quality Data</h5>
          </div>

          <div className="openfoodfacts-scores">
            {product.openfoodfacts_data.nutriscore && (
              <div className="score-badge">
                <span className="score-label">Nutri-Score</span>
                <span
                  className="score-grade"
                  style={{ backgroundColor: getNutriScoreColor(product.openfoodfacts_data.nutriscore) }}
                >
                  {product.openfoodfacts_data.nutriscore.toUpperCase()}
                </span>
              </div>
            )}

            {product.openfoodfacts_data.nova_group && (
              <div className="score-badge">
                <span className="score-label">NOVA Group</span>
                <span className="score-value">{product.openfoodfacts_data.nova_group}/4</span>
              </div>
            )}

            {product.openfoodfacts_data.ecoscore && (
              <div className="score-badge">
                <span className="score-label">Eco-Score</span>
                <span
                  className="score-grade"
                  style={{ backgroundColor: getNutriScoreColor(product.openfoodfacts_data.ecoscore) }}
                >
                  {product.openfoodfacts_data.ecoscore.toUpperCase()}
                </span>
              </div>
            )}
          </div>

          {product.openfoodfacts_data.allergens && (
            <div className="openfoodfacts-allergens">
              <strong>Allergens:</strong> {
                Array.isArray(product.openfoodfacts_data.allergens)
                  ? product.openfoodfacts_data.allergens.join(', ')
                  : product.openfoodfacts_data.allergens
              }
            </div>
          )}
        </div>
      )}

      {/* Quality Score */}
      {product.quality_score !== undefined && (
        <div className="product-quality">
          <Star size={16} className="quality-icon" />
          <span className="quality-label">Quality Score:</span>
          <span className="quality-value">{product.quality_score}/100</span>
        </div>
      )}

      {/* Sentiment Summary */}
      {hasReviews && (
        <div className="product-sentiment-summary">
          <TrendingUp size={16} className="sentiment-summary-icon" />
          <span className="sentiment-summary-label">
            {product.review_count || product.reviews!.length} review{(product.review_count || product.reviews!.length) !== 1 ? 's' : ''}
          </span>
          {product.sentiment_score !== undefined && (
            <span className="sentiment-summary-score">
              {product.sentiment_score > 60 ? '😊' : product.sentiment_score < 40 ? '😞' : '😐'}
              {product.sentiment_score}% positive
            </span>
          )}
        </div>
      )}

      {/* Social Media Reviews */}
      {hasReviews && expanded && (
        <div className="product-reviews">
          <h5 className="reviews-header">
            <MessageCircle size={16} />
            Social Media Comments
          </h5>
          <div className="reviews-list">
            {product.reviews!.slice(0, 5).map((review, idx) => (
              <div key={idx} className={`review-item ${getSentimentClass(review.sentiment)}`}>
                <div className="review-header">
                  <div className="review-author-row">
                    {getSentimentIcon(review.sentiment)}
                    <span className="review-author">{review.author}</span>
                    <Tag variant="default" size="small">{review.platform}</Tag>
                  </div>
                  {review.date && (
                    <span className="review-date">
                      {new Date(review.date).toLocaleDateString()}
                    </span>
                  )}
                </div>
                <p className="review-comment">"{review.comment}"</p>
                {review.url && (
                  <a
                    href={review.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="review-link"
                  >
                    <ExternalLink size={12} />
                    View original
                  </a>
                )}
              </div>
            ))}
          </div>
        </div>
      )}

      {product.price && (
        <div className="product-price">${product.price.toFixed(2)}</div>
      )}
    </motion.div>
  );
};
