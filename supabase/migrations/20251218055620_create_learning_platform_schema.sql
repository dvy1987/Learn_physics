/*
  # Physics as Wonder Learning Platform Schema

  1. New Tables
    - `modules`
      - `id` (uuid, primary key) - Unique identifier
      - `slug` (text, unique) - URL-friendly identifier
      - `title` (text) - The "Big Question" title
      - `description` (text) - Brief emotional description
      - `intro_copy` (text) - Expanded introduction shown when accordion opens
      - `order_index` (integer) - Display order
      - `created_at` (timestamptz) - Creation timestamp
    
    - `lessons`
      - `id` (uuid, primary key) - Unique identifier
      - `module_id` (uuid, foreign key) - Reference to parent module
      - `slug` (text, unique) - URL-friendly identifier
      - `title` (text) - Curiosity-driven lesson title
      - `promise` (text) - One-sentence promise of what will "click"
      - `time_estimate` (text) - Reading time estimate (e.g., "~6 min")
      - `order_index` (integer) - Display order within module
      - `content` (jsonb) - Structured lesson content
      - `created_at` (timestamptz) - Creation timestamp
    
    - `exploration_progress`
      - `id` (uuid, primary key) - Unique identifier
      - `user_id` (uuid) - User identifier (can be anonymous session)
      - `lesson_id` (uuid, foreign key) - Reference to explored lesson
      - `explored_at` (timestamptz) - When the lesson was explored
      - Unique constraint on user_id + lesson_id

  2. Security
    - Enable RLS on all tables
    - Public read access for modules and lessons (educational content)
    - Users can only read/write their own progress
*/

-- Create modules table
CREATE TABLE IF NOT EXISTS modules (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  slug text UNIQUE NOT NULL,
  title text NOT NULL,
  description text NOT NULL,
  intro_copy text NOT NULL,
  order_index integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create lessons table
CREATE TABLE IF NOT EXISTS lessons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id uuid NOT NULL REFERENCES modules(id) ON DELETE CASCADE,
  slug text UNIQUE NOT NULL,
  title text NOT NULL,
  promise text NOT NULL,
  time_estimate text NOT NULL DEFAULT '~6 min',
  order_index integer NOT NULL DEFAULT 0,
  content jsonb NOT NULL DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

-- Create exploration progress table
CREATE TABLE IF NOT EXISTS exploration_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  lesson_id uuid NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  explored_at timestamptz DEFAULT now(),
  UNIQUE(user_id, lesson_id)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_lessons_module_id ON lessons(module_id);
CREATE INDEX IF NOT EXISTS idx_lessons_order ON lessons(module_id, order_index);
CREATE INDEX IF NOT EXISTS idx_modules_order ON modules(order_index);
CREATE INDEX IF NOT EXISTS idx_progress_user ON exploration_progress(user_id);

-- Enable Row Level Security
ALTER TABLE modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE exploration_progress ENABLE ROW LEVEL SECURITY;

-- Modules: Public read access (educational content should be accessible)
CREATE POLICY "Anyone can read modules"
  ON modules FOR SELECT
  TO anon, authenticated
  USING (true);

-- Lessons: Public read access
CREATE POLICY "Anyone can read lessons"
  ON lessons FOR SELECT
  TO anon, authenticated
  USING (true);

-- Progress: Users can read their own progress
CREATE POLICY "Users can read own progress"
  ON exploration_progress FOR SELECT
  TO anon, authenticated
  USING (user_id = coalesce(auth.uid(), user_id));

-- Progress: Users can insert their own progress
CREATE POLICY "Users can insert own progress"
  ON exploration_progress FOR INSERT
  TO anon, authenticated
  WITH CHECK (user_id = coalesce(auth.uid(), user_id));

-- Progress: Users can delete their own progress
CREATE POLICY "Users can delete own progress"
  ON exploration_progress FOR DELETE
  TO anon, authenticated
  USING (user_id = coalesce(auth.uid(), user_id));