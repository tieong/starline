import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Sparkles, CheckCircle } from 'lucide-react';
import './EarlyAccessModal.css';

interface EarlyAccessModalProps {
  isOpen: boolean;
  onClose: () => void;
  source?: string;
}

const roles = [
  'Brand Manager',
  'Marketing Agency',
  'PR Professional',
  'Talent Manager',
  'Social Media Strategist',
  'Journalist/Researcher',
  'Content Creator',
  'Influencer Follower/Fan',
  'Other',
];

export const EarlyAccessModal = ({ isOpen, onClose, source = 'unknown' }: EarlyAccessModalProps) => {
  const [formData, setFormData] = useState({
    email: '',
    fullName: '',
    company: '',
    role: '',
    useCase: '',
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setIsSubmitting(true);

    try {
      // Use direct fetch instead of Supabase client
      const response = await fetch(`${import.meta.env.VITE_SUPABASE_URL}/rest/v1/early_access_requests`, {
        method: 'POST',
        headers: {
          'apikey': import.meta.env.VITE_SUPABASE_ANON_KEY,
          'Authorization': `Bearer ${import.meta.env.VITE_SUPABASE_ANON_KEY}`,
          'Content-Type': 'application/json',
          'Prefer': 'return=minimal'
        },
        body: JSON.stringify({
          email: formData.email,
          full_name: formData.fullName,
          company: formData.company || null,
          role: formData.role,
          use_case: formData.useCase || null,
          committed_to_beta: false,
          source,
        })
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.message || 'Failed to submit');
      }

      setIsSuccess(true);
      setTimeout(() => {
        onClose();
        setIsSuccess(false);
        setFormData({
          email: '',
          fullName: '',
          company: '',
          role: '',
          useCase: '',
        });
      }, 3000);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setIsSubmitting(false);
    }
  };

  const isFormValid =
    formData.email.trim() !== '' &&
    formData.fullName.trim() !== '' &&
    formData.role !== '';

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
            className="early-access-modal"
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.95 }}
            transition={{ duration: 0.2 }}
          >
            {!isSuccess ? (
              <>
                <div className="modal-header">
                  <div className="header-content">
                    <Sparkles size={24} className="sparkles-icon" />
                    <h2>Request Early Access</h2>
                  </div>
                  <button className="close-button" onClick={onClose}>
                    <X size={24} />
                  </button>
                </div>

                <div className="modal-content">
                  <p className="modal-subtitle">
                    Join exclusive early access to Starline. Get priority access to new features and shape the future of influencer intelligence.
                  </p>

                  <form className="early-access-form" onSubmit={handleSubmit}>
                    <div className="form-group">
                      <label htmlFor="email">Email *</label>
                      <input
                        id="email"
                        type="email"
                        value={formData.email}
                        onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                        placeholder="your@email.com"
                        required
                      />
                    </div>

                    <div className="form-group">
                      <label htmlFor="fullName">Full Name *</label>
                      <input
                        id="fullName"
                        type="text"
                        value={formData.fullName}
                        onChange={(e) => setFormData({ ...formData, fullName: e.target.value })}
                        placeholder="John Doe"
                        required
                      />
                    </div>

                    <div className="form-group">
                      <label htmlFor="company">Company/Agency</label>
                      <input
                        id="company"
                        type="text"
                        value={formData.company}
                        onChange={(e) => setFormData({ ...formData, company: e.target.value })}
                        placeholder="Optional"
                      />
                    </div>

                    <div className="form-group">
                      <label htmlFor="role">Role *</label>
                      <select
                        id="role"
                        value={formData.role}
                        onChange={(e) => setFormData({ ...formData, role: e.target.value })}
                        required
                      >
                        <option value="">Select your role</option>
                        {roles.map((role) => (
                          <option key={role} value={role}>
                            {role}
                          </option>
                        ))}
                      </select>
                    </div>

                    <div className="form-group">
                      <label htmlFor="useCase">What will you use Starline for?</label>
                      <textarea
                        id="useCase"
                        value={formData.useCase}
                        onChange={(e) => setFormData({ ...formData, useCase: e.target.value })}
                        placeholder="e.g., Finding influencers for our fashion brand campaigns, tracking competitor partnerships..."
                        rows={3}
                      />
                    </div>

                    {error && (
                      <div className="error-message">
                        <span>{error}</span>
                      </div>
                    )}

                    <button
                      type="submit"
                      className="btn btn-primary btn-full"
                      disabled={!isFormValid || isSubmitting}
                    >
                      {isSubmitting ? 'Submitting...' : 'Request Early Access'}
                    </button>
                  </form>
                </div>
              </>
            ) : (
              <div className="success-content">
                <CheckCircle size={64} className="success-icon" />
                <h2>You're on the list!</h2>
                <p>
                  Thanks you! Will follow up at <strong>{formData.email}</strong>.
                </p>
                <p className="success-subtext">
                  Check your inbox for next steps and exclusive updates.
                </p>
              </div>
            )}
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
};
