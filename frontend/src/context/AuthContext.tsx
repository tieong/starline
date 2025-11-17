import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { supabase } from '../lib/supabase';
import { User } from '../types';

interface AuthContextType {
  user: User | null;
  isAuthenticated: boolean;
  loading: boolean;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
  signup: (username: string, email: string, password: string) => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  // Load user profile from database
  const loadUserProfile = async (userId: string) => {
    try {
      const { data: profile, error } = await supabase
        .from('user_profiles')
        .select('*')
        .eq('id', userId)
        .single();

      if (error) throw error;

      if (profile) {
        const userData: User = {
          id: profile.id,
          username: profile.username,
          email: profile.email,
          avatar: profile.avatar,
          reputation: {
            userId: profile.id,
            score: profile.reputation_score || 0,
            totalSubmissions: profile.total_submissions || 0,
            approvedSubmissions: profile.approved_submissions || 0,
            flaggedSubmissions: profile.flagged_submissions || 0,
            badges: profile.badges || [],
            joinedDate: profile.created_at,
            contributionHistory: profile.contribution_history || [],
          },
          createdAt: profile.created_at,
        };
        setUser(userData);
      }
    } catch (error) {
      console.error('Error loading user profile:', error);
    }
  };

  // Check for existing session on mount
  useEffect(() => {
    const initializeAuth = async () => {
      try {
        const { data: { session } } = await supabase.auth.getSession();

        if (session?.user) {
          await loadUserProfile(session.user.id);
        }
      } catch (error) {
        console.error('Error initializing auth:', error);
      } finally {
        setLoading(false);
      }
    };

    initializeAuth();

    // Listen for auth state changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (_event, session) => {
        if (session?.user) {
          await loadUserProfile(session.user.id);
        } else {
          setUser(null);
        }
      }
    );

    return () => {
      subscription.unsubscribe();
    };
  }, []);

  const login = async (email: string, password: string) => {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });

    if (error) throw error;

    if (data.user) {
      await loadUserProfile(data.user.id);
    }
  };

  const logout = async () => {
    const { error } = await supabase.auth.signOut();
    if (error) throw error;
    setUser(null);
  };

  const signup = async (username: string, email: string, password: string) => {
    // Create auth user with username in metadata
    const { data: authData, error: authError } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: {
          username,
        },
      },
    });

    if (authError) throw authError;

    // Check if email confirmation is required
    if (authData.user && !authData.session) {
      // Email confirmation required - user will need to check their email
      throw new Error('Please check your email to confirm your account before signing in.');
    }

    if (authData.user && authData.session) {
      // User is authenticated, create profile
      const { data: profileData, error: profileError } = await supabase
        .from('user_profiles')
        .insert({
          id: authData.user.id,
          username,
          email,
          reputation_score: 0,
          total_submissions: 0,
          approved_submissions: 0,
          flagged_submissions: 0,
          badges: [],
          contribution_history: [],
        })
        .select()
        .single();

      if (profileError) {
        console.error('Profile creation error:', profileError);
        throw new Error(`Failed to create profile: ${profileError.message}`);
      }

      // Set user state directly from the created profile
      if (profileData) {
        const userData: User = {
          id: profileData.id,
          username: profileData.username,
          email: profileData.email,
          avatar: profileData.avatar,
          reputation: {
            userId: profileData.id,
            score: profileData.reputation_score || 0,
            totalSubmissions: profileData.total_submissions || 0,
            approvedSubmissions: profileData.approved_submissions || 0,
            flaggedSubmissions: profileData.flagged_submissions || 0,
            badges: profileData.badges || [],
            joinedDate: profileData.created_at,
            contributionHistory: profileData.contribution_history || [],
          },
          createdAt: profileData.created_at,
        };
        setUser(userData);
      }
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        isAuthenticated: !!user,
        loading,
        login,
        logout,
        signup,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
