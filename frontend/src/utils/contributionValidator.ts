import { Contribution, ValidationResult, ValidationIssue } from '../types';

// Simulated list of existing contributions for duplicate detection
const existingContributions: Partial<Contribution>[] = [
  {
    type: 'brand-signal',
    influencerId: 'cyprien',
    brandName: 'Raid Shadow Legends',
  },
  {
    type: 'timeline-event',
    influencerId: 'squeezie',
    title: 'Lancement de Popcorn',
  },
];

// Blocklist for defamatory or unsafe content
const blocklist = ['scandal', 'fake', 'scam', 'fraud'];

/**
 * Simulates AI validation of a contribution
 * Checks for duplicates, contradictions, impossible info, wrong platform, defamation, unsafe content
 */
export const validateContribution = async (
  contribution: Contribution
): Promise<ValidationResult> => {
  // Simulate API delay
  await new Promise(resolve => setTimeout(resolve, 800));

  const issues: ValidationIssue[] = [];

  // Check for duplicates
  const duplicate = existingContributions.find(
    existing =>
      existing.type === contribution.type &&
      existing.influencerId === contribution.influencerId &&
      (contribution.type === 'brand-signal' &&
        existing.type === 'brand-signal' &&
        existing.brandName?.toLowerCase() === (contribution as any).brandName?.toLowerCase())
  );

  if (duplicate) {
    issues.push({
      type: 'duplicate',
      severity: 'medium',
      message: 'Similar contribution already exists. Consider adding additional context instead.',
    });
  }

  // Check confidence level
  if (contribution.confidence !== undefined && contribution.confidence < 30) {
    issues.push({
      type: 'impossible',
      severity: 'low',
      message: 'Low confidence level detected. Consider gathering more evidence before submitting.',
    });
  }

  // Check for unsafe content (simplified keyword check)
  const contentToCheck = JSON.stringify(contribution).toLowerCase();
  const foundBlockedWords = blocklist.filter(word => contentToCheck.includes(word));

  if (foundBlockedWords.length > 0) {
    issues.push({
      type: 'defamation',
      severity: 'high',
      message: 'Content may contain inappropriate or defamatory language. Please review before submitting.',
    });
  }

  // Type-specific validation
  if (contribution.type === 'brand-signal') {
    const brandSignal = contribution as any;
    const hasEvidence = Object.values(brandSignal.evidence).some(v => v === true);

    if (!hasEvidence) {
      issues.push({
        type: 'impossible',
        severity: 'high',
        message: 'At least one evidence type must be selected.',
      });
    }
  }

  if (contribution.type === 'platform-correction') {
    const platformCorrection = contribution as any;

    if (platformCorrection.currentValue === platformCorrection.correctedValue) {
      issues.push({
        type: 'contradiction',
        severity: 'high',
        message: 'Corrected value is the same as current value.',
      });
    }
  }

  // Determine auto-routing based on contribution type
  let targetSection: 'timeline' | 'collabs' | 'network' | 'sentiment' | 'platform';
  let routingConfidence = 95;

  switch (contribution.type) {
    case 'timeline-event':
      targetSection = 'timeline';
      break;
    case 'brand-signal':
      targetSection = 'collabs';
      break;
    case 'network-insight':
      targetSection = 'network';
      break;
    case 'platform-correction':
      targetSection = 'platform';
      break;
    case 'general-context':
      targetSection = 'sentiment';
      routingConfidence = 70; // Lower confidence for general context
      break;
    default:
      targetSection = 'sentiment';
      routingConfidence = 50;
  }

  const isValid = !issues.some(issue => issue.severity === 'high');

  return {
    isValid,
    issues,
    autoRouting: {
      targetSection,
      confidence: routingConfidence,
    },
  };
};
