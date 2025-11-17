import { useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { TimelineEventContribution } from '../../types';
import { validateContribution } from '../../utils/contributionValidator';
import { ArrowLeft, CheckCircle, AlertTriangle, XCircle } from 'lucide-react';

interface TimelineEventFormProps {
  influencerId: string;
  onClose: () => void;
  onBack: () => void;
}

const eventTypes = ['viral-moment', 'collaboration', 'controversy', 'milestone', 'other'] as const;

export const TimelineEventForm = ({ influencerId, onClose, onBack }: TimelineEventFormProps) => {
  const { user } = useAuth();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [validationResult, setValidationResult] = useState<any>(null);

  const [formData, setFormData] = useState({
    eventType: 'other' as typeof eventTypes[number],
    title: '',
    description: '',
    date: new Date().toISOString().split('T')[0],
    evidenceLink: '',
    platform: '',
    confidence: 70,
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;

    setIsSubmitting(true);

    const contribution: Partial<TimelineEventContribution> = {
      type: 'timeline-event',
      influencerId,
      userId: user.id,
      eventType: formData.eventType,
      title: formData.title,
      description: formData.description,
      date: formData.date,
      evidence: {
        link: formData.evidenceLink || undefined,
        platform: formData.platform || undefined,
      },
      confidence: formData.confidence,
      submittedAt: new Date().toISOString(),
      status: 'pending',
    };

    const validation = await validateContribution(contribution as TimelineEventContribution);
    setValidationResult(validation);
    setIsSubmitting(false);

    if (validation.isValid && validation.issues.length === 0) {
      setTimeout(() => onClose(), 2000);
    }
  };

  const isFormValid = formData.title.trim() !== '' && formData.description.trim() !== '';

  return (
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <label htmlFor="eventType" className="required">Event Type</label>
        <select
          id="eventType"
          value={formData.eventType}
          onChange={(e) => setFormData({ ...formData, eventType: e.target.value as typeof eventTypes[number] })}
          required
        >
          <option value="viral-moment">Viral Moment</option>
          <option value="collaboration">Collaboration</option>
          <option value="controversy">Controversy</option>
          <option value="milestone">Milestone</option>
          <option value="other">Other</option>
        </select>
      </div>

      <div className="form-group">
        <label htmlFor="title" className="required">Event Title</label>
        <input
          type="text"
          id="title"
          value={formData.title}
          onChange={(e) => setFormData({ ...formData, title: e.target.value })}
          placeholder="Brief, descriptive title"
          required
        />
      </div>

      <div className="form-group">
        <label htmlFor="description" className="required">Description</label>
        <textarea
          id="description"
          value={formData.description}
          onChange={(e) => setFormData({ ...formData, description: e.target.value })}
          placeholder="Provide context and details about this event"
          required
        />
      </div>

      <div className="form-group">
        <label htmlFor="date" className="required">Event Date</label>
        <input
          type="date"
          id="date"
          value={formData.date}
          onChange={(e) => setFormData({ ...formData, date: e.target.value })}
          required
        />
      </div>

      <div className="form-group">
        <label htmlFor="evidenceLink">Evidence Link (optional)</label>
        <input
          type="url"
          id="evidenceLink"
          value={formData.evidenceLink}
          onChange={(e) => setFormData({ ...formData, evidenceLink: e.target.value })}
          placeholder="https://..."
        />
      </div>

      <div className="form-group">
        <label htmlFor="platform">Platform (optional)</label>
        <input
          type="text"
          id="platform"
          value={formData.platform}
          onChange={(e) => setFormData({ ...formData, platform: e.target.value })}
          placeholder="e.g., YouTube, Twitter, Instagram"
        />
      </div>

      <div className="form-group">
        <label htmlFor="confidence">
          Confidence Level: <span className="slider-value">{formData.confidence}%</span>
        </label>
        <input
          type="range"
          id="confidence"
          className="confidence-slider"
          min="0"
          max="100"
          value={formData.confidence}
          onChange={(e) => setFormData({ ...formData, confidence: parseInt(e.target.value) })}
        />
      </div>

      {validationResult && (
        <div className={`validation-feedback ${
          validationResult.isValid && validationResult.issues.length === 0 ? 'success' :
          validationResult.issues.some((i: any) => i.severity === 'high') ? 'error' : 'warning'
        }`}>
          {validationResult.isValid && validationResult.issues.length === 0 ? (
            <div className="validation-issue">
              <CheckCircle size={20} />
              <span>Your contribution will be validated by AI and if everything goes well, it will be published within 24 hours.</span>
            </div>
          ) : (
            validationResult.issues.map((issue: any, index: number) => (
              <div key={index} className="validation-issue">
                {issue.severity === 'high' ? <XCircle size={20} /> : <AlertTriangle size={20} />}
                <span>{issue.message}</span>
              </div>
            ))
          )}
        </div>
      )}

      <div className="form-actions">
        <button type="button" className="btn btn-secondary" onClick={onBack}>
          <ArrowLeft size={16} style={{ marginRight: '8px' }} />
          Back
        </button>
        <button
          type="submit"
          className="btn btn-primary"
          disabled={!isFormValid || isSubmitting}
        >
          {isSubmitting ? 'Validating...' : 'Submit Contribution'}
        </button>
      </div>
    </form>
  );
};
