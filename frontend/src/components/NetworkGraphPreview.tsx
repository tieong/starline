import { useEffect, useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'framer-motion';
import * as d3 from 'd3';
import { Network, ExternalLink } from 'lucide-react';
import { dataService } from '../services/dataService';
import { useDataContext } from '../context/DataContext';
import { GraphNode, Relationship } from '../types';
import './NetworkGraphPreview.css';

interface NetworkGraphPreviewProps {
  influencerId: string;
}

interface Node extends d3.SimulationNodeDatum {
  id: string;
  name: string;
  type: 'influencer' | 'agency' | 'brand' | 'event';
  avatar?: string;
  score?: number;
  size: number;
}

interface Link extends d3.SimulationLinkDatum<Node> {
  source: string | Node;
  target: string | Node;
  type: string;
  strength: number;
}

export const NetworkGraphPreview = ({ influencerId }: NetworkGraphPreviewProps) => {
  const navigate = useNavigate();
  const { useMockData } = useDataContext();
  const svgRef = useRef<SVGSVGElement>(null);
  const [loading, setLoading] = useState(true);
  const [hasData, setHasData] = useState(false);

  useEffect(() => {
    const loadAndRenderGraph = async () => {
      if (!svgRef.current || !influencerId) {
        console.log('[NetworkGraphPreview] Missing svgRef or influencerId');
        setLoading(false);
        return;
      }

      console.log('[NetworkGraphPreview] Loading graph data for influencer:', influencerId);
      setLoading(true);
      
      try {
        // Create a timeout promise
        const timeoutPromise = new Promise((_, reject) => {
          setTimeout(() => reject(new Error('Graph data loading timeout')), 15000);
        });

        // Load graph data with timeout (skipFetch=true for preview to avoid long AI calls)
        const graphDataPromise = dataService.getGraphData(useMockData, influencerId, true);
        
        const { nodes: graphNodes, relationships } = await Promise.race([
          graphDataPromise,
          timeoutPromise
        ]) as { nodes: GraphNode[]; relationships: Relationship[] };

        console.log('[NetworkGraphPreview] Loaded graph data:', {
          nodeCount: graphNodes?.length || 0,
          relationshipCount: relationships?.length || 0
        });

        if (!graphNodes || graphNodes.length === 0) {
          console.log('[NetworkGraphPreview] No graph nodes available');
          setHasData(false);
          setLoading(false);
          return;
        }

        // Filter to show only the central node and its direct connections
        const centralNodeId = useMockData ? influencerId : `influencer-${influencerId}`;
        const connectedNodeIds = new Set<string>([centralNodeId]);

        // Find direct connections
        relationships.forEach(rel => {
          const sourceId = rel.source;
          const targetId = rel.target;

          if (sourceId === centralNodeId) connectedNodeIds.add(targetId);
          if (targetId === centralNodeId) connectedNodeIds.add(sourceId);
        });

        // Filter nodes and links
        const filteredNodes = graphNodes.filter(n => connectedNodeIds.has(n.id));
        const filteredLinks = relationships.filter(rel => {
          const sourceId = rel.source;
          const targetId = rel.target;
          return connectedNodeIds.has(sourceId) && connectedNodeIds.has(targetId);
        });

        // If we have at least the central node, show the graph
        if (filteredNodes.length === 0) {
          console.log('[NetworkGraphPreview] No matching nodes found');
          setHasData(false);
          setLoading(false);
          return;
        }

        setHasData(true);

        // Limit to max 10 connections for preview
        const maxNodes = 11; // Central + 10 connections
        if (filteredNodes.length > maxNodes) {
          const centralNode = filteredNodes.find(n => n.id === centralNodeId);
          const otherNodes = filteredNodes.filter(n => n.id !== centralNodeId).slice(0, maxNodes - 1);
          filteredNodes.splice(0, filteredNodes.length, centralNode!, ...otherNodes);
        }

        console.log('[NetworkGraphPreview] Rendering graph with', filteredNodes.length, 'nodes');
        renderGraph(filteredNodes, filteredLinks, centralNodeId);
      } catch (error) {
        console.error('[NetworkGraphPreview] Failed to load graph preview:', error);
        setHasData(false);
      } finally {
        setLoading(false);
      }
    };

    loadAndRenderGraph();
  }, [influencerId, useMockData]);

  const renderGraph = (graphNodes: GraphNode[], relationships: Relationship[], centralNodeId: string) => {
    if (!svgRef.current) return;

    const width = svgRef.current.clientWidth;
    const height = svgRef.current.clientHeight;

    // Clear previous content
    d3.select(svgRef.current).selectAll('*').remove();

    const svg = d3.select(svgRef.current);
    const g = svg.append('g');

    // Prepare data
    const nodes: Node[] = graphNodes.map(n => ({ ...n }));
    const links: Link[] = relationships.map(r => ({ ...r }));

    // Create force simulation
    const simulation = d3.forceSimulation<Node>(nodes)
      .force('link', d3.forceLink<Node, Link>(links)
        .id(d => d.id)
        .distance(60)
        .strength(0.5))
      .force('charge', d3.forceManyBody().strength(-300))
      .force('center', d3.forceCenter(width / 2, height / 2))
      .force('collision', d3.forceCollide().radius(20));

    // Draw links
    const link = g.append('g')
      .selectAll('line')
      .data(links)
      .enter()
      .append('line')
      .attr('stroke', '#444')
      .attr('stroke-width', 1.5)
      .attr('stroke-opacity', 0.6);

    // Draw nodes
    const node = g.append('g')
      .selectAll('g')
      .data(nodes)
      .enter()
      .append('g')
      .attr('cursor', 'pointer');

    // Node circles
    node.append('circle')
      .attr('r', d => d.id === centralNodeId ? 18 : 12)
      .attr('fill', d => {
        if (d.id === centralNodeId) return '#6366f1';
        if (d.type === 'agency') return '#f59e0b';
        if (d.type === 'brand') return '#10b981';
        return '#8b5cf6';
      })
      .attr('stroke', '#fff')
      .attr('stroke-width', 2);

    // Node labels (only for central node in preview)
    node.filter(d => d.id === centralNodeId)
      .append('text')
      .text(d => d.name)
      .attr('text-anchor', 'middle')
      .attr('dy', 30)
      .attr('font-size', '11px')
      .attr('fill', '#fff')
      .attr('font-weight', 'bold');

    // Update positions on simulation tick
    simulation.on('tick', () => {
      link
        .attr('x1', d => (d.source as Node).x || 0)
        .attr('y1', d => (d.source as Node).y || 0)
        .attr('x2', d => (d.target as Node).x || 0)
        .attr('y2', d => (d.target as Node).y || 0);

      node.attr('transform', d => `translate(${d.x || 0},${d.y || 0})`);
    });

    // Stop simulation after a few iterations for preview
    simulation.alpha(0.3).restart();
    setTimeout(() => simulation.stop(), 2000);
  };

  const handleViewFullNetwork = () => {
    navigate(`/graph/${influencerId}`);
  };

  if (loading) {
    return (
      <div className="network-graph-preview loading">
        <div className="preview-loading">
          <Network className="spinning" size={24} />
          <p>Loading network...</p>
        </div>
      </div>
    );
  }

  if (!hasData) {
    return (
      <div className="network-graph-preview-button-only">
        <motion.button
          className="explore-network-button"
          onClick={handleViewFullNetwork}
          whileHover={{ scale: 1.02 }}
          whileTap={{ scale: 0.98 }}
        >
          <Network size={18} />
          <span>Explore network graph</span>
          <ExternalLink size={14} />
        </motion.button>
      </div>
    );
  }

  return (
    <div className="network-graph-preview">
      <svg ref={svgRef} className="preview-svg" />
      <motion.button
        className="view-full-graph-button"
        onClick={handleViewFullNetwork}
        whileHover={{ scale: 1.02 }}
        whileTap={{ scale: 0.98 }}
      >
        <Network size={16} />
        <span>View full network graph</span>
        <ExternalLink size={14} />
      </motion.button>
    </div>
  );
};

