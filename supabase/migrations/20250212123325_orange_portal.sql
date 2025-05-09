/*
  # Add more Latin-derived words (Part 2)

  1. New Words
    - Added more Latin root words and their derivatives:
      - facere (to make)
      - tenere (to hold)
      - ducere (to lead)
      - mittere (to send)
      - trahere (to draw)
      - struere (to build)
    
  2. Examples
    - Added usage examples for each word
    
  3. Connections
    - Created derivation connections between root words and their derivatives
*/

-- Latin root verbs and their derivatives
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- facere group
('facere', 'to make, do', '/ˈfakere/', 'latin', 'Latin root meaning "to make or do"', -100),
('factory', 'manufacturing place', '/ˈfæktəri/', 'english', 'From Medieval Latin factoria, from facere', 1500),
('facilitate', 'to make easier', '/fəˈsɪlɪteɪt/', 'english', 'From Latin facilis, from facere', 1600),
('satisfy', 'to fulfill needs', '/ˈsætɪsfaɪ/', 'english', 'From Latin satisfacere, from facere', 1400),

-- tenere group
('tenere', 'to hold', '/ˈtenere/', 'latin', 'Latin root meaning "to hold"', -100),
('contain', 'to hold within', '/kənˈteɪn/', 'english', 'From Latin continere, from tenere', 1300),
('maintain', 'to keep in state', '/meɪnˈteɪn/', 'english', 'From Latin manutenere, from tenere', 1300),
('tenure', 'right to hold', '/ˈtenjʊər/', 'english', 'From Latin tenura, from tenere', 1400),

-- ducere group
('ducere', 'to lead', '/ˈduːkere/', 'latin', 'Latin root meaning "to lead"', -100),
('produce', 'to bring forth', '/prəˈdjuːs/', 'english', 'From Latin producere, from ducere', 1400),
('reduce', 'to bring down', '/rɪˈdjuːs/', 'english', 'From Latin reducere, from ducere', 1400),
('educate', 'to lead out, teach', '/ˈedjʊkeɪt/', 'english', 'From Latin educare, related to ducere', 1400),

-- mittere group
('mittere', 'to send', '/ˈmɪttere/', 'latin', 'Latin root meaning "to send"', -100),
('transmit', 'to send across', '/trænzˈmɪt/', 'english', 'From Latin transmittere, from mittere', 1400),
('permit', 'to allow', '/pərˈmɪt/', 'english', 'From Latin permittere, from mittere', 1300),
('submit', 'to yield', '/səbˈmɪt/', 'english', 'From Latin submittere, from mittere', 1300),

-- trahere group
('trahere', 'to draw', '/ˈtrahere/', 'latin', 'Latin root meaning "to draw"', -100),
('attract', 'to draw toward', '/əˈtrækt/', 'english', 'From Latin attractus, from trahere', 1400),
('contract', 'to draw together', '/ˈkɒntrækt/', 'english', 'From Latin contractus, from trahere', 1400),
('extract', 'to draw out', '/ˈekstrækt/', 'english', 'From Latin extractus, from trahere', 1400),

-- struere group
('struere', 'to build', '/ˈstruere/', 'latin', 'Latin root meaning "to build"', -100),
('construct', 'to build', '/kənˈstrʌkt/', 'english', 'From Latin constructus, from struere', 1400),
('structure', 'building, arrangement', '/ˈstrʌktʃər/', 'english', 'From Latin structura, from struere', 1400),
('instruct', 'to build up knowledge', '/ɪnˈstrʌkt/', 'english', 'From Latin instructus, from struere', 1400);

-- Add examples
INSERT INTO word_examples (word_id, example)
SELECT id, 'The factory produces automobiles.'
FROM words WHERE word = 'factory';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The new software will facilitate data analysis.'
FROM words WHERE word = 'facilitate';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The container contains valuable artifacts.'
FROM words WHERE word = 'contain';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Regular maintenance keeps the machine running smoothly.'
FROM words WHERE word = 'maintain';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The farm produces organic vegetables.'
FROM words WHERE word = 'produce';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Radio waves can transmit information over long distances.'
FROM words WHERE word = 'transmit';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Magnets attract iron.'
FROM words WHERE word = 'attract';

INSERT INTO word_examples (word_id, example)
SELECT id, 'They will construct a new bridge.'
FROM words WHERE word = 'construct';

-- Safe connection creation
DO $$
DECLARE
    source_word_id uuid;
    target_word_id uuid;
BEGIN
    -- facere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'facere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('factory', 'facilitate', 'satisfy')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- tenere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'tenere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('contain', 'maintain', 'tenure')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- ducere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'ducere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('produce', 'reduce', 'educate')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- mittere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'mittere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('transmit', 'permit', 'submit')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- trahere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'trahere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('attract', 'contract', 'extract')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- struere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'struere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('construct', 'structure', 'instruct')
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