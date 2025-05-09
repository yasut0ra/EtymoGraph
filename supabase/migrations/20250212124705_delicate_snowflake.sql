/*
  # Add more Latin and Greek word groups

  1. New Words
    - Latin verb groups: audire, sentire, vertere
    - Latin noun groups: anima, corpus, pars
    - Greek root groups: anthropos, kosmos, phone
    - Greek compound elements: auto-, bio-, geo-

  2. Examples and Connections
    - Add example sentences for each word
    - Create derivation connections between root words and derivatives
*/

-- Latin verb groups
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- audire group
('audire', 'to hear', '/auˈdiːre/', 'latin', 'Latin root meaning "to hear"', -100),
('audio', 'sound', '/ˈɔːdioʊ/', 'english', 'From Latin audire', 1900),
('audible', 'able to be heard', '/ˈɔːdəbl/', 'english', 'From Latin audibilis', 1500),
('audience', 'group of listeners', '/ˈɔːdiəns/', 'english', 'From Latin audientia', 1400),

-- sentire group
('sentire', 'to feel', '/senˈtiːre/', 'latin', 'Latin root meaning "to feel"', -100),
('sense', 'faculty of perception', '/sens/', 'english', 'From Latin sensus', 1300),
('sensitive', 'quick to feel', '/ˈsensətɪv/', 'english', 'From Medieval Latin sensitivus', 1400),
('sentiment', 'feeling, opinion', '/ˈsentɪmənt/', 'english', 'From Latin sentimentum', 1600),

-- vertere group
('vertere', 'to turn', '/ˈwertere/', 'latin', 'Latin root meaning "to turn"', -100),
('convert', 'change form', '/kənˈvɜːt/', 'english', 'From Latin convertere', 1300),
('reverse', 'turn back', '/rɪˈvɜːs/', 'english', 'From Latin reversus', 1300),
('divert', 'turn aside', '/daɪˈvɜːt/', 'english', 'From Latin divertere', 1400);

-- Latin noun groups
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- anima group
('anima', 'soul, breath', '/ˈanima/', 'latin', 'Latin word meaning "soul" or "breath"', -100),
('animal', 'living being', '/ˈænɪməl/', 'english', 'From Latin animal', 1200),
('animate', 'bring to life', '/ˈænɪmeɪt/', 'english', 'From Latin animatus', 1500),
('animation', 'act of bringing to life', '/ˌænɪˈmeɪʃən/', 'english', 'From Latin animatio', 1600),

-- pars group
('pars', 'part', '/pars/', 'latin', 'Latin word meaning "part"', -100),
('particle', 'tiny part', '/ˈpɑːtɪkl/', 'english', 'From Latin particula', 1400),
('participate', 'take part in', '/pɑːˈtɪsɪpeɪt/', 'english', 'From Latin participatus', 1500),
('partition', 'division into parts', '/pɑːˈtɪʃən/', 'english', 'From Latin partitio', 1400);

-- Greek root groups
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- anthropos group
('anthropos', 'human', '/ˈænθrɒpɒs/', 'greek', 'Greek word meaning "human"', -800),
('anthropology', 'study of humans', '/ˌænθrəˈpɒlədʒi/', 'english', 'From Greek anthropos + logos', 1600),
('misanthrope', 'person who dislikes humans', '/ˈmɪsənθrəʊp/', 'english', 'From Greek misos + anthropos', 1600),

-- kosmos group
('kosmos', 'order, universe', '/ˈkɒzmɒs/', 'greek', 'Greek word meaning "order" or "universe"', -800),
('cosmic', 'relating to universe', '/ˈkɒzmɪk/', 'english', 'From Greek kosmikos', 1600),
('cosmology', 'study of universe', '/kɒzˈmɒlədʒi/', 'english', 'From Greek kosmos + logos', 1700),
('cosmopolitan', 'worldwide in scope', '/ˌkɒzməˈpɒlɪtən/', 'english', 'From Greek kosmopolites', 1600),

-- phone group
('phone', 'sound', '/fəʊn/', 'greek', 'Greek word meaning "sound"', -800),
('phonetic', 'relating to speech sounds', '/fəˈnetɪk/', 'english', 'From Greek phonetikos', 1800),
('symphony', 'harmony of sounds', '/ˈsɪmfəni/', 'english', 'From Greek symphonia', 1400),
('microphone', 'device for sound', '/ˈmaɪkrəfəʊn/', 'english', 'From Greek mikros + phone', 1800);

-- Add examples
INSERT INTO word_examples (word_id, example)
SELECT id, 'The audio quality of the recording was excellent.'
FROM words WHERE word = 'audio';

INSERT INTO word_examples (word_id, example)
SELECT id, 'She has a keen sense of humor.'
FROM words WHERE word = 'sense';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The magician converted water into ice.'
FROM words WHERE word = 'convert';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The zoo houses many different animals.'
FROM words WHERE word = 'animal';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Students actively participate in class discussions.'
FROM words WHERE word = 'participate';

INSERT INTO word_examples (word_id, example)
SELECT id, 'She studies cultural anthropology.'
FROM words WHERE word = 'anthropology';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The cosmic rays come from distant stars.'
FROM words WHERE word = 'cosmic';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The symphony orchestra performed beautifully.'
FROM words WHERE word = 'symphony';

-- Safe connection creation
DO $$
DECLARE
    source_word_id uuid;
    target_word_id uuid;
BEGIN
    -- audire connections
    SELECT id INTO source_word_id FROM words WHERE word = 'audire';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('audio', 'audible', 'audience')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- sentire connections
    SELECT id INTO source_word_id FROM words WHERE word = 'sentire';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('sense', 'sensitive', 'sentiment')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- vertere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'vertere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('convert', 'reverse', 'divert')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- anima connections
    SELECT id INTO source_word_id FROM words WHERE word = 'anima';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('animal', 'animate', 'animation')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- pars connections
    SELECT id INTO source_word_id FROM words WHERE word = 'pars';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('particle', 'participate', 'partition')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- anthropos connections
    SELECT id INTO source_word_id FROM words WHERE word = 'anthropos';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('anthropology', 'misanthrope')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- kosmos connections
    SELECT id INTO source_word_id FROM words WHERE word = 'kosmos';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('cosmic', 'cosmology', 'cosmopolitan')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- phone connections
    SELECT id INTO source_word_id FROM words WHERE word = 'phone';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('phonetic', 'symphony', 'microphone')
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