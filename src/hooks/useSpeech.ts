import { useState, useCallback } from 'react';

export function useSpeech() {
  const [isPlaying, setIsPlaying] = useState(false);

  const speak = useCallback((text: string, language: string = 'en-US') => {
    if (!window.speechSynthesis) {
      console.error('Speech synthesis not supported');
      return;
    }

    // Cancel any ongoing speech
    window.speechSynthesis.cancel();

    const utterance = new SpeechSynthesisUtterance(text);
    
    // Map languages to appropriate voices
    const languageMap: Record<string, string> = {
      english: 'en-US',
      latin: 'it-IT', // Using Italian as closest to Classical Latin
      greek: 'el-GR',
      german: 'de-DE',
      french: 'fr-FR',
      japanese: 'ja-JP',
      spanish: 'es-ES',
      dutch: 'nl-NL'
    };

    utterance.lang = languageMap[language.toLowerCase()] || language;
    
    utterance.onstart = () => setIsPlaying(true);
    utterance.onend = () => setIsPlaying(false);
    utterance.onerror = () => setIsPlaying(false);

    window.speechSynthesis.speak(utterance);
  }, []);

  return { speak, isPlaying };
}