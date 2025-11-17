import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, TrendingUp, Package, Network, Database, FileText } from 'lucide-react';
import { ContributionType } from '../types';
import { TimelineEventForm } from './contribution-forms/TimelineEventForm';
import { BrandSignalForm } from './contribution-forms/BrandSignalForm';
import { NetworkInsightForm } from './contribution-forms/NetworkInsightForm';
import { PlatformCorrectionForm } from './contribution-forms/PlatformCorrectionForm';
import { GeneralContextForm } from './contribution-forms/GeneralContextForm';
import './ContributionModal.css';

interface ContributionModalProps {
  isOpen: boolean;
  onClose: () => void;
  influencerId: string;
}

interface InsightTypeOption {
  type: ContributionType;
  title: string;
  description: string;
  icon: React.ReactNode;
  color: string;
}

const insightTypes: InsightTypeOption[] = [
  {
    type: 'timeline-event',
    title: 'Timeline Event',
    description: 'Tell us about a viral moment, collaboration, controversy, milestone.',
    icon: <TrendingUp size={24} />,
    color: '#8B5CF6',
  },
  {
    type: 'brand-signal',
    title: 'Brand / Product / Collab Signal',
    description: 'Did this creator promote a brand or product? Provide context.',
    icon: <Package size={24} />,
    color: '#3B82F6',
  },
  {
    type: 'network-insight',
    title: 'Network / Association Insight',
    description: 'Add a connection, collaboration, or cluster insight.',
    icon: <Network size={24} />,
    color: '#10B981',
  },
  {
    type: 'platform-correction',
    title: 'Platform Data Correction',
    description: 'Missing platform? Incorrect follower number?',
    icon: <Database size={24} />,
    color: '#F59E0B',
  },
  {
    type: 'general-context',
    title: 'General Context',
    description: 'Community knowledge that does not fit above.',
    icon: <FileText size={24} />,
    color: '#6B7280',
  },
];

export const ContributionModal = ({ isOpen, onClose, influencerId }: ContributionModalProps) => {
  const [selectedType, setSelectedType] = useState<ContributionType | null>(null);
  const [step, setStep] = useState<'select' | 'form'>('select');

  const handleTypeSelect = (type: ContributionType) => {
    setSelectedType(type);
    setStep('form');
  };

  const handleBack = () => {
    setStep('select');
    setSelectedType(null);
  };

  const handleClose = () => {
    setStep('select');
    setSelectedType(null);
    onClose();
  };

  const renderForm = () => {
    if (!selectedType) return null;

    switch (selectedType) {
      case 'timeline-event':
        return <TimelineEventForm influencerId={influencerId} onClose={handleClose} onBack={handleBack} />;
      case 'brand-signal':
        return <BrandSignalForm influencerId={influencerId} onClose={handleClose} onBack={handleBack} />;
      case 'network-insight':
        return <NetworkInsightForm influencerId={influencerId} onClose={handleClose} onBack={handleBack} />;
      case 'platform-correction':
        return <PlatformCorrectionForm influencerId={influencerId} onClose={handleClose} onBack={handleBack} />;
      case 'general-context':
        return <GeneralContextForm influencerId={influencerId} onClose={handleClose} onBack={handleBack} />;
      default:
        return null;
    }
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          <motion.div
            className="modal-overlay"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={handleClose}
          />
          <motion.div
            className="contribution-modal"
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.95 }}
            transition={{ duration: 0.2 }}
          >
            <div className="modal-header">
              <h2>{step === 'select' ? 'Contribute Insight' : 'Submit Your Insight'}</h2>
              <button className="close-button" onClick={handleClose}>
                <X size={24} />
              </button>
            </div>

            <div className="modal-content">
              {step === 'select' ? (
                <motion.div
                  className="insight-type-selection"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                >
                  <p className="selection-subtitle">
                    Select the type of insight you'd like to contribute:
                  </p>
                  <div className="insight-types-grid">
                    {insightTypes.map((option) => (
                      <motion.button
                        key={option.type}
                        className="insight-type-card"
                        onClick={() => handleTypeSelect(option.type)}
                        whileHover={{ y: -4, scale: 1.02 }}
                        whileTap={{ scale: 0.98 }}
                        style={{ '--card-color': option.color } as React.CSSProperties}
                      >
                        <div className="card-icon">{option.icon}</div>
                        <h3>{option.title}</h3>
                        <p>{option.description}</p>
                      </motion.button>
                    ))}
                  </div>
                </motion.div>
              ) : (
                <motion.div
                  className="insight-form"
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                >
                  {renderForm()}
                </motion.div>
              )}
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
};
