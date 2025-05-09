import React, { useCallback } from 'react';
import ReactFlow, {
  Background,
  Controls,
  MiniMap,
  Node,
  Edge,
  useNodesState,
  useEdgesState,
  XYPosition,
} from 'reactflow';
import 'reactflow/dist/style.css';
import { useEtymologyStore } from '../store/etymologyStore';
import WordNode from './WordNode';
import SearchBar from './SearchBar';
import TimelineControls from './TimelineControls';

const nodeTypes = {
  wordNode: WordNode,
};

// Constants for layout
const TIMELINE_START_X = 200;
const TIMELINE_WIDTH = 4000;
const VERTICAL_GAP = 250;
const ROW_HEIGHT = 300;
const NODE_SPACING = 120;
const VERTICAL_OFFSET = 100;

export default function EtymologyMap() {
  const { filteredWords, connections, setSelectedWord } = useEtymologyStore();
  const [timelineYear, setTimelineYear] = React.useState<number | null>(null);
  const [nodes, setNodes, onNodesChange] = useNodesState([]);
  const [edges, setEdges, onEdgesChange] = useEdgesState([]);
  const [initialized, setInitialized] = React.useState(false);
  const [draggedNodePositions, setDraggedNodePositions] = React.useState<Record<string, XYPosition>>({});

  React.useEffect(() => {
    if (filteredWords.length > 0 && !initialized) {
      setInitialized(true);
    }
  }, [filteredWords, initialized]);

  React.useEffect(() => {
    if (!initialized) return;

    const visibleWords = filteredWords.filter(word => 
      timelineYear === null || word.year <= timelineYear
    );

    if (visibleWords.length === 0) {
      setNodes([]);
      setEdges([]);
      return;
    }

    // Calculate year range for scaling
    const minYear = Math.min(...visibleWords.map(w => w.year));
    const maxYear = Math.max(...visibleWords.map(w => w.year));
    const yearSpan = Math.max(maxYear - minYear, 1);

    // Group words by language and root word
    const wordGroups = visibleWords.reduce((acc, word) => {
      const lang = word.language.toLowerCase();
      if (!acc[lang]) acc[lang] = new Map();
      
      // Find root word through connections
      let rootId = word.id;
      const derivedFrom = connections.find(conn => 
        conn.targetId === word.id && conn.type === 'derivation'
      );
      if (derivedFrom) {
        rootId = derivedFrom.sourceId;
      }
      
      if (!acc[lang].has(rootId)) {
        acc[lang].set(rootId, []);
      }
      acc[lang].get(rootId)!.push(word);
      
      return acc;
    }, {} as Record<string, Map<string, typeof visibleWords>>);

    // Sort languages by earliest word
    const sortedLanguages = Object.entries(wordGroups)
      .sort(([, groupsA], [, groupsB]) => {
        const earliestA = Math.min(...Array.from(groupsA.values()).flat().map(w => w.year));
        const earliestB = Math.min(...Array.from(groupsB.values()).flat().map(w => w.year));
        return earliestA - earliestB;
      })
      .map(([lang]) => lang);

    // Create nodes with improved positioning
    const newNodes: Node[] = [];
    const usedPositions = new Set<string>();

    sortedLanguages.forEach((language, langIndex) => {
      const groups = Array.from(wordGroups[language].values());
      const baseY = langIndex * ROW_HEIGHT + VERTICAL_GAP;
      
      groups.forEach(words => {
        words.sort((a, b) => a.year - b.year);
        
        words.forEach((word, wordIndex) => {
          // Use saved position if available, otherwise calculate new position
          const savedPosition = draggedNodePositions[word.id];
          let x, y;

          if (savedPosition) {
            x = savedPosition.x;
            y = savedPosition.y;
          } else {
            x = ((word.year - minYear) / yearSpan) * TIMELINE_WIDTH + TIMELINE_START_X;
            x += (Math.random() - 0.5) * NODE_SPACING * 0.5;
            y = baseY;
            y += (wordIndex % 2) * VERTICAL_OFFSET - VERTICAL_OFFSET / 2;

            let posKey = `${Math.round(x)},${Math.round(y)}`;
            let offset = 0;
            let attempts = 0;

            while (usedPositions.has(posKey) && attempts < 20) {
              offset += NODE_SPACING;
              y = baseY + (offset % (ROW_HEIGHT - VERTICAL_OFFSET)) - ((ROW_HEIGHT - VERTICAL_OFFSET) / 2);
              x += NODE_SPACING * 0.5;
              posKey = `${Math.round(x)},${Math.round(y)}`;
              attempts++;
            }
            usedPositions.add(posKey);
          }

          newNodes.push({
            id: word.id,
            type: 'wordNode',
            position: { x, y },
            data: {
              ...word,
              isHighlighted: timelineYear !== null && word.year === timelineYear,
            },
          });
        });
      });
    });

    // Create edges
    const visibleNodeIds = new Set(newNodes.map(n => n.id));
    const newEdges: Edge[] = connections
      .filter(conn => 
        visibleNodeIds.has(conn.sourceId) && 
        visibleNodeIds.has(conn.targetId)
      )
      .map((conn) => ({
        id: conn.id,
        source: conn.sourceId,
        target: conn.targetId,
        type: 'smoothstep',
        animated: timelineYear !== null,
        style: { 
          stroke: conn.type === 'cognate' ? '#9333ea' : '#2563eb',
          strokeWidth: 2,
          opacity: 0.8
        },
        data: { type: conn.type },
        markerEnd: {
          type: 'arrowclosed',
          color: conn.type === 'cognate' ? '#9333ea' : '#2563eb',
        },
      }));

    setNodes(newNodes);
    setEdges(newEdges);
  }, [filteredWords, connections, timelineYear, setNodes, setEdges, initialized, draggedNodePositions]);

  const onNodeClick = useCallback((event: React.MouseEvent, node: Node) => {
    setSelectedWord(node.data);
  }, [setSelectedWord]);

  const onNodeDragStop = useCallback((event: React.MouseEvent, node: Node) => {
    setDraggedNodePositions(prev => ({
      ...prev,
      [node.id]: node.position
    }));
  }, []);

  if (!initialized) {
    return (
      <div className="w-full h-screen flex items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-blue-500 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
          <p className="text-gray-600">Loading etymology map...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="w-full h-screen">
      <SearchBar />
      <TimelineControls
        words={filteredWords}
        currentYear={timelineYear}
        onYearChange={setTimelineYear}
      />
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        onNodeClick={onNodeClick}
        onNodeDragStop={onNodeDragStop}
        nodeTypes={nodeTypes}
        fitView
        minZoom={0.2}
        maxZoom={1.5}
        defaultViewport={{ x: 0, y: 0, zoom: 0.35 }}
        nodesDraggable={true}
        nodesConnectable={false}
        elementsSelectable={true}
        proOptions={{ hideAttribution: true }}
      >
        <Background color="#f1f5f9" gap={32} />
        <Controls />
        <MiniMap 
          nodeColor={(node) => {
            const language = (node.data?.language || '').toLowerCase();
            return language === 'english' ? '#bfdbfe' :
                   language === 'latin' ? '#fecaca' :
                   language === 'greek' ? '#bbf7d0' :
                   language === 'german' ? '#fef3c7' :
                   language === 'french' ? '#e9d5ff' :
                   language === 'japanese' ? '#fce7f3' :
                   language === 'spanish' ? '#ffedd5' :
                   language === 'dutch' ? '#cffafe' :
                   '#e5e7eb';
          }}
          maskColor="#ffffff50"
        />
      </ReactFlow>
    </div>
  );
}