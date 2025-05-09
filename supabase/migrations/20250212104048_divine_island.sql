/*
  # Add More Etymology Words

  1. New Words
    - Latin origin: credere, portare, currere groups
    - Greek origin: chronos, pathos, demos groups
    - Germanic origin: strong, night, light groups
    
  2. Examples and Connections
    - Usage examples for new words
    - Safe connection creation with duplicate prevention
*/

-- Latin origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- credere group
('credere', 'to believe', '/ˈkredere/', 'latin', 'Latin root meaning "to believe"', -100),
('credit', 'trust, belief', '/ˈkredɪt/', 'english', 'From Latin creditus', 1400),
('incredible', 'unbelievable', '/ɪnˈkredəbl/', 'english', 'From Latin incredibilis', 1500),
('credential', 'proof of qualification', '/krəˈdenʃəl/', 'english', 'From Medieval Latin credentialis', 1600),

-- portare group
('portare', 'to carry', '/porˈtaːre/', 'latin', 'Latin root meaning "to carry"', -100),
('transport', 'carry across', '/ˈtrænspɔːt/', 'english', 'From Latin transportare', 1400),
('export', 'carry out', '/ˈekspɔːt/', 'english', 'From Latin exportare', 1500),
('portable', 'able to be carried', '/ˈpɔːtəbl/', 'english', 'From Latin portabilis', 1400),

-- currere group
('currere', 'to run', '/ˈkurrere/', 'latin', 'Latin root meaning "to run"', -100),
('current', 'flowing, present', '/ˈkʌrənt/', 'english', 'From Latin currens', 1300),
('curriculum', 'course of study', '/kəˈrɪkjʊləm/', 'english', 'From Latin curriculum', 1600),
('excursion', 'journey', '/ɪkˈskɜːʃn/', 'english', 'From Latin excursio', 1500);

-- Greek origin words
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- chronos group
('chronos', 'time', '/ˈkrɒnɒs/', 'greek', 'Greek word for time', -800),
('chronology', 'time arrangement', '/krəˈnɒlədʒi/', 'english', 'From Greek chronos + logos', 1600),
('synchronize', 'occur at same time', '/ˈsɪŋkrənaɪz/', 'english', 'From Greek syn + chronos', 1600),
('chronic', 'lasting long time', '/ˈkrɒnɪk/', 'english', 'From Greek chronikos', 1400),

-- pathos group
('pathos', 'suffering, emotion', '/ˈpeɪθɒs/', 'greek', 'Greek word for suffering', -800),
('sympathy', 'feeling with others', '/ˈsɪmpəθi/', 'english', 'From Greek sympatheia', 1500),
('empathy', 'understanding feelings', '/ˈempəθi/', 'english', 'From Greek empatheia', 1900),
('pathology', 'study of disease', '/pəˈθɒlədʒi/', 'english', 'From Greek pathos + logos', 1600),

-- demos group
('demos', 'people', '/ˈdiːmɒs/', 'greek', 'Greek word for people', -800),
('democracy', 'rule by people', '/dɪˈmɒkrəsi/', 'english', 'From Greek demokratia', 1400),
('demographic', 'population study', '/ˌdeməˈɡræfɪk/', 'english', 'From Greek demos + graphein', 1800),
('epidemic', 'affecting many people', '/ˌepɪˈdemɪk/', 'english', 'From Greek epidemos', 1600);

-- Add examples
INSERT INTO word_examples (word_id, example)
SELECT id, 'He has good credit at the bank.'
FROM words WHERE word = 'credit';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The portable computer can be carried anywhere.'
FROM words WHERE word = 'portable';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The curriculum includes mathematics and science.'
FROM words WHERE word = 'curriculum';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Please synchronize your watches.'
FROM words WHERE word = 'synchronize';

INSERT INTO word_examples (word_id, example)
SELECT id, 'She showed great empathy for others.'
FROM words WHERE word = 'empathy';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Democracy is based on the will of the people.'
FROM words WHERE word = 'democracy';

-- Safe connection creation
DO $$
DECLARE
    source_word_id uuid;
    target_word_id uuid;
BEGIN
    -- credere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'credere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('credit', 'incredible', 'credential')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- portare connections
    SELECT id INTO source_word_id FROM words WHERE word = 'portare';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('transport', 'export', 'portable')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- currere connections
    SELECT id INTO source_word_id FROM words WHERE word = 'currere';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('current', 'curriculum', 'excursion')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- chronos connections
    SELECT id INTO source_word_id FROM words WHERE word = 'chronos';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('chronology', 'synchronize', 'chronic')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- pathos connections
    SELECT id INTO source_word_id FROM words WHERE word = 'pathos';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('sympathy', 'empathy', 'pathology')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- demos connections
    SELECT id INTO source_word_id FROM words WHERE word = 'demos';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('democracy', 'demographic', 'epidemic')
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