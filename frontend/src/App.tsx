import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Home } from './pages/Home';
import { AllInfluencers } from './pages/AllInfluencers';
import { InfluencerDetail } from './pages/InfluencerDetail';
import { NetworkGraph } from './pages/NetworkGraph';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/influencers" element={<AllInfluencers />} />
        <Route path="/influencer/:id" element={<InfluencerDetail />} />
        <Route path="/graph/:id?" element={<NetworkGraph />} />
      </Routes>
    </Router>
  );
}

export default App;
