import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import InfluencerDetail from './pages/InfluencerDetail';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/influencer/:id" element={<InfluencerDetail />} />
      </Routes>
    </Router>
  );
}

export default App;
