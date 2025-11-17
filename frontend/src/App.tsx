import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Analytics } from '@vercel/analytics/react';
import { DataProvider } from './context/DataContext';
import { AuthProvider } from './context/AuthContext';
import { Home } from './pages/Home';
import { AllInfluencers } from './pages/AllInfluencers';
import { InfluencerDetail } from './pages/InfluencerDetail';
import { NetworkGraph } from './pages/NetworkGraph';
import { ExplorationLoading } from './pages/ExplorationLoading';

function App() {
  return (
    <AuthProvider>
      <DataProvider>
        <Router>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/influencers" element={<AllInfluencers />} />
            <Route path="/influencer/:id" element={<InfluencerDetail />} />
            <Route path="/graph/:id?" element={<NetworkGraph />} />
            <Route path="/explore/:name" element={<ExplorationLoading />} />
          </Routes>
        </Router>
        <Analytics />
      </DataProvider>
    </AuthProvider>
  );
}

export default App;
