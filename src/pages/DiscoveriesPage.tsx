import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { ArrowLeft, BookOpen, Calendar } from 'lucide-react';
import { supabase, getUserId } from '../lib/supabase';
import type { Lesson, Module } from '../types';

interface DiscoveryItem {
  lesson: Lesson;
  module: Module;
  explored_at: string;
}

export function DiscoveriesPage() {
  const [discoveries, setDiscoveries] = useState<DiscoveryItem[]>([]);
  const [loading, setLoading] = useState(true);
  const userId = getUserId();

  useEffect(() => {
    async function fetchDiscoveries() {
      const { data: progressData } = await supabase
        .from('exploration_progress')
        .select('lesson_id, explored_at')
        .eq('user_id', userId)
        .order('explored_at', { ascending: false });

      if (progressData && progressData.length > 0) {
        const lessonIds = progressData.map(p => p.lesson_id);

        const { data: lessonsData } = await supabase
          .from('lessons')
          .select('*')
          .in('id', lessonIds);

        if (lessonsData) {
          const moduleIds = [...new Set(lessonsData.map(l => l.module_id))];

          const { data: modulesData } = await supabase
            .from('modules')
            .select('*')
            .in('id', moduleIds);

          if (modulesData) {
            const moduleMap = new Map(modulesData.map(m => [m.id, m]));
            const lessonMap = new Map(lessonsData.map(l => [l.id, l]));

            const items: DiscoveryItem[] = progressData
              .map(p => {
                const lesson = lessonMap.get(p.lesson_id);
                const module = lesson ? moduleMap.get(lesson.module_id) : null;
                if (lesson && module) {
                  return { lesson, module, explored_at: p.explored_at };
                }
                return null;
              })
              .filter((item): item is DiscoveryItem => item !== null);

            setDiscoveries(items);
          }
        }
      }

      setLoading(false);
    }

    fetchDiscoveries();
  }, [userId]);

  const discoveryYears = [...new Set(
    discoveries
      .filter(d => d.lesson.historical_context?.discovery_year)
      .map(d => d.lesson.historical_context!.discovery_year)
  )].sort((a, b) => a - b);

  const earliestYear = discoveryYears[0];
  const latestYear = discoveryYears[discoveryYears.length - 1];

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-stone-400">Loading your journey...</div>
      </div>
    );
  }

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
          <div className="flex items-center gap-2 mb-4">
            <BookOpen className="w-5 h-5 text-amber-600" />
            <span className="text-sm text-stone-500 uppercase tracking-wider">Your Journey</span>
          </div>
          <h1 className="text-3xl md:text-4xl font-light text-stone-800 mb-4">
            Your Discoveries
          </h1>
          <p className="text-stone-600">
            Ideas you've explored, spanning {earliestYear && latestYear
              ? `${latestYear - earliestYear} years of human discovery (${earliestYear}–${latestYear})`
              : 'centuries of human discovery'
            }.
          </p>
        </header>

        {discoveries.length === 0 ? (
          <div className="text-center py-16">
            <p className="text-stone-500 mb-6">You haven't explored any ideas yet.</p>
            <Link
              to="/explore"
              className="inline-flex items-center gap-2 px-6 py-3 bg-stone-800 text-stone-50 rounded-full hover:bg-stone-700 transition-colors"
            >
              Begin exploring
            </Link>
          </div>
        ) : (
          <div className="space-y-1">
            {discoveries.map((discovery, index) => (
              <DiscoveryCard
                key={discovery.lesson.id}
                discovery={discovery}
                isLast={index === discoveries.length - 1}
              />
            ))}
          </div>
        )}

        {discoveries.length > 0 && (
          <footer className="mt-16 pt-8 border-t border-stone-100 text-center">
            <p className="text-stone-500 text-sm mb-4">
              {discoveries.length} {discoveries.length === 1 ? 'idea' : 'ideas'} explored
            </p>
            <Link
              to="/explore"
              className="text-amber-600 hover:text-amber-700 text-sm"
            >
              Continue your journey
            </Link>
          </footer>
        )}
      </div>
    </div>
  );
}

function DiscoveryCard({ discovery, isLast }: {
  discovery: DiscoveryItem;
  isLast: boolean;
}) {
  const { lesson, module } = discovery;
  const historical = lesson.historical_context;

  const exploredDate = new Date(discovery.explored_at);
  const formattedDate = exploredDate.toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric'
  });

  return (
    <Link
      to={`/explore/${module.slug}/${lesson.slug}`}
      className="block group"
    >
      <div className={`relative pl-8 py-6 hover:bg-stone-50 transition-colors ${
        !isLast ? 'border-b border-stone-100' : ''
      }`}>
        <div className="absolute left-0 top-0 bottom-0 w-px bg-stone-200" />
        <div className="absolute left-[-4px] top-8 w-[9px] h-[9px] rounded-full bg-stone-300 group-hover:bg-amber-500 transition-colors" />

        <div className="flex items-start justify-between gap-4">
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2 mb-1">
              {historical?.discovery_year && (
                <span className="text-xs font-medium text-amber-700 bg-amber-50 px-2 py-0.5 rounded">
                  {historical.discovery_year}
                </span>
              )}
              <span className={`text-xs px-2 py-0.5 rounded ${
                module.level === 1 ? 'bg-emerald-50 text-emerald-700' :
                module.level === 2 ? 'bg-sky-50 text-sky-700' :
                'bg-amber-50 text-amber-700'
              }`}>
                Level {module.level}
              </span>
            </div>

            <h3 className="text-stone-800 font-medium group-hover:text-amber-700 transition-colors mb-1">
              {lesson.title}
            </h3>

            {historical?.key_figures && historical.key_figures.length > 0 && (
              <p className="text-sm text-stone-500">
                {historical.key_figures.slice(0, 3).join(', ')}
                {historical.key_figures.length > 3 && ' and others'}
              </p>
            )}
          </div>

          <div className="flex items-center gap-1 text-xs text-stone-400 flex-shrink-0">
            <Calendar className="w-3 h-3" />
            <span>{formattedDate}</span>
          </div>
        </div>
      </div>
    </Link>
  );
}
