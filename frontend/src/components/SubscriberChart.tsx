import { motion } from 'framer-motion';
import { SubscriberGrowthPoint } from '../types';
import './SubscriberChart.css';

interface SubscriberChartProps {
  data: SubscriberGrowthPoint[];
  name?: string;
}

export const SubscriberChart = ({ data }: SubscriberChartProps) => {
  if (!data || data.length === 0) {
    return null;
  }

  const maxFollowers = Math.max(...data.map(d => d.followers));
  const minFollowers = Math.min(...data.map(d => d.followers));
  const range = maxFollowers - minFollowers;

  const formatDate = (dateStr: string) => {
    const [year, month] = dateStr.split('-');
    const monthNames = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun', 'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'];
    return `${monthNames[parseInt(month) - 1]} ${year}`;
  };

  const formatFollowers = (num: number) => {
    if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`;
    if (num >= 1000) return `${(num / 1000).toFixed(0)}K`;
    return num.toString();
  };

  // Create SVG path for the line
  const chartWidth = 100;
  const chartHeight = 100;
  const points = data.map((point, index) => {
    const x = (index / (data.length - 1)) * chartWidth;
    const y = chartHeight - ((point.followers - minFollowers) / range) * chartHeight;
    return { x, y, ...point };
  });

  const pathD = points.map((point, index) => 
    `${index === 0 ? 'M' : 'L'} ${point.x} ${point.y}`
  ).join(' ');

  const areaD = `${pathD} L ${chartWidth} ${chartHeight} L 0 ${chartHeight} Z`;

  // Calculate growth stats
  const firstValue = data[0].followers;
  const lastValue = data[data.length - 1].followers;
  const totalGrowth = lastValue - firstValue;
  const percentGrowth = ((totalGrowth / firstValue) * 100).toFixed(1);

  return (
    <div className="subscriber-chart">
      <div className="chart-header">
        <div className="chart-title-group">
          <h3 className="chart-title">Progression des abonnés</h3>
          <p className="chart-subtitle">{data.length} derniers mois</p>
        </div>
        <div className="chart-stats-group">
          <div className="chart-stat">
            <span className="chart-stat-value">{formatFollowers(totalGrowth)}</span>
            <span className="chart-stat-label">Croissance</span>
          </div>
          <div className="chart-stat">
            <span className="chart-stat-value" style={{ 
              color: totalGrowth > 0 ? 'var(--primary-green)' : 'var(--primary-red)' 
            }}>
              {totalGrowth > 0 ? '+' : ''}{percentGrowth}%
            </span>
            <span className="chart-stat-label">Variation</span>
          </div>
        </div>
      </div>

      <div className="chart-container">
        <svg 
          viewBox={`0 0 ${chartWidth} ${chartHeight}`} 
          preserveAspectRatio="none"
          className="chart-svg"
        >
          <defs>
            <linearGradient id="areaGradient" x1="0" x2="0" y1="0" y2="1">
              <stop offset="0%" stopColor="var(--primary-purple)" stopOpacity="0.3" />
              <stop offset="50%" stopColor="var(--primary-blue)" stopOpacity="0.15" />
              <stop offset="100%" stopColor="var(--primary-green)" stopOpacity="0.05" />
            </linearGradient>
            <linearGradient id="lineGradient" x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="var(--primary-purple)" />
              <stop offset="50%" stopColor="var(--primary-blue)" />
              <stop offset="100%" stopColor="var(--primary-green)" />
            </linearGradient>
          </defs>

          {/* Area under line */}
          <motion.path
            d={areaD}
            fill="url(#areaGradient)"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            transition={{ duration: 0.5 }}
          />

          {/* Main line */}
          <motion.path
            d={pathD}
            fill="none"
            stroke="url(#lineGradient)"
            strokeWidth="0.5"
            strokeLinecap="round"
            strokeLinejoin="round"
            initial={{ pathLength: 0 }}
            animate={{ pathLength: 1 }}
            transition={{ duration: 1.5, ease: 'easeInOut' }}
          />

          {/* Data points */}
          {points.map((point, index) => (
            <motion.circle
              key={index}
              cx={point.x}
              cy={point.y}
              r="1"
              fill="var(--black)"
              initial={{ scale: 0, opacity: 0 }}
              animate={{ scale: 1, opacity: 1 }}
              transition={{ delay: 0.5 + index * 0.05, duration: 0.3 }}
              className="chart-point"
            >
              <title>{formatDate(point.date)}: {formatFollowers(point.followers)}</title>
            </motion.circle>
          ))}
        </svg>

        {/* X-axis labels */}
        <div className="chart-x-labels">
          <span className="chart-label">{formatDate(data[0].date)}</span>
          {data.length > 6 && (
            <span className="chart-label">{formatDate(data[Math.floor(data.length / 2)].date)}</span>
          )}
          <span className="chart-label">{formatDate(data[data.length - 1].date)}</span>
        </div>

        {/* Y-axis grid and labels */}
        <div className="chart-y-axis">
          <span className="chart-y-label">{formatFollowers(maxFollowers)}</span>
          <span className="chart-y-label chart-y-label-mid">{formatFollowers((maxFollowers + minFollowers) / 2)}</span>
          <span className="chart-y-label">{formatFollowers(minFollowers)}</span>
        </div>
      </div>
    </div>
  );
};

