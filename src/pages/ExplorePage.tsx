import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { ChevronDown, Clock, Sparkles, X } from 'lucide-react';
import { supabase } from '../lib/supabase';
import { useProgress } from '../context/ProgressContext';
import type { Module, Lesson } from '../types';

const LEVEL_INFO = {
  1: { label: 'Foundations', description: 'Start here. No background needed.' },
  2: { label: 'Going Deeper', description: 'Build on what you\'ve explored.' },
  3: { label: 'The Full Picture', description: 'For the truly curious.' },
};

export function ExplorePage() {
  const [modules, setModules] = useState<Module[]>([]);
  const [expandedModule, setExpandedModule] = useState<string | null>(null);
  const [selectedLevel, setSelectedLevel] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);
  const [lastLessonInfo, setLastLessonInfo] = useState<{ title: string; moduleSlug: string; lessonSlug: string } | null>(null);
  const [showWelcome, setShowWelcome] = useState(true);
  const { returnInfo, updateActivity } = useProgress();

  useEffect(() => {
    async function fetchModules() {
      const { data: modulesData } = await supabase
        .from('modules')
        .select('*')
        .order('order_index');

      if (modulesData) {
        const { data: lessonsData } = await supabase
          .from('lessons')
          .select('*')
          .order('order_index');

        const modulesWithLessons = modulesData.map(module => ({
          ...module,
          lessons: lessonsData?.filter(lesson => lesson.module_id === module.id) || []
        }));

        setModules(modulesWithLessons);

        if (returnInfo?.lastLessonId && lessonsData) {
          const lastLesson = lessonsData.find(l => l.id === returnInfo.lastLessonId);
          if (lastLesson) {
            const parentModule = modulesData.find(m => m.id === lastLesson.module_id);
            if (parentModule) {
              setLastLessonInfo({
                title: lastLesson.title,
                moduleSlug: parentModule.slug,
                lessonSlug: lastLesson.slug
              });
            }
          }
        }
      }
      setLoading(false);
    }

    fetchModules();
  }, [returnInfo]);

  const filteredModules = selectedLevel
    ? modules.filter(m => m.level === selectedLevel)
    : modules;

  const groupedModules = filteredModules.reduce((acc, module) => {
    const level = module.level;
    if (!acc[level]) acc[level] = [];
    acc[level].push(module);
    return acc;
  }, {} as Record<number, Module[]>);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-stone-400">Loading explorations...</div>
      </div>
    );
  }

  const dismissWelcome = () => {
    setShowWelcome(false);
    updateActivity();
  };

  return (
    <div className="min-h-screen px-6 py-16">
      <div className="max-w-3xl mx-auto">
        {returnInfo && showWelcome && (
          <div className="mb-8 bg-stone-100 rounded-xl p-5 relative">
            <button
              onClick={dismissWelcome}
              className="absolute top-4 right-4 text-stone-400 hover:text-stone-600 transition-colors"
            >
              <X className="w-4 h-4" />
            </button>
            <p className="text-stone-700 mb-2">
              Welcome back. You last explored {returnInfo.daysSinceLastVisit} {returnInfo.daysSinceLastVisit === 1 ? 'day' : 'days'} ago.
            </p>
            {lastLessonInfo && (
              <Link
                to={`/explore/${lastLessonInfo.moduleSlug}/${lastLessonInfo.lessonSlug}`}
                className="text-amber-600 hover:text-amber-700 text-sm"
              >
                Continue with "{lastLessonInfo.title}"
              </Link>
            )}
          </div>
        )}

        <header className="text-center mb-12">
          <h1 className="text-3xl md:text-4xl font-light text-stone-800 mb-4">
            Big Questions
          </h1>
          <p className="text-stone-600 max-w-lg mx-auto leading-relaxed">
            Each exploration begins with a question that puzzled humanity's greatest minds.
            Choose whichever calls to you.
          </p>
        </header>

        <div className="flex justify-center gap-2 mb-12">
          <LevelButton
            level={null}
            label="All"
            isSelected={selectedLevel === null}
            onClick={() => setSelectedLevel(null)}
          />
          {[1, 2, 3].map(level => (
            <LevelButton
              key={level}
              level={level}
              label={LEVEL_INFO[level as keyof typeof LEVEL_INFO].label}
              isSelected={selectedLevel === level}
              onClick={() => setSelectedLevel(level)}
            />
          ))}
        </div>

        <div className="space-y-12">
          {Object.entries(groupedModules)
            .sort(([a], [b]) => Number(a) - Number(b))
            .map(([level, levelModules]) => (
              <div key={level}>
                {selectedLevel === null && (
                  <div className="mb-6">
                    <div className="flex items-center gap-3 mb-2">
                      <div className={`px-3 py-1 rounded-full text-sm font-medium ${
                        level === '1' ? 'bg-emerald-100 text-emerald-700' :
                        level === '2' ? 'bg-sky-100 text-sky-700' :
                        'bg-amber-100 text-amber-700'
                      }`}>
                        Level {level}
                      </div>
                      <span className="text-stone-600 font-medium">
                        {LEVEL_INFO[Number(level) as keyof typeof LEVEL_INFO].label}
                      </span>
                    </div>
                    <p className="text-sm text-stone-500">
                      {LEVEL_INFO[Number(level) as keyof typeof LEVEL_INFO].description}
                    </p>
                  </div>
                )}

                <div className="space-y-4">
                  {levelModules.map(module => (
                    <ModuleAccordion
                      key={module.id}
                      module={module}
                      isExpanded={expandedModule === module.id}
                      onToggle={() => setExpandedModule(
                        expandedModule === module.id ? null : module.id
                      )}
                    />
                  ))}
                </div>
              </div>
            ))}
        </div>

        <footer className="mt-16 text-center text-stone-500 text-sm">
          <p>There's no right order. No wrong place to start.</p>
        </footer>
      </div>
    </div>
  );
}

