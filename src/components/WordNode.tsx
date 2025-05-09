import React from 'react';
import { Handle, Position } from 'reactflow';
import { Volume2 } from 'lucide-react';
import { WordNode as WordNodeType } from '../types/etymology';
import { useSpeech } from '../hooks/useSpeech';

interface WordNodeProps {
  data: WordNodeType['data'] & { isHighlighted?: boolean };
}

export default function WordNode({ data }: WordNodeProps) {
  const { speak, isPlaying } = useSpeech();
  
  const languageColors: Record<string, { bg: string; border: string; text: string; shadow: string }> = {
    english: {
      bg: 'bg-gradient-to-br from-blue-50 to-blue-100',
      border: 'border-blue-200',
      text: 'text-blue-900',
      shadow: 'shadow-blue-200/50'
    },
    latin: {
      bg: 'bg-gradient-to-br from-red-50 to-red-100',
      border: 'border-red-200',
      text: 'text-red-900',
      shadow: 'shadow-red-200/50'
    },
    greek: {
      bg: 'bg-gradient-to-br from-green-50 to-green-100',
      border: 'border-green-200',
      text: 'text-green-900',
      shadow: 'shadow-green-200/50'
    },
    german: {
      bg: 'bg-gradient-to-br from-amber-50 to-amber-100',
      border: 'border-amber-200',
      text: 'text-amber-900',
      shadow: 'shadow-amber-200/50'
    },
    french: {
      bg: 'bg-gradient-to-br from-purple-50 to-purple-100',
      border: 'border-purple-200',
      text: 'text-purple-900',
      shadow: 'shadow-purple-200/50'
    },
    japanese: {
      bg: 'bg-gradient-to-br from-pink-50 to-pink-100',
      border: 'border-pink-200',
      text: 'text-pink-900',
      shadow: 'shadow-pink-200/50'
    },
    spanish: {
      bg: 'bg-gradient-to-br from-orange-50 to-orange-100',
      border: 'border-orange-200',
      text: 'text-orange-900',
      shadow: 'shadow-orange-200/50'
    },
    dutch: {
      bg: 'bg-gradient-to-br from-cyan-50 to-cyan-100',
      border: 'border-cyan-200',
      text: 'text-cyan-900',
      shadow: 'shadow-cyan-200/50'
    }
  };

  const colors = languageColors[data.language.toLowerCase()] || {
    bg: 'bg-gradient-to-br from-gray-50 to-gray-100',
    border: 'border-gray-200',
    text: 'text-gray-900',
    shadow: 'shadow-gray-200/50'
  };

  const highlightClass = data.isHighlighted
    ? 'ring-2 ring-offset-2 ring-blue-500 shadow-lg transform scale-110'
    : 'hover:shadow-xl hover:scale-105';

  const handleSpeak = (e: React.MouseEvent) => {
    e.stopPropagation();
    speak(data.word, data.language);
  };

  return (
    <div
      className={`
        min-w-[220px] rounded-xl border ${colors.border} ${colors.bg}
        backdrop-blur-sm backdrop-filter
        transition-all duration-300 ease-in-out
        shadow-lg ${colors.shadow} ${highlightClass}
      `}
    >
      <Handle 
        type="target" 
        position={Position.Top} 
        className="!bg-gray-400/50 !w-3 !h-3 !border-2 !border-white" 
      />
      
      <div className="p-4 space-y-3">
        <div className={`flex justify-between items-center ${colors.text} group`}>
          <span className="text-lg font-bold tracking-tight">{data.word}</span>
          <button
            onClick={handleSpeak}
            className={`p-1.5 rounded-full transition-all duration-300
              ${isPlaying ? 'bg-blue-100 text-blue-600' : 'opacity-50 group-hover:opacity-100 hover:bg-gray-100 text-gray-500 hover:text-gray-700'}
            `}
          >
            <Volume2 size={16} />
          </button>
        </div>
        
        <div className="text-sm text-gray-600 font-mono tracking-tight">
          {data.pronunciation}
        </div>
        
        <div className="flex items-center gap-2">
          <span className={`
            px-2 py-0.5 rounded-full text-xs font-medium
            ${colors.bg} ${colors.text} border ${colors.border}
            shadow-sm
          `}>
            {data.language}
          </span>
          <span className="text-xs text-gray-500 font-medium">
            {data.year < 0 ? `${Math.abs(data.year)} BCE` : `${data.year} CE`}
          </span>
        </div>

        <div className="text-sm text-gray-600 line-clamp-2 leading-relaxed">
          {data.meaning}
        </div>
      </div>

      <Handle 
        type="source" 
        position={Position.Bottom} 
        className="!bg-gray-400/50 !w-3 !h-3 !border-2 !border-white" 
      />
    </div>
  );
}