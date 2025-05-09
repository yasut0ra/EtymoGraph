import { create } from 'zustand';
import { Word, Connection } from '../types/etymology';
import { fetchWords, fetchConnections } from '../services/wordService';

interface EtymologyState {
  words: Word[];
  filteredWords: Word[];
  connections: Connection[];
  selectedWord: Word | null;
  loading: boolean;
  error: string | null;
  setWords: (words: Word[]) => void;
  setFilteredWords: (words: Word[]) => void;
  setConnections: (connections: Connection[]) => void;
  setSelectedWord: (word: Word | null) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  fetchData: () => Promise<void>;
}

export const useEtymologyStore = create<EtymologyState>((set, get) => ({
  words: [],
  filteredWords: [],
  connections: [],
  selectedWord: null,
  loading: false,
  error: null,
  setWords: (words) => set({ words, filteredWords: words }),
  setFilteredWords: (filteredWords) => set({ filteredWords }),
  setConnections: (connections) => set({ connections }),
  setSelectedWord: (word) => set({ selectedWord: word }),
  setLoading: (loading) => set({ loading }),
  setError: (error) => set({ error }),
  fetchData: async () => {
    const { setLoading, setError, setWords, setConnections } = get();
    setLoading(true);
    try {
      const [words, connections] = await Promise.all([
        fetchWords(),
        fetchConnections()
      ]);
      setWords(words);
      setConnections(connections);
      setError(null);
    } catch (error) {
      setError(error instanceof Error ? error.message : 'Failed to fetch data');
    } finally {
      setLoading(false);
    }
  }
}));