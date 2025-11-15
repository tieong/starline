import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { apiClient, type InfluencerSearchResult, type TrendingInfluencer } from '../services/api';

export default function Home() {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState<InfluencerSearchResult[]>([]);
  const [topInfluencers, setTopInfluencers] = useState<TrendingInfluencer[]>([]);
  const [loading, setLoading] = useState(false);
  const [loadingTop, setLoadingTop] = useState(false);
  const [autoDiscovering, setAutoDiscovering] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  // Fetch top 5 French influencers on mount
  useEffect(() => {
    const fetchTopInfluencers = async () => {
      // Check if auto-discovery is enabled via environment variable
      const autoDiscoveryEnabled = import.meta.env.VITE_ENABLE_AUTO_DISCOVERY !== 'false';

      if (!autoDiscoveryEnabled) {
        console.log('Auto-discovery is disabled via VITE_ENABLE_AUTO_DISCOVERY env variable');
        return;
      }

      try {
        setLoadingTop(true);
        const response = await apiClient.getTopInfluencers({ limit: 5, country: 'FR', auto_discover: true });
        setTopInfluencers(response.influencers);

        // Show message if auto-discovery happened
        if (response.auto_discovered && response.newly_analyzed_count) {
          setAutoDiscovering(true);
          setTimeout(() => setAutoDiscovering(false), 5000); // Clear message after 5 seconds
        }
      } catch (err) {
        console.error('Failed to fetch top influencers:', err);
        setError('Failed to load top influencers');
      } finally {
        setLoadingTop(false);
      }
    };

    fetchTopInfluencers();
  }, []);

  const handleSearch = async () => {
    const query = searchQuery.trim();
    if (query) {
      try {
        setLoading(true);
        setError(null);
        const results = await apiClient.searchInfluencers(query);

        // If no results found, automatically trigger analysis
        if (results.length === 0) {
          console.log(`No results for "${query}", triggering analysis...`);

          // Show analyzing message immediately
          setError(`Analyzing "${query}"... Discovering social profiles, timeline, and connections.`);
          setLoading(false); // Stop loading spinner, show analyzing message

          try {
            const analysisResult = await apiClient.analyzeInfluencer(query);

            // Check if analysis is in progress or completed
            if ('status' in analysisResult && analysisResult.status === 'analyzing') {
              setError(`Analyzing "${query}"... This may take 20-30 seconds. Please refresh to see results.`);
            } else {
              // Analysis completed successfully, search again to get the new data
              setLoading(true);
              setError(null);
              const newResults = await apiClient.searchInfluencers(query);
              setSearchResults(newResults);
              setLoading(false);

              if (newResults.length === 0) {
                setError(`Analysis complete but no data found for "${query}". Please try again.`);
              }
            }
          } catch (analysisErr: any) {
            console.error('Analysis failed:', analysisErr);
            setError(`Analysis failed: ${analysisErr.message || 'Unknown error'}. Please try a different name.`);
          }
        } else {
          setSearchResults(results);
          setLoading(false);
        }
      } catch (err) {
        console.error('Search failed:', err);
        setError('Search failed');
        setSearchResults([]);
        setLoading(false);
      }
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      handleSearch();
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
              onChange={(e) => setSearchQuery(e.target.value)}
              onKeyDown={handleKeyDown}
              placeholder="Search for influencers (press Enter)..."
              className="w-full px-6 py-4 text-lg rounded-full border-2 border-gray-200 focus:border-blue-500 focus:outline-none shadow-lg transition-all"
            />
            <button
              onClick={handleSearch}
              className="absolute right-3 top-1/2 transform -translate-y-1/2 bg-blue-600 hover:bg-blue-700 text-white rounded-full p-3 transition-all shadow-md hover:shadow-lg"
              aria-label="Search"
            >
              <svg
                className="w-5 h-5"
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
            </button>
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
                      src={influencer.avatar_url || 'https://media.istockphoto.com/id/2171382633/vector/user-profile-icon-anonymous-person-symbol-blank-avatar-graphic-vector-illustration.jpg?s=170667a&w=0&k=20&c=C0GFBgcEAPMXFFQBSK-rS2Omt9sUGImXfJE_8JOWC0M='}
                      alt={influencer.name}
                      className="w-16 h-16 rounded-full object-cover"
                      onError={(e) => {
                        const target = e.target as HTMLImageElement;
                        target.src = 'https://media.istockphoto.com/id/2171382633/vector/user-profile-icon-anonymous-person-symbol-blank-avatar-graphic-vector-illustration.jpg?s=170667a&w=0&k=20&c=C0GFBgcEAPMXFFQBSK-rS2Omt9sUGImXfJE_8JOWC0M=';
                      }}
                    />
                    <div className="flex-1">
                      <div className="flex items-center gap-2">
                        <h3 className="font-semibold text-lg">{influencer.name}</h3>
                      </div>
                      <p className="text-sm text-gray-500">
                        {influencer.platforms[0]?.platform || 'Unknown'}
                      </p>
                    </div>
                  </div>

                  <p className="text-sm text-gray-600 mb-4 line-clamp-2">
                    {influencer.bio}
                  </p>

                  <div className="flex justify-between items-center">
                    <div>
                      <p className="text-xs text-gray-500">Followers</p>
                      <p className="font-semibold">
                        {influencer.platforms[0]?.followers
                          ? `${(influencer.platforms[0].followers / 1000000).toFixed(1)}M`
                          : 'N/A'}
                      </p>
                    </div>
                    <div className="text-right">
                      <p className="text-xs text-gray-500">Trust Score</p>
                      <p className={`text-2xl font-bold ${getTrustScoreColor(influencer.trust_score)}`}>
                        {influencer.trust_score}
                      </p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* No results / Analysis status */}
        {searchQuery && searchResults.length === 0 && !loading && (
          <div className="text-center mt-12">
            {error ? (
              <div className="max-w-2xl mx-auto bg-blue-50 border-2 border-blue-200 rounded-xl p-8">
                <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
                <p className="text-blue-800 text-lg font-semibold mb-2">
                  {error}
                </p>
                <p className="text-blue-600 text-sm">
                  We're discovering this influencer's profile, timeline, and connections using AI.
                </p>
              </div>
            ) : (
              <p className="text-gray-500 text-lg">No influencers found matching "{searchQuery}"</p>
            )}
          </div>
        )}

        {/* Top 5 French Influencers - Show when no search */}
        {!searchQuery && (
          <div className="max-w-7xl mx-auto">
            <div className="text-center mb-8">
              <h2 className="text-3xl font-bold text-gray-800 mb-2">
                Top 5 French Influencers
              </h2>
              <p className="text-gray-600">Most influential creators in France</p>
              {autoDiscovering && (
                <div className="mt-4 inline-block bg-blue-50 border border-blue-200 rounded-lg px-4 py-2">
                  <p className="text-blue-700 text-sm">
                    🔄 Discovered and analyzed new influencers for you!
                  </p>
                </div>
              )}
            </div>

            {loadingTop ? (
              <div className="flex flex-col items-center justify-center py-20">
                <div className="animate-spin rounded-full h-16 w-16 border-b-4 border-blue-600 mb-4"></div>
                <p className="text-gray-600 text-lg">Loading top influencers...</p>
                <p className="text-gray-500 text-sm mt-2">This may take a moment if discovering new influencers</p>
              </div>
            ) : topInfluencers.length > 0 ? (
              <div className="grid md:grid-cols-2 lg:grid-cols-5 gap-6">
                {topInfluencers.map((influencer, index) => (
                <div
                  key={influencer.id}
                  onClick={() => navigate(`/influencer/${influencer.id}`)}
                  className="bg-white rounded-xl shadow-md hover:shadow-xl transition-all cursor-pointer p-4 border-2 border-gray-100 hover:border-blue-300 relative overflow-hidden"
                >
                  {/* Ranking badge */}
                  <div className="absolute top-0 right-0">
                    <div className={`px-3 py-1 rounded-bl-xl font-bold text-sm ${
                      index === 0 ? 'bg-gradient-to-br from-yellow-400 to-orange-500 text-white' :
                      index === 1 ? 'bg-gradient-to-br from-gray-300 to-gray-400 text-white' :
                      index === 2 ? 'bg-gradient-to-br from-orange-300 to-orange-400 text-white' :
                      'bg-gray-100 text-gray-600'
                    }`}>
                      #{index + 1}
                    </div>
                  </div>

                  <div className="flex flex-col items-center text-center mt-2">
                    <img
                      src={influencer.avatar_url || 'https://media.istockphoto.com/id/2171382633/vector/user-profile-icon-anonymous-person-symbol-blank-avatar-graphic-vector-illustration.jpg?s=170667a&w=0&k=20&c=C0GFBgcEAPMXFFQBSK-rS2Omt9sUGImXfJE_8JOWC0M='}
                      alt={influencer.name}
                      className="w-20 h-20 rounded-full border-4 border-blue-500 shadow-md mb-3 object-cover"
                      onError={(e) => {
                        const target = e.target as HTMLImageElement;
                        target.src = 'https://media.istockphoto.com/id/2171382633/vector/user-profile-icon-anonymous-person-symbol-blank-avatar-graphic-vector-illustration.jpg?s=170667a&w=0&k=20&c=C0GFBgcEAPMXFFQBSK-rS2Omt9sUGImXfJE_8JOWC0M=';
                      }}
                    />

                    <h3 className="text-base font-bold text-gray-900 mb-1 line-clamp-1">
                      {influencer.name}
                    </h3>

                    <p className="text-xs text-blue-600 font-semibold mb-2">
                      {influencer.platforms[0]?.platform || 'Multi'}
                    </p>

                    {influencer.country && (
                      <p className="text-xs text-gray-500 mb-2">
                        🌍 {influencer.country}
                      </p>
                    )}

                    <div className="w-full space-y-2 mb-3">
                      <div className="bg-gray-50 rounded-lg px-3 py-1.5">
                        <p className="text-xs text-gray-500">Followers</p>
                        <p className="text-sm font-bold text-gray-900">
                          {influencer.total_followers
                            ? influencer.total_followers >= 1000000
                              ? `${(influencer.total_followers / 1000000).toFixed(1)}M`
                              : `${(influencer.total_followers / 1000).toFixed(0)}K`
                            : influencer.platforms[0]?.followers
                            ? influencer.platforms[0].followers >= 1000000
                              ? `${(influencer.platforms[0].followers / 1000000).toFixed(1)}M`
                              : `${(influencer.platforms[0].followers / 1000).toFixed(0)}K`
                            : 'N/A'}
                        </p>
                      </div>
                      <div className="bg-gradient-to-r from-blue-50 to-purple-50 rounded-lg px-3 py-1.5">
                        <p className="text-xs text-gray-500">Trust Score</p>
                        <p className={`text-lg font-bold ${getTrustScoreColor(influencer.trust_score)}`}>
                          {influencer.trust_score}
                        </p>
                      </div>
                    </div>

                    <button className="w-full bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700 text-white font-semibold px-4 py-1.5 text-sm rounded-full transition-all shadow-sm hover:shadow-md">
                      View Profile
                    </button>
                  </div>
                </div>
              ))}
            </div>
            ) : (
              <div className="text-center py-12">
                <p className="text-gray-500">No influencers found</p>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
