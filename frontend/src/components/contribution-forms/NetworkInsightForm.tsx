import { useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { NetworkInsightContribution } from '../../types';
import { validateContribution } from '../../utils/contributionValidator';
import { ArrowLeft, CheckCircle, AlertTriangle, XCircle } from 'lucide-react';

interface NetworkInsightFormProps {
  influencerId: string;
  onClose: () => void;
  onBack: () => void;
}

export const NetworkInsightForm = ({ influencerId, onClose, onBack }: NetworkInsightFormProps) => {
  const { user } = useAuth();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [validationResult, setValidationResult] = useState<any>(null);

  const [formData, setFormData] = useState({
    connectionType: 'collaboration' as const,
    targetName: '',
    targetType: 'influencer' as const,
    description: '',
    strength: 5,
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;

    setIsSubmitting(true);

    const contribution: Partial<NetworkInsightContribution> = {
      type: 'network-insight',
      influencerId,
      userId: user.id,
      connectionType: formData.connectionType,
      targetId: `target-${Date.now()}`,
      targetName: formData.targetName,
      targetType: formData.targetType,
      description: formData.description,
      strength: formData.strength,
      submittedAt: new Date().toISOString(),
      status: 'pending',
    };

    const validation = await validateContribution(contribution as NetworkInsightContribution);
    setValidationResult(validation);
    setIsSubmitting(false);

    if (validation.isValid && validation.issues.length === 0) {
      setTimeout(() => onClose(), 2000);
    }
  };

  const isFormValid = formData.targetName.trim() !== '' && formData.description.trim() !== '';

  return (
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <label htmlFor="connectionType" className="required">Connection Type</label>
        <select
          id="connectionType"
          value={formData.connectionType}
          onChange={(e) => setFormData({ ...formData, connectionType: e.target.value as any })}
          required
        >
          <option value="collaboration">Collaboration</option>
          <option value="friendship">Friendship</option>
          <option value="business">Business Relationship</option>
          <option value="family">Family</option>
          <option value="other">Other</option>
        </select>
      </div>

      <div className="form-group">
        <label htmlFor="targetType" className="required">Connected Entity Type</label>
        <select
          id="targetType"
          value={formData.targetType}
          onChange={(e) => setFormData({ ...formData, targetType: e.target.value as any })}
          required
        >
          <option value="influencer">Influencer</option>
          <option value="brand">Brand</option>
          <option value="agency">Agency</option>
        </select>
      </div>

      <div className="form-group">
        <label htmlFor="targetName" className="required">Name</label>
        <input
          type="text"
          id="targetName"
          value={formData.targetName}
          onChange={(e) => setFormData({ ...formData, targetName: e.target.value })}
          placeholder="Name of the connected entity"
          required
        />
      </div>

      <div className="form-group">
        <label htmlFor="description" className="required">Description</label>
        <textarea
          id="description"
          value={formData.description}
          onChange={(e) => setFormData({ ...formData, description: e.target.value })}
          placeholder="Describe the connection and provide context"
          required
        />
      </div>

      <div className="form-group">
        <label htmlFor="strength">
          Connection Strength: <span className="slider-value">{formData.strength}/10</span>
        </label>
        <input
          type="range"
          id="strength"
          className="confidence-slider"
          min="1"
          max="10"
          value={formData.strength}
          onChange={(e) => setFormData({ ...formData, strength: parseInt(e.target.value) })}
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
