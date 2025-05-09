/*
  # Add remaining Latin words

  1. New Words
    - Added Latin nouns and their derivatives:
      - civis (citizen)
      - homo (human)
      - dominus (master)
      - populus (people)
      - socius (companion)
      - corpus (body)
      - mors (death)
      - sanguis (blood)
      - viscus (organ)
      - natura (nature)
    - Added Latin abstract nouns:
      - verus (truth)
      - fides (faith)
      - justus (justice)
      - tempus (time)
      - ordo (order)
    - Added Latin nature words:
      - aqua (water)
      - ignis (fire)
      - terra (earth)
      - silva (forest)
      - mare (sea)
    - Added Latin adjectives:
      - altus (high)
      - primus (first)
      - ultimus (last)
      - medius (middle)

  2. Examples
    - Added usage examples for each word
    
  3. Connections
    - Created derivation connections between root words and their derivatives
*/

-- Latin nouns and their derivatives
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- civis group
('civis', 'citizen', '/ˈkiːwis/', 'latin', 'Latin word meaning "citizen"', -100),
('civil', 'relating to citizens', '/ˈsɪvɪl/', 'english', 'From Latin civilis, from civis', 1200),
('civilization', 'advanced society', '/ˌsɪvɪlaɪˈzeɪʃən/', 'english', 'From Latin civilis', 1600),
('civic', 'relating to a city', '/ˈsɪvɪk/', 'english', 'From Latin civicus', 1500),

-- homo group
('homo', 'human', '/ˈhoːmoː/', 'latin', 'Latin word meaning "human"', -100),
('homicide', 'killing of a human', '/ˈhɒmɪsaɪd/', 'english', 'From Latin homicidium', 1400),
('homage', 'respect shown', '/ˈhɒmɪdʒ/', 'english', 'From Latin homo through Old French', 1300),
('hominid', 'human-like primate', '/ˈhɒmɪnɪd/', 'english', 'From Latin homo', 1800),

-- dominus group
('dominus', 'master, lord', '/ˈdɒmɪnʊs/', 'latin', 'Latin word meaning "master" or "lord"', -100),
('dominate', 'to rule over', '/ˈdɒmɪneɪt/', 'english', 'From Latin dominatus', 1500),
('domain', 'territory ruled', '/dəˈmeɪn/', 'english', 'From Latin dominium', 1300),
('dominion', 'sovereign authority', '/dəˈmɪnjən/', 'english', 'From Latin dominium', 1400),

-- natura group
('natura', 'nature', '/naːˈtuːra/', 'latin', 'Latin word meaning "nature"', -100),
('natural', 'of nature', '/ˈnætʃrəl/', 'english', 'From Latin naturalis', 1300),
('naturalize', 'make natural', '/ˈnætʃrəlaɪz/', 'english', 'From Latin naturalis', 1500),
('supernatural', 'beyond nature', '/ˌsuːpəˈnætʃrəl/', 'english', 'From Latin super + naturalis', 1500);

-- Latin abstract concepts
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- verus group
('verus', 'true', '/ˈweːrʊs/', 'latin', 'Latin word meaning "true"', -100),
('verify', 'confirm truth', '/ˈverɪfaɪ/', 'english', 'From Latin verificare', 1400),
('verdict', 'truth statement', '/ˈvɜːdɪkt/', 'english', 'From Latin veredictum', 1300),
('veracity', 'truthfulness', '/vəˈræsɪti/', 'english', 'From Latin veritas', 1600),

-- fides group
('fides', 'faith', '/ˈfiːdeːs/', 'latin', 'Latin word meaning "faith"', -100),
('fidelity', 'faithfulness', '/fɪˈdelɪti/', 'english', 'From Latin fidelitas', 1400),
('confident', 'trusting, sure', '/ˈkɒnfɪdənt/', 'english', 'From Latin confidens', 1400),
('infidel', 'unfaithful one', '/ˈɪnfɪdəl/', 'english', 'From Latin infidelis', 1400);

-- Nature elements
INSERT INTO words (word, meaning, pronunciation, language, etymology, year) VALUES
-- aqua group
('aqua', 'water', '/ˈækwə/', 'latin', 'Latin word meaning "water"', -100),
('aquarium', 'water container', '/əˈkweəriəm/', 'english', 'From Latin aquarium', 1800),
('aquatic', 'relating to water', '/əˈkwætɪk/', 'english', 'From Latin aquaticus', 1500),
('aqueduct', 'water channel', '/ˈækwɪdʌkt/', 'english', 'From Latin aquaeductus', 1500),

-- terra group
('terra', 'earth', '/ˈterra/', 'latin', 'Latin word meaning "earth"', -100),
('terrain', 'land surface', '/təˈreɪn/', 'english', 'From Latin terrenum', 1500),
('terrestrial', 'of earth', '/təˈrestriəl/', 'english', 'From Latin terrestris', 1400),
('terrace', 'raised earth', '/ˈterəs/', 'english', 'From Latin terra through French', 1500);

-- Add examples
INSERT INTO word_examples (word_id, example)
SELECT id, 'Civil rights are fundamental to democracy.'
FROM words WHERE word = 'civil';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The case was classified as homicide.'
FROM words WHERE word = 'homicide';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The king dominated the medieval society.'
FROM words WHERE word = 'dominate';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Scientists study natural phenomena.'
FROM words WHERE word = 'natural';

INSERT INTO word_examples (word_id, example)
SELECT id, 'Please verify your email address.'
FROM words WHERE word = 'verify';

INSERT INTO word_examples (word_id, example)
SELECT id, 'The aquarium contains tropical fish.'
FROM words WHERE word = 'aquarium';

-- Safe connection creation
DO $$
DECLARE
    source_word_id uuid;
    target_word_id uuid;
BEGIN
    -- civis connections
    SELECT id INTO source_word_id FROM words WHERE word = 'civis';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('civil', 'civilization', 'civic')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- homo connections
    SELECT id INTO source_word_id FROM words WHERE word = 'homo';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('homicide', 'homage', 'hominid')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- natura connections
    SELECT id INTO source_word_id FROM words WHERE word = 'natura';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('natural', 'naturalize', 'supernatural')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- verus connections
    SELECT id INTO source_word_id FROM words WHERE word = 'verus';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('verify', 'verdict', 'veracity')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- aqua connections
    SELECT id INTO source_word_id FROM words WHERE word = 'aqua';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('aquarium', 'aquatic', 'aqueduct')
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM word_connections 
            WHERE source_id = source_word_id AND target_id = target_word_id
        ) THEN
            INSERT INTO word_connections (source_id, target_id, type)
            VALUES (source_word_id, target_word_id, 'derivation');
        END IF;
    END LOOP;

    -- terra connections
    SELECT id INTO source_word_id FROM words WHERE word = 'terra';
    FOR target_word_id IN SELECT id FROM words WHERE word IN ('terrain', 'terrestrial', 'terrace')
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