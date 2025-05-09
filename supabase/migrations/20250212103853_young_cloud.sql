/*
  # Add More Etymology Data with Safe Connection Handling

  1. New Words
    - Latin origin words (spectare, scribere, dicere, videre groups)
    - Greek origin words (logos, philos groups)
    
  2. Examples
    - Usage examples for key words
    
  3. Connections
    - Safe connection creation with duplicate prevention
*/

-- Latin origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- spectare group
('spectator', 'one who watches', '/spekˈteɪtər/', 'english', 'From Latin spectator, from spectare', 1400),
('prospect', 'outlook or view', '/ˈprɒspekt/', 'english', 'From Latin prospectus, from prospicere', 1400),
('perspective', 'point of view', '/pərˈspektɪv/', 'english', 'From Latin perspectivus', 1400),

-- scribere group
('scribere', 'to write', '/ˈskriːbere/', 'latin', 'Latin root meaning "to write"', -100),
('describe', 'give account of', '/dɪˈskraɪb/', 'english', 'From Latin describere', 1400),
('prescribe', 'to order', '/prɪˈskraɪb/', 'english', 'From Latin praescribere', 1400),
('subscribe', 'to sign', '/səbˈskraɪb/', 'english', 'From Latin subscribere', 1400),

-- dicere group
('dicere', 'to say', '/ˈdiːkere/', 'latin', 'Latin root meaning "to say"', -100),
('dictate', 'to order', '/dɪkˈteɪt/', 'english', 'From Latin dictatus', 1500),
('predict', 'foretell', '/prɪˈdɪkt/', 'english', 'From Latin praedicere', 1500),
('verdict', 'judgment', '/ˈvɜːdɪkt/', 'english', 'From Latin veredictum', 1500),

-- videre group
('videre', 'to see', '/wiːˈdeːre/', 'latin', 'Latin root meaning "to see"', -100),
('video', 'visual recording', '/ˈvɪdioʊ/', 'english', 'From Latin video', 1900),
('evident', 'clear', '/ˈevɪdənt/', 'english', 'From Latin evidens', 1500),
('provide', 'supply', '/prəˈvaɪd/', 'english', 'From Latin providere', 1400);

-- Greek origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- logos group
('biology', 'study of life', '/baɪˈɒlədʒi/', 'english', 'From Greek bios (life) + logos (study)', 1800),
('psychology', 'study of mind', '/saɪˈkɒlədʒi/', 'english', 'From Greek psyche (mind) + logos (study)', 1700),
('theology', 'study of religion', '/θiˈɒlədʒi/', 'english', 'From Greek theos (god) + logos (study)', 1400),

-- philos group
('philosophy', 'love of wisdom', '/fɪˈlɒsəfi/', 'english', 'From Greek philosophia', 1300),
('philanthropist', 'lover of humanity', '/fɪˈlænθrəpɪst/', 'english', 'From Greek philanthropos', 1700),
('bibliophile', 'book lover', '/ˈbɪbliəʊfaɪl/', 'english', 'From Greek biblio (book) + philos', 1800);

-- Add examples
INSERT INTO word_examples (word_id, example) 
SELECT id, 'The spectators cheered as the team scored.'
FROM words WHERE word = 'spectator';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The business prospects look promising.'
FROM words WHERE word = 'prospect';

INSERT INTO word_examples (word_id, example)
SELECT id, 'She described the scene in vivid detail.'
FROM words WHERE word = 'describe';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The doctor prescribed antibiotics for the infection.'
FROM words WHERE word = 'prescribe';

-- Safe connection creation for Latin words
DO $$
DECLARE
    source_word_id uuid;
    target_word_id uuid;
BEGIN
    -- scribere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'scribere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('describe', 'prescribe', 'subscribe')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- dicere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'dicere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('dictate', 'predict', 'verdict')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- videre connections
    SELECT id INTO source_word_id FROM words WHERE word = 'videre';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('video', 'evident', 'provide')
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

-- Safe connection creation for Greek words
DO $$
DECLARE
    source_word_id uuid;
    target_word_id uuid;
BEGIN
    -- logos connections
    SELECT id INTO source_word_id FROM words WHERE word = 'logos';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('biology', 'psychology', 'theology')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- philos connections
    SELECT id INTO source_word_id FROM words WHERE word = 'philos';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('philosophy', 'philanthropist', 'bibliophile')
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