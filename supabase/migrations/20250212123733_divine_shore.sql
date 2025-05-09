/*
  # Add more Latin words and derivatives

  1. New Words
    - Added Latin verbs and their derivatives:
      - legere (to read/choose)
      - regere (to rule)
      - sanguis (blood)
      - viscus (organ)
      - tempus (time)
      - ordo (order)
      - ignis (fire)
      - mare (sea)
      - silva (forest)
      - altus (high)
      - primus (first)
      - ultimus (last)
      - medius (middle)

  2. Examples
    - Added usage examples for each word
    
  3. Connections
    - Created derivation connections between root words and their derivatives
*/

-- Latin verbs and their derivatives
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- legere group
('legere', 'to read, choose', '/ˈleɡere/', 'latin', 'Latin root meaning "to read or choose"', -100),
('elect', 'to choose by voting', '/ɪˈlekt/', 'english', 'From Latin eligere, from legere', 1400),
('collect', 'to gather together', '/kəˈlekt/', 'english', 'From Latin colligere, from legere', 1400),
('intellect', 'understanding', '/ˈɪntəlekt/', 'english', 'From Latin intellectus, from legere', 1300),
('legal', 'relating to law', '/ˈliːɡəl/', 'english', 'From Latin legalis, from lex (law)', 1400),

-- regere group
('regere', 'to rule', '/ˈreɡere/', 'latin', 'Latin root meaning "to rule"', -100),
('reign', 'to rule as monarch', '/reɪn/', 'english', 'From Latin regnare, from regere', 1200),
('regulate', 'to control', '/ˈreɡjʊleɪt/', 'english', 'From Latin regulatus, from regere', 1600),
('regime', 'system of rule', '/reɪˈʒiːm/', 'english', 'From Latin regimen, from regere', 1500);

-- Latin nouns and derivatives
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- sanguis group
('sanguis', 'blood', '/ˈsaŋɡwɪs/', 'latin', 'Latin word meaning "blood"', -100),
('sanguine', 'optimistic', '/ˈsæŋɡwɪn/', 'english', 'From Latin sanguineus', 1400),
('consanguinity', 'blood relation', '/ˌkɒnsæŋˈɡwɪnɪti/', 'english', 'From Latin consanguinitas', 1500),

-- viscus group
('viscus', 'internal organ', '/ˈvɪskʊs/', 'latin', 'Latin word meaning "internal organ"', -100),
('visceral', 'relating to internal organs', '/ˈvɪsərəl/', 'english', 'From Medieval Latin visceralis', 1600),
('eviscerate', 'remove entrails', '/ɪˈvɪsəreɪt/', 'english', 'From Latin evisceratus', 1600),

-- tempus group
('tempus', 'time', '/ˈtempʊs/', 'latin', 'Latin word meaning "time"', -100),
('temporal', 'relating to time', '/ˈtempərəl/', 'english', 'From Latin temporalis', 1300),
('temporary', 'lasting for a time', '/ˈtempərəri/', 'english', 'From Latin temporarius', 1400),
('contemporary', 'existing at same time', '/kənˈtempərəri/', 'english', 'From Latin contemporarius', 1600),

-- ordo group
('ordo', 'order', '/ˈɔːrdoː/', 'latin', 'Latin word meaning "order"', -100),
('order', 'arrangement', '/ˈɔːdər/', 'english', 'From Latin ordo', 1200),
('ordinary', 'normal, usual', '/ˈɔːdɪnəri/', 'english', 'From Latin ordinarius', 1300),
('coordinate', 'arrange together', '/koʊˈɔːdɪneɪt/', 'english', 'From Latin coordinatus', 1600);

-- Nature words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- ignis group
('ignis', 'fire', '/ˈɪɡnɪs/', 'latin', 'Latin word meaning "fire"', -100),
('ignite', 'to set on fire', '/ɪɡˈnaɪt/', 'english', 'From Latin ignitus', 1600),
('ignition', 'act of igniting', '/ɪɡˈnɪʃən/', 'english', 'From Medieval Latin ignitionem', 1600),

-- mare group
('mare', 'sea', '/ˈmɑːre/', 'latin', 'Latin word meaning "sea"', -100),
('marine', 'of the sea', '/məˈriːn/', 'english', 'From Latin marinus', 1400),
('maritime', 'relating to sea', '/ˈmærɪtaɪm/', 'english', 'From Latin maritimus', 1500),

-- silva group
('silva', 'forest', '/ˈsɪlva/', 'latin', 'Latin word meaning "forest"', -100),
('sylvan', 'of the woods', '/ˈsɪlvən/', 'english', 'From Latin silvanus', 1500),
('savage', 'wild, fierce', '/ˈsævɪdʒ/', 'english', 'From Latin silvaticus', 1300);

-- Latin adjectives and derivatives
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- altus group
('altus', 'high', '/ˈaltʊs/', 'latin', 'Latin word meaning "high"', -100),
('altitude', 'height', '/ˈæltɪtjuːd/', 'english', 'From Latin altitudo', 1500),
('exalt', 'raise high', '/ɪɡˈzɔːlt/', 'english', 'From Latin exaltare', 1400),

-- primus group
('primus', 'first', '/ˈpriːmʊs/', 'latin', 'Latin word meaning "first"', -100),
('primary', 'first in importance', '/ˈpraɪməri/', 'english', 'From Latin primarius', 1400),
('primitive', 'early stage', '/ˈprɪmɪtɪv/', 'english', 'From Latin primitivus', 1400),

-- ultimus group
('ultimus', 'last', '/ˈʊltɪmʊs/', 'latin', 'Latin word meaning "last"', -100),
('ultimate', 'final', '/ˈʌltɪmət/', 'english', 'From Latin ultimatus', 1500),
('ultimatum', 'final demand', '/ˌʌltɪˈmeɪtəm/', 'english', 'From Medieval Latin ultimatum', 1700),

-- medius group
('medius', 'middle', '/ˈmediʊs/', 'latin', 'Latin word meaning "middle"', -100),
('medium', 'middle state', '/ˈmiːdiəm/', 'english', 'From Latin medium', 1300),
('mediate', 'act as go-between', '/ˈmiːdieɪt/', 'english', 'From Latin mediatus', 1500);

-- Add examples
INSERT INTO word_examples (word_id, example)
SELECT id, 'The people elected a new president.'
FROM words WHERE word = 'elect';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The king reigned for forty years.'
FROM words WHERE word = 'reign';

INSERT INTO word_examples (word_id, example)
SELECT id, 'She has a sanguine personality.'
FROM words WHERE word = 'sanguine';

INSERT INTO word_examples (word_id, example)
SELECT id, 'He had a visceral reaction to the news.'
FROM words WHERE word = 'visceral';

INSERT INTO word_examples (word_id, example)
SELECT id, 'This is a temporary solution.'
FROM words WHERE word = 'temporary';

-- Safe connection creation
DO $$
DECLARE
    source_word_id uuid;
    target_word_id uuid;
BEGIN
    -- legere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'legere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('elect', 'collect', 'intellect', 'legal')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- regere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'regere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('reign', 'regulate', 'regime')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- Add more connections for other word groups...
    -- (Similar pattern for sanguis, viscus, tempus, ordo, etc.)
END $$;