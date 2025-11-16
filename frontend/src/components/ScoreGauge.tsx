import { motion } from 'framer-motion';
import './ScoreGauge.css';

interface ScoreGaugeProps {
  label: string;
  value: number;
  max?: number;
  color?: string;
  showValue?: boolean;
}

export const ScoreGauge = ({
  label,
  value,
  max = 100,
  color,
  showValue = true
}: ScoreGaugeProps) => {
  const percentage = (value / max) * 100;

  const getColor = () => {
    if (color) return color;
    // Style brutal : toujours noir
    return 'var(--black)';
  };

  return (
    <div className="score-gauge">
      <div className="score-gauge-header">
        <span className="score-gauge-label">{label}</span>
        {showValue && <span className="score-gauge-value">{value}</span>}
      </div>
      <div className="score-gauge-bar">
        <motion.div
          className="score-gauge-fill"
          style={{ backgroundColor: getColor() }}
          initial={{ width: 0 }}
          animate={{ width: `${percentage}%` }}
          transition={{ duration: 1, delay: 0.2, ease: 'easeOut' }}
        />
      </div>
    </div>
  );
};
