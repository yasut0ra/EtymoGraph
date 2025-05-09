/*
  # Add more etymology words

  1. New Words
    - Add Latin origin words (amare, animus, caput, etc.)
    - Add Greek origin words (anthropos, arkhos, autos, etc.)
    - Add Germanic origin words (bindan, brycg, cunnan, etc.)
    - Add French origin words (accorder, bataille, chambre, etc.)
    - Add Norman French origin words (justice, parlement, royal, etc.)

  2. Examples
    - Add example sentences for each word
    - Examples demonstrate word usage in context

  3. Connections
    - Create derivation connections between root words and derived words
    - Link related words within same language groups
*/

-- Latin origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('amare', 'to love', '/aˈmaːre/', 'latin', 'Latin root meaning "to love"', -100),
('animus', 'soul, mind', '/ˈanimus/', 'latin', 'Latin word for soul or mind', -100),
('caput', 'head', '/ˈkaput/', 'latin', 'Latin word for head', -100),
('civis', 'citizen', '/ˈkiːwis/', 'latin', 'Latin word for citizen', -100),
('corpus', 'body', '/ˈkorpus/', 'latin', 'Latin word for body', -100),
('ducere', 'to lead', '/ˈduːkere/', 'latin', 'Latin root meaning "to lead"', -100),
('facere', 'to make', '/ˈfakere/', 'latin', 'Latin root meaning "to make"', -100),
('ferre', 'to carry', '/ˈferre/', 'latin', 'Latin root meaning "to carry"', -100),
('fluere', 'to flow', '/ˈfluere/', 'latin', 'Latin root meaning "to flow"', -100),
('gradi', 'to step', '/ˈɡraːdiː/', 'latin', 'Latin root meaning "to step"', -100),
('legere', 'to read', '/ˈleɡere/', 'latin', 'Latin root meaning "to read"', -100),
('loqui', 'to speak', '/ˈlokwiː/', 'latin', 'Latin root meaning "to speak"', -100),
('manus', 'hand', '/ˈmanus/', 'latin', 'Latin word for hand', -100),
('mater', 'mother', '/ˈmaːter/', 'latin', 'Latin word for mother', -100),
('mors', 'death', '/mors/', 'latin', 'Latin word for death', -100),
('nomen', 'name', '/ˈnoːmen/', 'latin', 'Latin word for name', -100),
('omnis', 'all', '/ˈomnis/', 'latin', 'Latin word meaning "all"', -100),
('sentire', 'to feel', '/senˈtiːre/', 'latin', 'Latin root meaning "to feel"', -100),
('tangere', 'to touch', '/ˈtanɡere/', 'latin', 'Latin root meaning "to touch"', -100),
('vocare', 'to call', '/woˈkaːre/', 'latin', 'Latin root meaning "to call"', -100);

-- Greek origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('anthropos', 'human', '/ænˈθrɒpɒs/', 'greek', 'Greek word for human', -800),
('arkhos', 'ruler', '/ˈɑːrkɒs/', 'greek', 'Greek word for ruler', -800),
('autos', 'self', '/ˈaʊtɒs/', 'greek', 'Greek word for self', -800),
('bios', 'life', '/ˈbaɪɒs/', 'greek', 'Greek word for life', -800),
('metron', 'measure', '/ˈmetrɒn/', 'greek', 'Greek word for measure', -800),
('mikros', 'small', '/ˈmaɪkrɒs/', 'greek', 'Greek word for small', -800),
('neuron', 'nerve', '/ˈnjʊərɒn/', 'greek', 'Greek word for nerve', -800),
('orthos', 'straight, correct', '/ˈɔːθɒs/', 'greek', 'Greek word meaning "straight" or "correct"', -800),
('polis', 'city', '/ˈpɒlɪs/', 'greek', 'Greek word for city', -800),
('psyche', 'soul, mind', '/ˈsaɪki/', 'greek', 'Greek word for soul or mind', -800),
('skopos', 'watcher', '/ˈskɒpɒs/', 'greek', 'Greek word for watcher', -800),
('techne', 'art, skill', '/ˈtekni/', 'greek', 'Greek word for art or skill', -800),
('theos', 'god', '/ˈθiːɒs/', 'greek', 'Greek word for god', -800);

-- Germanic origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('bindan', 'to bind', '/ˈbɪndən/', 'german', 'Proto-Germanic root meaning "to bind"', 0),
('brycg', 'bridge', '/brʏtʃ/', 'german', 'Proto-Germanic word for bridge', 0),
('cunnan', 'to know', '/ˈkʊnən/', 'german', 'Proto-Germanic root meaning "to know"', 0),
('dæg', 'day', '/dæɡ/', 'german', 'Proto-Germanic word for day', 0),
('faran', 'to travel', '/ˈfɑrən/', 'german', 'Proto-Germanic root meaning "to travel"', 0),
('gieldan', 'to yield', '/ˈɡiːldən/', 'german', 'Proto-Germanic root meaning "to yield"', 0),
('hlud', 'loud', '/hluːd/', 'german', 'Proto-Germanic word meaning "loud"', 0),
('leod', 'people', '/leːod/', 'german', 'Proto-Germanic word for people', 0),
('motan', 'must', '/ˈmoːtən/', 'german', 'Proto-Germanic root meaning "must"', 0),
('scean', 'to shine', '/ʃeːan/', 'german', 'Proto-Germanic root meaning "to shine"', 0),
('standan', 'to stand', '/ˈstandən/', 'german', 'Proto-Germanic root meaning "to stand"', 0),
('weorthan', 'to become', '/ˈweːorθan/', 'german', 'Proto-Germanic root meaning "to become"', 0);

-- French origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('accorder', 'to grant', '/akɔʁde/', 'french', 'Old French word meaning "to grant"', 800),
('bataille', 'battle', '/bataj/', 'french', 'Old French word for battle', 800),
('chambre', 'room', '/ʃɑ̃bʁ/', 'french', 'Old French word for room', 800),
('décider', 'to decide', '/deside/', 'french', 'Old French word meaning "to decide"', 800),
('légal', 'legal', '/leɡal/', 'french', 'Old French word meaning "legal"', 800),
('pouvoir', 'power', '/puvwaʁ/', 'french', 'Old French word meaning "power"', 800);

-- Norman French origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
('parlement', 'discussion', '/paʁləmɑ̃/', 'french', 'Norman French word for discussion', 1000),
('royal', 'royal', '/ʁwajal/', 'french', 'Norman French word meaning "royal"', 1000);

-- Add examples
INSERT INTO word_examples (word_id, example)
SELECT id, 'The word "amiable" comes from the Latin root "amare".'
FROM words WHERE word = 'amare';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The study of anthropology examines human cultures and societies.'
FROM words WHERE word = 'anthropos';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The ancient binding spell was written in runes.'
FROM words WHERE word = 'bindan';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The accord was signed by both parties.'
FROM words WHERE word = 'accorder';

-- Add connections (examples)
INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'anthropos' AND t.word = 'anthropology';

INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'polis' AND t.word = 'metropolis';

INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'mater' AND t.word = 'maternal';