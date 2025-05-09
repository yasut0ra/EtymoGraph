import 'dotenv/config';
import { supabase } from '../src/lib/supabase';
import axios from 'axios';
import * as cheerio from 'cheerio';

interface WiktionaryEntry {
  word: string;
  etymology: string;
  pronunciations: string[];
  definitions: string[];
  language: string;
  year?: number;
}

interface EtymologyData {
  etymology: string;
  year?: number;
}

// Rate limiting helper
const delay = (ms: number) => new Promise(resolve => setTimeout(resolve, ms));

async function fetchWiktionaryData(word: string): Promise<WiktionaryEntry | null> {
  try {
    const response = await axios.get(
      `https://en.wiktionary.org/api/rest_v1/page/definition/${encodeURIComponent(word)}`
    );

    if (!response.data || !response.data.en) {
      return null;
    }

    const etymologyResponse = await axios.get(
      `https://en.wiktionary.org/w/api.php?action=parse&format=json&page=${encodeURIComponent(word)}&prop=wikitext&section=1`
    );

    const entry: WiktionaryEntry = {
      word,
      etymology: '',
      pronunciations: [],
      definitions: [],
      language: 'english'
    };

    // Parse etymology
    if (etymologyResponse.data?.parse?.wikitext['*']) {
      entry.etymology = etymologyResponse.data.parse.wikitext['*']
        .replace(/{{[^}]+}}/g, '')
        .replace(/\[\[[^\]]+\]\]/g, '')
        .replace(/''[^']+''/g, '')
        .trim();
    }

    // Parse definitions and pronunciations
    const enData = response.data.en;
    entry.definitions = enData.map((item: any) => item.definitions[0].definition)
      .filter((def: string) => def && !def.startsWith('{{') && !def.startsWith('[['));
    
    if (enData[0]?.pronunciations?.ipa) {
      entry.pronunciations = enData[0].pronunciations.ipa;
    }

    return entry;
  } catch (error) {
    console.error(`Error fetching Wiktionary data for ${word}:`, error);
    return null;
  }
}

async function fetchEtymOnlineData(word: string): Promise<EtymologyData | null> {
  try {
    const response = await axios.get(
      `https://www.etymonline.com/word/${encodeURIComponent(word)}`
    );
    const $ = cheerio.load(response.data);
    
    const etymologyText = $('.word__defination').text().trim();
    const yearMatch = etymologyText.match(/(\d{3,4}s?)/);
    
    return {
      etymology: etymologyText,
      year: yearMatch ? parseInt(yearMatch[1]) : undefined
    };
  } catch (error) {
    console.error(`Error fetching EtymOnline data for ${word}:`, error);
    return null;
  }
}

async function importWordData(word: WiktionaryEntry, etymOnlineData?: EtymologyData) {
  try {
    const { data: existingWord } = await supabase
      .from('words')
      .select('id')
      .eq('word', word.word)
      .single();

    if (existingWord) {
      console.log(`Word ${word.word} already exists, skipping...`);
      return;
    }

    const { data: newWord, error } = await supabase
      .from('words')
      .insert([{
        word: word.word,
        meaning: word.definitions[0] || '',
        pronunciation: word.pronunciations[0] || '',
        language: word.language,
        etymology: etymOnlineData?.etymology || word.etymology || '',
        year: etymOnlineData?.year || 1800
      }])
      .select()
      .single();

    if (error) throw error;
    console.log(`Imported word: ${word.word}`);
    return newWord;
  } catch (error) {
    console.error(`Error importing word ${word.word}:`, error);
  }
}

// Common English words with etymological interest
const wordList = [
  // Latin-derived words
  'education', 'science', 'medicine', 'literature', 'culture',
  'nature', 'animal', 'human', 'social', 'civil',
  'legal', 'moral', 'mental', 'physical', 'natural',
  
  // Greek-derived words
  'philosophy', 'democracy', 'technology', 'system', 'method',
  'theory', 'analysis', 'synthesis', 'hypothesis', 'thesis',
  'phenomenon', 'psychology', 'biology', 'physics', 'mathematics',
  
  // Germanic-derived words
  'world', 'life', 'death', 'love', 'hate',
  'good', 'evil', 'right', 'wrong', 'truth',
  'friend', 'king', 'queen', 'knight', 'sword',
  
  // French-derived words
  'art', 'beauty', 'fashion', 'style', 'design',
  'dance', 'music', 'poetry', 'romance', 'pleasure',
  'court', 'judge', 'royal', 'noble', 'prince'
];

async function importEtymologyData() {
  console.log('Starting etymology data import...');
  
  for (const word of wordList) {
    console.log(`Processing word: ${word}`);
    
    // Rate limiting
    await delay(1000);
    
    // Fetch data from both sources
    const [wiktionaryData, etymOnlineData] = await Promise.all([
      fetchWiktionaryData(word),
      fetchEtymOnlineData(word)
    ]);
    
    if (wiktionaryData) {
      await importWordData(wiktionaryData, etymOnlineData || undefined);
    }
    
    // Additional delay between words
    await delay(2000);
  }
  
  console.log('Etymology data import completed!');
}

// Run the import if this is the main module
if (import.meta.url === new URL(import.meta.url).href) {
  importEtymologyData()
    .catch(console.error)
    .finally(() => process.exit());
}

export { importEtymologyData };