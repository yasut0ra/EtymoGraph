import React from 'react';
import { Play, Pause, SkipBack, SkipForward, Clock } from 'lucide-react';
import { Word } from '../types/etymology';

interface TimelineControlsProps {
  words: Word[];
  currentYear: number | null;
  onYearChange: (year: number | null) => void;
}

export default function TimelineControls({
  words,
  currentYear,
  onYearChange,
}: TimelineControlsProps) {
  const [isPlaying, setIsPlaying] = React.useState(false);
  const [playbackSpeed, setPlaybackSpeed] = React.useState(1000);

  const years = React.useMemo(() => {
    const allYears = words.map(w => w.year);
    return [...new Set(allYears)].sort((a, b) => a - b);
  }, [words]);

  const currentYearIndex = React.useMemo(() => {
    if (currentYear === null) return -1;
    return years.indexOf(currentYear);
  }, [currentYear, years]);

  React.useEffect(() => {
    if (!isPlaying) return;

    const interval = setInterval(() => {
      if (currentYearIndex === years.length - 1) {
        setIsPlaying(false);
        return;
      }
      onYearChange(years[currentYearIndex + 1]);
    }, playbackSpeed);

    return () => clearInterval(interval);
  }, [isPlaying, currentYearIndex, years, onYearChange, playbackSpeed]);

  const handlePlayPause = () => {
    if (!isPlaying && currentYear === null) {
      onYearChange(years[0]);
    }
    setIsPlaying(!isPlaying);
  };

  const handleSkipForward = () => {
    if (currentYearIndex < years.length - 1) {
      onYearChange(years[currentYearIndex + 1]);
    }
  };

  const handleSkipBack = () => {
    if (currentYearIndex > 0) {
      onYearChange(years[currentYearIndex - 1]);
    }
  };

  const handleReset = () => {
    setIsPlaying(false);
    onYearChange(null);
  };

  if (years.length < 2) return null;

  return (
    <div className="absolute bottom-8 left-1/2 transform -translate-x-1/2 z-10">
      <div className="bg-white/90 backdrop-blur-sm rounded-xl shadow-lg p-6 space-y-4
        border border-gray-100">
        <div className="flex items-center justify-center space-x-6">
          <button
            onClick={handleSkipBack}
            disabled={currentYearIndex <= 0}
            className="p-2 text-gray-600 hover:text-gray-900 disabled:opacity-50
              hover:bg-gray-100 rounded-lg transition-colors"
          >
            <SkipBack size={20} />
          </button>
          <button
            onClick={handlePlayPause}
            className="p-3 text-blue-600 hover:text-blue-800
              hover:bg-blue-50 rounded-lg transition-colors"
          >
            {isPlaying ? <Pause size={24} /> : <Play size={24} />}
          </button>
          <button
            onClick={handleSkipForward}
            disabled={currentYearIndex === years.length - 1}
            className="p-2 text-gray-600 hover:text-gray-900 disabled:opacity-50
              hover:bg-gray-100 rounded-lg transition-colors"
          >
            <SkipForward size={20} />
          </button>
        </div>
        
        <div className="flex items-center space-x-4">
          <Clock size={16} className="text-gray-400" />
          <input
            type="range"
            min="0"
            max={years.length - 1}
            value={currentYearIndex === -1 ? 0 : currentYearIndex}
            onChange={(e) => onYearChange(years[Number(e.target.value)])}
            className="w-64 accent-blue-500"
          />
          <span className="text-sm font-medium text-gray-600 min-w-[80px]">
            {currentYear ?? years[0]}
          </span>
        </div>

        <div className="flex justify-between items-center">
          <select
            value={playbackSpeed}
            onChange={(e) => setPlaybackSpeed(Number(e.target.value))}
            className="text-sm border rounded-lg px-2 py-1 bg-white/50
              focus:outline-none focus:ring-2 focus:ring-blue-500"
          >
            <option value={2000}>Slow</option>
            <option value={1000}>Normal</option>
            <option value={500}>Fast</option>
          </select>
          <button
            onClick={handleReset}
            className="text-sm text-gray-600 hover:text-gray-900
              px-3 py-1 rounded-lg hover:bg-gray-100 transition-colors"
          >
            Reset
          </button>
        </div>
      </div>
    </div>
  );
}