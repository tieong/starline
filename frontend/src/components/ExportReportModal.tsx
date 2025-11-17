import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Download, CheckCircle, Mail } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { Influencer } from '../types';
import './ExportReportModal.css';

interface ExportReportModalProps {
  isOpen: boolean;
  onClose: () => void;
  influencer: Influencer;
}

export const ExportReportModal = ({ isOpen, onClose, influencer }: ExportReportModalProps) => {
  const [email, setEmail] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setIsSubmitting(true);

    try {
      // Track export in database
      const { error: exportError } = await supabase
        .from('influencer_exports')
        .insert({
          email,
          influencer_id: influencer.id,
          influencer_name: influencer.name,
          export_type: 'pdf',
        });

      if (exportError) throw exportError;

      // Track engagement event
      await supabase.from('engagement_events').insert({
        event_type: 'export_report',
        event_category: 'export',
        event_label: influencer.id,
        metadata: { influencer_name: influencer.name },
      });

      setIsSuccess(true);
      setTimeout(() => {
        onClose();
        setIsSuccess(false);
        setEmail('');
      }, 3000);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setIsSubmitting(false);
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
            onClick={onClose}
          />
          <motion.div
            className="export-report-modal"
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.95 }}
            transition={{ duration: 0.2 }}
          >
            {!isSuccess ? (
              <>
                <div className="modal-header">
                  <div className="header-content">
                    <Download size={24} className="download-icon" />
                    <h2>Export Influencer Report</h2>
                  </div>
                  <button className="close-button" onClick={onClose}>
                    <X size={24} />
                  </button>
                </div>

                <div className="modal-content">
                  <div className="influencer-preview">
                    <img src={influencer.avatar} alt={influencer.name} className="influencer-avatar" />
                    <div>
                      <h3>{influencer.name}</h3>
                      <p>{influencer.platformPresence?.length || 0} platforms</p>
                    </div>
                  </div>

                  <p className="modal-subtitle">
                    Get a comprehensive PDF report with all metrics, platforms, collaborations, and timeline events for {influencer.name}.
                  </p>

                  <form className="export-form" onSubmit={handleSubmit}>
                    <div className="form-group">
                      <label htmlFor="email">
                        <Mail size={16} />
                        Email Address
                      </label>
                      <input
                        id="email"
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        placeholder="your@email.com"
                        required
                        autoFocus
                      />
                      <p className="form-hint">We'll send the report to this email within minutes</p>
                    </div>

                    {error && (
                      <div className="error-message">
                        <span>{error}</span>
                      </div>
                    )}

                    <button
                      type="submit"
                      className="btn btn-primary btn-full"
                      disabled={!email.trim() || isSubmitting}
                    >
                      {isSubmitting ? 'Sending...' : 'Send Report to Email'}
                    </button>
                  </form>
                </div>
              </>
            ) : (
              <div className="success-content">
                <CheckCircle size={64} className="success-icon" />
                <h2>Report on its way!</h2>
                <p>
                  We've sent the influencer report for <strong>{influencer.name}</strong> to{' '}
                  <strong>{email}</strong>.
                </p>
                <p className="success-subtext">Check your inbox in a few minutes.</p>
              </div>
            )}
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
};
