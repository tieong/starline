import { useParams, useNavigate } from 'react-router-dom';
import { useState, useRef, useCallback, useEffect, useMemo } from 'react';
import ForceGraph2D from 'react-force-graph-2d';
import { apiClient, type InfluencerDetail as InfluencerDetailType } from '../services/api';

export default function InfluencerDetail() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [selectedNode, setSelectedNode] = useState<string | null>(null);
  const [influencer, setInfluencer] = useState<InfluencerDetailType | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const graphRef = useRef<any>();

  // Fetch influencer data
  useEffect(() => {
    const fetchInfluencer = async () => {
      if (!id) return;

      try {
        setLoading(true);
        setError(null);
        const data = await apiClient.getInfluencer(id);

        // Add defensive checks and default values
        const normalizedData = {
          ...data,
          platforms: data.platforms || [],
          timeline: data.timeline || [],
          products: data.products || [],
          connections: data.connections || [],
          bio: data.bio || 'No bio available',
          avatar_url: data.avatar_url || 'https://i.pravatar.cc/150',
        };

        console.log('Fetched influencer data:', normalizedData);
        setInfluencer(normalizedData);
      } catch (err: any) {
        console.error('Failed to fetch influencer:', err);

        // If influencer not found, try to analyze it
        if (err.message === 'Influencer not found') {
          try {
            setError('Influencer not in database. Analyzing now...');
            console.log(`Influencer "${id}" not found, triggering analysis...`);

            // Use the ID as the name for analysis
            const analysisResult = await apiClient.analyzeInfluencer(id);

            // Check if analysis completed or is in progress
            if ('status' in analysisResult && analysisResult.status === 'analyzing') {
              setError('Analysis in progress... This takes 20-30 seconds. Please refresh in a moment.');
            } else {
              // Analysis completed successfully, fetch the data again
              const freshData = await apiClient.getInfluencer(id);

              const normalizedFreshData = {
                ...freshData,
                platforms: freshData.platforms || [],
                timeline: freshData.timeline || [],
                products: freshData.products || [],
                connections: freshData.connections || [],
                bio: freshData.bio || 'No bio available',
                avatar_url: freshData.avatar_url || 'https://i.pravatar.cc/150',
              };

              setInfluencer(normalizedFreshData);
              setError(null);
            }
          } catch (analysisErr: any) {
            console.error('Analysis failed:', analysisErr);
            setError(`Could not analyze "${id}". ${analysisErr.message}`);
          }
        } else {
          setError(err.message || 'Failed to load influencer');
        }
      } finally {
        setLoading(false);
      }
    };

    fetchInfluencer();
  }, [id]);

  // Build network graph data from connections (memoized to prevent re-renders)
  // MUST be before any conditional returns to follow Rules of Hooks
  const networkData = useMemo(() => {
    if (!influencer?.connections || influencer.connections.length === 0) {
      return null;
    }

    return {
      nodes: [
        { id: influencer.id, name: influencer.name, val: 30, color: '#3b82f6' },
        ...influencer.connections.map((conn, idx) => ({
          id: `conn-${idx}`,
          name: conn.name,
          val: 10 + (conn.strength || 1),
          color: conn.type === 'collaboration' ? '#10b981' : '#8b5cf6',
        })),
      ],
      links: influencer.connections.map((conn, idx) => ({
        source: influencer.id,
        target: `conn-${idx}`,
        value: conn.strength || 1,
      })),
    };
  }, [influencer?.connections, influencer?.id, influencer?.name]);

  const handleNodeClick = useCallback((node: any) => {
    setSelectedNode(node.id);
  }, []);

  const getLinkColor = useCallback(() => '#cbd5e1', []);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Loading influencer data...</p>
        </div>
      </div>
    );
  }

  if (error || !influencer) {
    const isAnalyzing = error?.includes('Analyzing') || error?.includes('Analysis in progress');

    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 via-white to-purple-50">
        <div className="text-center max-w-2xl mx-auto px-4">
          {isAnalyzing ? (
            <div className="bg-white rounded-2xl shadow-xl p-12 border-2 border-blue-100">
              <div className="animate-spin rounded-full h-16 w-16 border-b-4 border-blue-600 mx-auto mb-6"></div>
              <h2 className="text-3xl font-bold text-blue-900 mb-4">
                Analyzing Influencer...
              </h2>
              <p className="text-gray-700 text-lg mb-4">{error}</p>
              <div className="bg-blue-50 rounded-lg p-6 mb-6">
                <p className="text-blue-800 font-semibold mb-2">What we're discovering:</p>
                <ul className="text-sm text-blue-700 text-left space-y-2">
                  <li>✓ Social media platforms & follower counts</li>
                  <li>✓ Products and sponsorships</li>
                  <li>✓ Success timeline & breakthrough moments</li>
                  <li>✓ Network connections & collaborations</li>
                </ul>
              </div>
              <p className="text-gray-600 text-sm">
                This typically takes 20-30 seconds. You can refresh this page or search again shortly.
              </p>
            </div>
          ) : (
            <div className="bg-white rounded-2xl shadow-xl p-12">
              <h2 className="text-2xl font-bold text-gray-800 mb-4">{error || 'Influencer not found'}</h2>
              <p className="text-gray-600 mb-6">
                We couldn't find or analyze this influencer. Please try a different name or check the spelling.
              </p>
              <button
                onClick={() => navigate('/')}
                className="px-8 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-semibold shadow-lg hover:shadow-xl transition-all"
              >
                Back to Home
              </button>
            </div>
          )}
        </div>
      </div>
    );
  }

  const getTrustScoreColor = (score: number) => {
    if (score >= 85) return 'text-green-600';
    if (score >= 70) return 'text-yellow-600';
    return 'text-red-600';
  };

  const getMilestoneIcon = (type: string) => {
    switch (type) {
      case 'video':
        return (
          <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
            <path d="M2 6a2 2 0 012-2h6a2 2 0 012 2v8a2 2 0 01-2 2H4a2 2 0 01-2-2V6zM14.553 7.106A1 1 0 0014 8v4a1 1 0 00.553.894l2 1A1 1 0 0018 13V7a1 1 0 00-1.447-.894l-2 1z" />
          </svg>
        );
      case 'tweet':
        return (
          <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
            <path d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"/>
          </svg>
        );
      case 'instagram':
        return (
          <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
            <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
          </svg>
        );
      case 'tiktok':
        return (
          <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
            <path d="M19.59 6.69a4.83 4.83 0 01-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 01-5.2 1.74 2.89 2.89 0 012.31-4.64 2.93 2.93 0 01.88.13V9.4a6.84 6.84 0 00-1-.05A6.33 6.33 0 005 20.1a6.34 6.34 0 0010.86-4.43v-7a8.16 8.16 0 004.77 1.52v-3.4a4.85 4.85 0 01-1-.1z"/>
          </svg>
        );
      case 'achievement':
        return (
          <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
          </svg>
        );
      case 'collaboration':
        return (
          <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
            <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z" />
          </svg>
        );
      default:
        return (
          <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clipRule="evenodd" />
          </svg>
        );
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
  };

  const formatNumber = (num: number) => {
    if (num >= 1000000) {
      return `${(num / 1000000).toFixed(1)}M`;
    }
    if (num >= 1000) {
      return `${(num / 1000).toFixed(1)}K`;
    }
    return num.toString();
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-purple-50">
      {/* Header */}
      <div className="bg-white shadow-sm border-b">
        <div className="container mx-auto px-4 py-4">
          <button
            onClick={() => navigate('/')}
            className="flex items-center gap-2 text-gray-600 hover:text-gray-800"
          >
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
            </svg>
            Back to Search
          </button>
        </div>
      </div>

      <div className="container mx-auto px-4 py-8">
        {/* Influencer Header */}
        <div className="bg-white rounded-xl shadow-lg p-8 mb-8">
          <div className="flex items-start gap-6">
            <img
              src={influencer.avatar_url || 'https://i.pravatar.cc/150'}
              alt={influencer.name}
              className="w-32 h-32 rounded-full"
            />
            <div className="flex-1">
              <div className="flex items-center gap-3 mb-2">
                <h1 className="text-3xl font-bold">{influencer.name}</h1>
                {influencer.verified && (
                  <svg className="w-8 h-8 text-blue-500" fill="currentColor" viewBox="0 0 20 20">
                    <path
                      fillRule="evenodd"
                      d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                )}
              </div>
              <p className="text-gray-600 mb-2">
                {influencer.platforms.map(p => p.platform).join(', ') || 'Unknown'}
              </p>
              <p className="text-gray-700 mb-4">{influencer.bio}</p>
              <div className="flex gap-8">
                <div>
                  <p className="text-sm text-gray-500">Total Followers</p>
                  <p className="text-2xl font-bold">
                    {(() => {
                      const totalFollowers = influencer.platforms?.reduce((sum, p) => sum + (p.followers || 0), 0) || 0;
                      if (totalFollowers >= 1000000) {
                        return `${(totalFollowers / 1000000).toFixed(1)}M`;
                      } else if (totalFollowers >= 1000) {
                        return `${(totalFollowers / 1000).toFixed(0)}K`;
                      }
                      return totalFollowers.toString();
                    })()}
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-500">Trust Score</p>
                  <p className={`text-4xl font-bold ${getTrustScoreColor(influencer.trust_score || 0)}`}>
                    {influencer.trust_score || 0}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* Success Timeline */}
        {influencer.timeline && influencer.timeline.length > 0 && (
          <div className="bg-white rounded-xl shadow-lg p-8 mb-8">
            <h2 className="text-2xl font-bold mb-8 text-gray-800">Success Timeline</h2>
            <div className="relative">
              {/* Vertical line */}
              <div className="absolute left-8 top-0 bottom-0 w-0.5 bg-gradient-to-b from-blue-500 via-purple-500 to-pink-500"></div>

              {/* Timeline items */}
              <div className="space-y-8">
                {influencer.timeline.map((milestone) => (
                  <div key={milestone.id} className="relative pl-20">
                    {/* Icon */}
                    <div className="absolute left-0 w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full flex items-center justify-center text-white shadow-lg">
                      {getMilestoneIcon(milestone.type)}
                    </div>

                    {/* Content */}
                    <div className="bg-gradient-to-br from-gray-50 to-white rounded-lg p-6 shadow-md hover:shadow-lg transition-all border border-gray-100">
                      <div className="flex items-start justify-between mb-2">
                        <div className="flex-1">
                          <h3 className="text-xl font-bold text-gray-900 mb-1">{milestone.title}</h3>
                          <p className="text-sm text-blue-600 font-semibold mb-2">{formatDate(milestone.date)}</p>
                        </div>
                        <span className="ml-4 px-3 py-1 bg-blue-100 text-blue-700 text-xs font-semibold rounded-full">
                          {milestone.platform}
                        </span>
                      </div>

                      <p className="text-gray-700 mb-3">{milestone.description}</p>

                      {/* Stats */}
                      {(milestone.views || milestone.likes) && (
                        <div className="flex gap-4 mt-4">
                          {milestone.views && (
                            <div className="flex items-center gap-2 bg-white rounded-full px-4 py-2 shadow-sm">
                              <svg className="w-5 h-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
                                <path fillRule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clipRule="evenodd" />
                              </svg>
                              <span className="font-semibold text-gray-700">{formatNumber(milestone.views)} views</span>
                            </div>
                          )}
                          {milestone.likes && (
                            <div className="flex items-center gap-2 bg-white rounded-full px-4 py-2 shadow-sm">
                              <svg className="w-5 h-5 text-pink-500" fill="currentColor" viewBox="0 0 20 20">
                                <path fillRule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clipRule="evenodd" />
                              </svg>
                              <span className="font-semibold text-gray-700">{formatNumber(milestone.likes)} likes</span>
                            </div>
                          )}
                        </div>
                      )}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        <div className="grid lg:grid-cols-2 gap-8">
          {/* Network Graph */}
          <div className="bg-white rounded-xl shadow-lg p-6">
            <h2 className="text-2xl font-bold mb-4">Network Connections</h2>
            <p className="text-gray-600 mb-4">
              Click on nodes to see connection details
            </p>
            {networkData && (
              <div className="border rounded-lg overflow-hidden">
                <ForceGraph2D
                  ref={graphRef}
                  graphData={networkData}
                  nodeLabel="name"
                  nodeColor="color"
                  nodeRelSize={6}
                  linkWidth={2}
                  linkColor={getLinkColor}
                  onNodeClick={handleNodeClick}
                  width={500}
                  height={400}
                />
              </div>
            )}
            {selectedNode && (
              <div className="mt-4 p-4 bg-blue-50 rounded-lg">
                <p className="font-semibold">
                  Selected: {networkData?.nodes.find(n => n.id === selectedNode)?.name}
                </p>
                <p className="text-sm text-gray-600 mt-1">
                  Click on another node to view their connection
                </p>
              </div>
            )}
          </div>

          {/* Products */}
          {influencer.products && influencer.products.length > 0 && (
            <div className="bg-white rounded-xl shadow-lg p-6">
              <h2 className="text-2xl font-bold mb-6">Products & Sponsorships</h2>
              <div className="space-y-4">
                {influencer.products.map((product, idx) => (
                  <div key={idx} className="border-b pb-4 last:border-b-0">
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex-1">
                        <h3 className="font-semibold text-lg">{product.name}</h3>
                        <p className="text-sm text-gray-600 capitalize">{product.category}</p>
                      </div>
                      {product.quality_score && (
                        <div className="text-right">
                          <p className="text-xs text-gray-500">Quality Score</p>
                          <p className={`text-2xl font-bold ${getTrustScoreColor(product.quality_score)}`}>
                            {product.quality_score}
                          </p>
                        </div>
                      )}
                    </div>
                    {product.description && (
                      <p className="text-sm text-gray-700">{product.description}</p>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Platforms Section */}
        {influencer.platforms && influencer.platforms.length > 0 && (
          <div className="mt-8 bg-white rounded-xl shadow-lg p-6">
            <h2 className="text-2xl font-bold mb-6">Platform Presence</h2>
            <div className="grid md:grid-cols-2 gap-4">
              {influencer.platforms.map((platform, idx) => (
                <div key={idx} className="border rounded-lg p-4">
                  <div className="flex items-center justify-between mb-2">
                    <div>
                      <h3 className="font-semibold text-lg capitalize">{platform.platform}</h3>
                      <p className="text-sm text-gray-600">{platform.username}</p>
                    </div>
                    {platform.verified && (
                      <svg className="w-6 h-6 text-blue-500" fill="currentColor" viewBox="0 0 20 20">
                        <path
                          fillRule="evenodd"
                          d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                          clipRule="evenodd"
                        />
                      </svg>
                    )}
                  </div>
                  <div className="flex items-center justify-between mt-3">
                    <div>
                      <p className="text-xs text-gray-500">Followers</p>
                      <p className="text-xl font-bold">{formatNumber(platform.followers)}</p>
                    </div>
                    {platform.url && (
                      <a
                        href={platform.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-blue-600 hover:text-blue-700 text-sm"
                      >
                        View Profile →
                      </a>
                    )}
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
