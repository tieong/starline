import { useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { GeneralContextContribution } from '../../types';
import { validateContribution } from '../../utils/contributionValidator';
import { ArrowLeft, CheckCircle, AlertTriangle, XCircle } from 'lucide-react';

interface GeneralContextFormProps {
  influencerId: string;
  onClose: () => void;
  onBack: () => void;
}

export const GeneralContextForm = ({ influencerId, onClose, onBack }: GeneralContextFormProps) => {
  const { user } = useAuth();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [validationResult, setValidationResult] = useState<any>(null);

  const [formData, setFormData] = useState({
    category: '',
    content: '',
    tags: '',
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;

    setIsSubmitting(true);

    const contribution: Partial<GeneralContextContribution> = {
      type: 'general-context',
      influencerId,
      userId: user.id,
      category: formData.category,
      content: formData.content,
      tags: formData.tags.split(',').map(t => t.trim()).filter(t => t),
      submittedAt: new Date().toISOString(),
      status: 'pending',
    };

    const validation = await validateContribution(contribution as GeneralContextContribution);
    setValidationResult(validation);
    setIsSubmitting(false);

    if (validation.isValid && validation.issues.length === 0) {
      setTimeout(() => onClose(), 2000);
    }
  };

  const isFormValid = formData.category.trim() !== '' && formData.content.trim() !== '';

  return (
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <label htmlFor="category" className="required">Category</label>
        <input
          type="text"
          id="category"
          value={formData.category}
          onChange={(e) => setFormData({ ...formData, category: e.target.value })}
          placeholder="e.g., Personal Life, Career, Education"
          required
        />
      </div>

      <div className="form-group">
        <label htmlFor="content" className="required">Context Information</label>
        <textarea
          id="content"
          value={formData.content}
          onChange={(e) => setFormData({ ...formData, content: e.target.value })}
          placeholder="Share any relevant context that doesn't fit other categories"
          required
          style={{ minHeight: '150px' }}
        />
      </div>

      <div className="form-group">
        <label htmlFor="tags">Tags (optional)</label>
        <input
          type="text"
          id="tags"
          value={formData.tags}
          onChange={(e) => setFormData({ ...formData, tags: e.target.value })}
          placeholder="e.g., history, fun-fact, background"
        />
        <div className="form-hint">Separate multiple tags with commas</div>
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
