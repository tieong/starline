import { useEffect, useRef, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import * as d3 from 'd3';
import { ArrowLeft, ZoomIn, ZoomOut, Maximize2, Home, Loader2 } from 'lucide-react';
import { DataSourceToggle } from '../components/DataSourceToggle';
import { dataService } from '../services/dataService';
import { apiService } from '../services/api';
import { useDataContext } from '../context/DataContext';
import { GraphNode, Relationship, Influencer } from '../types';
import { InfluencerInfoPanel } from '../components/InfluencerInfoPanel';
import { ThreeDInfluencerMap } from '../components/ThreeDInfluencerMap';
import './NetworkGraph.css';

interface Node extends d3.SimulationNodeDatum {
  id: string;
  name: string;
  type: 'influencer' | 'agency' | 'brand' | 'event';
  avatar?: string;
  score?: number;
  size: number;
  explored?: boolean;
  pending_name?: string;
  influencer_id?: number;
}

interface Link extends d3.SimulationLinkDatum<Node> {
  source: string | Node;
  target: string | Node;
  type: string;
  strength: number;
  label?: string;
}

export const NetworkGraph = () => {
  const { id } = useParams<{ id?: string }>();
  const navigate = useNavigate();
  const { useMockData } = useDataContext();
  const svgRef = useRef<SVGSVGElement>(null);

  const [graphNodes, setGraphNodes] = useState<GraphNode[]>([]);
  const [relationships, setRelationships] = useState<Relationship[]>([]);
  const [influencers, setInfluencers] = useState<Influencer[]>([]);
  const [loading, setLoading] = useState(true);

  const [selectedInfluencerId, setSelectedInfluencerId] = useState<string | null>(id || null);
  const [centralInfluencer, setCentralInfluencer] = useState<string | null>(id || null);
  const [viewMode, setViewMode] = useState<'3d' | '2d'>(id ? '2d' : '3d');
  const [zoomLevel, setZoomLevel] = useState<number>(1);
  
  // États pour l'exploration itérative
  const [expandingNodes, setExpandingNodes] = useState<Set<string>>(new Set());
  const [explorationMode, setExplorationMode] = useState(false);

  // Fonction pour expandre un nœud (générer ses connexions)
  const handleNodeExpansion = async (node: Node) => {
    // Ne pas expanser si déjà en cours
    if (expandingNodes.has(node.id)) {
      console.log('[NetworkGraph] Node already expanding:', node.id);
      return;
    }

    // Ne pas expanser si déjà exploré
    if (node.explored) {
      console.log('[NetworkGraph] Node already explored:', node.id);
      return;
    }

    // Seulement les influenceurs peuvent être expandus
    if (node.type !== 'influencer') {
      console.log('[NetworkGraph] Cannot expand non-influencer node:', node.id);
      return;
    }

    // En mode mock data, ne pas supporter l'expansion
    if (useMockData) {
      console.log('[NetworkGraph] Expansion not supported in mock data mode');
      return;
    }

    console.log('[NetworkGraph] Expanding node:', node.name, node.id);
    
    // Marquer comme en cours d'expansion
    setExpandingNodes(prev => new Set(prev).add(node.id));

    try {
      // Appeler l'API pour expandre le nœud
      const result = await apiService.expandNode(
        node.id,
        node.pending_name || node.name
      );

      console.log('[NetworkGraph] Expansion result:', result);

      // Mettre à jour le graphe avec les nouveaux nœuds et liens
      setGraphNodes(prevNodes => {
        const newNodes = [...prevNodes];
        
        // Marquer le nœud source comme exploré
        const sourceNodeIndex = newNodes.findIndex(n => n.id === node.id);
        if (sourceNodeIndex !== -1) {
          newNodes[sourceNodeIndex] = {
            ...newNodes[sourceNodeIndex],
            explored: true,
            influencer_id: result.influencer_data.id
          };
        }

        // Ajouter les nouveaux nœuds (éviter les doublons)
        result.new_nodes.forEach((newNode: any) => {
          if (!newNodes.find(n => n.id === newNode.id)) {
            newNodes.push(newNode);
          }
        });

        return newNodes;
      });

      setRelationships(prevLinks => {
        const newLinks = [...prevLinks];
        
        // Ajouter les nouveaux liens (éviter les doublons)
        result.new_links.forEach((newLink: any) => {
          const exists = newLinks.find(l => 
            l.source === newLink.source && l.target === newLink.target
          );
          if (!exists) {
            newLinks.push(newLink);
          }
        });

        return newLinks;
      });

      console.log('[NetworkGraph] Successfully expanded node:', node.name);
    } catch (error) {
      console.error('[NetworkGraph] Failed to expand node:', error);
    } finally {
      // Retirer de la liste des nœuds en expansion
      setExpandingNodes(prev => {
        const next = new Set(prev);
        next.delete(node.id);
        return next;
      });
    }
  };

  // Load graph data
  useEffect(() => {
    const loadGraphData = async () => {
      console.log('[NetworkGraph] Starting to load graph data, useMockData:', useMockData, 'id:', id);
      setLoading(true);
      try {
        const [graphData, influencersData] = await Promise.all([
          dataService.getGraphData(useMockData, id),
          dataService.getInfluencers(useMockData),
        ]);

        console.log('[NetworkGraph] Graph data loaded:', {
          nodeCount: graphData.nodes.length,
          relationshipCount: graphData.relationships.length,
          nodes: graphData.nodes.slice(0, 3)
        });

        setGraphNodes(graphData.nodes);
        setRelationships(graphData.relationships);
        setInfluencers(influencersData);
      } catch (err) {
        console.error('Failed to load graph data:', err);
      } finally {
        setLoading(false);
      }
    };

    loadGraphData();
  }, [useMockData, id]);

  useEffect(() => {
    if (id) {
      setCentralInfluencer(id);
      setSelectedInfluencerId(id);
      setViewMode('2d');
    }
  }, [id]);

  useEffect(() => {
    console.log('[NetworkGraph] Rendering useEffect triggered:', {
      hasRef: !!svgRef.current,
      viewMode,
      nodeCount: graphNodes?.length || 0,
      relationshipCount: relationships?.length || 0,
      centralInfluencer,
      id
    });

    if (!svgRef.current) return;
    if (viewMode !== '2d') {
      d3.select(svgRef.current).selectAll('*').remove();
      return;
    }

    // Don't render if we don't have valid data
    if (!graphNodes || graphNodes.length === 0) {
      console.warn('[NetworkGraph] No graph nodes available for rendering');
      return;
    }

    console.log('[NetworkGraph] Starting D3 render with', graphNodes.length, 'nodes');

    const width = svgRef.current.clientWidth;
    const height = svgRef.current.clientHeight;

    console.log('[NetworkGraph] SVG dimensions:', { width, height });

    if (width === 0 || height === 0) {
      console.error('[NetworkGraph] SVG has zero dimensions! Cannot render graph.');
      return;
    }

    // Clear previous content
    d3.select(svgRef.current).selectAll('*').remove();

    const svg = d3.select(svgRef.current);

    const g = svg.append('g');

    // Zoom behavior with intelligent detail display
    const zoom = d3.zoom<SVGSVGElement, unknown>()
      .scaleExtent([0.5, 3])
      .on('zoom', (event) => {
        g.attr('transform', event.transform);
        setZoomLevel(event.transform.k);

        // Update visibility based on zoom level
        updateDetailsVisibility(event.transform.k);
      });

    svg.call(zoom);

    // Prepare data
    const nodes: Node[] = graphNodes.map(n => ({ ...n }));
    const links: Link[] = relationships.map(r => ({ ...r }));

    console.log('[NetworkGraph] Prepared D3 data:', { nodes: nodes.length, links: links.length });

    // Color mapping - Vibrant colors with white background
    const colorMap = {
      influencer: '#8B5CF6', // Purple
      agency: '#F59E0B',     // Orange
      brand: '#3B82F6',      // Blue
      event: '#10B981'       // Green
    };

    const linkColorMap = {
      agency: '#F59E0B',
      collaboration: '#10B981',
      friendship: '#8B5CF6',
      brand: '#3B82F6'
    };

    // Create force simulation
    const simulation = d3.forceSimulation(nodes)
      .force('link', d3.forceLink(links)
        .id((d: any) => d.id)
        .distance(150)
        .strength((d: any) => d.strength * 0.5)
      )
      .force('charge', d3.forceManyBody().strength(-800))
      .force('center', d3.forceCenter(width / 2, height / 2))
      .force('collision', d3.forceCollide().radius((d: any) => d.size + 10));

    // Handle both ID formats for central influencer
    const centralNodeId = centralInfluencer
      ? (centralInfluencer.startsWith('influencer-')
          ? centralInfluencer
          : `influencer-${centralInfluencer}`)
      : null;

    // Create links with colorful style (following GUIDELINES.md: high contrast, bold)
    const link = g.append('g')
      .selectAll('line')
      .data(links)
      .join('line')
      .attr('stroke', (d: any) => linkColorMap[d.type as keyof typeof linkColorMap] || '#000000')
      .attr('stroke-opacity', (d: any) => {
        if (!centralNodeId) return 0.7;

        const source = typeof d.source === 'object' ? d.source.id : d.source;
        const target = typeof d.target === 'object' ? d.target.id : d.target;

        // Highlight links connected to central node
        const isConnectedToCenter = source === centralNodeId || target === centralNodeId;
        return isConnectedToCenter ? 0.9 : 0.4;
      })
      .attr('stroke-width', (d: any) => {
        if (!centralNodeId) return 2.5;

        const source = typeof d.source === 'object' ? d.source.id : d.source;
        const target = typeof d.target === 'object' ? d.target.id : d.target;

        const isConnectedToCenter = source === centralNodeId || target === centralNodeId;
        return isConnectedToCenter ? 3.5 : 2;
      });

    // Create link labels (hidden for cleaner Obsidian look)
    const linkLabel = g.append('g')
      .selectAll('text')
      .data(links.filter(l => l.label))
      .join('text')
      .text((d: any) => d.label)
      .attr('font-size', 9)
      .attr('fill', 'rgba(255, 255, 255, 0.4)')
      .attr('text-anchor', 'middle')
      .style('pointer-events', 'none')
      .style('opacity', 0); // Hidden by default

    // Create nodes
    const node = g.append('g')
      .selectAll('g')
      .data(nodes)
      .join('g')
      .call(d3.drag<any, Node>()
        .on('start', dragstarted)
        .on('drag', dragged)
        .on('end', dragended) as any
      );

    console.log('[NetworkGraph] Created D3 node elements:', node.size());

    // Helper function to check if node is connected to central
    const isNodeConnected = (nodeId: string) => {
      if (!centralInfluencer) return true;

      // Handle both formats: "1" and "influencer-1"
      const centralNodeId = centralInfluencer.startsWith('influencer-')
        ? centralInfluencer
        : `influencer-${centralInfluencer}`;

      if (nodeId === centralNodeId) return true;
      return links.some(l => {
        const source = typeof l.source === 'object' ? l.source.id : l.source;
        const target = typeof l.target === 'object' ? l.target.id : l.target;
        return (source === centralNodeId && target === nodeId) ||
               (target === centralNodeId && source === nodeId);
      });
    };

    // Node circles - Colorful with gradient shadows
    node.append('circle')
      .attr('r', (d: Node) => {
        const baseSize = d.size * 0.4;
        const isConnected = isNodeConnected(d.id);

        if (d.id === centralNodeId) return baseSize * 1.5;
        if (isConnected) return baseSize;
        return baseSize * 0.6; // Smaller for non-connected nodes
      })
      .attr('fill', (d: Node) => {
        // Nœuds non-explorés ont un remplissage semi-transparent
        if (d.type === 'influencer' && !d.explored) {
          return `${colorMap[d.type]}40`; // 25% opacity
        }
        return colorMap[d.type];
      })
      .attr('stroke', (d: Node) => colorMap[d.type])
      .attr('stroke-width', (d: Node) => {
        // Nœuds non-explorés ont un contour plus épais
        if (d.type === 'influencer' && !d.explored) return 3;
        return 2;
      })
      .attr('stroke-dasharray', (d: Node) => {
        // Nœuds non-explorés ont un contour en pointillé
        if (d.type === 'influencer' && !d.explored) return '5,3';
        return '0';
      })
      .style('cursor', (d: Node) => {
        if (d.type === 'influencer' && !d.explored) return 'pointer';
        return 'pointer';
      })
      .style('filter', (d: Node) => {
        const color = colorMap[d.type];
        return `drop-shadow(0 0 ${d.id === centralNodeId ? '10px' : '6px'} ${color})`;
      })
      .style('opacity', (d: Node) => {
        if (!centralNodeId) return 0.95;
        if (d.id === centralNodeId) return 1;
        const isConnected = isNodeConnected(d.id);
        return isConnected ? 0.85 : 0.2;
      })
      .on('click', async (event, d) => {
        event.stopPropagation();
        
        // Si le nœud n'est pas exploré et c'est un influenceur, lancer l'expansion
        if (d.type === 'influencer' && !d.explored && !expandingNodes.has(d.id)) {
          console.log('[NetworkGraph] Clicking unexplored node, expanding:', d.name);
          await handleNodeExpansion(d);
        }
        
        // Set this node as the new center
        setCentralInfluencer(d.id);
        if (d.type === 'influencer') {
          setSelectedInfluencerId(d.id);
        } else {
          setSelectedInfluencerId(null);
        }
      })
      .on('mouseenter', function() {
        d3.select(this)
          .transition()
          .duration(200)
          .attr('r', (d: any) => {
            const baseSize = d.size * 0.4;
            const isConnected = isNodeConnected(d.id);
            let currentSize = baseSize;
            if (d.id === centralNodeId) currentSize = baseSize * 1.5;
            else if (!isConnected) currentSize = baseSize * 0.6;
            return currentSize * 1.2;
          })
          .attr('stroke-width', 3);
      })
      .on('mouseleave', function() {
        d3.select(this)
          .transition()
          .duration(200)
          .attr('r', (d: any) => {
            const baseSize = d.size * 0.4;
            const isConnected = isNodeConnected(d.id);
            if (d.id === centralNodeId) return baseSize * 1.5;
            if (isConnected) return baseSize;
            return baseSize * 0.6;
          })
          .attr('stroke-width', 2);
      });

    // Add score badges for influencers with colors
    node.filter((d: Node) => d.type === 'influencer' && !!d.score)
      .append('circle')
      .attr('r', 10)
      .attr('cx', (d: Node) => d.size * 0.25)
      .attr('cy', (d: Node) => -d.size * 0.25)
      .attr('fill', (d: Node) => {
        if (!d.score) return '#10B981';
        if (d.score >= 85) return '#10B981';
        if (d.score >= 70) return '#3B82F6';
        if (d.score >= 50) return '#F59E0B';
        return '#EF4444';
      })
      .attr('stroke', 'white')
      .attr('stroke-width', 2)
      .style('filter', (d: Node) => {
        const color = d.score! >= 85 ? '#10B981' : d.score! >= 70 ? '#3B82F6' : d.score! >= 50 ? '#F59E0B' : '#EF4444';
        return `drop-shadow(0 0 4px ${color})`;
      });

    const scoreText = node.filter((d: Node) => d.type === 'influencer' && !!d.score)
      .append('text')
      .attr('class', 'score-text')
      .attr('x', (d: Node) => d.size * 0.25)
      .attr('y', (d: Node) => -d.size * 0.25 + 4)
      .attr('text-anchor', 'middle')
      .attr('font-family', 'Inter, sans-serif')
      .attr('font-size', 9)
      .attr('font-weight', '700')
      .attr('fill', 'white')
      .style('pointer-events', 'none')
      .style('opacity', 0) // Hidden by default, shown when zoomed
      .text((d: Node) => d.score || '');

    // Node labels - Visible for major nodes or when zoomed
    // First add background rectangle for labels (following GUIDELINES.md: black border 1px, no radius)
    const labelBackgrounds = node.append('rect')
      .attr('class', 'label-bg')
      .attr('x', (d: Node) => {
        // Calculate width based on text length (rough estimation)
        const textWidth = d.name.length * 6;
        return -textWidth / 2 - 4;
      })
      .attr('y', (d: Node) => (d.size * 0.5) + 38 - 10)
      .attr('width', (d: Node) => d.name.length * 6 + 8)
      .attr('height', 16)
      .attr('fill', 'rgba(255, 255, 255, 0.95)')
      .attr('stroke', '#000000')
      .attr('stroke-width', 1)
      .attr('rx', 0)
      .style('opacity', (d: Node) => {
        // Always show for central node
        if (d.id === centralInfluencer) return '1';

        // Show for major nodes (influencers, brands, agencies) if connected
        const isConnected = isNodeConnected(d.id);
        const isMajorNode = d.type === 'influencer' || d.type === 'brand' || d.type === 'agency';

        if (isMajorNode && isConnected) return '0.7';
        return '0'; // Hidden for small nodes, shown on zoom
      });

    // Ajouter un indicateur "+" pour les nœuds non-explorés
    node.filter((d: Node) => d.type === 'influencer' && !d.explored)
      .append('text')
      .attr('class', 'node-expand-indicator')
      .text('+')
      .attr('y', 5)
      .attr('text-anchor', 'middle')
      .attr('font-family', 'Inter, sans-serif')
      .attr('font-size', 18)
      .attr('font-weight', 'bold')
      .attr('fill', 'white')
      .style('pointer-events', 'none')
      .style('opacity', 0.9);

    const nodeLabels = node.append('text')
      .attr('class', 'node-label')
      .text((d: Node) => {
        // Ajouter "🔍" pour les nœuds non-explorés
        if (d.type === 'influencer' && !d.explored) {
          return `${d.name} 🔍`;
        }
        return d.name;
      })
      .attr('y', (d: Node) => (d.size * 0.5) + 38)
      .attr('text-anchor', 'middle')
      .attr('font-family', 'Inter, sans-serif')
      .attr('font-size', 10)
      .attr('font-weight', 500)
      .attr('fill', '#000000')
      .style('pointer-events', 'none')
      .style('opacity', (d: Node) => {
        // Always show for central node
        if (d.id === centralInfluencer) return '1';

        // Show for major nodes (influencers, brands, agencies) if connected
        const isConnected = isNodeConnected(d.id);
        const isMajorNode = d.type === 'influencer' || d.type === 'brand' || d.type === 'agency';

        if (isMajorNode && isConnected) return '0.7';
        return '0'; // Hidden for small nodes, shown on zoom
      });

    // Function to update details visibility based on zoom level
    const updateDetailsVisibility = (zoomScale: number) => {
      const showDetails = zoomScale > 1.2;

      // Show/hide score text numbers
      scoreText.style('opacity', showDetails ? '1' : '0');

      const computeLabelOpacity = (d: Node) => {
        if (d.id === centralInfluencer) return 1;

        const isConnected = isNodeConnected(d.id);
        const isMajorNode = d.type === 'influencer' || d.type === 'brand' || d.type === 'agency';

        if (showDetails && isConnected) return 0.8;
        if (isMajorNode && isConnected) return 0.7;
        return 0;
      };

      nodeLabels.style('opacity', (d: any) => computeLabelOpacity(d).toString());
      labelBackgrounds.style('opacity', (d: any) => computeLabelOpacity(d).toString());
    };

    // Show labels on hover
    node.on('mouseenter', function() {
      d3.select(this).select('.node-label')
        .transition()
        .duration(200)
        .style('opacity', 1);
      d3.select(this).select('.label-bg')
        .transition()
        .duration(200)
        .style('opacity', 1);
    })
    .on('mouseleave', function(_event, d: any) {
      const currentZoom = zoomLevel;
      const showDetails = currentZoom > 1.2;
      const isConnected = isNodeConnected(d.id);
      const isMajorNode = d.type === 'influencer' || d.type === 'brand' || d.type === 'agency';

      const targetOpacity = () => {
        if (d.id === centralInfluencer) return 1;
        if (showDetails && isConnected) return 0.8;
        if (isMajorNode && isConnected) return 0.7;
        return 0;
      };

      d3.select(this).select('.node-label')
        .transition()
        .duration(200)
        .style('opacity', targetOpacity);
      d3.select(this).select('.label-bg')
        .transition()
        .duration(200)
        .style('opacity', targetOpacity);
    });

    // Simulation tick
    simulation.on('tick', () => {
      link
        .attr('x1', (d: any) => d.source.x)
        .attr('y1', (d: any) => d.source.y)
        .attr('x2', (d: any) => d.target.x)
        .attr('y2', (d: any) => d.target.y);

      linkLabel
        .attr('x', (d: any) => (d.source.x + d.target.x) / 2)
        .attr('y', (d: any) => (d.source.y + d.target.y) / 2);

      node.attr('transform', (d: any) => `translate(${d.x},${d.y})`);
    });

    function dragstarted(event: any, d: Node) {
      if (!event.active) simulation.alphaTarget(0.3).restart();
      d.fx = d.x;
      d.fy = d.y;
    }

    function dragged(event: any, d: Node) {
      d.fx = event.x;
      d.fy = event.y;
    }

    function dragended(event: any, d: Node) {
      if (!event.active) simulation.alphaTarget(0);
      d.fx = null;
      d.fy = null;
    }

    console.log('[NetworkGraph] D3 render setup complete, nodes and simulation created');

    // Cleanup
    return () => {
      console.log('[NetworkGraph] Cleanup: stopping simulation');
      simulation.stop();
    };
  }, [id, centralInfluencer, viewMode, graphNodes, relationships]);

  const resetView = () => {
    if (viewMode !== '2d') return;
    const svg = d3.select(svgRef.current);
    svg.transition().duration(750).call(
      d3.zoom<SVGSVGElement, unknown>().transform as any,
      d3.zoomIdentity
    );
    setSelectedInfluencerId(null);
    setCentralInfluencer(null);
  };

  const zoomIn = () => {
    if (viewMode !== '2d') return;
    const svg = d3.select(svgRef.current);
    svg.transition().duration(300).call(
      d3.zoom<SVGSVGElement, unknown>().scaleBy as any,
      1.3
    );
  };

  const zoomOut = () => {
    if (viewMode !== '2d') return;
    const svg = d3.select(svgRef.current);
    svg.transition().duration(300).call(
      d3.zoom<SVGSVGElement, unknown>().scaleBy as any,
      0.7
    );
  };

  const selectedInfluencer = selectedInfluencerId
    ? influencers.find(inf => inf.id === selectedInfluencerId) || null
    : null;

  const handleThreeDSelection = (targetId: string) => {
    setCentralInfluencer(targetId);
    setSelectedInfluencerId(targetId);
    setViewMode('2d');
  };

  return (
    <div className="network-graph-page">
      {/* Data Source Toggle */}
      <div className="data-source-toggle-container">
        <DataSourceToggle />
      </div>

      <motion.div
        className="graph-header"
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        <div className="graph-header-left">
          <button className="back-button" onClick={() => navigate('/')}>
            <Home size={20} />
            <span>Home</span>
          </button>
          <button className="back-button" onClick={() => navigate(-1)}>
            <ArrowLeft size={20} />
            <span>Back</span>
          </button>
        </div>

        <div className="graph-header-center">
          <h1>Influence Network</h1>
          <div className="graph-view-toggle">
            <button
              className={viewMode === '3d' ? 'active' : ''}
              onClick={() => setViewMode('3d')}
            >
              3D overview
            </button>
            <button
              className={viewMode === '2d' ? 'active' : ''}
              onClick={() => setViewMode('2d')}
            >
              2D network
            </button>
          </div>
          {!useMockData && expandingNodes.size > 0 && (
            <div className="exploration-status">
              <Loader2 size={16} className="exploration-status-spinner" />
              <span>Exploring {expandingNodes.size} node{expandingNodes.size > 1 ? 's' : ''}...</span>
            </div>
          )}
        </div>

        <div className="graph-controls">
          <button onClick={zoomIn} title="Zoom in" disabled={viewMode !== '2d'}>
            <ZoomIn size={20} />
          </button>
          <button onClick={zoomOut} title="Zoom out" disabled={viewMode !== '2d'}>
            <ZoomOut size={20} />
          </button>
          <button onClick={resetView} title="Reset view" disabled={viewMode !== '2d'}>
            <Maximize2 size={20} />
          </button>
        </div>
      </motion.div>

      <motion.div
        className="graph-container"
      initial={{ opacity: 0, scale: 0.95 }}
      animate={{ opacity: 1, scale: 1 }}
      transition={{ delay: 0.2 }}
    >
        {viewMode === '2d' ? (
          <svg ref={svgRef} className="graph-svg"></svg>
        ) : (
          <ThreeDInfluencerMap onSelectInfluencer={handleThreeDSelection} />
        )}

        {viewMode === '2d' && (
          <AnimatePresence>
            {selectedInfluencer && (
              <InfluencerInfoPanel
                influencer={selectedInfluencer}
                onClose={() => setSelectedInfluencerId(null)}
                onViewProfile={() => navigate(`/influencer/${selectedInfluencer.id}`)}
              />
            )}
          </AnimatePresence>
        )}
    </motion.div>

      {viewMode === '2d' && (
        <motion.div
          className="graph-legend"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <h3>Legend</h3>
          <div className="legend-items">
            <div className="legend-item">
              <div className="legend-color" style={{ background: '#8B5CF6' }}></div>
              <span>Influencer</span>
            </div>
            <div className="legend-item">
              <div className="legend-color" style={{ background: '#F59E0B' }}></div>
              <span>Agency</span>
            </div>
            <div className="legend-item">
              <div className="legend-color" style={{ background: '#3B82F6' }}></div>
              <span>Brand</span>
            </div>
            <div className="legend-item">
              <div className="legend-color" style={{ background: '#10B981' }}></div>
              <span>Event</span>
            </div>
          </div>
        </motion.div>
      )}
    </div>
  );
};
