import { ReactNode } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Sparkles, Compass, BookOpen } from 'lucide-react';
import { useProgress } from '../context/ProgressContext';

interface LayoutProps {
  children: ReactNode;
}

export function Layout({ children }: LayoutProps) {
  const location = useLocation();
  const { exploredCount } = useProgress();

  return (
    <div className="min-h-screen bg-stone-50">
      <header className="fixed top-0 left-0 right-0 z-50 bg-stone-50/80 backdrop-blur-sm border-b border-stone-200/50">
        <nav className="max-w-4xl mx-auto px-6 py-4 flex items-center justify-between">
          <Link
            to="/"
            className="flex items-center gap-2 text-stone-800 hover:text-stone-600 transition-colors"
          >
            <Sparkles className="w-5 h-5 text-amber-600" />
            <span className="font-medium tracking-tight">Physics as Wonder</span>
          </Link>

          <div className="flex items-center gap-6">
            {exploredCount > 0 && (
              <Link
                to="/discoveries"
                className="flex items-center gap-2 text-sm text-stone-500 hover:text-stone-700 transition-colors"
              >
                <BookOpen className="w-4 h-4" />
                <span className="hidden sm:inline">{exploredCount} {exploredCount === 1 ? 'discovery' : 'discoveries'}</span>
                <span className="sm:hidden">{exploredCount}</span>
              </Link>
            )}

            {location.pathname !== '/explore' && (
              <Link
                to="/explore"
                className="flex items-center gap-2 text-sm text-stone-600 hover:text-stone-800 transition-colors"
              >
                <Compass className="w-4 h-4" />
                <span>Explore</span>
              </Link>
            )}
          </div>
        </nav>
      </header>

      <main className="pt-16">
        {children}
      </main>
    </div>
  );
}
