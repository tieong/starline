-- Starline Database Schema for Supabase

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- User Profiles Table
-- This table stores user profile data and reputation metrics
CREATE TABLE user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL,
  avatar TEXT,
  reputation_score INTEGER DEFAULT 0 CHECK (reputation_score >= 0 AND reputation_score <= 100),
  total_submissions INTEGER DEFAULT 0,
  approved_submissions INTEGER DEFAULT 0,
  flagged_submissions INTEGER DEFAULT 0,
  badges JSONB DEFAULT '[]'::jsonb,
  contribution_history JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Contributions Table
-- Stores all user-submitted insights
CREATE TABLE contributions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES user_profiles(id) ON DELETE CASCADE,
  influencer_id TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('timeline-event', 'brand-signal', 'network-insight', 'platform-correction', 'general-context')),
  data JSONB NOT NULL,
  confidence INTEGER CHECK (confidence >= 0 AND confidence <= 100),
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected', 'flagged')),
  submitted_at TIMESTAMPTZ DEFAULT NOW(),
  reviewed_at TIMESTAMPTZ,
  reviewed_by UUID REFERENCES user_profiles(id),
  review_notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Timeline Events Table
-- Stores approved timeline events
CREATE TABLE timeline_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  influencer_id TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  event_date DATE NOT NULL,
  category TEXT NOT NULL,
  severity TEXT CHECK (severity IN ('positive', 'neutral', 'negative')),
  source_url TEXT,
  contribution_id UUID REFERENCES contributions(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Brand Signals Table
-- Stores approved brand collaborations
CREATE TABLE brand_signals (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  influencer_id TEXT NOT NULL,
  brand_name TEXT NOT NULL,
  category TEXT NOT NULL,
  evidence JSONB NOT NULL,
  post_link TEXT,
  spotted_date DATE,
  contribution_id UUID REFERENCES contributions(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Network Insights Table
-- Stores approved network connections
CREATE TABLE network_insights (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  from_entity_id TEXT NOT NULL,
  to_entity_id TEXT NOT NULL,
  relationship_type TEXT NOT NULL,
  description TEXT,
  evidence_link TEXT,
  contribution_id UUID REFERENCES contributions(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Platform Corrections Table
-- Stores platform data corrections
CREATE TABLE platform_corrections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  influencer_id TEXT NOT NULL,
  correction_type TEXT NOT NULL CHECK (correction_type IN ('add-platform', 'incorrect-followers', 'other')),
  platform_name TEXT,
  correct_value TEXT,
  evidence_link TEXT,
  contribution_id UUID REFERENCES contributions(id),
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'applied', 'rejected')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- General Context Table
-- Stores general contextual information
CREATE TABLE general_context (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  influencer_id TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT,
  source_link TEXT,
  contribution_id UUID REFERENCES contributions(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_contributions_user_id ON contributions(user_id);
CREATE INDEX idx_contributions_influencer_id ON contributions(influencer_id);
CREATE INDEX idx_contributions_status ON contributions(status);
CREATE INDEX idx_contributions_type ON contributions(type);
CREATE INDEX idx_timeline_events_influencer_id ON timeline_events(influencer_id);
CREATE INDEX idx_brand_signals_influencer_id ON brand_signals(influencer_id);
CREATE INDEX idx_network_insights_from_entity ON network_insights(from_entity_id);
CREATE INDEX idx_network_insights_to_entity ON network_insights(to_entity_id);
CREATE INDEX idx_platform_corrections_influencer_id ON platform_corrections(influencer_id);
CREATE INDEX idx_general_context_influencer_id ON general_context(influencer_id);

-- Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE contributions ENABLE ROW LEVEL SECURITY;
ALTER TABLE timeline_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE brand_signals ENABLE ROW LEVEL SECURITY;
ALTER TABLE network_insights ENABLE ROW LEVEL SECURITY;
ALTER TABLE platform_corrections ENABLE ROW LEVEL SECURITY;
ALTER TABLE general_context ENABLE ROW LEVEL SECURITY;

-- User Profiles Policies
CREATE POLICY "Users can view all profiles" ON user_profiles
  FOR SELECT USING (true);

CREATE POLICY "Users can update own profile" ON user_profiles
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile" ON user_profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Contributions Policies
CREATE POLICY "Users can view all contributions" ON contributions
  FOR SELECT USING (true);

CREATE POLICY "Users can insert own contributions" ON contributions
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own pending contributions" ON contributions
  FOR UPDATE USING (auth.uid() = user_id AND status = 'pending');

-- Timeline Events Policies
CREATE POLICY "Anyone can view timeline events" ON timeline_events
  FOR SELECT USING (true);

-- Brand Signals Policies
CREATE POLICY "Anyone can view brand signals" ON brand_signals
  FOR SELECT USING (true);

-- Network Insights Policies
CREATE POLICY "Anyone can view network insights" ON network_insights
  FOR SELECT USING (true);

-- Platform Corrections Policies
CREATE POLICY "Anyone can view platform corrections" ON platform_corrections
  FOR SELECT USING (true);

-- General Context Policies
CREATE POLICY "Anyone can view general context" ON general_context
  FOR SELECT USING (true);

-- Functions

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers to auto-update updated_at
CREATE TRIGGER update_user_profiles_updated_at BEFORE UPDATE ON user_profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contributions_updated_at BEFORE UPDATE ON contributions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_timeline_events_updated_at BEFORE UPDATE ON timeline_events
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_brand_signals_updated_at BEFORE UPDATE ON brand_signals
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_network_insights_updated_at BEFORE UPDATE ON network_insights
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_platform_corrections_updated_at BEFORE UPDATE ON platform_corrections
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_general_context_updated_at BEFORE UPDATE ON general_context
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to update user reputation when contribution is approved
CREATE OR REPLACE FUNCTION update_user_reputation()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'approved' AND OLD.status != 'approved' THEN
    UPDATE user_profiles
    SET
      approved_submissions = approved_submissions + 1,
      reputation_score = LEAST(100, reputation_score + 5)
    WHERE id = NEW.user_id;
  ELSIF NEW.status = 'flagged' AND OLD.status != 'flagged' THEN
    UPDATE user_profiles
    SET
      flagged_submissions = flagged_submissions + 1,
      reputation_score = GREATEST(0, reputation_score - 10)
    WHERE id = NEW.user_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER contribution_status_change AFTER UPDATE ON contributions
  FOR EACH ROW EXECUTE FUNCTION update_user_reputation();

-- Function to increment total_submissions when a new contribution is created
CREATE OR REPLACE FUNCTION increment_total_submissions()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE user_profiles
  SET total_submissions = total_submissions + 1
  WHERE id = NEW.user_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER new_contribution_created AFTER INSERT ON contributions
  FOR EACH ROW EXECUTE FUNCTION increment_total_submissions();
