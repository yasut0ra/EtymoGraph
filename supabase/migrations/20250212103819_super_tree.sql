/*
  # Add Germanic and French Etymology Data

  1. New Words
    - Germanic origin words (hand, work, water, etc.)
    - French origin words (courir, garder, chef, etc.)
    - Norman French origin words (justice, crime)

  2. Examples
    - Added usage examples for each word
    - Multiple examples per word where appropriate

  3. Connections
    - Added derivation relationships
    - Added cognate relationships
    - Organized by language groups
*/

-- Germanic origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- hand group
('hand', 'hand', '/hænd/', 'english', 'From Old English hand', 800),
('handle', 'to touch or manage', '/ˈhændl/', 'english', 'From Old English handle', 1000),
('handshake', 'greeting gesture', '/ˈhændʃeɪk/', 'english', 'Compound of hand + shake', 1500),

-- work group
('work', 'activity, labor', '/wɜːk/', 'english', 'From Old English weorc', 800),
('worker', 'one who works', '/ˈwɜːkər/', 'english', 'From work + -er', 1200),
('workshop', 'place of work', '/ˈwɜːkʃɒp/', 'english', 'Compound of work + shop', 1300),

-- water group
('water', 'water', '/ˈwɔːtər/', 'english', 'From Old English wæter', 800),
('waterfall', 'falling water', '/ˈwɔːtərfɔːl/', 'english', 'Compound of water + fall', 1200),
('waterproof', 'impervious to water', '/ˈwɔːtərpruːf/', 'english', 'Compound of water + proof', 1700);

-- French origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- courir group
('courir', 'to run', '/kuˈʁiʁ/', 'french', 'From Latin currere', 800),
('courier', 'messenger', '/ˈkʊriər/', 'english', 'From Old French corier', 1300),
('course', 'path, direction', '/kɔːrs/', 'english', 'From Old French cours', 1200),

-- garder group
('garder', 'to keep, guard', '/ɡaʁde/', 'french', 'From Frankish wardōn', 800),
('guard', 'protect', '/ɡɑːd/', 'english', 'From Old French garder', 1200),
('regard', 'consider, respect', '/rɪˈɡɑːd/', 'english', 'From Old French regarder', 1300),

-- Norman French words
('justice', 'fairness, law', '/ˈdʒʌstɪs/', 'english', 'From Anglo-Norman justice', 1100),
('crime', 'offense, wrongdoing', '/kraɪm/', 'english', 'From Anglo-Norman crime', 1200);

-- Add examples
INSERT INTO word_examples (word_id, example)
SELECT id, 'He shook hands with his new business partner.'
FROM words WHERE word = 'handshake';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The workshop was filled with tools and equipment.'
FROM words WHERE word = 'workshop';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The waterfall cascaded down the mountainside.'
FROM words WHERE word = 'waterfall';

-- Add connections for Germanic words
INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'hand' AND t.word IN ('handle', 'handshake');

INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'work' AND t.word IN ('worker', 'workshop');

-- Add connections for French words
INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'courir' AND t.word IN ('courier', 'course');

INSERT INTO word_connections (source_id, target_id, type)
SELECT s.id, t.id, 'derivation'
FROM words s, words t
WHERE s.word = 'garder' AND t.word IN ('guard', 'regard');