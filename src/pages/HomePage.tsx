import { Link } from 'react-router-dom';
import { ArrowRight, Sparkles } from 'lucide-react';

export function HomePage() {
  return (
    <div className="min-h-screen flex flex-col">
      <section className="flex-1 flex items-center justify-center px-6 py-24">
        <div className="max-w-2xl mx-auto text-center">
          <div className="inline-flex items-center gap-2 px-4 py-2 bg-amber-50 text-amber-700 rounded-full text-sm mb-8">
            <Sparkles className="w-4 h-4" />
            <span>No math required. Curiosity is enough.</span>
          </div>

          <h1 className="text-4xl md:text-5xl lg:text-6xl font-light text-stone-800 leading-tight mb-6 tracking-tight">
            The universe is stranger
            <br />
            <span className="text-stone-500">than it has any right to be</span>
          </h1>

          <p className="text-lg md:text-xl text-stone-600 leading-relaxed mb-12 max-w-xl mx-auto">
            These ideas once seemed impossible. Then curious people asked questions
            that changed everything. This is an invitation to explore what they found.
          </p>

          <Link
            to="/explore"
            className="inline-flex items-center gap-3 px-8 py-4 bg-stone-800 text-stone-50 rounded-full text-lg hover:bg-stone-700 transition-all hover:gap-4 group"
          >
            <span>Begin exploring</span>
            <ArrowRight className="w-5 h-5 transition-transform group-hover:translate-x-1" />
          </Link>
        </div>
      </section>

      <section className="px-6 py-24 bg-stone-100/50">
        <div className="max-w-4xl mx-auto">
          <h2 className="text-2xl font-light text-stone-700 text-center mb-16">
            What you'll discover
          </h2>

          <DiscoverySection title="The Rules of Motion">
            <DiscoveryCard
              title="Everything keeps moving"
              description="Newton discovered that motion is natural—stopping is the weird part. Objects don't need pushing to keep going."
              href="/explore/why-do-things-move/the-world-in-motion"
            />
            <DiscoveryCard
              title="Energy never dies"
              description="It transforms. It flows. But it never disappears. This simple truth took centuries to discover."
              href="/explore/what-is-energy-really/the-conservation-revelation"
            />
            <DiscoveryCard
              title="Every push pushes back"
              description="Try to push yourself on ice. You can't move forward without pushing something backward."
              href="/explore/why-cant-you-push-yourself/action-and-reaction"
            />
            <DiscoveryCard
              title="Heavy and light fall together"
              description="Drop a feather and a hammer in a vacuum. They hit the ground at the same instant."
              href="/explore/why-do-things-fall-the-same-way/galileos-revolutionary-experiment"
            />
          </DiscoverySection>

          <DiscoverySection title="The Shape of Reality">
            <DiscoveryCard
              title="Time bends"
              description="Einstein showed that time passes differently depending on how fast you move. Not metaphorically. Actually."
              href="/explore/is-time-the-same-for-everyone/when-everyone-thought-time-was-absolute"
            />
            <DiscoveryCard
              title="Space curves"
              description="Gravity isn't a force pulling you down. It's the shape of space itself, curved by mass."
              href="/explore/what-is-space-made-of/the-fabric-we-cant-see"
            />
          </DiscoverySection>

          <DiscoverySection title="The Quantum World">
            <DiscoveryCard
              title="Reality is fuzzy"
              description="At the smallest scales, particles don't have definite positions until observed. Uncertainty is built into nature."
              href="/explore/why-does-reality-feel-random/the-world-before-quantum-mechanics"
            />
            <DiscoveryCard
              title="Possibility computes"
              description="Quantum computers don't just calculate faster—they think in a fundamentally different way."
              href="/explore/can-we-compute-with-uncertainty/the-limits-of-classical-computers"
            />
          </DiscoverySection>

          <GoingDeeperSection>
            <DiscoveryCard
              title="Nature is lazy"
              description="Light takes the fastest path. Planets follow the smoothest curves. The universe is remarkably efficient."
              href="/explore/the-lazy-universe/natures-optimization"
              subtle
            />
            <DiscoveryCard
              title="Symmetry runs everything"
              description="Emmy Noether proved the deepest truth in physics: every conservation law is a hidden symmetry of the universe."
              href="/explore/why-does-symmetry-matter/the-hidden-pattern"
              subtle
            />
            <DiscoveryCard
              title="Time has a direction"
              description="You can't unscramble an egg. But why? The laws of physics work perfectly in reverse—yet time only flows one way."
              href="/explore/why-does-time-only-flow-forward/the-mystery-of-times-arrow"
              subtle
            />
            <DiscoveryCard
              title="Everything connects"
              description="Einstein called it 'spooky action at a distance.' Measure one particle, and another instantly knows—no matter how far apart."
              href="/explore/how-can-things-be-connected-instantly/einsteins-spooky-action"
              subtle
            />
          </GoingDeeperSection>
        </div>
      </section>

      <section className="px-6 py-24">
        <div className="max-w-2xl mx-auto text-center">
          <h2 className="text-2xl md:text-3xl font-light text-stone-700 mb-6">
            This is not a course
          </h2>
          <p className="text-stone-600 leading-relaxed mb-4">
            There are no tests. No grades. No deadlines. No prerequisites.
          </p>
          <p className="text-stone-600 leading-relaxed mb-8">
            Each exploration is self-contained. Leave and return whenever you like.
            The only requirement is curiosity.
          </p>
          <p className="text-stone-500 text-sm italic">
            If physics ever felt intimidating, this is a good place to start.
          </p>
        </div>
      </section>

      <footer className="px-6 py-12 border-t border-stone-200">
        <div className="max-w-4xl mx-auto text-center text-stone-500 text-sm">
          <p>
            These ideas reshaped how humans understand reality.
            <br />
            You're allowed to explore them.
          </p>
        </div>
      </footer>
    </div>
  );
}

