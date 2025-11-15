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
}

const DataContext = createContext<DataContextType | undefined>(undefined);

const STORAGE_KEY = 'starline_use_mock_data';

export function DataProvider({ children }: { children: ReactNode }) {
  // Initialize from localStorage, default to true (mock data)
  const [useMockData, setUseMockData] = useState<boolean>(() => {
    const stored = localStorage.getItem(STORAGE_KEY);
    return stored !== null ? stored === 'true' : true;
  });

  const [error, setError] = useState<string | null>(null);

  // Persist to localStorage whenever it changes
  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, useMockData.toString());
  }, [useMockData]);

  const toggleDataSource = () => {
    setUseMockData((prev) => !prev);
    setError(null); // Clear any previous errors when toggling
  };

  return (
    <DataContext.Provider
      value={{
        useMockData,
        toggleDataSource,
        isLoading: false,
        error,
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
