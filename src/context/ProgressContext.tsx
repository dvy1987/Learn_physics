import { createContext, useContext, useState, useEffect, useCallback, ReactNode } from 'react';
import { supabase, getUserId } from '../lib/supabase';

interface ReturnInfo {
  daysSinceLastVisit: number;
  lastLessonId: string | null;
}

interface ProgressContextType {
  exploredLessons: Set<string>;
  completedExercises: Set<string>;
  markAsExplored: (lessonId: string) => Promise<void>;
  markExerciseComplete: (exerciseId: string) => Promise<void>;
  isExplored: (lessonId: string) => boolean;
  isExerciseComplete: (exerciseId: string) => boolean;
  exploredCount: number;
  exerciseCount: number;
  returnInfo: ReturnInfo | null;
  updateActivity: (lessonId?: string) => Promise<void>;
}

const ProgressContext = createContext<ProgressContextType | null>(null);

export function ProgressProvider({ children }: { children: ReactNode }) {
  const [exploredLessons, setExploredLessons] = useState<Set<string>>(new Set());
  const [completedExercises, setCompletedExercises] = useState<Set<string>>(new Set());
  const [returnInfo, setReturnInfo] = useState<ReturnInfo | null>(null);
  const userId = getUserId();

  useEffect(() => {
    async function fetchProgress() {
      const [lessonsResult, exercisesResult, activityResult] = await Promise.all([
        supabase
          .from('exploration_progress')
          .select('lesson_id')
          .eq('user_id', userId),
        supabase
          .from('exercise_completions')
          .select('exercise_id')
          .eq('user_id', userId),
        supabase
          .from('user_activity')
          .select('last_active_at, last_lesson_id')
          .eq('user_id', userId)
          .maybeSingle()
      ]);

      if (lessonsResult.data) {
        setExploredLessons(new Set(lessonsResult.data.map(p => p.lesson_id)));
      }

      if (exercisesResult.data) {
        setCompletedExercises(new Set(exercisesResult.data.map(p => p.exercise_id)));
      }

      if (activityResult.data) {
        const lastActive = new Date(activityResult.data.last_active_at);
        const now = new Date();
        const diffTime = Math.abs(now.getTime() - lastActive.getTime());
        const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));

        if (diffDays >= 1) {
          setReturnInfo({
            daysSinceLastVisit: diffDays,
            lastLessonId: activityResult.data.last_lesson_id
          });
        }
      }
    }

    fetchProgress();
  }, [userId]);

  const markAsExplored = useCallback(async (lessonId: string) => {
    if (exploredLessons.has(lessonId)) return;

    const { error } = await supabase
      .from('exploration_progress')
      .insert({ user_id: userId, lesson_id: lessonId });

    if (!error) {
      setExploredLessons(prev => new Set([...prev, lessonId]));
    }
  }, [userId, exploredLessons]);

  const markExerciseComplete = useCallback(async (exerciseId: string) => {
    if (completedExercises.has(exerciseId)) return;

    const { error } = await supabase
      .from('exercise_completions')
      .insert({ user_id: userId, exercise_id: exerciseId });

    if (!error) {
      setCompletedExercises(prev => new Set([...prev, exerciseId]));
    }
  }, [userId, completedExercises]);

  const isExplored = useCallback((lessonId: string) => {
    return exploredLessons.has(lessonId);
  }, [exploredLessons]);

  const isExerciseComplete = useCallback((exerciseId: string) => {
    return completedExercises.has(exerciseId);
  }, [completedExercises]);

  const updateActivity = useCallback(async (lessonId?: string) => {
    const { data: existing } = await supabase
      .from('user_activity')
      .select('id')
      .eq('user_id', userId)
      .maybeSingle();

    if (existing) {
      await supabase
        .from('user_activity')
        .update({
          last_active_at: new Date().toISOString(),
          ...(lessonId && { last_lesson_id: lessonId })
        })
        .eq('user_id', userId);
    } else {
      await supabase
        .from('user_activity')
        .insert({
          user_id: userId,
          last_active_at: new Date().toISOString(),
          ...(lessonId && { last_lesson_id: lessonId })
        });
    }

    setReturnInfo(null);
  }, [userId]);

  return (
    <ProgressContext.Provider value={{
      exploredLessons,
      completedExercises,
      markAsExplored,
      markExerciseComplete,
      isExplored,
      isExerciseComplete,
      exploredCount: exploredLessons.size,
      exerciseCount: completedExercises.size,
      returnInfo,
      updateActivity
    }}>
      {children}
    </ProgressContext.Provider>
  );
}

export function useProgress() {
  const context = useContext(ProgressContext);
  if (!context) {
    throw new Error('useProgress must be used within a ProgressProvider');
  }
  return context;
}
