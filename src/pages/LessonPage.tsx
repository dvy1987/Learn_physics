import { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import { ArrowLeft, ArrowRight, Sparkles, BookOpen } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { useProgress } from '../context/ProgressContext';
import { ExerciseCard } from '../components/ExerciseCard';
import type { Lesson, Module, Exercise } from '../types';

export function LessonPage() {
  const { moduleSlug, lessonSlug } = useParams();
  const navigate = useNavigate();
  const { markAsExplored, isExplored, updateActivity } = useProgress();
  const [lesson, setLesson] = useState<Lesson | null>(null);
  const [module, setModule] = useState<Module | null>(null);
  const [exercises, setExercises] = useState<Exercise[]>([]);
  const [nextLesson, setNextLesson] = useState<Lesson | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchLesson() {
      const { data: lessonData } = await supabase
        .from('lessons')
        .select('*')
        .eq('slug', lessonSlug)
        .maybeSingle();

      if (lessonData) {
        setLesson(lessonData);

        const [moduleResult, exercisesResult, nextLessonResult] = await Promise.all([
          supabase
            .from('modules')
            .select('*')
            .eq('id', lessonData.module_id)
            .maybeSingle(),
          supabase
            .from('exercises')
            .select('*')
            .eq('lesson_id', lessonData.id)
            .order('order_index'),
          supabase
            .from('lessons')
            .select('*')
            .eq('module_id', lessonData.module_id)
            .gt('order_index', lessonData.order_index)
            .order('order_index')
            .limit(1)
            .maybeSingle()
        ]);

        if (moduleResult.data) {
          setModule(moduleResult.data);
        }

        if (exercisesResult.data) {
          setExercises(exercisesResult.data);
        }

        setNextLesson(nextLessonResult.data);

        await markAsExplored(lessonData.id);
        await updateActivity(lessonData.id);
      }

      setLoading(false);
    }

    fetchLesson();
  }, [lessonSlug, markAsExplored, updateActivity]);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-stone-400">Loading...</div>
      </div>
    );
  }

  if (!lesson || !module) {
    return (
      <div className="min-h-screen flex flex-col items-center justify-center px-6">
        <p className="text-stone-600 mb-4">This exploration wasn't found.</p>
        <Link to="/explore" className="text-amber-600 hover:text-amber-700">
          Return to explorations
        </Link>
      </div>
    );
  }

  const content = lesson.content;
  const explored = isExplored(lesson.id);

  return (
    <div className="min-h-screen">
      <div className="max-w-2xl mx-auto px-6 py-12">
        <nav className="mb-12">
          <Link
            to="/explore"
            className="inline-flex items-center gap-2 text-stone-500 hover:text-stone-700 transition-colors text-sm"
          >
            <ArrowLeft className="w-4 h-4" />
            <span>Back to explorations</span>
          </Link>
        </nav>

        <header className="mb-12">
          <div className="flex items-center gap-2 mb-2">
            <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${
              module.level === 1 ? 'bg-emerald-100 text-emerald-700' :
              module.level === 2 ? 'bg-sky-100 text-sky-700' :
              'bg-amber-100 text-amber-700'
            }`}>
              Level {module.level}
            </span>
            <span className="text-sm text-stone-500">{module.title}</span>
          </div>
          <h1 className="text-3xl md:text-4xl font-light text-stone-800 mb-4">
            {lesson.title}
          </h1>
          <p className="text-stone-600">{lesson.promise}</p>
        </header>

        <article className="space-y-12">
          <Section>
            <p className="text-lg text-stone-600 leading-relaxed italic">
              {content.gentle_entry}
            </p>
          </Section>

          <Section>
            <p className="text-stone-700 leading-relaxed whitespace-pre-line">
              {content.human_context}
            </p>
          </Section>

          <Section>
            <p className="text-stone-700 leading-relaxed whitespace-pre-line">
              {content.concept_reveal}
            </p>
          </Section>

          <Section className="bg-amber-50 -mx-6 px-6 py-8 rounded-2xl border border-amber-100">
            <div className="flex items-start gap-3">
              <Sparkles className="w-5 h-5 text-amber-600 flex-shrink-0 mt-1" />
              <p className="text-stone-800 leading-relaxed font-medium">
                {content.insight_moment}
              </p>
            </div>
          </Section>

          <Section>
            <p className="text-stone-600 leading-relaxed italic border-l-2 border-stone-200 pl-6">
              {content.reflection_prompt}
            </p>
          </Section>

          {exercises.length > 0 && (
            <Section className="pt-8 border-t border-stone-200">
              <h2 className="text-xl font-light text-stone-800 mb-2">
                Go Deeper
              </h2>
              <p className="text-stone-500 text-sm mb-6">
                Thought experiments to deepen your understanding. Take your time.
              </p>
              <div className="space-y-4">
                {exercises.map((exercise, index) => (
                  <ExerciseCard key={exercise.id} exercise={exercise} index={index} />
                ))}
              </div>
            </Section>
          )}

          <Section className="pt-8 border-t border-stone-200">
            <p className="text-stone-500 leading-relaxed mb-8">
              {content.forward_motion}
            </p>

            <div className="flex flex-col sm:flex-row gap-4">
              {nextLesson ? (
                <Link
                  to={`/explore/${moduleSlug}/${nextLesson.slug}`}
                  className="inline-flex items-center justify-center gap-3 px-6 py-4 bg-stone-800 text-stone-50 rounded-full hover:bg-stone-700 transition-all group"
                >
                  <span>Continue exploring</span>
                  <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1" />
                </Link>
              ) : (
                <button
                  onClick={() => navigate('/explore')}
                  className="inline-flex items-center justify-center gap-3 px-6 py-4 bg-stone-800 text-stone-50 rounded-full hover:bg-stone-700 transition-all"
                >
                  <span>Explore another question</span>
                </button>
              )}

              <Link
                to="/explore"
                className="inline-flex items-center justify-center gap-2 px-6 py-4 text-stone-600 hover:text-stone-800 transition-colors"
              >
                <span>Or return anytime</span>
              </Link>
            </div>
          </Section>
        </article>

        {explored && lesson.historical_context && (
          <footer className="mt-16 pt-8 border-t border-stone-100">
            <div className="bg-stone-100/50 rounded-xl p-6 text-center">
              <div className="flex items-center justify-center gap-2 mb-3">
                <BookOpen className="w-4 h-4 text-stone-500" />
                <span className="text-xs uppercase tracking-wider text-stone-500 font-medium">Your Discovery</span>
              </div>
              <p className="text-stone-700 mb-2">
                You've explored what {lesson.historical_context.key_figures.slice(0, 2).join(' and ')} {lesson.historical_context.key_figures.length > 2 ? 'and others ' : ''}revealed in {lesson.historical_context.discovery_year}.
              </p>
              {lesson.historical_context.original_work && (
                <p className="text-sm text-stone-500 italic">
                  {lesson.historical_context.original_work}
                </p>
              )}
            </div>
          </footer>
        )}

        {explored && !lesson.historical_context && (
          <footer className="mt-16 pt-8 border-t border-stone-100 text-center">
            <p className="text-sm text-stone-400">
              You've explored this idea. It will be here whenever you want to return.
            </p>
          </footer>
        )}
      </div>
    </div>
  );
}

function Section({ children, className = '' }: { children: React.ReactNode; className?: string }) {
  return (
    <section className={className}>
      {children}
    </section>
  );
}
