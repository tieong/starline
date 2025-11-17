import { useState } from 'react';
import { useAuth } from '../../context/AuthContext';
import { BrandSignalContribution } from '../../types';
import { validateContribution } from '../../utils/contributionValidator';
import { ArrowLeft, CheckCircle, AlertTriangle, XCircle } from 'lucide-react';

interface BrandSignalFormProps {
  influencerId: string;
  onClose: () => void;
  onBack: () => void;
}

const categories = ['food', 'fashion', 'tech', 'beauty', 'gaming', 'lifestyle', 'other'] as const;

export const BrandSignalForm = ({ influencerId, onClose, onBack }: BrandSignalFormProps) => {
  const { user } = useAuth();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [validationResult, setValidationResult] = useState<any>(null);

  const [formData, setFormData] = useState({
    brandName: '',
    category: 'other' as typeof categories[number],
    evidence: {
      productShown: false,
      taggedBrand: false,
      affiliateLink: false,
      repeatedMentions: false,
    },
    postLink: '',
    confidence: 70,
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) return;

    setIsSubmitting(true);

    const contribution: Partial<BrandSignalContribution> = {
      type: 'brand-signal',
      influencerId,
      userId: user.id,
      brandName: formData.brandName,
      category: formData.category,
      evidence: formData.evidence,
      postLink: formData.postLink || undefined,
      confidence: formData.confidence,
      submittedAt: new Date().toISOString(),
      status: 'pending',
    };

    // Client-side validation simulation
    const validation = await validateContribution(contribution as BrandSignalContribution);
    setValidationResult(validation);

    setIsSubmitting(false);

    // If validation passes, show success and close after delay
    if (validation.isValid && validation.issues.length === 0) {
      setTimeout(() => {
        onClose();
      }, 2000);
    }
  };

  const isFormValid = formData.brandName.trim() !== '' &&
    Object.values(formData.evidence).some(v => v === true);

  return (
    <form onSubmit={handleSubmit}>
      <div className="form-group">
        <label htmlFor="brandName" className="required">Brand Name</label>
        <input
          type="text"
          id="brandName"
          value={formData.brandName}
          onChange={(e) => setFormData({ ...formData, brandName: e.target.value })}
          placeholder="e.g., Nike, Coca-Cola, Razer"
          required
        />
        <div className="form-hint">Enter the exact brand name as it appears</div>
      </div>

      <div className="form-group">
        <label htmlFor="category" className="required">Category</label>
        <select
          id="category"
          value={formData.category}
          onChange={(e) => setFormData({ ...formData, category: e.target.value as typeof categories[number] })}
          required
        >
          <option value="food">Food & Beverage</option>
          <option value="fashion">Fashion & Apparel</option>
          <option value="tech">Technology</option>
          <option value="beauty">Beauty & Cosmetics</option>
          <option value="gaming">Gaming</option>
          <option value="lifestyle">Lifestyle</option>
          <option value="other">Other</option>
        </select>
      </div>

      <div className="form-group">
        <label className="required">Evidence (select all that apply)</label>
        <div className="checkbox-group">
          <div className="checkbox-item">
            <input
              type="checkbox"
              id="productShown"
              checked={formData.evidence.productShown}
              onChange={(e) => setFormData({
                ...formData,
                evidence: { ...formData.evidence, productShown: e.target.checked }
              })}
            />
            <label htmlFor="productShown">Product shown in content</label>
          </div>
          <div className="checkbox-item">
            <input
              type="checkbox"
              id="taggedBrand"
              checked={formData.evidence.taggedBrand}
              onChange={(e) => setFormData({
                ...formData,
                evidence: { ...formData.evidence, taggedBrand: e.target.checked }
              })}
            />
            <label htmlFor="taggedBrand">Brand tagged</label>
          </div>
          <div className="checkbox-item">
            <input
              type="checkbox"
              id="affiliateLink"
              checked={formData.evidence.affiliateLink}
              onChange={(e) => setFormData({
                ...formData,
                evidence: { ...formData.evidence, affiliateLink: e.target.checked }
              })}
            />
            <label htmlFor="affiliateLink">Affiliate link provided</label>
          </div>
          <div className="checkbox-item">
            <input
              type="checkbox"
              id="repeatedMentions"
              checked={formData.evidence.repeatedMentions}
              onChange={(e) => setFormData({
                ...formData,
                evidence: { ...formData.evidence, repeatedMentions: e.target.checked }
              })}
            />
            <label htmlFor="repeatedMentions">Repeated mentions across content</label>
          </div>
        </div>
        <div className="form-hint">At least one evidence type is required</div>
      </div>

      <div className="form-group">
        <label htmlFor="postLink">Link to Post (optional)</label>
        <input
          type="url"
          id="postLink"
          value={formData.postLink}
          onChange={(e) => setFormData({ ...formData, postLink: e.target.value })}
          placeholder="https://..."
        />
        <div className="form-hint">Provide a link to the content featuring the brand</div>
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
        <div className="form-hint">How confident are you in this information?</div>
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
