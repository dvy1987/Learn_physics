import { useState } from 'react';
import { Lightbulb, ChevronDown, Sparkles, Brain, Link2 } from 'lucide-react';
import { useProgress } from '../context/ProgressContext';
import type { Exercise } from '../types';

interface ExerciseCardProps {
  exercise: Exercise;
  index: number;
}

const exerciseIcons = {
  thought_experiment: Brain,
  reflection: Lightbulb,
  connection: Link2,
};

const exerciseLabels = {
  thought_experiment: 'Thought Experiment',
  reflection: 'Reflection',
  connection: 'Connection',
};

export function ExerciseCard({ exercise, index }: ExerciseCardProps) {
  const { isExerciseComplete, markExerciseComplete } = useProgress();
  const [showHint, setShowHint] = useState(false);
  const [showInsight, setShowInsight] = useState(isExerciseComplete(exercise.id));
  const completed = isExerciseComplete(exercise.id);

  const Icon = exerciseIcons[exercise.exercise_type];
  const label = exerciseLabels[exercise.exercise_type];

  const handleRevealInsight = async () => {
    setShowInsight(true);
    await markExerciseComplete(exercise.id);
  };

  return (
    <div className={`rounded-xl border transition-all ${
      completed
        ? 'bg-teal-50/50 border-teal-200/50'
        : 'bg-white border-stone-200'
    }`}>
      <div className="p-6">
        <div className="flex items-start gap-4">
          <div className={`w-10 h-10 rounded-full flex items-center justify-center flex-shrink-0 ${
            completed ? 'bg-teal-100 text-teal-600' : 'bg-stone-100 text-stone-500'
          }`}>
            <Icon className="w-5 h-5" />
          </div>

          <div className="flex-1">
            <div className="flex items-center gap-2 mb-2">
              <span className="text-xs font-medium text-stone-400 uppercase tracking-wide">
                {label} {index + 1}
              </span>
              {completed && (
                <span className="text-xs text-teal-600 bg-teal-100 px-2 py-0.5 rounded-full">
                  pondered
                </span>
              )}
            </div>

            <p className="text-stone-800 leading-relaxed mb-4">
              {exercise.question}
            </p>

            {exercise.hint && !showInsight && (
              <button
                onClick={() => setShowHint(!showHint)}
                className="flex items-center gap-2 text-sm text-stone-500 hover:text-stone-700 transition-colors mb-4"
              >
                <ChevronDown className={`w-4 h-4 transition-transform ${showHint ? 'rotate-180' : ''}`} />
                <span>{showHint ? 'Hide hint' : 'Need a hint?'}</span>
              </button>
            )}

            {showHint && !showInsight && (
              <div className="bg-stone-50 rounded-lg p-4 mb-4 border border-stone-100">
                <p className="text-sm text-stone-600 italic">{exercise.hint}</p>
              </div>
            )}

            {!showInsight ? (
              <button
                onClick={handleRevealInsight}
                className="inline-flex items-center gap-2 px-4 py-2 bg-stone-800 text-stone-50 rounded-full text-sm hover:bg-stone-700 transition-colors"
              >
                <Sparkles className="w-4 h-4" />
                <span>Reveal the insight</span>
              </button>
            ) : (
              <div className="bg-amber-50 rounded-lg p-4 border border-amber-100">
                <div className="flex items-start gap-3">
                  <Sparkles className="w-5 h-5 text-amber-600 flex-shrink-0 mt-0.5" />
                  <p className="text-stone-700 leading-relaxed">{exercise.insight}</p>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
