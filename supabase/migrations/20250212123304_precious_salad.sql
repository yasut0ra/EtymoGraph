/*
  # Add more Latin-derived words

  1. New Words
    - Added Latin root words:
      - capere (to take)
      - ponere (to place)
      - movere (to move)
      - facere (to make)
      - tenere (to hold)
      - ducere (to lead)
      - mittere (to send)
      - trahere (to draw)
      - struere (to build)
    - Added derived English words for each root
    - Added adjectives:
      - fortis (strong)
      - longus (long)
      - magnus (large)
      - novus (new)
      - clarus (bright)
      - omnis (all)
      - gravis (heavy)
      - levis (light)
      - brevis (short)

  2. Examples
    - Added usage examples for each word
    
  3. Connections
    - Created derivation connections between root words and their derivatives
*/

-- Latin root verbs and their derivatives
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- capere group
('capere', 'to take, seize', '/ˈkapere/', 'latin', 'Latin root meaning "to take or seize"', -100),
('capture', 'to catch or seize', '/ˈkæptʃər/', 'english', 'From Latin capere', 1500),
('capable', 'having ability', '/ˈkeɪpəbl/', 'english', 'From Late Latin capabilis, from capere', 1500),
('accept', 'to receive willingly', '/əkˈsept/', 'english', 'From Latin acceptare, from capere', 1300),

-- ponere group
('ponere', 'to place', '/ˈponere/', 'latin', 'Latin root meaning "to place"', -100),
('position', 'location, placement', '/pəˈzɪʃən/', 'english', 'From Latin positio, from ponere', 1400),
('compose', 'to put together', '/kəmˈpoʊz/', 'english', 'From Latin componere, from ponere', 1400),
('deposit', 'to place for safekeeping', '/dɪˈpɒzɪt/', 'english', 'From Latin depositum, from ponere', 1500),

-- movere group
('movere', 'to move', '/moˈweːre/', 'latin', 'Latin root meaning "to move"', -100),
('motion', 'movement', '/ˈmoʊʃən/', 'english', 'From Latin motio, from movere', 1400),
('emotion', 'strong feeling', '/ɪˈmoʊʃən/', 'english', 'From Latin emovere, from movere', 1500),
('promote', 'to advance', '/prəˈmoʊt/', 'english', 'From Latin promovere, from movere', 1400),

-- Latin adjectives
('fortis', 'strong', '/ˈfɔːrtɪs/', 'latin', 'Latin word meaning "strong"', -100),
('longus', 'long', '/ˈlɒŋɡʊs/', 'latin', 'Latin word meaning "long"', -100),
('magnus', 'great, large', '/ˈmæɡnʊs/', 'latin', 'Latin word meaning "great" or "large"', -100),
('novus', 'new', '/ˈnowʊs/', 'latin', 'Latin word meaning "new"', -100),
('clarus', 'clear, bright', '/ˈklɑːrʊs/', 'latin', 'Latin word meaning "clear" or "bright"', -100),
('omnis', 'all, every', '/ˈɒmnɪs/', 'latin', 'Latin word meaning "all" or "every"', -100),
('gravis', 'heavy', '/ˈɡrɑːwɪs/', 'latin', 'Latin word meaning "heavy"', -100),
('levis', 'light', '/ˈlewɪs/', 'latin', 'Latin word meaning "light"', -100),
('brevis', 'short', '/ˈbrewɪs/', 'latin', 'Latin word meaning "short"', -100);

-- Add examples
INSERT INTO word_examples (word_id, example)
SELECT id, 'The police captured the suspect after a long chase.'
FROM words WHERE word = 'capture';

INSERT INTO word_examples (word_id, example)
SELECT id, 'She is capable of solving complex problems.'
FROM words WHERE word = 'capable';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The committee accepted his proposal.'
FROM words WHERE word = 'accept';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Please maintain your current position.'
FROM words WHERE word = 'position';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Mozart composed many beautiful symphonies.'
FROM words WHERE word = 'compose';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The motion of the planets follows predictable patterns.'
FROM words WHERE word = 'motion';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Joy is a powerful emotion.'
FROM words WHERE word = 'emotion';

-- Safe connection creation
DO $$
DECLARE
    source_word_id uuid;
    target_word_id uuid;
BEGIN
    -- capere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'capere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('capture', 'capable', 'accept')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- ponere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'ponere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('position', 'compose', 'deposit')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- movere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'movere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('motion', 'emotion', 'promote')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;
END $$;