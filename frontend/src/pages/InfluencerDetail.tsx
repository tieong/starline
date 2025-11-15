import { useParams, useNavigate } from 'react-router-dom';
import { useState, useRef, useCallback, useEffect, useMemo } from 'react';
import ForceGraph2D from 'react-force-graph-2d';
import { XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Area, AreaChart } from 'recharts';
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
          news: data.news || [],
          bio: data.bio || 'No bio available',
          avatar_url: data.avatar_url || 'https://media.istockphoto.com/id/2171382633/vector/user-profile-icon-anonymous-person-symbol-blank-avatar-graphic-vector-illustration.jpg?s=170667a&w=0&k=20&c=C0GFBgcEAPMXFFQBSK-rS2Omt9sUGImXfJE_8JOWC0M=',
        };

        console.log('Fetched influencer data:', normalizedData);

        // Check if we only have platforms (trust_score === 0 means platforms_only analysis)
        // If so, trigger basic analysis to fetch products and calculate trust score
        let finalData = normalizedData;
        if (normalizedData.trust_score === 0 || normalizedData.products.length === 0) {
          console.log('Influencer has platforms only, fetching products and calculating trust score...');
          try {
            // Trigger basic analysis to get products + trust score
            await apiClient.analyzeInfluencer(normalizedData.name, 'basic');

            // Fetch updated data with products and trust score
            const updatedData = await apiClient.getInfluencer(id);
            finalData = {
              ...updatedData,
              platforms: updatedData.platforms || [],
              timeline: updatedData.timeline || [],
              products: updatedData.products || [],
              connections: updatedData.connections || [],
              news: updatedData.news || [],
              bio: updatedData.bio || 'No bio available',
              avatar_url: updatedData.avatar_url || normalizedData.avatar_url,
            };
            setInfluencer(finalData);
          } catch (err) {
            console.error('Failed to fetch products:', err);
            // Still show the influencer with platforms only
            setInfluencer(normalizedData);
          }
        } else {
          setInfluencer(normalizedData);
        }

        // Auto-fetch missing data on-demand when viewing profile
        // This runs in the background after initial display
        // Use finalData to check what's missing (not the original normalizedData)
        if (id) {
          // Fetch timeline if missing
          if (finalData.timeline.length === 0) {
            console.log('Timeline missing, fetching on-demand...');
            apiClient.fetchTimeline(id).then(async () => {
              const refreshedData = await apiClient.getInfluencer(id);
              setInfluencer(prev => ({
                ...prev!,
                timeline: refreshedData.timeline || []
              }));
              console.log('Timeline fetched successfully');
            }).catch(err => {
              console.error('Failed to fetch timeline:', err);
            });
          }

          // Fetch connections if missing
          if (finalData.connections.length === 0) {
            console.log('Connections missing, fetching on-demand...');
            apiClient.fetchConnections(id).then(async () => {
              const refreshedData = await apiClient.getInfluencer(id);
              setInfluencer(prev => ({
                ...prev!,
                connections: refreshedData.connections || []
              }));
              console.log('Connections fetched successfully');
            }).catch(err => {
              console.error('Failed to fetch connections:', err);
            });
          }

          // Fetch news if missing
          if (finalData.news.length === 0) {
            console.log('News missing, fetching on-demand...');
            apiClient.fetchNews(id).then(async () => {
              const refreshedData = await apiClient.getInfluencer(id);
              setInfluencer(prev => ({
                ...prev!,
                news: refreshedData.news || []
              }));
              console.log('News fetched successfully');
            }).catch(err => {
              console.error('Failed to fetch news:', err);
            });
          }

          // Fetch reviews for products that don't have them
          if (finalData.products.length > 0) {
            finalData.products.forEach((product: any, index: number) => {
              if (!product.reviews || product.reviews.length === 0) {
                console.log(`Product "${product.name}" has no reviews, fetching on-demand...`);
                apiClient.fetchProductReviews(product.id).then(async () => {
                  const refreshedData = await apiClient.getInfluencer(id);
                  setInfluencer(prev => ({
                    ...prev!,
                    products: refreshedData.products || []
                  }));
                  console.log(`Reviews for "${product.name}" fetched successfully`);
                }).catch(err => {
                  console.error(`Failed to fetch reviews for "${product.name}":`, err);
                });
              }

              // Fetch OpenFoodFacts data for food products without it
              if (product.category === 'food' && !product.openfoodfacts_data) {
                console.log(`Product "${product.name}" missing OpenFoodFacts data, fetching...`);
                apiClient.fetchOpenFoodFacts(product.id).then(async () => {
                  const refreshedData = await apiClient.getInfluencer(id);
                  setInfluencer(prev => ({
                    ...prev!,
                    products: refreshedData.products || []
                  }));
                  console.log(`OpenFoodFacts data for "${product.name}" fetched successfully`);
                }).catch(err => {
                  console.error(`Failed to fetch OpenFoodFacts for "${product.name}":`, err);
                });
              }
            });
          }
        }
      } catch (err: any) {
        console.error('Failed to fetch influencer:', err);

        // If influencer not found, try to analyze it
        if (err.message === 'Influencer not found') {
          try {
            setError('Influencer not in database. Analyzing now...');
            console.log(`Influencer "${id}" not found, triggering analysis...`);

            // Use the ID as the name for analysis (use "basic" to get products + trust score)
            const analysisResult = await apiClient.analyzeInfluencer(id, 'basic');

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
                news: freshData.news || [],
                bio: freshData.bio || 'No bio available',
                avatar_url: freshData.avatar_url || 'https://media.istockphoto.com/id/2171382633/vector/user-profile-icon-anonymous-person-symbol-blank-avatar-graphic-vector-illustration.jpg?s=170667a&w=0&k=20&c=C0GFBgcEAPMXFFQBSK-rS2Omt9sUGImXfJE_8JOWC0M=',
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

    const getEntityColor = (entityType: string) => {
      switch (entityType) {
        case 'influencer': return '#3b82f6'; // blue
        case 'ad_agency': return '#f59e0b'; // orange
        case 'brand': return '#10b981'; // green
        case 'management': return '#8b5cf6'; // purple
        case 'record_label': return '#ef4444'; // red
        case 'network': return '#06b6d4'; // cyan
        case 'studio': return '#ec4899'; // pink
        default: return '#6b7280'; // gray
      }
    };

    return {
      nodes: [
        { id: influencer.id, name: influencer.name, val: 30, color: '#3b82f6', entityType: 'influencer' },
        ...influencer.connections.map((conn, idx) => ({
          id: `conn-${idx}`,
          name: conn.name,
          entityType: conn.entity_type || 'influencer',
          val: 10 + (conn.strength || 1),
          color: getEntityColor(conn.entity_type || 'influencer'),
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

    // Only navigate if it's an influencer node (not agencies, brands, etc.)
    if (node.id.startsWith('conn-') && node.entityType === 'influencer') {
      // Convert the connection name to URL-safe format (lowercase, replace spaces with underscores)
      const influencerId = node.name.toLowerCase().replace(/\s+/g, '_');
      navigate(`/influencer/${influencerId}`);
    }
  }, [navigate]);

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
              src={influencer.avatar_url || 'https://media.istockphoto.com/id/2171382633/vector/user-profile-icon-anonymous-person-symbol-blank-avatar-graphic-vector-illustration.jpg?s=170667a&w=0&k=20&c=C0GFBgcEAPMXFFQBSK-rS2Omt9sUGImXfJE_8JOWC0M='}
              alt={influencer.name}
              className="w-32 h-32 rounded-full object-cover"
              onError={(e) => {
                const target = e.target as HTMLImageElement;
                target.src = 'https://media.istockphoto.com/id/2171382633/vector/user-profile-icon-anonymous-person-symbol-blank-avatar-graphic-vector-illustration.jpg?s=170667a&w=0&k=20&c=C0GFBgcEAPMXFFQBSK-rS2Omt9sUGImXfJE_8JOWC0M=';
              }}
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

        {/* Growth Chart */}
        {influencer.timeline && influencer.timeline.length > 0 && (
          <div className="bg-white rounded-xl shadow-lg p-8 mb-8">
            <h2 className="text-2xl font-bold mb-2 text-gray-800">Growth Timeline</h2>
            <p className="text-gray-600 mb-6">Tracking content performance over time - hover over points to see details</p>

            <ResponsiveContainer width="100%" height={400}>
              <AreaChart
                data={influencer.timeline
                  .filter(event => event.date && (event.views > 0 || event.likes > 0)) // Only include events with metrics
                  .sort((a, b) => {
                    const dateA = new Date(a.date).getTime();
                    const dateB = new Date(b.date).getTime();
                    return dateA - dateB;
                  })
                  .map((event) => ({
                    date: new Date(event.date).toLocaleDateString('en-US', { month: 'short', year: 'numeric' }),
                    views: event.views || 0,
                    likes: event.likes || 0,
                    title: event.title,
                    description: event.description,
                    platform: event.platform,
                    type: event.type,
                  }))}
                margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
              >
                <defs>
                  <linearGradient id="colorViews" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.8}/>
                    <stop offset="95%" stopColor="#3b82f6" stopOpacity={0.1}/>
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                <XAxis
                  dataKey="date"
                  stroke="#6b7280"
                  style={{ fontSize: '12px' }}
                />
                <YAxis
                  stroke="#6b7280"
                  style={{ fontSize: '12px' }}
                  tickFormatter={(value) => {
                    if (value >= 1000000) return `${(value / 1000000).toFixed(1)}M`;
                    if (value >= 1000) return `${(value / 1000).toFixed(0)}K`;
                    return value;
                  }}
                />
                <Tooltip
                  content={({ active, payload }) => {
                    if (active && payload && payload.length) {
                      const data = payload[0].payload;
                      return (
                        <div className="bg-white border-2 border-blue-500 rounded-lg p-4 shadow-xl max-w-sm">
                          <div className="flex items-center gap-2 mb-2">
                            <div className={`w-3 h-3 rounded-full ${
                              data.type === 'video' ? 'bg-red-500' :
                              data.type === 'collaboration' ? 'bg-green-500' :
                              data.type === 'achievement' ? 'bg-yellow-500' :
                              'bg-blue-500'
                            }`} />
                            <p className="font-bold text-gray-900">{data.title}</p>
                          </div>
                          <p className="text-sm text-gray-600 mb-2">{data.date}</p>
                          <p className="text-sm text-gray-700 mb-3">{data.description}</p>
                          <div className="flex gap-4 text-xs">
                            {data.views > 0 && (
                              <div className="flex items-center gap-1">
                                <svg className="w-4 h-4 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                                  <path d="M10 12a2 2 0 100-4 2 2 0 000 4z" />
                                  <path fillRule="evenodd" d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clipRule="evenodd" />
                                </svg>
                                <span className="font-semibold">{formatNumber(data.views)}</span>
                              </div>
                            )}
                            {data.likes > 0 && (
                              <div className="flex items-center gap-1">
                                <svg className="w-4 h-4 text-pink-500" fill="currentColor" viewBox="0 0 20 20">
                                  <path fillRule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clipRule="evenodd" />
                                </svg>
                                <span className="font-semibold">{formatNumber(data.likes)}</span>
                              </div>
                            )}
                            <span className="px-2 py-0.5 bg-blue-100 text-blue-700 rounded-full font-semibold">
                              {data.platform}
                            </span>
                          </div>
                        </div>
                      );
                    }
                    return null;
                  }}
                />
                <Area
                  type="monotone"
                  dataKey="views"
                  stroke="#3b82f6"
                  strokeWidth={3}
                  fill="url(#colorViews)"
                  dot={{ fill: '#3b82f6', r: 6, strokeWidth: 2, stroke: '#fff' }}
                  activeDot={{ r: 8, strokeWidth: 3 }}
                />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        )}

        <div className="grid lg:grid-cols-2 gap-8">
          {/* Network Graph */}
          <div className="bg-white rounded-xl shadow-lg p-6">
            <h2 className="text-2xl font-bold mb-4">Network Connections</h2>
            {networkData ? (
              <>
                <p className="text-gray-600 mb-2">
                  Click on influencer nodes to navigate
                </p>
                <div className="flex flex-wrap gap-2 mb-4 text-xs">
                  <span className="flex items-center gap-1">
                    <div className="w-3 h-3 rounded-full bg-blue-500"></div>
                    Influencer
                  </span>
                  <span className="flex items-center gap-1">
                    <div className="w-3 h-3 rounded-full bg-orange-500"></div>
                    Ad Agency
                  </span>
                  <span className="flex items-center gap-1">
                    <div className="w-3 h-3 rounded-full bg-green-500"></div>
                    Brand
                  </span>
                  <span className="flex items-center gap-1">
                    <div className="w-3 h-3 rounded-full bg-purple-500"></div>
                    Management
                  </span>
                  <span className="flex items-center gap-1">
                    <div className="w-3 h-3 rounded-full bg-red-500"></div>
                    Record Label
                  </span>
                  <span className="flex items-center gap-1">
                    <div className="w-3 h-3 rounded-full bg-cyan-500"></div>
                    Network
                  </span>
                </div>
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
                {selectedNode && (
                  <div className="mt-4 p-4 bg-blue-50 rounded-lg">
                    {(() => {
                      const selectedNodeData = networkData?.nodes.find(n => n.id === selectedNode);
                      const isInfluencer = selectedNodeData?.entityType === 'influencer';
                      return (
                        <>
                          <div className="flex items-center gap-2 mb-1">
                            <p className="font-semibold">
                              {selectedNodeData?.name}
                            </p>
                            <span className="text-xs bg-white px-2 py-0.5 rounded-full border capitalize">
                              {selectedNodeData?.entityType?.replace('_', ' ')}
                            </span>
                          </div>
                          <p className="text-sm text-gray-600">
                            {isInfluencer ? 'Click to navigate to their profile' : 'Business entity'}
                          </p>
                        </>
                      );
                    })()}
                  </div>
                )}
              </>
            ) : (
              <div className="text-center py-12">
                <svg className="w-16 h-16 text-gray-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
                <p className="text-gray-500 mb-2">No connections found</p>
                <p className="text-sm text-gray-400">
                  AI analysis didn't identify any collaborations or connections for this influencer.
                </p>
              </div>
            )}
          </div>

          {/* Products */}
          {influencer.products && influencer.products.length > 0 && (
            <div className="bg-white rounded-xl shadow-lg p-6">
              <h2 className="text-2xl font-bold mb-6">Products & Sponsorships</h2>
              <div className="space-y-6">
                {influencer.products.map((product, idx) => (
                  <div key={idx} className="border rounded-lg p-4 bg-gray-50">
                    <div className="flex items-start justify-between mb-3">
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
                      <p className="text-sm text-gray-700 mb-3">{product.description}</p>
                    )}

                    {/* OpenFoodFacts Nutritional Data */}
                    {product.openfoodfacts_data && (
                      <div className="mt-4 border-t pt-4 bg-white rounded-lg p-4">
                        <h4 className="font-semibold text-sm mb-3 flex items-center gap-2">
                          <span>🥗 Nutritional & Safety Information</span>
                          <span className="text-xs bg-green-100 text-green-800 px-2 py-1 rounded-full">
                            OpenFoodFacts
                          </span>
                        </h4>
                        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                          {product.openfoodfacts_data.nutriscore_grade && (
                            <div className="text-center p-3 bg-gradient-to-br from-green-50 to-green-100 rounded-lg border border-green-200">
                              <p className="text-xs text-gray-600 mb-1">NutriScore</p>
                              <p className={`text-3xl font-bold ${
                                product.openfoodfacts_data.nutriscore_grade === 'a' ? 'text-green-600' :
                                product.openfoodfacts_data.nutriscore_grade === 'b' ? 'text-lime-600' :
                                product.openfoodfacts_data.nutriscore_grade === 'c' ? 'text-yellow-600' :
                                product.openfoodfacts_data.nutriscore_grade === 'd' ? 'text-orange-600' :
                                'text-red-600'
                              }`}>
                                {product.openfoodfacts_data.nutriscore_grade.toUpperCase()}
                              </p>
                            </div>
                          )}
                          {product.openfoodfacts_data.nova_group && (
                            <div className="text-center p-3 bg-gradient-to-br from-blue-50 to-blue-100 rounded-lg border border-blue-200">
                              <p className="text-xs text-gray-600 mb-1">NOVA Group</p>
                              <p className="text-3xl font-bold text-blue-700">
                                {product.openfoodfacts_data.nova_group}
                              </p>
                              <p className="text-xs text-gray-500 mt-1">
                                {product.openfoodfacts_data.nova_group === 1 ? 'Unprocessed' :
                                 product.openfoodfacts_data.nova_group === 2 ? 'Processed' :
                                 product.openfoodfacts_data.nova_group === 3 ? 'Processed' :
                                 'Ultra-processed'}
                              </p>
                            </div>
                          )}
                          {product.openfoodfacts_data.ecoscore_grade && (
                            <div className="text-center p-3 bg-gradient-to-br from-emerald-50 to-emerald-100 rounded-lg border border-emerald-200">
                              <p className="text-xs text-gray-600 mb-1">Eco-Score</p>
                              <p className={`text-3xl font-bold ${
                                product.openfoodfacts_data.ecoscore_grade === 'a' ? 'text-green-600' :
                                product.openfoodfacts_data.ecoscore_grade === 'b' ? 'text-lime-600' :
                                product.openfoodfacts_data.ecoscore_grade === 'c' ? 'text-yellow-600' :
                                product.openfoodfacts_data.ecoscore_grade === 'd' ? 'text-orange-600' :
                                'text-red-600'
                              }`}>
                                {product.openfoodfacts_data.ecoscore_grade.toUpperCase()}
                              </p>
                            </div>
                          )}
                          {product.openfoodfacts_data.safety_score !== undefined && (
                            <div className="text-center p-3 bg-gradient-to-br from-purple-50 to-purple-100 rounded-lg border border-purple-200">
                              <p className="text-xs text-gray-600 mb-1">Safety Score</p>
                              <p className={`text-3xl font-bold ${getTrustScoreColor(product.openfoodfacts_data.safety_score)}`}>
                                {product.openfoodfacts_data.safety_score}
                              </p>
                            </div>
                          )}
                        </div>

                        {/* Ingredients */}
                        {product.openfoodfacts_data.ingredients_text && (
                          <div className="mt-4">
                            <p className="text-xs font-semibold text-gray-700 mb-1">Ingredients:</p>
                            <p className="text-sm text-gray-600 leading-relaxed">
                              {product.openfoodfacts_data.ingredients_text}
                            </p>
                          </div>
                        )}

                        {/* Allergens */}
                        {product.openfoodfacts_data.allergens && product.openfoodfacts_data.allergens.length > 0 && (
                          <div className="mt-3">
                            <p className="text-xs font-semibold text-red-700 mb-2">⚠️ Allergens:</p>
                            <div className="flex flex-wrap gap-2">
                              {product.openfoodfacts_data.allergens.map((allergen: string, i: number) => (
                                <span key={i} className="text-xs bg-red-100 text-red-800 px-2 py-1 rounded-full border border-red-200">
                                  {allergen}
                                </span>
                              ))}
                            </div>
                          </div>
                        )}

                        {/* Warning for hazardous ingredients (cosmetics) */}
                        {product.openfoodfacts_data.hazardous_ingredients && product.openfoodfacts_data.hazardous_ingredients.length > 0 && (
                          <div className="mt-3 p-3 bg-red-50 border border-red-200 rounded-lg">
                            <p className="text-xs font-semibold text-red-800 mb-2">⚠️ Hazardous Ingredients:</p>
                            <ul className="text-sm text-red-700 space-y-1">
                              {product.openfoodfacts_data.hazardous_ingredients.map((ingredient: string, i: number) => (
                                <li key={i}>• {ingredient}</li>
                              ))}
                            </ul>
                          </div>
                        )}
                      </div>
                    )}

                    {/* User Reviews from Social Media */}
                    {product.reviews && product.reviews.length > 0 && (
                      <div className="mt-4 border-t pt-4">
                        <h4 className="font-semibold text-sm mb-3 flex items-center gap-2">
                          <span>💬 User Comments from Social Media</span>
                          <span className="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded-full">
                            {product.review_count} reviews
                          </span>
                        </h4>
                        <div className="space-y-3 max-h-96 overflow-y-auto">
                          {product.reviews.map((review, reviewIdx) => {
                            const getSentimentColor = (sentiment: string) => {
                              if (sentiment === 'positive') return 'border-l-green-500 bg-green-50';
                              if (sentiment === 'negative') return 'border-l-red-500 bg-red-50';
                              return 'border-l-gray-500 bg-white';
                            };

                            const getSentimentIcon = (sentiment: string) => {
                              if (sentiment === 'positive') return '👍';
                              if (sentiment === 'negative') return '👎';
                              return '💬';
                            };

                            return (
                              <div
                                key={reviewIdx}
                                className={`border-l-4 p-3 rounded ${getSentimentColor(review.sentiment)}`}
                              >
                                <div className="flex items-start justify-between mb-2">
                                  <div className="flex items-center gap-2">
                                    <span className="text-lg">{getSentimentIcon(review.sentiment)}</span>
                                    <span className="font-semibold text-sm">@{review.author}</span>
                                    <span className="text-xs bg-white px-2 py-0.5 rounded-full border capitalize">
                                      {review.platform}
                                    </span>
                                  </div>
                                  {review.date && (
                                    <span className="text-xs text-gray-500">
                                      {new Date(review.date).toLocaleDateString('en-US', {
                                        month: 'short',
                                        day: 'numeric',
                                        year: 'numeric'
                                      })}
                                    </span>
                                  )}
                                </div>
                                <p className="text-sm text-gray-700 mb-2 italic">"{review.comment}"</p>
                                {review.url && (
                                  <a
                                    href={review.url}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="text-xs text-blue-600 hover:text-blue-700"
                                  >
                                    View original →
                                  </a>
                                )}
                              </div>
                            );
                          })}
                        </div>
                      </div>
                    )}
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>

        {/* News & Drama Section */}
        {influencer.news && influencer.news.length > 0 && (
          <div className="mt-8 bg-white rounded-xl shadow-lg p-6">
            <h2 className="text-2xl font-bold mb-6">News & Drama</h2>
            <div className="space-y-4">
              {influencer.news.map((article) => {
                const getSentimentColor = (sentiment: string) => {
                  if (sentiment === 'positive') return 'bg-green-100 text-green-800 border-green-200';
                  if (sentiment === 'negative') return 'bg-red-100 text-red-800 border-red-200';
                  return 'bg-gray-100 text-gray-800 border-gray-200';
                };

                const getSentimentIcon = (sentiment: string) => {
                  if (sentiment === 'positive') return '✅';
                  if (sentiment === 'negative') return '⚠️';
                  return '📰';
                };

                const getTypeColor = (type: string) => {
                  if (type === 'drama' || type === 'controversy' || type === 'legal') return 'bg-red-50 border-red-200';
                  if (type === 'achievement') return 'bg-green-50 border-green-200';
                  if (type === 'collaboration') return 'bg-blue-50 border-blue-200';
                  return 'bg-gray-50 border-gray-200';
                };

                return (
                  <div
                    key={article.id}
                    className={`border-2 rounded-lg p-4 ${getTypeColor(article.article_type)}`}
                  >
                    <div className="flex items-start justify-between mb-3">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-2">
                          <span className="text-2xl">{getSentimentIcon(article.sentiment)}</span>
                          <h3 className="font-bold text-lg">{article.title}</h3>
                        </div>
                        <div className="flex items-center gap-2 mb-2">
                          <span className={`px-2 py-1 rounded-full text-xs font-semibold ${getSentimentColor(article.sentiment)} border`}>
                            {article.sentiment.toUpperCase()}
                          </span>
                          <span className="px-2 py-1 bg-white rounded-full text-xs font-semibold border border-gray-300 capitalize">
                            {article.article_type}
                          </span>
                          {article.date && (
                            <span className="text-xs text-gray-500">
                              {formatDate(article.date)}
                            </span>
                          )}
                        </div>
                      </div>
                      <div className="text-right ml-4">
                        <p className="text-xs text-gray-500 mb-1">Severity</p>
                        <div className="flex items-center gap-1">
                          {[...Array(10)].map((_, i) => (
                            <div
                              key={i}
                              className={`w-1.5 h-6 rounded-sm ${
                                i < article.severity
                                  ? article.severity >= 7
                                    ? 'bg-red-500'
                                    : article.severity >= 4
                                    ? 'bg-yellow-500'
                                    : 'bg-green-500'
                                  : 'bg-gray-200'
                              }`}
                            />
                          ))}
                        </div>
                      </div>
                    </div>
                    <p className="text-gray-700 mb-3">{article.description}</p>
                    <div className="flex items-center justify-between text-sm">
                      <span className="text-gray-500">
                        Source: <span className="font-semibold">{article.source}</span>
                      </span>
                      {article.url && (
                        <a
                          href={article.url}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-blue-600 hover:text-blue-700 font-semibold"
                        >
                          Read More →
                        </a>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}

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
