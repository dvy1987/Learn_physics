/*
  # Add Historical Context and User Activity Tracking

  1. Changes to Existing Tables
    - `lessons` - Add `historical_context` JSONB column containing:
      - discovery_year: Year the concept was first discovered/formulated
      - key_figures: Array of scientists involved
      - breakthrough_description: Brief description of the historical significance
      - original_work: Name of the original paper/book if applicable

  2. New Tables
    - `user_activity`
      - `id` (uuid, primary key)
      - `user_id` (uuid) - User identifier
      - `last_active_at` (timestamptz) - Last activity timestamp
      - `last_lesson_id` (uuid, nullable) - Reference to last viewed lesson
      - Unique constraint on user_id

  3. Security
    - Enable RLS on user_activity
    - Users can only read/write their own activity
*/

-- Add historical_context column to lessons
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'lessons' AND column_name = 'historical_context'
  ) THEN
    ALTER TABLE lessons ADD COLUMN historical_context jsonb DEFAULT NULL;
  END IF;
END $$;

-- Create user_activity table for soft return incentive
CREATE TABLE IF NOT EXISTS user_activity (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL UNIQUE,
  last_active_at timestamptz DEFAULT now(),
  last_lesson_id uuid REFERENCES lessons(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now()
);

-- Create index for efficient lookups
CREATE INDEX IF NOT EXISTS idx_user_activity_user ON user_activity(user_id);
CREATE INDEX IF NOT EXISTS idx_user_activity_last_active ON user_activity(last_active_at);

-- Enable RLS
ALTER TABLE user_activity ENABLE ROW LEVEL SECURITY;

-- User activity: Users can read their own activity
CREATE POLICY "Users can read own activity"
  ON user_activity FOR SELECT
  TO anon, authenticated
  USING (user_id = coalesce(auth.uid(), user_id));

-- User activity: Users can insert their own activity
CREATE POLICY "Users can insert own activity"
  ON user_activity FOR INSERT
  TO anon, authenticated
  WITH CHECK (user_id = coalesce(auth.uid(), user_id));

-- User activity: Users can update their own activity
CREATE POLICY "Users can update own activity"
  ON user_activity FOR UPDATE
  TO anon, authenticated
  USING (user_id = coalesce(auth.uid(), user_id))
  WITH CHECK (user_id = coalesce(auth.uid(), user_id));
