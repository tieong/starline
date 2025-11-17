import { useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { PlatformCorrectionContribution } from '../../types';
import { validateContribution } from '../../utils/contributionValidator';
import { ArrowLeft, CheckCircle, AlertTriangle, XCircle } from 'lucide-react';

interface PlatformCorrectionFormProps {
  influencerId: string;
  onClose: () => void;
  onBack: () => void;
}

export const PlatformCorrectionForm = ({ influencerId, onClose, onBack }: PlatformCorrectionFormProps) => {
  const { user } = useAuth();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [validationResult, setValidationResult] = useState<any>(null);

  const [formData, setFormData] = useState<{
    correctionType: 'missing-platform' | 'incorrect-followers' | 'incorrect-handle' | 'other';
    platform: string;
    currentValue: string;
    correctedValue: string;
    evidence: string;
  }>({
    correctionType: 'incorrect-followers',
    platform: '',
    currentValue: '',
    correctedValue: '',
    evidence: '',
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;

    setIsSubmitting(true);

    const contribution: Partial<PlatformCorrectionContribution> = {
      type: 'platform-correction',
      influencerId,
      userId: user.id,
      correctionType: formData.correctionType,
      platform: formData.platform || undefined,
      currentValue: formData.currentValue,
      correctedValue: formData.correctedValue,
      evidence: formData.evidence || undefined,
      submittedAt: new Date().toISOString(),
      status: 'pending',
    };

    const validation = await validateContribution(contribution as PlatformCorrectionContribution);
    setValidationResult(validation);
    setIsSubmitting(false);

    if (validation.isValid && validation.issues.length === 0) {
      setTimeout(() => onClose(), 2000);
    }
  };

  const isFormValid = formData.correctedValue.trim() !== '';

  return (
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <label htmlFor="correctionType" className="required">Correction Type</label>
        <select
          id="correctionType"
          value={formData.correctionType}
          onChange={(e) => setFormData({ ...formData, correctionType: e.target.value as any })}
          required
        >
          <option value="missing-platform">Missing Platform</option>
          <option value="incorrect-followers">Incorrect Follower Count</option>
          <option value="incorrect-handle">Incorrect Handle</option>
          <option value="other">Other</option>
        </select>
      </div>

      {formData.correctionType !== 'other' && (
        <div className="form-group">
          <label htmlFor="platform">Platform</label>
          <input
            type="text"
            id="platform"
            value={formData.platform}
            onChange={(e) => setFormData({ ...formData, platform: e.target.value })}
            placeholder="e.g., YouTube, TikTok, Instagram"
          />
        </div>
      )}

      <div className="form-group">
        <label htmlFor="currentValue">Current Value (if any)</label>
        <input
          type="text"
          id="currentValue"
          value={formData.currentValue}
          onChange={(e) => setFormData({ ...formData, currentValue: e.target.value })}
          placeholder="What's currently shown"
        />
      </div>

      <div className="form-group">
        <label htmlFor="correctedValue" className="required">Corrected Value</label>
        <input
          type="text"
          id="correctedValue"
          value={formData.correctedValue}
          onChange={(e) => setFormData({ ...formData, correctedValue: e.target.value })}
          placeholder="The correct information"
          required
        />
      </div>

      <div className="form-group">
        <label htmlFor="evidence">Evidence Link (optional)</label>
        <input
          type="url"
          id="evidence"
          value={formData.evidence}
          onChange={(e) => setFormData({ ...formData, evidence: e.target.value })}
          placeholder="Link to proof"
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
