import React from 'react';
import { useEtymologyStore } from '../store/etymologyStore';
import { Volume2, X, Play, Clock, BookOpen, Link } from 'lucide-react';
import { useSpeech } from '../hooks/useSpeech';

export default function WordDetails() {
  const { selectedWord, setSelectedWord, words, connections } = useEtymologyStore();
  const [isPlaying, setIsPlaying] = React.useState(false);
  const { speak, isPlaying: isSpeaking } = useSpeech();

  if (!selectedWord) return null;

  // Find related words (both source and target connections)
  const relatedWords = connections
    .filter(conn => conn.sourceId === selectedWord.id || conn.targetId === selectedWord.id)
    .map(conn => {
      const relatedWordId = conn.sourceId === selectedWord.id ? conn.targetId : conn.sourceId;
      const word = words.find(w => w.id === relatedWordId);
      return {
        word,
        type: conn.type,
        isSource: conn.sourceId === selectedWord.id
      };
    })
    .filter(item => item.word) as { word: typeof selectedWord; type: string; isSource: boolean }[];

  // Find the evolution chain
  const getEvolutionChain = () => {
    const chain = [selectedWord];
    let currentWord = selectedWord;
    
    // Look forward in time
    while (true) {
      const nextConnection = connections.find(conn => 
        conn.sourceId === currentWord.id && 
        conn.type === 'derivation'
      );
      if (!nextConnection) break;
      
      const nextWord = words.find(w => w.id === nextConnection.targetId);
      if (!nextWord || chain.includes(nextWord)) break;
      
      chain.push(nextWord);
      currentWord = nextWord;
    }
    
    // Look backward in time
    currentWord = selectedWord;
    while (true) {
      const prevConnection = connections.find(conn => 
        conn.targetId === currentWord.id && 
        conn.type === 'derivation'
      );
      if (!prevConnection) break;
      
      const prevWord = words.find(w => w.id === prevConnection.sourceId);
      if (!prevWord || chain.includes(prevWord)) break;
      
      chain.unshift(prevWord);
      currentWord = prevWord;
    }
    
    return chain;
  };

  const evolutionChain = getEvolutionChain();

  const handlePlayEvolution = () => {
    setIsPlaying(true);
    // Play each word in the evolution chain with a delay
    evolutionChain.forEach((word, index) => {
      setTimeout(() => {
        speak(word.word, word.language);
        if (index === evolutionChain.length - 1) {
          setIsPlaying(false);
        }
      }, index * 2000); // 2 seconds delay between words
    });
  };

  const handleSpeak = () => {
    speak(selectedWord.word, selectedWord.language);
  };

  return (
    <div className="fixed right-4 top-4 w-96 bg-white rounded-lg shadow-lg p-6 max-h-[90vh] overflow-y-auto">
      <div className="flex justify-between items-center mb-6">
        <h2 className="text-2xl font-bold">{selectedWord.word}</h2>
        <button
          onClick={() => setSelectedWord(null)}
          className="text-gray-500 hover:text-gray-700"
        >
          <X size={20} />
        </button>
      </div>

      <div className="space-y-6">
        {/* Pronunciation and Audio */}
        <div className="flex items-center space-x-3 bg-gray-50 p-3 rounded-lg">
          <span className="text-gray-600 font-mono">{selectedWord.pronunciation}</span>
          <button 
            onClick={handleSpeak}
            className={`text-blue-500 hover:text-blue-700 p-2 hover:bg-blue-50 rounded-full transition-colors
              ${isSpeaking ? 'bg-blue-50' : ''}
            `}
          >
            <Volume2 size={18} />
          </button>
        </div>

        {/* Evolution Timeline */}
        {evolutionChain.length > 1 && (
          <div className="border-t pt-4">
            <div className="flex items-center justify-between mb-3">
              <h3 className="font-semibold text-gray-700 flex items-center gap-2">
                <Clock size={18} />
                Evolution Timeline
              </h3>
              <button
                onClick={handlePlayEvolution}
                disabled={isPlaying}
                className="text-blue-500 hover:text-blue-700 disabled:opacity-50"
              >
                <Play size={18} />
              </button>
            </div>
            <div className="space-y-2">
              {evolutionChain.map((word, index) => (
                <div
                  key={word.id}
                  className="flex items-center gap-2"
                >
                  <div className="w-16 text-sm text-gray-500">
                    {word.year}
                  </div>
                  <div className="flex-1 p-2 bg-gray-50 rounded-lg">
                    <div className="font-medium">{word.word}</div>
                    <div className="text-sm text-gray-500">{word.language}</div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Meaning and Etymology */}
        <div>
          <h3 className="font-semibold text-gray-700 flex items-center gap-2 mb-2">
            <BookOpen size={18} />
            Meaning & Etymology
          </h3>
          <div className="space-y-3">
            <p className="text-gray-600">{selectedWord.meaning}</p>
            <p className="text-gray-600 text-sm">{selectedWord.etymology}</p>
          </div>
        </div>

        {/* Related Words */}
        {relatedWords.length > 0 && (
          <div className="border-t pt-4">
            <h3 className="font-semibold text-gray-700 flex items-center gap-2 mb-3">
              <Link size={18} />
              Related Words
            </h3>
            <div className="grid grid-cols-1 gap-2">
              {relatedWords.map(({ word, type, isSource }) => (
                <button
                  key={word.id}
                  onClick={() => setSelectedWord(word)}
                  className="text-left p-3 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors"
                >
                  <div className="font-medium">{word.word}</div>
                  <div className="text-sm text-gray-500">
                    {type === 'cognate' ? 'Cognate' : isSource ? 'Derived from this word' : 'Derives from this word'}
                  </div>
                </button>
              ))}
            </div>
          </div>
        )}

        {/* Examples */}
        <div className="border-t pt-4">
          <h3 className="font-semibold text-gray-700 mb-2">Examples</h3>
          <ul className="list-disc list-inside text-gray-600 space-y-2">
            {selectedWord.examples.map((example, index) => (
              <li key={index} className="leading-relaxed">{example}</li>
            ))}
          </ul>
        </div>
      </div>
    </div>
  );
}