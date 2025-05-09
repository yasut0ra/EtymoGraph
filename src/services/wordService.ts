import { supabase } from '../lib/supabase';
import { Word, Connection } from '../types/etymology';

export async function fetchWords(): Promise<Word[]> {
  const { data: words, error: wordsError } = await supabase
    .from('words')
    .select('*')
    .order('year', { ascending: true });

  if (wordsError) throw wordsError;

  const { data: examples, error: examplesError } = await supabase
    .from('word_examples')
    .select('*');

  if (examplesError) throw examplesError;

  return words.map(word => ({
    ...word,
    examples: examples
      .filter(ex => ex.word_id === word.id)
      .map(ex => ex.example)
  }));
}

export async function fetchConnections(): Promise<Connection[]> {
  const { data, error } = await supabase
    .from('word_connections')
    .select('*');

  if (error) throw error;

  return data.map(conn => ({
    id: conn.id,
    sourceId: conn.source_id,
    targetId: conn.target_id,
    type: conn.type as Connection['type']
  }));
}

export async function searchWords(query: string): Promise<Word[]> {
  const { data, error } = await supabase
    .from('words')
    .select('*')
    .or(`word.ilike.%${query}%,meaning.ilike.%${query}%,etymology.ilike.%${query}%`)
    .order('year', { ascending: true });

  if (error) throw error;

  return data;
}