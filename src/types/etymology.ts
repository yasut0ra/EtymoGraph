export interface Word {
  id: string;
  word: string;
  meaning: string;
  pronunciation: string;
  language: string;
  etymology: string;
  examples: string[];
  year: number;
}

export interface Connection {
  id: string;
  sourceId: string;
  targetId: string;
  type: 'derivation' | 'cognate' | 'compound';
}

export interface WordNode {
  id: string;
  type: 'wordNode';
  position: { x: number; y: number };
  data: Word;
}

export interface WordEdge {
  id: string;
  source: string;
  target: string;
  type: 'smoothstep';
  data: {
    type: Connection['type'];
  };
}