function DiscoverySection({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="mb-14">
      <h3 className="text-xs text-stone-400 uppercase tracking-widest mb-6 text-center">
        {title}
      </h3>
      <div className="grid md:grid-cols-2 gap-6">
        {children}
      </div>
    </div>
  );
}

function GoingDeeperSection({ children }: { children: React.ReactNode }) {
  return (
    <div className="mt-16 pt-12 border-t border-stone-200/60">
      <div className="text-center mb-8">
        <h3 className="text-xs text-stone-400 uppercase tracking-widest mb-2">
          Going Deeper
        </h3>
        <p className="text-sm text-stone-400 italic">
          For the especially curious
        </p>
      </div>
      <div className="grid md:grid-cols-2 gap-6 max-w-lg mx-auto md:max-w-none">
        {children}
      </div>
    </div>
  );
}

function DiscoveryCard({
  title,
  description,
  href,
  subtle = false
}: {
  title: string;
  description: string;
  href: string;
  subtle?: boolean;
}) {
  return (
    <Link
      to={href}
      className={`block p-6 rounded-2xl border transition-all group cursor-pointer ${
        subtle
          ? 'bg-stone-50/50 border-stone-200/50 hover:border-stone-300 hover:bg-white hover:shadow-sm'
          : 'bg-white border-stone-200/80 hover:border-stone-400 hover:shadow-md'
      }`}
    >
      <h3 className={`text-lg font-medium mb-2 group-hover:text-stone-900 ${
        subtle ? 'text-stone-700' : 'text-stone-800'
      }`}>
        {title}
      </h3>
      <p className={`leading-relaxed ${subtle ? 'text-stone-500' : 'text-stone-600'}`}>
        {description}
      </p>
      <span className={`inline-block mt-4 text-sm transition-colors ${
        subtle
          ? 'text-stone-300 group-hover:text-stone-500'
          : 'text-stone-400 group-hover:text-stone-600'
      }`}>
        Begin exploring →
      </span>
    </Link>
  );
}
