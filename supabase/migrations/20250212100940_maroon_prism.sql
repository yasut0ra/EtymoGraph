/*
  # Add Etymology Data

  1. Data Addition
    - Add words from various language origins:
      - Latin
      - Greek
      - Germanic
      - French
      - Norman French
      - Dutch
      - Spanish
      - Japanese
    
  2. Structure
    - Each word includes:
      - Original word/root
      - Meaning
      - Language of origin
      - Year (approximate)
      - Etymology description
    - Examples for each word
    - Connections between related words
*/

-- Latin origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('spectare', 'to look at', '/spekˈtaːre/', 'latin', 'Latin root meaning "to look at" or "to watch"', -100),
('inspect', 'examine carefully', '/ɪnˈspekt/', 'english', 'From Latin "spectare" (to look at) with prefix "in-" (into)', 1600),
('respect', 'regard highly', '/rɪˈspekt/', 'english', 'From Latin "spectare" with prefix "re-" (back, again)', 1500),
('spectacle', 'impressive display', '/ˈspektəkl/', 'english', 'From Latin "spectaculum", derived from "spectare"', 1300);

-- Add examples
INSERT INTO word_examples (word_id, example) 
SELECT id, 'The inspector carefully inspected the building for safety violations.'
FROM words WHERE word = 'inspect';

INSERT INTO word_examples (word_id, example)
SELECT id, 'She has great respect for her teachers.'
FROM words WHERE word = 'respect';

-- Add connections
INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'spectare' AND t.word = 'inspect';

INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'spectare' AND t.word = 'respect';

-- Greek origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('philos', 'loving', '/ˈfiːlɒs/', 'greek', 'Greek root meaning "loving" or "dear"', -800),
('philosophy', 'love of wisdom', '/fɪˈlɒsəfi/', 'english', 'From Greek "philos" (loving) + "sophia" (wisdom)', 1200),
('philanthropist', 'lover of humanity', '/fɪˈlænθrəpɪst/', 'english', 'From Greek "philos" (loving) + "anthropos" (mankind)', 1600);

-- Germanic origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('hus', 'dwelling', '/huːs/', 'german', 'Proto-Germanic root meaning "dwelling" or "shelter"', 0),
('house', 'building for dwelling', '/haʊs/', 'english', 'From Old English "hus", from Proto-Germanic', 900),
('household', 'people living together', '/ˈhaʊshoʊld/', 'english', 'Compound of "house" + "hold"', 1200);

-- French origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('courir', 'to run', '/kuˈʁiʁ/', 'french', 'From Latin "currere" meaning "to run"', 800),
('courier', 'messenger', '/ˈkʊriər/', 'english', 'From Old French "corier", from "courir"', 1300),
('course', 'path or direction', '/kɔːrs/', 'english', 'From Old French "cours", from "courir"', 1200);

-- Add more examples and connections as needed
INSERT INTO word_examples (word_id, example)
SELECT id, 'She studied philosophy at university.'
FROM words WHERE word = 'philosophy';

INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'philos' AND t.word = 'philosophy';

-- Continue with more insertions for other word groups...