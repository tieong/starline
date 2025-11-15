import { useParams, useNavigate } from 'react-router-dom';
import { useState, useRef, useCallback } from 'react';
import ForceGraph2D from 'react-force-graph-2d';
import { mockInfluencers, mockReviews, mockTrustMetrics, mockNetworkData } from '../mockData';

export default function InfluencerDetail() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [selectedNode, setSelectedNode] = useState<string | null>(null);
  const graphRef = useRef<any>();

  const influencer = mockInfluencers.find((inf) => inf.id === id);
  const reviews = mockReviews[id || ''] || [];
  const trustMetrics = mockTrustMetrics[id || ''];
  const networkData = mockNetworkData[id || ''];

  if (!influencer) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-gray-800 mb-4">Influencer not found</h2>
          <button
            onClick={() => navigate('/')}
            className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            Back to Home
          </button>
        </div>
      </div>
    );
  }

  const handleNodeClick = useCallback((node: any) => {
    setSelectedNode(node.id);
  }, []);

  const getTrustScoreColor = (score: number) => {
    if (score >= 85) return 'text-green-600';
    if (score >= 70) return 'text-yellow-600';
    return 'text-red-600';
  };

  const getMetricColor = (score: number) => {
    if (score >= 85) return 'bg-green-500';
    if (score >= 70) return 'bg-yellow-500';
    return 'bg-red-500';
  };

  const renderStars = (rating: number) => {
    return (
      <div className="flex gap-1">
        {[1, 2, 3, 4, 5].map((star) => (
          <svg
            key={star}
            className={`w-4 h-4 ${star <= rating ? 'text-yellow-400' : 'text-gray-300'}`}
            fill="currentColor"
            viewBox="0 0 20 20"
          >
            <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
          </svg>
        ))}
      </div>
    );
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
              src={influencer.avatarUrl}
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
              <p className="text-gray-600 mb-2">{influencer.platform}</p>
              <p className="text-gray-700 mb-4">{influencer.bio}</p>
              <div className="flex gap-8">
                <div>
                  <p className="text-sm text-gray-500">Followers</p>
                  <p className="text-2xl font-bold">{(influencer.followerCount / 1000000).toFixed(1)}M</p>
                </div>
                <div>
                  <p className="text-sm text-gray-500">Trust Score</p>
                  <p className={`text-4xl font-bold ${getTrustScoreColor(influencer.trustScore)}`}>
                    {influencer.trustScore}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>

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
                  linkColor={() => '#cbd5e1'}
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

          {/* Trust Metrics */}
          {trustMetrics && (
            <div className="bg-white rounded-xl shadow-lg p-6">
              <h2 className="text-2xl font-bold mb-6">Trust Metrics</h2>
              <div className="space-y-4">
                <div>
                  <div className="flex justify-between mb-2">
                    <span className="font-medium">Authenticity</span>
                    <span className="font-bold">{trustMetrics.authenticity}%</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-3">
                    <div
                      className={`h-3 rounded-full ${getMetricColor(trustMetrics.authenticity)}`}
                      style={{ width: `${trustMetrics.authenticity}%` }}
                    />
                  </div>
                </div>

                <div>
                  <div className="flex justify-between mb-2">
                    <span className="font-medium">Product Quality</span>
                    <span className="font-bold">{trustMetrics.productQuality}%</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-3">
                    <div
                      className={`h-3 rounded-full ${getMetricColor(trustMetrics.productQuality)}`}
                      style={{ width: `${trustMetrics.productQuality}%` }}
                    />
                  </div>
                </div>

                <div>
                  <div className="flex justify-between mb-2">
                    <span className="font-medium">Transparency</span>
                    <span className="font-bold">{trustMetrics.transparency}%</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-3">
                    <div
                      className={`h-3 rounded-full ${getMetricColor(trustMetrics.transparency)}`}
                      style={{ width: `${trustMetrics.transparency}%` }}
                    />
                  </div>
                </div>

                <div>
                  <div className="flex justify-between mb-2">
                    <span className="font-medium">Engagement</span>
                    <span className="font-bold">{trustMetrics.engagement}%</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-3">
                    <div
                      className={`h-3 rounded-full ${getMetricColor(trustMetrics.engagement)}`}
                      style={{ width: `${trustMetrics.engagement}%` }}
                    />
                  </div>
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Reviews Section */}
        <div className="mt-8 bg-white rounded-xl shadow-lg p-6">
          <h2 className="text-2xl font-bold mb-6">Community Reviews</h2>
          {reviews.length > 0 ? (
            <div className="space-y-4">
              {reviews.map((review) => (
                <div key={review.id} className="border-b pb-4 last:border-b-0">
                  <div className="flex items-start justify-between mb-2">
                    <div>
                      <div className="flex items-center gap-2">
                        <span className="font-semibold">{review.userName}</span>
                        {review.verified && (
                          <span className="text-xs bg-blue-100 text-blue-800 px-2 py-1 rounded">
                            Verified Purchase
                          </span>
                        )}
                      </div>
                      {renderStars(review.rating)}
                    </div>
                    <span className="text-sm text-gray-500">{review.date}</span>
                  </div>
                  {review.productName && (
                    <p className="text-sm text-gray-600 mb-2">
                      Product: <span className="font-medium">{review.productName}</span>
                    </p>
                  )}
                  <p className="text-gray-700">{review.comment}</p>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-gray-500 text-center py-8">
              No reviews yet for this influencer
            </p>
          )}
        </div>
      </div>
    </div>
  );
}
