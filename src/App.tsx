import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { ProgressProvider } from './context/ProgressContext';
import { Layout } from './components/Layout';
import { ScrollToTop } from './components/ScrollToTop';
import { HomePage } from './pages/HomePage';
import { ExplorePage } from './pages/ExplorePage';
import { LessonPage } from './pages/LessonPage';
import { DiscoveriesPage } from './pages/DiscoveriesPage';

function App() {
  return (
    <BrowserRouter>
      <ScrollToTop />
      <ProgressProvider>
        <Layout>
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/explore" element={<ExplorePage />} />
            <Route path="/explore/:moduleSlug/:lessonSlug" element={<LessonPage />} />
            <Route path="/discoveries" element={<DiscoveriesPage />} />
          </Routes>
        </Layout>
      </ProgressProvider>
    </BrowserRouter>
  );
}

export default App;
