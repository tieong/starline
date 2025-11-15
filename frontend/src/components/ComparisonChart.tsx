import { motion } from 'framer-motion';
import { SubscriberGrowthPoint } from '../types';
import './ComparisonChart.css';
import { X } from 'lucide-react';
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Legend, ResponsiveContainer } from 'recharts';
import { ChartContainer, ChartTooltip, ChartTooltipContent } from './ui/chart';

interface ComparisonChartProps {
  influencer1: {
    name: string;
    data: SubscriberGrowthPoint[];
    color: string;
  };
  influencer2?: {
    name: string;
    data: SubscriberGrowthPoint[];
    color: string;
  };
  onRemoveComparison?: () => void;
}

export const ComparisonChart = ({
  influencer1,
  influencer2,
  onRemoveComparison
}: ComparisonChartProps) => {

  if (!influencer1.data || influencer1.data.length === 0) {
    return null;
  }

  const formatDate = (dateStr: string) => {
    const [year, month] = dateStr.split('-');
    const monthNames = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun', 'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'];
    return `${monthNames[parseInt(month) - 1]} ${year}`;
  };

  const formatFollowers = (num: number) => {
    if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`;
    if (num >= 1000) return `${(num / 1000).toFixed(1)}K`;
    return num.toString();
  };

  const calculatePercentageGrowth = (data: SubscriberGrowthPoint[]) => {
    if (data.length < 2) return 0;
    const firstValue = data[0].followers;
    const lastValue = data[data.length - 1].followers;
    return ((lastValue - firstValue) / firstValue) * 100;
  };

  // Prepare combined data for recharts
  const prepareChartData = () => {
    const dataMap = new Map<string, any>();

    // Add influencer1 data
    influencer1.data.forEach((point) => {
      const startValue = influencer1.data[0].followers;
      const percentChange = ((point.followers - startValue) / startValue) * 100;
      const key = point.date;

      if (!dataMap.has(key)) {
        dataMap.set(key, { name: formatDate(point.date), date: point.date });
      }
      dataMap.get(key)![influencer1.name] = percentChange;
    });

    // Add influencer2 data if present
    if (influencer2 && influencer2.data && influencer2.data.length > 0) {
      influencer2.data.forEach((point) => {
        const startValue = influencer2.data[0].followers;
        const percentChange = ((point.followers - startValue) / startValue) * 100;
        const key = point.date;

        if (!dataMap.has(key)) {
          dataMap.set(key, { name: formatDate(point.date), date: point.date });
        }
        dataMap.get(key)![influencer2.name] = percentChange;
      });
    }

    return Array.from(dataMap.values());
  };

  // Calculate stats for both influencers
  const growth1 = calculatePercentageGrowth(influencer1.data);
  const growth2 = influencer2 && influencer2.data && influencer2.data.length > 0
    ? calculatePercentageGrowth(influencer2.data)
    : null;

  const totalGrowth1 = influencer1.data[influencer1.data.length - 1].followers - influencer1.data[0].followers;
  const totalGrowth2 = influencer2 && influencer2.data && influencer2.data.length > 0
    ? influencer2.data[influencer2.data.length - 1].followers - influencer2.data[0].followers
    : null;

  const chartData = prepareChartData();

  // Chart configuration for shadcn/ui
  const chartConfig = {
    [influencer1.name]: {
      label: influencer1.name,
      theme: {
        light: influencer1.color,
        dark: influencer1.color,
      },
    },
    ...(influencer2 && {
      [influencer2.name]: {
        label: influencer2.name,
        theme: {
          light: influencer2.color,
          dark: influencer2.color,
        },
      },
    }),
  };

  return (
    <div className="comparison-chart">
      <div className="comparison-header">
        <div className="comparison-title-group">
          <h3 className="comparison-title">
            Comparaison de progression
          </h3>
          <p className="comparison-subtitle">
            Performance relative sur {influencer1.data.length} mois
          </p>
        </div>
        {influencer2 && onRemoveComparison && (
          <button
            className="remove-comparison-btn"
            onClick={onRemoveComparison}
            title="Retirer la comparaison"
          >
            <X size={18} />
          </button>
        )}
      </div>

      <div className="comparison-legends">
        <div className="comparison-legend">
          <div
            className="legend-color"
            style={{ background: influencer1.color }}
          />
          <div className="legend-info">
            <span className="legend-name">{influencer1.name}</span>
            <div className="legend-stats">
              <span className="legend-growth">{formatFollowers(totalGrowth1)}</span>
              <span
                className="legend-percent"
                style={{ color: growth1 > 0 ? 'var(--primary-green)' : 'var(--primary-red)' }}
              >
                {growth1 > 0 ? '+' : ''}{growth1.toFixed(1)}%
              </span>
            </div>
          </div>
        </div>

        {influencer2 && influencer2.data && influencer2.data.length > 0 && totalGrowth2 !== null && growth2 !== null && (
          <div className="comparison-legend">
            <div
              className="legend-color"
              style={{ background: influencer2.color }}
            />
            <div className="legend-info">
              <span className="legend-name">{influencer2.name}</span>
              <div className="legend-stats">
                <span className="legend-growth">{formatFollowers(totalGrowth2)}</span>
                <span
                  className="legend-percent"
                  style={{ color: growth2 > 0 ? 'var(--primary-green)' : 'var(--primary-red)' }}
                >
                  {growth2 > 0 ? '+' : ''}{growth2.toFixed(1)}%
                </span>
              </div>
            </div>
          </div>
        )}
      </div>

      <motion.div
        className="comparison-container-wrapper"
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 0.5 }}
      >
        <ChartContainer config={chartConfig} className="w-full">
          <div className="comparison-container">
            <ResponsiveContainer width="100%" height={400}>
              <AreaChart
                data={chartData}
                margin={{ top: 16, right: 24, left: 0, bottom: 48 }}
              >
                <defs>
                  <linearGradient id={`gradient1`} x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor={influencer1.color} stopOpacity={0.8} />
                    <stop offset="95%" stopColor={influencer1.color} stopOpacity={0.1} />
                  </linearGradient>
                  {influencer2 && (
                    <linearGradient id={`gradient2`} x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor={influencer2.color} stopOpacity={0.8} />
                      <stop offset="95%" stopColor={influencer2.color} stopOpacity={0.1} />
                    </linearGradient>
                  )}
                </defs>
                <CartesianGrid
                  strokeDasharray="2 2"
                  stroke="var(--border-subtle)"
                  vertical={false}
                />
                <XAxis
                  dataKey="name"
                  stroke="var(--border-subtle)"
                  style={{ fontSize: '11px', fontFamily: 'var(--font-sans)' }}
                  tick={{ fill: 'var(--text-muted)' }}
                  tickLine={{ stroke: 'var(--border-subtle)' }}
                />
                <YAxis
                  stroke="var(--border-subtle)"
                  style={{ fontSize: '12px', fontFamily: 'var(--font-sans)' }}
                  tick={{ fill: 'var(--text-muted)' }}
                  label={{ 
                    value: 'CROISSANCE %', 
                    angle: -90, 
                    position: 'insideLeft',
                    style: { 
                      fontSize: '11px', 
                      fontFamily: 'var(--font-sans)',
                      textTransform: 'uppercase',
                      letterSpacing: '0.08em',
                      fill: 'var(--text-muted)'
                    }
                  }}
                />
                <ChartTooltip
                  content={<ChartTooltipContent indicator="line" />}
                  cursor={{ stroke: 'var(--border-main)', strokeWidth: 1, strokeDasharray: '2 2' }}
                />
                <Legend
                  wrapperStyle={{ fontSize: '13px', fontFamily: 'var(--font-sans)' }}
                />
                <Area
                  type="monotone"
                  dataKey={influencer1.name}
                  stroke={influencer1.color}
                  strokeWidth={2}
                  fill={`url(#gradient1)`}
                  isAnimationActive={true}
                  animationDuration={800}
                />
                {influencer2 && (
                  <Area
                    type="monotone"
                    dataKey={influencer2.name}
                    stroke={influencer2.color}
                    strokeWidth={2}
                    fill={`url(#gradient2)`}
                    isAnimationActive={true}
                    animationDuration={800}
                  />
                )}
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </ChartContainer>
      </motion.div>

      {influencer2 && (
        <div className="comparison-performance-summary">
          <div className="performance-card">
            <span className="performance-label">Meilleure performance</span>
            <span
              className="performance-value"
              style={{ color: growth1 > growth2! ? influencer1.color : influencer2.color }}
            >
              {growth1 > growth2! ? influencer1.name : influencer2.name}
            </span>
          </div>
          <div className="performance-card">
            <span className="performance-label">Différence</span>
            <span className="performance-value">
              {Math.abs(growth1 - growth2!).toFixed(1)} points
            </span>
          </div>
        </div>
      )}
    </div>
  );
};