interface LevelButtonProps {
  level: number | null;
  label: string;
  isSelected: boolean;
  onClick: () => void;
}

function LevelButton({ label, isSelected, onClick }: LevelButtonProps) {
  return (
    <button
      onClick={onClick}
      className={`px-4 py-2 rounded-full text-sm transition-all ${
        isSelected
          ? 'bg-stone-800 text-stone-50'
          : 'bg-stone-100 text-stone-600 hover:bg-stone-200'
      }`}
    >
      {label}
    </button>
  );
}

interface ModuleAccordionProps {
  module: Module;
  isExpanded: boolean;
  onToggle: () => void;
}

function ModuleAccordion({ module, isExpanded, onToggle }: ModuleAccordionProps) {
  const { isExplored } = useProgress();
  const exploredCount = module.lessons?.filter(l => isExplored(l.id)).length || 0;
  const totalLessons = module.lessons?.length || 0;
  const hasLessons = totalLessons > 0;
  const progress = totalLessons > 0 ? exploredCount / totalLessons : 0;
  const isComplete = exploredCount === totalLessons && totalLessons > 0;

  return (
    <div className={`bg-white rounded-2xl border overflow-hidden transition-all hover:border-stone-300 ${
      isComplete ? 'border-amber-200 bg-amber-50/30' : 'border-stone-200'
    }`}>
      <button
        onClick={onToggle}
        className="w-full px-8 py-6 flex items-start justify-between text-left"
      >
        <div className="flex items-start gap-4 flex-1 pr-4">
          {hasLessons && (
            <div className="flex-shrink-0 mt-1">
              <ProgressRing progress={progress} isComplete={isComplete} />
            </div>
          )}
          <div className="flex-1">
            <h2 className="text-xl md:text-2xl font-light text-stone-800 mb-2">
              {module.title}
            </h2>
            <p className="text-stone-600 leading-relaxed">
              {module.description}
            </p>
            {exploredCount > 0 && (
              <p className="mt-3 text-sm text-stone-500">
                {isComplete
                  ? 'Fully explored'
                  : `${exploredCount} of ${totalLessons} ideas explored`}
              </p>
            )}
          </div>
        </div>
        <ChevronDown
          className={`w-5 h-5 text-stone-400 transition-transform flex-shrink-0 mt-1 ${
            isExpanded ? 'rotate-180' : ''
          }`}
        />
      </button>

      <div
        className={`overflow-hidden transition-all duration-300 ease-in-out ${
          isExpanded ? 'max-h-[1000px] opacity-100' : 'max-h-0 opacity-0'
        }`}
      >
        <div className="px-8 pb-6">
          <p className="text-stone-500 text-sm italic mb-6 pb-6 border-t border-stone-100 pt-6">
            {module.intro_copy}
          </p>

          {hasLessons ? (
            <div className="space-y-3">
              {module.lessons?.map(lesson => (
                <LessonCard key={lesson.id} lesson={lesson} moduleSlug={module.slug} />
              ))}
            </div>
          ) : (
            <div className="text-center py-8 text-stone-400">
              <p className="mb-2">Content coming soon</p>
              <p className="text-sm">This exploration is being crafted with care.</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

interface LessonCardProps {
  lesson: Lesson;
  moduleSlug: string;
}

function LessonCard({ lesson, moduleSlug }: LessonCardProps) {
  const { isExplored } = useProgress();
  const explored = isExplored(lesson.id);

  return (
    <Link
      to={`/explore/${moduleSlug}/${lesson.slug}`}
      className={`block p-5 rounded-xl border transition-all group ${
        explored
          ? 'bg-amber-50/50 border-amber-200/50 hover:border-amber-300'
          : 'bg-stone-50 border-stone-200 hover:border-stone-300 hover:bg-stone-100/50'
      }`}
    >
      <div className="flex items-start justify-between gap-4">
        <div className="flex-1">
          <div className="flex items-center gap-2 mb-1">
            <h3 className="font-medium text-stone-800 group-hover:text-stone-900 transition-colors">
              {lesson.title}
            </h3>
            {explored && (
              <span className="text-xs text-amber-600 bg-amber-100 px-2 py-0.5 rounded-full">
                explored
              </span>
            )}
          </div>
          <p className="text-sm text-stone-600">
            {lesson.promise}
          </p>
        </div>
        <div className="flex items-center gap-1 text-xs text-stone-400 flex-shrink-0">
          <Clock className="w-3 h-3" />
          <span>{lesson.time_estimate}</span>
        </div>
      </div>
    </Link>
  );
}

function ProgressRing({ progress, isComplete }: { progress: number; isComplete: boolean }) {
  const radius = 12;
  const circumference = 2 * Math.PI * radius;
  const strokeDashoffset = circumference - (progress * circumference);

  return (
    <div className="relative w-8 h-8">
      <svg className="w-8 h-8 transform -rotate-90" viewBox="0 0 32 32">
        <circle
          cx="16"
          cy="16"
          r={radius}
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          className="text-stone-200"
        />
        <circle
          cx="16"
          cy="16"
          r={radius}
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          strokeDasharray={circumference}
          strokeDashoffset={strokeDashoffset}
          strokeLinecap="round"
          className={`transition-all duration-500 ${isComplete ? 'text-amber-500' : 'text-stone-400'}`}
        />
      </svg>
      {isComplete && (
        <div className="absolute inset-0 flex items-center justify-center">
          <Sparkles className="w-3 h-3 text-amber-500" />
        </div>
      )}
    </div>
  );
}
