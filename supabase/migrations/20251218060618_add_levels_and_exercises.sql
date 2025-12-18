/*
  # Add Levels and Exercises to Learning Platform

  1. Changes to Existing Tables
    - `modules` - Add `level` column (1, 2, 3) to categorize depth
    - `modules` - Add `level_label` for display (e.g., "Foundations", "Going Deeper", "The Full Picture")

  2. New Tables
    - `exercises`
      - `id` (uuid, primary key)
      - `lesson_id` (uuid, foreign key) - Reference to parent lesson
      - `order_index` (integer) - Display order
      - `question` (text) - The thought experiment or reflection question
      - `hint` (text) - Optional hint to guide thinking
      - `insight` (text) - The "aha" moment revealed after reflection
      - `exercise_type` (text) - Type: 'thought_experiment', 'reflection', 'connection'

    - `exercise_completions`
      - `id` (uuid, primary key)
      - `user_id` (uuid) - User identifier
      - `exercise_id` (uuid, foreign key) - Reference to exercise
      - `completed_at` (timestamptz) - When completed
      - Unique constraint on user_id + exercise_id

  3. Security
    - Enable RLS on new tables
    - Public read for exercises (educational content)
    - Users can only read/write their own completions
*/

-- Add level column to modules
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'modules' AND column_name = 'level'
  ) THEN
    ALTER TABLE modules ADD COLUMN level integer NOT NULL DEFAULT 1;
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'modules' AND column_name = 'level_label'
  ) THEN
    ALTER TABLE modules ADD COLUMN level_label text NOT NULL DEFAULT 'Foundations';
  END IF;
END $$;

-- Create exercises table
CREATE TABLE IF NOT EXISTS exercises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  lesson_id uuid NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  order_index integer NOT NULL DEFAULT 0,
  question text NOT NULL,
  hint text,
  insight text NOT NULL,
  exercise_type text NOT NULL DEFAULT 'thought_experiment',
  created_at timestamptz DEFAULT now()
);

-- Create exercise completions table
CREATE TABLE IF NOT EXISTS exercise_completions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  exercise_id uuid NOT NULL REFERENCES exercises(id) ON DELETE CASCADE,
  completed_at timestamptz DEFAULT now(),
  UNIQUE(user_id, exercise_id)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_exercises_lesson_id ON exercises(lesson_id);
CREATE INDEX IF NOT EXISTS idx_exercises_order ON exercises(lesson_id, order_index);
CREATE INDEX IF NOT EXISTS idx_exercise_completions_user ON exercise_completions(user_id);
CREATE INDEX IF NOT EXISTS idx_modules_level ON modules(level);

-- Enable RLS
ALTER TABLE exercises ENABLE ROW LEVEL SECURITY;
ALTER TABLE exercise_completions ENABLE ROW LEVEL SECURITY;

-- Exercises: Public read access
CREATE POLICY "Anyone can read exercises"
  ON exercises FOR SELECT
  TO anon, authenticated
  USING (true);

-- Exercise completions: Users can read their own
CREATE POLICY "Users can read own exercise completions"
  ON exercise_completions FOR SELECT
  TO anon, authenticated
  USING (user_id = coalesce(auth.uid(), user_id));

-- Exercise completions: Users can insert their own
CREATE POLICY "Users can insert own exercise completions"
  ON exercise_completions FOR INSERT
  TO anon, authenticated
  WITH CHECK (user_id = coalesce(auth.uid(), user_id));

-- Exercise completions: Users can delete their own
CREATE POLICY "Users can delete own exercise completions"
  ON exercise_completions FOR DELETE
  TO anon, authenticated
  USING (user_id = coalesce(auth.uid(), user_id));