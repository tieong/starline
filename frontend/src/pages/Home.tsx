import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { mockInfluencers } from '../mockData';
import type { Influencer } from '../types';

export default function Home() {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState<Influencer[]>([]);
  const navigate = useNavigate();

  const handleSearch = (query: string) => {
    setSearchQuery(query);
    if (query.trim()) {
      const results = mockInfluencers.filter(
        (influencer) =>
          influencer.name.toLowerCase().includes(query.toLowerCase()) ||
          influencer.platform.toLowerCase().includes(query.toLowerCase()) ||
          influencer.bio.toLowerCase().includes(query.toLowerCase())
      );
      setSearchResults(results);
    } else {
      setSearchResults([]);
    }
  };

  const getTrustScoreColor = (score: number) => {
    if (score >= 85) return 'text-green-600';
    if (score >= 70) return 'text-yellow-600';
    return 'text-red-600';
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-purple-50">
      <div className="container mx-auto px-4 py-12">
        {/* Header */}
        <div className="text-center mb-12">
          <h1 className="text-6xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-purple-600 mb-4">
            Starline
          </h1>
          <p className="text-gray-600 text-lg">
            Crowdsourced Trust Ratings: Empowering Consumers to Verify Influencer Integrity
          </p>
        </div>

        {/* Search Bar */}
        <div className="max-w-3xl mx-auto mb-12">
          <div className="relative">
            <input
              type="text"
              value={searchQuery}
              onChange={(e) => handleSearch(e.target.value)}
              placeholder="Search for influencers..."
              className="w-full px-6 py-4 text-lg rounded-full border-2 border-gray-200 focus:border-blue-500 focus:outline-none shadow-lg transition-all"
            />
            <svg
              className="absolute right-6 top-1/2 transform -translate-y-1/2 w-6 h-6 text-gray-400"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>
          </div>
        </div>

        {/* Search Results */}
        {searchResults.length > 0 && (
          <div className="max-w-5xl mx-auto">
            <h2 className="text-2xl font-semibold mb-6 text-gray-800">
              Search Results ({searchResults.length})
            </h2>
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
              {searchResults.map((influencer) => (
                <div
                  key={influencer.id}
                  onClick={() => navigate(`/influencer/${influencer.id}`)}
                  className="bg-white rounded-xl shadow-md hover:shadow-xl transition-all cursor-pointer p-6 border border-gray-100"
                >
                  <div className="flex items-start gap-4 mb-4">
                    <img
                      src={influencer.avatarUrl}
                      alt={influencer.name}
                      className="w-16 h-16 rounded-full"
                    />
                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <h3 className="font-semibold text-lg">{influencer.name}</h3>
                        {influencer.verified && (
                          <svg
                            className="w-5 h-5 text-blue-500"
                            fill="currentColor"
                            viewBox="0 0 20 20"
                          >
                            <path
                              fillRule="evenodd"
                              d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                              clipRule="evenodd"
                            />
                          </svg>
                        )}
                      </div>
                      <p className="text-sm text-gray-500">{influencer.platform}</p>
                    </div>
                  </div>

                  <p className="text-sm text-gray-600 mb-4 line-clamp-2">
                    {influencer.bio}
                  </p>

                  <div className="flex justify-between items-center">
                    <div>
                      <p className="text-xs text-gray-500">Followers</p>
                      <p className="font-semibold">
                        {(influencer.followerCount / 1000000).toFixed(1)}M
                      </p>
                    </div>
                    <div className="text-right">
                      <p className="text-xs text-gray-500">Trust Score</p>
                      <p className={`text-2xl font-bold ${getTrustScoreColor(influencer.trustScore)}`}>
                        {influencer.trustScore}
                      </p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* No results */}
        {searchQuery && searchResults.length === 0 && (
          <div className="text-center text-gray-500 mt-12">
            <p className="text-lg">No influencers found matching "{searchQuery}"</p>
          </div>
        )}

        {/* Empty state */}
        {!searchQuery && (
          <div className="text-center text-gray-400 mt-12">
            <svg
              className="mx-auto w-24 h-24 mb-4"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={1.5}
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>
            <p className="text-lg">Start searching to discover influencers</p>
          </div>
        )}
      </div>
    </div>
  );
}
