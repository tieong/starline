/**
 * Data Context
 *
 * Manages the data source (mock vs real API) state across the application.
 * Provides a toggle to switch between mock data and real backend API.
 */

import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

interface DataContextType {
  useMockData: boolean;
  toggleDataSource: () => void;
  isLoading: boolean;
  error: string | null;
  apiConnectionStatus: 'connected' | 'disconnected' | 'unknown';
  showToggle: boolean; // Whether to show the data source toggle in UI
}

const DataContext = createContext<DataContextType | undefined>(undefined);

const STORAGE_KEY = 'starline_use_mock_data';

export function DataProvider({ children }: { children: ReactNode }) {
  // Check if mock data is forced via environment variable
  const forceMockData = import.meta.env.VITE_FORCE_MOCK_DATA === 'true';
  const showToggle = !forceMockData; // Hide toggle if forced via env var

  // Initialize from localStorage or env var, default to true (mock data)
  const [useMockData, setUseMockData] = useState<boolean>(() => {
    if (forceMockData) {
      return true; // Always use mock data if env var is set
    }
    const stored = localStorage.getItem(STORAGE_KEY);
    return stored !== null ? stored === 'true' : true;
  });

  const [error, setError] = useState<string | null>(null);
  const [isTransitioning, setIsTransitioning] = useState(false);
  const [apiConnectionStatus, setApiConnectionStatus] = useState<'connected' | 'disconnected' | 'unknown'>('unknown');

  // Persist to localStorage whenever it changes
  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, useMockData.toString());
  }, [useMockData]);

  // Check API connection status when using real API
  useEffect(() => {
    if (!useMockData) {
      const checkApiConnection = async () => {
        try {
          const response = await fetch(`${import.meta.env.VITE_API_URL || 'http://localhost:8000'}/health`, {
            method: 'GET',
            signal: AbortSignal.timeout(5000), // 5 second timeout
          });
          
          if (response.ok) {
            setApiConnectionStatus('connected');
            setError(null);
          } else {
            setApiConnectionStatus('disconnected');
            setError('API connection failed');
          }
        } catch (err) {
          setApiConnectionStatus('disconnected');
          setError('Cannot reach API server');
        }
      };

      checkApiConnection();
      
      // Check every 30 seconds when using API
      const interval = setInterval(checkApiConnection, 30000);
      
      return () => clearInterval(interval);
    } else {
      setApiConnectionStatus('unknown');
      setError(null);
    }
  }, [useMockData]);

  const toggleDataSource = () => {
    // Don't allow toggling if mock data is forced via env var
    if (forceMockData) {
      return;
    }

    // Trigger page transition animation
    setIsTransitioning(true);
    document.body.classList.add('page-transitioning');

    // Toggle after a brief delay for animation
    setTimeout(() => {
      setUseMockData((prev) => !prev);
      setError(null);
    }, 150);

    // Remove transition class after animation completes
    setTimeout(() => {
      setIsTransitioning(false);
      document.body.classList.remove('page-transitioning');
    }, 600);
  };

  return (
    <DataContext.Provider
      value={{
        useMockData,
        toggleDataSource,
        isLoading: isTransitioning,
        error,
        apiConnectionStatus,
        showToggle,
      }}
    >
      {children}
    </DataContext.Provider>
  );
}

export function useDataContext() {
  const context = useContext(DataContext);
  if (context === undefined) {
    throw new Error('useDataContext must be used within a DataProvider');
  }
  return context;
}
