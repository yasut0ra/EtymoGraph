/*
  # Etymology Database Schema

  1. New Tables
    - `words`
      - `id` (uuid, primary key)
      - `word` (text, the word itself)
      - `meaning` (text, definition)
      - `pronunciation` (text, IPA notation)
      - `language` (text, language of the word)
      - `etymology` (text, etymology description)
      - `year` (integer, approximate year of origin)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

    - `word_examples`
      - `id` (uuid, primary key)
      - `word_id` (uuid, foreign key to words)
      - `example` (text, usage example)
      - `created_at` (timestamp)

    - `word_connections`
      - `id` (uuid, primary key)
      - `source_id` (uuid, foreign key to words)
      - `target_id` (uuid, foreign key to words)
      - `type` (text, connection type: 'derivation', 'cognate', 'compound')
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for public read access
    - Add policies for authenticated users to manage their saved words
*/

-- Create words table
CREATE TABLE IF NOT EXISTS words (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  word text NOT NULL,
  meaning text NOT NULL,
  pronunciation text NOT NULL,
  language text NOT NULL,
  etymology text NOT NULL,
  year integer NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create word_examples table
CREATE TABLE IF NOT EXISTS word_examples (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  word_id uuid REFERENCES words(id) ON DELETE CASCADE,
  example text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create word_connections table
CREATE TABLE IF NOT EXISTS word_connections (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  source_id uuid REFERENCES words(id) ON DELETE CASCADE,
  target_id uuid REFERENCES words(id) ON DELETE CASCADE,
  type text NOT NULL CHECK (type IN ('derivation', 'cognate', 'compound')),
  created_at timestamptz DEFAULT now(),
  UNIQUE(source_id, target_id)
);

-- Enable Row Level Security
ALTER TABLE words ENABLE ROW LEVEL SECURITY;
ALTER TABLE word_examples ENABLE ROW LEVEL SECURITY;
ALTER TABLE word_connections ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Allow public read access on words"
  ON words FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public read access on word_examples"
  ON word_examples FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public read access on word_connections"
  ON word_connections FOR SELECT
  TO public
  USING (true);

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger for updating updated_at
CREATE TRIGGER update_words_updated_at
  BEFORE UPDATE ON words
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_words_language ON words(language);
CREATE INDEX IF NOT EXISTS idx_words_year ON words(year);
CREATE INDEX IF NOT EXISTS idx_word_connections_source ON word_connections(source_id);
CREATE INDEX IF NOT EXISTS idx_word_connections_target ON word_connections(target_id);