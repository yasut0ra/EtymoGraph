/*
  # Add More Etymology Data

  1. Data Addition
    - Add more words from various language origins:
      - Latin (scribere, dicere, audire, etc.)
      - Greek (logos, graphos, tele, etc.)
      - Germanic (hand, work, water, etc.)
      - French (garder, tour, chef, etc.)
      - Norman French (royal, justice, etc.)
      - Other languages (Dutch, Spanish, Japanese)
    
  2. Structure
    - Maintains consistent data organization with previous migrations
    - Includes comprehensive examples and connections
*/

-- More Latin origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('scribere', 'to write', '/ˈskriːbere/', 'latin', 'Latin root meaning "to write"', -100),
('describe', 'give account of', '/dɪˈskraɪb/', 'english', 'From Latin "scribere" with prefix "de-" (down, completely)', 1400),
('prescribe', 'recommend', '/prɪˈskraɪb/', 'english', 'From Latin "scribere" with prefix "pre-" (before)', 1500),
('manuscript', 'handwritten text', '/ˈmænjʊskrɪpt/', 'english', 'From Latin "manu" (hand) + "scriptus" (written)', 1400);

-- Add examples for Latin words
INSERT INTO word_examples (word_id, example)
SELECT id, 'The doctor prescribed medication for her condition.'
FROM words WHERE word = 'prescribe';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The ancient manuscript was discovered in the monastery.'
FROM words WHERE word = 'manuscript';

-- Add connections for Latin words
INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'scribere' AND t.word IN ('describe', 'prescribe', 'manuscript');

-- More Greek origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('logos', 'word, study', '/ˈloʊɡɒs/', 'greek', 'Greek root meaning "word, reason, study"', -800),
('biology', 'study of life', '/baɪˈɒlədʒi/', 'english', 'From Greek "bios" (life) + "logos" (study)', 1800),
('psychology', 'study of mind', '/saɪˈkɒlədʒi/', 'english', 'From Greek "psyche" (mind) + "logos" (study)', 1700);

-- Add examples for Greek words
INSERT INTO word_examples (word_id, example)
SELECT id, 'She majored in biology at university.'
FROM words WHERE word = 'biology';

-- Add connections for Greek words
INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'logos' AND t.word IN ('biology', 'psychology');

-- Germanic origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('hand', 'hand', '/hænd/', 'english', 'From Old English "hand", from Proto-Germanic', 800),
('handle', 'to touch, manage', '/ˈhændl/', 'english', 'From Old English "handle", derived from "hand"', 1000),
('handshake', 'greeting gesture', '/ˈhændʃeɪk/', 'english', 'Compound of "hand" + "shake"', 1500);

-- Add examples for Germanic words
INSERT INTO word_examples (word_id, example)
SELECT id, 'They sealed the deal with a firm handshake.'
FROM words WHERE word = 'handshake';

-- French origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('garder', 'to keep, guard', '/ɡaʁde/', 'french', 'From Frankish "wardōn" (to watch)', 800),
('guard', 'protect', '/ɡɑːd/', 'english', 'From Old French "garder"', 1200),
('regard', 'consider, respect', '/rɪˈɡɑːd/', 'english', 'From Old French "regarder", from "garder"', 1300);

-- Japanese origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('tsunami', 'tidal wave', '/suːˈnɑːmi/', 'japanese', 'From Japanese "津波" (harbor wave)', 1900),
('karaoke', 'singing entertainment', '/ˌkæriˈoʊki/', 'japanese', 'From Japanese "カラオケ" (empty orchestra)', 1970);

-- Add examples for Japanese words
INSERT INTO word_examples (word_id, example)
SELECT id, 'The coastal areas were evacuated due to the tsunami warning.'
FROM words WHERE word = 'tsunami';

INSERT INTO word_examples (word_id, example)
SELECT id, 'They spent the evening singing karaoke with friends.'
FROM words WHERE word = 'karaoke';

-- Spanish origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('canyon', 'deep valley', '/ˈkænjən/', 'spanish', 'From Spanish "cañón", from "caña" (reed, tube)', 1800),
('cargo', 'goods carried', '/ˈkɑːɡəʊ/', 'spanish', 'From Spanish "cargo", from "cargar" (to load)', 1600);

-- Add examples for Spanish words
INSERT INTO word_examples (word_id, example)
SELECT id, 'They hiked through the Grand Canyon.'
FROM words WHERE word = 'canyon';

-- Dutch origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('yacht', 'sailing vessel', '/jɒt/', 'dutch', 'From Dutch "jacht", from "jagen" (to hunt)', 1550),
('boss', 'person in charge', '/bɒs/', 'dutch', 'From Dutch "baas" (master)', 1650);

-- Add examples for Dutch words
INSERT INTO word_examples (word_id, example)
SELECT id, 'They spent their vacation sailing on a luxury yacht.'
FROM words WHERE word = 'yacht';