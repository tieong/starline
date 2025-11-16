import { useEffect, useState, useRef } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import * as d3 from 'd3';
import { Loader2, CheckCircle2 } from 'lucide-react';
import { apiService } from '../services/api';
import './ExplorationLoading.css';

interface Node extends d3.SimulationNodeDatum {
  id: string;
  name: string;
  type: 'influencer' | 'agency' | 'brand' | 'event';
  size: number;
  explored?: boolean;
}

interface Link extends d3.SimulationLinkDatum<Node> {
  source: string | Node;
  target: string | Node;
  type: string;
  strength: number;
}

export const ExplorationLoading = () => {
  const { name } = useParams<{ name: string }>();
  const navigate = useNavigate();
  const svgRef = useRef<SVGSVGElement>(null);
  const simulationRef = useRef<d3.Simulation<Node, Link> | null>(null);

  const [status, setStatus] = useState<'analyzing' | 'generating' | 'complete' | 'error'>('analyzing');
  const [currentStep, setCurrentStep] = useState('Analyzing influencer...');
  const [nodes, setNodes] = useState<Node[]>([]);
  const [links, setLinks] = useState<Link[]>([]);
  const [centerInfluencerId, setCenterInfluencerId] = useState<number | null>(null);

  // Lancer l'exploration
  useEffect(() => {
    if (!name) return;

    const startExploration = async () => {
      try {
        setStatus('analyzing');
        setCurrentStep(`Searching for "${name}"...`);

        // Démarrer l'exploration
        const result = await apiService.startExploration(name);
        
        setCenterInfluencerId(result.center_influencer_id);
        setStatus('generating');
        setCurrentStep('Building graph...');

        // Ajouter les nœuds progressivement avec animation
        const allNodes = result.nodes;
        const allLinks = result.links;

        // Ajouter le nœud central d'abord
        setNodes([allNodes[0]]);
        await new Promise(resolve => setTimeout(resolve, 500));

        // Ajouter les autres nœuds un par un
        for (let i = 1; i < allNodes.length; i++) {
          setNodes(prev => [...prev, allNodes[i]]);
          setLinks(prev => {
            const newLinks = allLinks.filter(l => 
              typeof l.target === 'string' 
                ? l.target === allNodes[i].id 
                : l.target.id === allNodes[i].id
            );
            return [...prev, ...newLinks];
          });
          await new Promise(resolve => setTimeout(resolve, 300));
        }

        setStatus('complete');
        setCurrentStep('Graph complete!');

        // Rediriger vers le graphe après 1 seconde
        setTimeout(() => {
          navigate(`/graph/${result.center_influencer_id}`);
        }, 1500);

      } catch (error) {
        console.error('Exploration failed:', error);
        setStatus('error');
        setCurrentStep('Failed to analyze influencer');
      }
    };

    startExploration();
  }, [name, navigate]);

  // Initialiser le graphe D3
  useEffect(() => {
    if (!svgRef.current || nodes.length === 0) return;

    const width = svgRef.current.clientWidth;
    const height = svgRef.current.clientHeight;

    // Nettoyer l'ancien graphe
    d3.select(svgRef.current).selectAll('*').remove();

    const svg = d3.select(svgRef.current);
    const g = svg.append('g');

    // Couleurs
    const colorMap = {
      influencer: '#8B5CF6',
      agency: '#F59E0B',
      brand: '#3B82F6',
      event: '#10B981'
    };

    // Créer la simulation
    const simulation = d3.forceSimulation(nodes)
      .force('link', d3.forceLink(links)
        .id((d: any) => d.id)
        .distance(150)
        .strength((d: any) => d.strength || 0.5)
      )
      .force('charge', d3.forceManyBody().strength(-500))
      .force('center', d3.forceCenter(width / 2, height / 2))
      .force('collision', d3.forceCollide().radius((d: any) => d.size * 0.5 + 10));

    simulationRef.current = simulation;

    // Créer les liens
    const link = g.append('g')
      .selectAll('line')
      .data(links)
      .join('line')
      .attr('stroke', '#8B5CF6')
      .attr('stroke-opacity', 0.6)
      .attr('stroke-width', 2);

    // Créer les nœuds
    const node = g.append('g')
      .selectAll('g')
      .data(nodes)
      .join('g');

    node.append('circle')
      .attr('r', (d: Node) => d.size * 0.4)
      .attr('fill', (d: Node) => colorMap[d.type])
      .attr('stroke', '#fff')
      .attr('stroke-width', 2)
      .style('filter', (d: Node) => {
        const color = colorMap[d.type];
        return `drop-shadow(0 0 8px ${color})`;
      })
      .style('opacity', 0)
      .transition()
      .duration(500)
      .style('opacity', 1);

    // Ajouter les labels
    node.append('text')
      .text((d: Node) => d.name)
      .attr('y', (d: Node) => (d.size * 0.5) + 25)
      .attr('text-anchor', 'middle')
      .attr('font-family', 'Inter, sans-serif')
      .attr('font-size', 12)
      .attr('font-weight', 600)
      .attr('fill', '#fff')
      .style('opacity', 0)
      .transition()
      .duration(500)
      .delay(200)
      .style('opacity', 1);

    // Mise à jour de la simulation
    simulation.on('tick', () => {
      link
        .attr('x1', (d: any) => d.source.x)
        .attr('y1', (d: any) => d.source.y)
        .attr('x2', (d: any) => d.target.x)
        .attr('y2', (d: any) => d.target.y);

      node.attr('transform', (d: any) => `translate(${d.x},${d.y})`);
    });

    return () => {
      simulation.stop();
    };
  }, [nodes, links]);

  return (
    <div className="exploration-loading">
      {/* Graphe en fond */}
      <svg ref={svgRef} className="exploration-graph"></svg>

      {/* Overlay avec statut */}
      <div className="exploration-overlay">
        <motion.div
          className="exploration-status-card"
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.5 }}
        >
          <AnimatePresence mode="wait">
            {status === 'analyzing' && (
              <motion.div
                key="analyzing"
                className="status-content"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -20 }}
              >
                <Loader2 size={48} className="status-icon spinning" />
                <h2>Analyzing</h2>
                <p>{currentStep}</p>
              </motion.div>
            )}

            {status === 'generating' && (
              <motion.div
                key="generating"
                className="status-content"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -20 }}
              >
                <Loader2 size={48} className="status-icon spinning" />
                <h2>Generating Graph</h2>
                <p>{currentStep}</p>
                <div className="node-counter">
                  {nodes.length} node{nodes.length > 1 ? 's' : ''} discovered
                </div>
              </motion.div>
            )}

            {status === 'complete' && (
              <motion.div
                key="complete"
                className="status-content"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -20 }}
              >
                <CheckCircle2 size={48} className="status-icon success" />
                <h2>Complete!</h2>
                <p>Redirecting to graph...</p>
              </motion.div>
            )}

            {status === 'error' && (
              <motion.div
                key="error"
                className="status-content"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: -20 }}
              >
                <div className="status-icon error">✕</div>
                <h2>Error</h2>
                <p>{currentStep}</p>
                <button 
                  className="retry-button"
                  onClick={() => navigate('/')}
                >
                  Go back
                </button>
              </motion.div>
            )}
          </AnimatePresence>
        </motion.div>
      </div>
    </div>
  );
};

