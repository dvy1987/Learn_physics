export interface Module {
  id: string;
  slug: string;
  title: string;
  description: string;
  intro_copy: string;
  order_index: number;
  level: number;
  level_label: string;
  lessons?: Lesson[];
}

export interface LessonContent {
  gentle_entry: string;
  human_context: string;
  concept_reveal: string;
  insight_moment: string;
  reflection_prompt: string;
  forward_motion: string;
}

export interface HistoricalContext {
  discovery_year: number;
  key_figures: string[];
  breakthrough_description: string;
  original_work?: string;
}

export interface Lesson {
  id: string;
  module_id: string;
  slug: string;
  title: string;
  promise: string;
  time_estimate: string;
  order_index: number;
  content: LessonContent;
  historical_context?: HistoricalContext;
  exercises?: Exercise[];
}

export interface Exercise {
  id: string;
  lesson_id: string;
  order_index: number;
  question: string;
  hint: string | null;
  insight: string;
  exercise_type: 'thought_experiment' | 'reflection' | 'connection';
}

export interface ExplorationProgress {
  id: string;
  user_id: string;
  lesson_id: string;
  explored_at: string;
}

export interface ExerciseCompletion {
  id: string;
  user_id: string;
  exercise_id: string;
  completed_at: string;
}

export interface UserActivity {
  id: string;
  user_id: string;
  last_active_at: string;
  last_lesson_id?: string;
}
