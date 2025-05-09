import React from 'react';
import { Search, Filter, X } from 'lucide-react';
import { useEtymologyStore } from '../store/etymologyStore';

interface FilterOptions {
  language: string;
  yearStart: number;
  yearEnd: number;
}

export default function SearchBar() {
  const [isFilterOpen, setIsFilterOpen] = React.useState(false);
  const [filters, setFilters] = React.useState<FilterOptions>({
    language: 'all',
    yearStart: -2000,
    yearEnd: 2100
  });

  const { words, setFilteredWords } = useEtymologyStore();
  const [searchTerm, setSearchTerm] = React.useState('');

  const applyFilters = (wordList: typeof words, currentFilters: FilterOptions) => {
    let filtered = wordList;
    
    if (currentFilters.language !== 'all') {
      filtered = filtered.filter(word => 
        word.language.toLowerCase() === currentFilters.language.toLowerCase()
      );
    }

    filtered = filtered.filter(word => 
      word.year >= currentFilters.yearStart &&
      word.year <= currentFilters.yearEnd
    );

    setFilteredWords(filtered);
  };

  const handleSearch = (term: string) => {
    setSearchTerm(term);
    if (!term) {
      applyFilters(words, filters);
      return;
    }

    const searchResults = words.filter(word => 
      word.word.toLowerCase().includes(term.toLowerCase()) ||
      word.meaning.toLowerCase().includes(term.toLowerCase()) ||
      word.etymology.toLowerCase().includes(term.toLowerCase())
    );
    applyFilters(searchResults, filters);
  };

  const handleFilterChange = (newFilters: Partial<FilterOptions>) => {
    const updatedFilters = { ...filters, ...newFilters };
    setFilters(updatedFilters);
    applyFilters(words, updatedFilters);
  };

  const clearSearch = () => {
    setSearchTerm('');
    handleSearch('');
  };

  React.useEffect(() => {
    applyFilters(words, filters);
  }, [words]);

  return (
    <div className="absolute top-6 left-6 z-10 w-80">
      <div className="relative backdrop-blur-sm">
        <input
          type="text"
          placeholder="Search words..."
          value={searchTerm}
          onChange={(e) => handleSearch(e.target.value)}
          className="w-full px-4 py-3 pl-10 bg-white/80 rounded-xl shadow-lg 
            focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white
            transition-all duration-300"
        />
        <Search className="absolute left-3 top-3.5 text-gray-400" size={20} />
        {searchTerm && (
          <button
            onClick={clearSearch}
            className="absolute right-12 top-3.5 text-gray-400 hover:text-gray-600"
          >
            <X size={20} />
          </button>
        )}
        <button
          onClick={() => setIsFilterOpen(!isFilterOpen)}
          className={`absolute right-3 top-3.5 text-gray-400 hover:text-gray-600
            transition-colors duration-300
            ${isFilterOpen ? 'text-blue-500' : ''}
          `}
        >
          <Filter size={20} />
        </button>
      </div>

      {isFilterOpen && (
        <div className="mt-2 p-4 bg-white/90 backdrop-blur-sm rounded-xl shadow-lg
          border border-gray-100 space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Language
            </label>
            <select
              value={filters.language}
              onChange={(e) => handleFilterChange({ language: e.target.value })}
              className="w-full rounded-lg border-gray-200 shadow-sm 
                focus:border-blue-500 focus:ring-blue-500
                bg-white/50"
            >
              <option value="all">All Languages</option>
              <option value="latin">Latin</option>
              <option value="english">English</option>
              <option value="greek">Greek</option>
              <option value="german">German</option>
              <option value="french">French</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Time Period
            </label>
            <div className="flex space-x-2">
              <input
                type="number"
                value={filters.yearStart}
                onChange={(e) => handleFilterChange({ yearStart: Number(e.target.value) })}
                className="w-1/2 rounded-lg border-gray-200 shadow-sm 
                  focus:border-blue-500 focus:ring-blue-500
                  bg-white/50"
                placeholder="Start Year"
              />
              <input
                type="number"
                value={filters.yearEnd}
                onChange={(e) => handleFilterChange({ yearEnd: Number(e.target.value) })}
                className="w-1/2 rounded-lg border-gray-200 shadow-sm 
                  focus:border-blue-500 focus:ring-blue-500
                  bg-white/50"
                placeholder="End Year"
              />
            </div>
          </div>
        </div>
      )}
    </div>
  );
}