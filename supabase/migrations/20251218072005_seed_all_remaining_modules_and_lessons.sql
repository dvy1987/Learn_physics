/*
  # Seed All Remaining Modules and Lessons

  This migration adds comprehensive content for all topics referenced on the homepage.

  1. New Level 1 (Foundations) Modules - "The Shape of Reality"
    - `is-time-the-same-for-everyone` - Special Relativity (Einstein, 1905)
    - `what-is-space-made-of` - General Relativity (Einstein, 1915)

  2. New Level 1 (Foundations) Modules - "The Quantum World"
    - `why-does-reality-feel-random` - Quantum Mechanics (1920s)
    - `can-we-compute-with-uncertainty` - Quantum Computing (Feynman 1982, Shor 1994)

  3. New Level 2 (Going Deeper) Modules
    - `why-does-symmetry-matter` - Noether's Theorem (1918)
    - `why-does-time-only-flow-forward` - Entropy and Arrow of Time (Boltzmann, 1870s)
    - `how-can-things-be-connected-instantly` - Quantum Entanglement (EPR 1935, Bell 1964)

  4. Each module includes 3 lessons with full content and historical context
*/

-- Insert new modules
INSERT INTO modules (slug, title, description, intro_copy, order_index, level, level_label)
VALUES 
  (
    'is-time-the-same-for-everyone',
    'Is Time the Same for Everyone?',
    'Einstein''s mind-bending discovery about time and motion.',
    'We think of time as universal—a second is a second, everywhere, for everyone. Einstein proved this intuition catastrophically wrong. Time passes at different rates depending on how fast you move. This isn''t science fiction; it''s measured every day in GPS satellites.',
    5,
    1,
    'Foundations'
  ),
  (
    'what-is-space-made-of',
    'What Is Space Made Of?',
    'The invisible fabric that shapes the cosmos.',
    'Newton thought space was a fixed stage where physics happens. Einstein showed space is more like a fabric—one that can stretch, curve, and ripple. Mass tells space how to curve; curved space tells mass how to move. This is gravity, reimagined.',
    6,
    1,
    'Foundations'
  ),
  (
    'why-does-reality-feel-random',
    'Why Does Reality Feel Random?',
    'The quantum revolution that shattered certainty.',
    'At the atomic scale, the universe plays dice. Particles don''t have definite positions until you look. Electrons can be in two places at once. This isn''t philosophical hand-waving—it''s the most precisely tested theory in all of science.',
    7,
    1,
    'Foundations'
  ),
  (
    'can-we-compute-with-uncertainty',
    'Can We Compute With Uncertainty?',
    'How quantum weirdness becomes computational power.',
    'Classical computers think in certainties: 0 or 1, yes or no. Quantum computers think in possibilities—superpositions of all answers at once. This isn''t just faster computing; it''s a fundamentally different way of processing information.',
    8,
    1,
    'Foundations'
  ),
  (
    'why-does-symmetry-matter',
    'Why Does Symmetry Matter?',
    'The deepest connection in physics, discovered by Emmy Noether.',
    'Why is energy conserved? Why is momentum conserved? For centuries, these seemed like separate mysteries. Emmy Noether proved they''re all connected by symmetry. Every conservation law reflects a symmetry of the universe. This insight transformed physics.',
    14,
    2,
    'Going Deeper'
  ),
  (
    'why-does-time-only-flow-forward',
    'Why Does Time Only Flow Forward?',
    'The puzzle of entropy and the arrow of time.',
    'The laws of physics work perfectly in reverse. Drop a ball, and it bounces. The reverse—a ball spontaneously bouncing higher—is physically possible. Yet we never see it. Why does time have a direction? The answer involves entropy, probability, and the very birth of the universe.',
    15,
    2,
    'Going Deeper'
  ),
  (
    'how-can-things-be-connected-instantly',
    'How Can Things Be Connected Instantly?',
    'Quantum entanglement—spooky action at a distance.',
    'Einstein thought he found a flaw in quantum mechanics. Two particles, once entangled, seem to communicate instantly across any distance. He called it "spooky action at a distance" and believed it proved quantum mechanics incomplete. He was wrong—nature really is that strange.',
    16,
    2,
    'Going Deeper'
  )
ON CONFLICT (slug) DO NOTHING;

-- Insert lessons for all new modules
DO $$
DECLARE
  mod_time_relativity uuid;
  mod_space_curved uuid;
  mod_quantum_random uuid;
  mod_quantum_computing uuid;
  mod_symmetry uuid;
  mod_arrow_time uuid;
  mod_entanglement uuid;
BEGIN
  SELECT id INTO mod_time_relativity FROM modules WHERE slug = 'is-time-the-same-for-everyone';
  SELECT id INTO mod_space_curved FROM modules WHERE slug = 'what-is-space-made-of';
  SELECT id INTO mod_quantum_random FROM modules WHERE slug = 'why-does-reality-feel-random';
  SELECT id INTO mod_quantum_computing FROM modules WHERE slug = 'can-we-compute-with-uncertainty';
  SELECT id INTO mod_symmetry FROM modules WHERE slug = 'why-does-symmetry-matter';
  SELECT id INTO mod_arrow_time FROM modules WHERE slug = 'why-does-time-only-flow-forward';
  SELECT id INTO mod_entanglement FROM modules WHERE slug = 'how-can-things-be-connected-instantly';

  -- Lessons for "Is Time the Same for Everyone?" (Special Relativity)
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_time_relativity,
      'when-everyone-thought-time-was-absolute',
      'When Everyone Thought Time Was Absolute',
      'The reasonable assumption that turned out to be wrong.',
      '~5 min',
      1,
      '{"discovery_year": 1905, "key_figures": ["Albert Einstein", "Hendrik Lorentz", "Henri Poincaré"], "breakthrough_description": "Einstein''s special relativity showed that time is not absolute—it passes at different rates for observers in relative motion.", "original_work": "On the Electrodynamics of Moving Bodies (1905)"}',
      '{"sections": [{"type": "intro", "content": "For thousands of years, humans assumed time was universal. A second in New York is a second in Tokyo is a second on Mars. This seemed so obvious it barely needed stating."}, {"type": "text", "content": "Newton built his entire physics on this assumption. Time was a fixed background against which events unfolded—absolute, true, and mathematical time, which flows equably without regard to anything external."}, {"type": "insight", "content": "Einstein asked a deceptively simple question: how do we actually synchronize clocks that are far apart? The answer forced him to abandon absolute time entirely."}]}'
    ),
    (
      mod_time_relativity,
      'the-speed-of-light-paradox',
      'The Speed of Light Paradox',
      'The strange fact that led Einstein to his breakthrough.',
      '~6 min',
      2,
      '{"discovery_year": 1905, "key_figures": ["Albert Einstein", "James Clerk Maxwell"], "breakthrough_description": "Maxwell''s equations predicted light always travels at the same speed—regardless of how the observer moves. Einstein took this paradox seriously.", "original_work": "A Dynamical Theory of the Electromagnetic Field (Maxwell, 1865)"}',
      '{"sections": [{"type": "intro", "content": "Imagine you''re on a train moving at half the speed of light. You shine a flashlight forward. How fast does the light travel?"}, {"type": "text", "content": "Common sense says: the speed of light plus the speed of the train. But Maxwell''s equations say something shocking: the light travels at exactly the speed of light. Not faster, not slower. The same speed you''d measure if you were standing still."}, {"type": "insight", "content": "Einstein realized that if the speed of light is constant for all observers, something else must give. That something is time itself. Moving clocks run slow."}]}'
    ),
    (
      mod_time_relativity,
      'time-dilation-revealed',
      'Time Dilation Revealed',
      'How motion stretches time—and why it matters.',
      '~7 min',
      3,
      '{"discovery_year": 1905, "key_figures": ["Albert Einstein"], "breakthrough_description": "Einstein derived that time passes more slowly for moving objects—an effect called time dilation, now confirmed by countless experiments.", "original_work": "On the Electrodynamics of Moving Bodies (1905)"}',
      '{"sections": [{"type": "intro", "content": "A clock moving past you runs slow. Not because it''s broken—because time itself passes more slowly for moving objects."}, {"type": "text", "content": "The faster you move, the slower your time passes relative to someone at rest. At 87% the speed of light, time passes at half its normal rate. GPS satellites, orbiting at thousands of miles per hour, experience time slightly slower than clocks on Earth—and must correct for this to stay accurate."}, {"type": "insight", "content": "This isn''t just about clocks. Everything slows down: heartbeats, thoughts, aging. Travel fast enough, and you could return to Earth centuries in the future while having aged only years."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "What Is Space Made Of?" (General Relativity)
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_space_curved,
      'the-fabric-we-cant-see',
      'The Fabric We Can''t See',
      'Why Newton''s gravity was incomplete.',
      '~5 min',
      1,
      '{"discovery_year": 1915, "key_figures": ["Albert Einstein", "David Hilbert"], "breakthrough_description": "Einstein''s general relativity reimagined gravity not as a force, but as the curvature of spacetime caused by mass and energy.", "original_work": "The Field Equations of Gravitation (1915)"}',
      '{"sections": [{"type": "intro", "content": "Newton described gravity as a force that pulls objects together across empty space. It worked beautifully—but Newton himself admitted he had no idea how it actually worked."}, {"type": "text", "content": "How does the Sun ''know'' where Earth is? How does gravity reach across 93 million miles of empty space, instantly? Newton had no answer. He called it ''action at a distance'' and found it philosophically absurd, even though his equations worked."}, {"type": "insight", "content": "Einstein realized gravity isn''t a force at all. It''s geometry. Mass curves the fabric of space and time, and objects follow the curves."}]}'
    ),
    (
      mod_space_curved,
      'mass-bends-spacetime',
      'Mass Bends Spacetime',
      'Visualizing the invisible curvature all around us.',
      '~6 min',
      2,
      '{"discovery_year": 1915, "key_figures": ["Albert Einstein"], "breakthrough_description": "Einstein showed that mass and energy curve spacetime, and this curvature is what we experience as gravity.", "original_work": "The Foundation of the General Theory of Relativity (1916)"}',
      '{"sections": [{"type": "intro", "content": "Imagine a bowling ball on a trampoline. It creates a dip. Roll a marble nearby, and it curves toward the bowling ball—not because of a force, but because of the curved surface."}, {"type": "text", "content": "This is roughly how general relativity works. The Sun warps the spacetime around it. Earth doesn''t feel a ''pull''—it''s following the straightest possible path through curved spacetime. That path happens to be an orbit."}, {"type": "insight", "content": "There is no force of gravity. There''s only geometry. What we call ''falling'' is actually moving in a straight line through curved space."}]}'
    ),
    (
      mod_space_curved,
      'gravity-as-geometry',
      'Gravity as Geometry',
      'Why general relativity predicts things Newton couldn''t.',
      '~7 min',
      3,
      '{"discovery_year": 1919, "key_figures": ["Albert Einstein", "Arthur Eddington"], "breakthrough_description": "Eddington''s eclipse expedition confirmed that starlight bends around the Sun, exactly as Einstein predicted—proving gravity curves space.", "original_work": "A Determination of the Deflection of Light by the Sun''s Gravitational Field (1920)"}',
      '{"sections": [{"type": "intro", "content": "If gravity is geometry, light should bend around massive objects. Einstein calculated exactly how much. In 1919, astronomers tested this during a solar eclipse."}, {"type": "text", "content": "They photographed stars near the Sun''s edge. The stars appeared slightly shifted—their light had bent as it passed through the Sun''s curved spacetime. Einstein was right. Newspapers around the world declared a revolution in physics."}, {"type": "insight", "content": "General relativity also predicts black holes (where spacetime curves infinitely), gravitational waves (ripples in spacetime), and the expanding universe. All confirmed. Newton was good; Einstein was better."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "Why Does Reality Feel Random?" (Quantum Mechanics)
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_quantum_random,
      'the-world-before-quantum-mechanics',
      'The World Before Quantum Mechanics',
      'The crisis that shattered classical physics.',
      '~5 min',
      1,
      '{"discovery_year": 1900, "key_figures": ["Max Planck", "Albert Einstein", "Niels Bohr"], "breakthrough_description": "Planck''s quantum hypothesis (1900) and Einstein''s photon theory (1905) introduced the revolutionary idea that energy comes in discrete packets.", "original_work": "On the Law of Distribution of Energy in the Normal Spectrum (Planck, 1900)"}',
      '{"sections": [{"type": "intro", "content": "By 1900, physicists thought they had almost everything figured out. Newton''s mechanics worked. Maxwell''s electromagnetism worked. What was left?"}, {"type": "text", "content": "Then they looked closely at atoms. Hot objects glowed the wrong colors. Atoms should collapse instantly but didn''t. Light behaved like both a wave and a particle. The classical world was crumbling."}, {"type": "insight", "content": "The fix required something radical: energy doesn''t flow continuously like water. It comes in discrete packets—quanta. This tiny word would change everything."}]}'
    ),
    (
      mod_quantum_random,
      'the-double-slit-experiment',
      'The Double-Slit Experiment',
      'The experiment that proves reality is strange.',
      '~6 min',
      2,
      '{"discovery_year": 1927, "key_figures": ["Thomas Young", "Clinton Davisson", "Lester Germer"], "breakthrough_description": "When particles pass through two slits, they create an interference pattern—showing they behave like waves. But detecting which slit they use destroys the pattern.", "original_work": "Diffraction of Electrons by a Crystal of Nickel (Davisson & Germer, 1927)"}',
      '{"sections": [{"type": "intro", "content": "Fire electrons one at a time through two slits. Where do they land? If electrons were particles, you''d expect two bands. But you get an interference pattern—like waves."}, {"type": "text", "content": "Here''s the strange part: if you set up a detector to see which slit each electron goes through, the interference pattern disappears. The electron ''knows'' when it''s being watched and behaves differently."}, {"type": "insight", "content": "Each electron seems to go through both slits simultaneously, interfering with itself. Only when measured does it ''choose'' a definite path. Observation changes reality."}]}'
    ),
    (
      mod_quantum_random,
      'heisenbergs-uncertainty-principle',
      'Heisenberg''s Uncertainty Principle',
      'Why you can never know everything about a particle.',
      '~7 min',
      3,
      '{"discovery_year": 1927, "key_figures": ["Werner Heisenberg"], "breakthrough_description": "Heisenberg proved that the more precisely you know a particle''s position, the less precisely you can know its momentum—and vice versa. This isn''t a measurement limit; it''s fundamental.", "original_work": "On the Perceptual Content of Quantum Theoretical Kinematics and Mechanics (1927)"}',
      '{"sections": [{"type": "intro", "content": "Want to know exactly where an electron is and exactly how fast it''s moving? You can''t. Not because your instruments are bad—because the universe doesn''t allow it."}, {"type": "text", "content": "Heisenberg showed that position and momentum are fundamentally linked. Measure position precisely, and momentum becomes fuzzy. Measure momentum precisely, and position becomes fuzzy. This isn''t a limitation of technology; it''s woven into reality."}, {"type": "insight", "content": "This means particles don''t have definite properties until measured. Before measurement, an electron doesn''t have a position—it has a cloud of possibilities. Measurement collapses the cloud into a single reality."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "Can We Compute With Uncertainty?" (Quantum Computing)
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_quantum_computing,
      'the-limits-of-classical-computers',
      'The Limits of Classical Computers',
      'Why some problems are impossibly hard.',
      '~5 min',
      1,
      '{"discovery_year": 1982, "key_figures": ["Richard Feynman", "David Deutsch"], "breakthrough_description": "Feynman realized that simulating quantum systems on classical computers requires exponentially growing resources—but quantum computers could do it naturally.", "original_work": "Simulating Physics with Computers (Feynman, 1982)"}',
      '{"sections": [{"type": "intro", "content": "Your laptop is remarkably powerful. But some problems defeat any classical computer, no matter how fast—not in practice, but in principle."}, {"type": "text", "content": "Want to simulate 50 quantum particles? You''d need more memory than atoms in the universe. Want to factor a 1000-digit number? It would take longer than the age of the cosmos. Classical computers hit walls that bigger chips can''t overcome."}, {"type": "insight", "content": "Feynman asked: what if we built computers that work like quantum systems? Instead of fighting quantum weirdness, we could harness it."}]}'
    ),
    (
      mod_quantum_computing,
      'qubits-and-superposition',
      'Qubits and Superposition',
      'How quantum computers think in possibilities.',
      '~6 min',
      2,
      '{"discovery_year": 1985, "key_figures": ["David Deutsch"], "breakthrough_description": "Deutsch formalized quantum computing and showed that quantum parallelism—computing on superpositions of all inputs at once—could outperform classical machines.", "original_work": "Quantum Theory, the Church-Turing Principle and the Universal Quantum Computer (1985)"}',
      '{"sections": [{"type": "intro", "content": "A classical bit is 0 or 1. A qubit can be 0, 1, or any combination of both—simultaneously. This is superposition."}, {"type": "text", "content": "Two classical bits can represent one of four states: 00, 01, 10, or 11. Two qubits in superposition represent all four states at once. Ten qubits represent 1,024 states simultaneously. Fifty qubits? More states than any classical computer can track."}, {"type": "insight", "content": "A quantum computer doesn''t try all possibilities one by one. It computes on all possibilities at once, using interference to amplify correct answers and cancel wrong ones."}]}'
    ),
    (
      mod_quantum_computing,
      'what-quantum-computers-can-do',
      'What Quantum Computers Can Do',
      'The problems quantum computers will transform.',
      '~7 min',
      3,
      '{"discovery_year": 1994, "key_figures": ["Peter Shor", "Lov Grover"], "breakthrough_description": "Shor''s algorithm showed quantum computers could factor large numbers exponentially faster than classical computers—threatening modern cryptography.", "original_work": "Algorithms for Quantum Computation: Discrete Logarithms and Factoring (Shor, 1994)"}',
      '{"sections": [{"type": "intro", "content": "Quantum computers won''t replace your laptop. They''re not better at everything—just certain things. But those things matter enormously."}, {"type": "text", "content": "Shor''s algorithm factors large numbers exponentially faster. This breaks modern encryption, which relies on factoring being hard. Grover''s algorithm searches databases quadratically faster. Quantum simulation could revolutionize drug discovery and materials science."}, {"type": "insight", "content": "We''re still in early days—today''s quantum computers are error-prone and small. But the principles work. Quantum computing isn''t hype; it''s physics."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "Why Does Symmetry Matter?" (Noether's Theorem)
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_symmetry,
      'the-hidden-pattern',
      'The Hidden Pattern',
      'The question that haunted physicists for centuries.',
      '~5 min',
      1,
      '{"discovery_year": 1918, "key_figures": ["Emmy Noether"], "breakthrough_description": "Noether''s theorem revealed that every conservation law in physics corresponds to a symmetry of nature—unifying disparate rules under one principle.", "original_work": "Invariante Variationsprobleme (1918)"}',
      '{"sections": [{"type": "intro", "content": "Energy is conserved. Momentum is conserved. Angular momentum is conserved. These seemed like separate facts, discovered independently. Why are there so many conservation laws?"}, {"type": "text", "content": "For centuries, physicists accepted conservation laws as empirical facts—nature just works that way. But Emmy Noether, a mathematician working in Germany in 1918, discovered something deeper."}, {"type": "insight", "content": "Every conservation law is a hidden symmetry of the universe. They''re not independent facts; they''re all manifestations of one deep principle."}]}'
    ),
    (
      mod_symmetry,
      'symmetry-and-conservation-laws',
      'Symmetry and Conservation Laws',
      'Why unchanged physics means something can''t change.',
      '~6 min',
      2,
      '{"discovery_year": 1918, "key_figures": ["Emmy Noether"], "breakthrough_description": "Noether proved mathematically that continuous symmetries of a physical system generate conserved quantities.", "original_work": "Invariante Variationsprobleme (1918)"}',
      '{"sections": [{"type": "intro", "content": "The laws of physics are the same today as yesterday. They''re the same here as on the other side of the galaxy. They don''t care which direction you''re facing. These symmetries seem obvious—but they have profound consequences."}, {"type": "text", "content": "If physics doesn''t change over time, energy is conserved. If physics doesn''t change from place to place, momentum is conserved. If physics doesn''t change with direction, angular momentum is conserved."}, {"type": "insight", "content": "This is Noether''s theorem: every continuous symmetry implies a conserved quantity. The universe''s symmetries aren''t just elegant—they''re the reason anything is conserved at all."}]}'
    ),
    (
      mod_symmetry,
      'emmy-noethers-legacy',
      'Emmy Noether''s Legacy',
      'The mathematician who transformed physics.',
      '~7 min',
      3,
      '{"discovery_year": 1918, "key_figures": ["Emmy Noether", "David Hilbert", "Albert Einstein"], "breakthrough_description": "Einstein called Noether''s theorem one of the most important mathematical discoveries in the history of science. Hilbert fought to get her a university position despite gender discrimination.", "original_work": "Invariante Variationsprobleme (1918)"}',
      '{"sections": [{"type": "intro", "content": "Emmy Noether wasn''t allowed to formally teach at the University of Göttingen because she was a woman. Her lectures were advertised under a male colleague''s name. Yet she proved one of the deepest theorems in physics."}, {"type": "text", "content": "Einstein wrote that Noether was ''the most significant creative mathematical genius thus far produced since the higher education of women began.'' Her theorem underpins all of modern physics—from particle physics to general relativity."}, {"type": "insight", "content": "Today, when physicists discover a new particle or force, the first question they ask is: what symmetry does it respect? Noether taught us that symmetry isn''t just beauty—it''s the architecture of physical law."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "Why Does Time Only Flow Forward?" (Entropy and Arrow of Time)
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_arrow_time,
      'the-mystery-of-times-arrow',
      'The Mystery of Time''s Arrow',
      'Why physics works in reverse but the universe doesn''t.',
      '~5 min',
      1,
      '{"discovery_year": 1876, "key_figures": ["Ludwig Boltzmann", "Rudolf Clausius"], "breakthrough_description": "Boltzmann connected the macroscopic irreversibility of thermodynamics to the statistical behavior of atoms—explaining why time has a direction.", "original_work": "On the Relation between the Second Law of Thermodynamics and Probability Calculations (1877)"}',
      '{"sections": [{"type": "intro", "content": "Drop a glass and it shatters. You never see shards spontaneously reassemble into a glass. But why? The laws of physics work perfectly well in reverse."}, {"type": "text", "content": "Film a bouncing ball and play it backwards—the physics looks fine. Film a shattering glass backwards—it looks absurd. Yet every collision of every atom in that glass obeys time-reversible laws."}, {"type": "insight", "content": "The mystery isn''t why glasses shatter. It''s why they don''t un-shatter. The laws allow it. The answer lies not in physics, but in statistics."}]}'
    ),
    (
      mod_arrow_time,
      'entropy-and-disorder',
      'Entropy and Disorder',
      'Why messy states are overwhelmingly more common.',
      '~6 min',
      2,
      '{"discovery_year": 1877, "key_figures": ["Ludwig Boltzmann"], "breakthrough_description": "Boltzmann defined entropy in terms of the number of microscopic arrangements that produce the same macroscopic state—explaining the second law statistically.", "original_work": "S = k log W (carved on Boltzmann''s tombstone)"}',
      '{"sections": [{"type": "intro", "content": "Entropy measures disorder—but what does that really mean? It means there are far more ways to be messy than to be organized."}, {"type": "text", "content": "Imagine 100 coins on a table. There''s exactly ONE arrangement where all are heads. But there are billions of billions of arrangements where roughly half are heads and half tails. Randomness doesn''t push you toward disorder—it''s just that disorder is overwhelmingly more probable."}, {"type": "insight", "content": "This is the second law of thermodynamics: entropy tends to increase. Not because there''s a force toward disorder, but because disorder has almost all the probability."}]}'
    ),
    (
      mod_arrow_time,
      'why-you-cant-unscramble-an-egg',
      'Why You Can''t Unscramble an Egg',
      'The statistical trap that creates time''s direction.',
      '~7 min',
      3,
      '{"discovery_year": 1877, "key_figures": ["Ludwig Boltzmann", "J. Willard Gibbs"], "breakthrough_description": "The arrow of time emerges from the overwhelming statistical tendency toward higher-entropy states—not from any time-asymmetric law.", "original_work": "Elementary Principles in Statistical Mechanics (Gibbs, 1902)"}',
      '{"sections": [{"type": "intro", "content": "An egg has a special, organized structure: shell, white, yolk. Scramble it, and that organization is lost. Could it ever spontaneously unscramble?"}, {"type": "text", "content": "Technically, yes. Every molecular collision is reversible. There exists a precise arrangement of scrambled-egg molecules that would, if you could achieve it, spontaneously organize back into shell, white, and yolk. The probability? Roughly 1 divided by more zeros than atoms in the observable universe."}, {"type": "insight", "content": "Time''s arrow isn''t written in the laws of physics—it''s written in the statistics of initial conditions. The universe started in a remarkably low-entropy state. Everything since has been the long, slow slide toward equilibrium."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "How Can Things Be Connected Instantly?" (Quantum Entanglement)
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_entanglement,
      'einsteins-spooky-action',
      'Einstein''s Spooky Action',
      'The phenomenon Einstein refused to accept.',
      '~5 min',
      1,
      '{"discovery_year": 1935, "key_figures": ["Albert Einstein", "Boris Podolsky", "Nathan Rosen"], "breakthrough_description": "The EPR paper argued that quantum mechanics must be incomplete because entanglement seemed to require impossible instantaneous influences.", "original_work": "Can Quantum-Mechanical Description of Physical Reality Be Considered Complete? (1935)"}',
      '{"sections": [{"type": "intro", "content": "Einstein helped create quantum mechanics—then spent decades trying to prove it incomplete. His strongest argument? Entanglement."}, {"type": "text", "content": "Two particles can be ''entangled'' so that measuring one instantly determines the other, no matter how far apart they are. Einstein found this absurd. Nothing can travel faster than light. How could one particle ''know'' what happened to its partner?"}, {"type": "insight", "content": "Einstein, Podolsky, and Rosen published a paper arguing this proved quantum mechanics was missing something—hidden variables that predetermined the outcomes. It took 30 years to test who was right."}]}'
    ),
    (
      mod_entanglement,
      'bells-inequality',
      'Bell''s Inequality',
      'The experiment that proved Einstein wrong.',
      '~6 min',
      2,
      '{"discovery_year": 1964, "key_figures": ["John Bell", "Alain Aspect"], "breakthrough_description": "Bell derived an inequality that any hidden-variable theory must satisfy. Experiments consistently violate it—proving quantum mechanics is irreducibly nonlocal.", "original_work": "On the Einstein Podolsky Rosen Paradox (Bell, 1964)"}',
      '{"sections": [{"type": "intro", "content": "In 1964, physicist John Bell found a way to test Einstein''s hidden variables. He derived an inequality—a mathematical limit on correlations if hidden variables exist."}, {"type": "text", "content": "Quantum mechanics predicts correlations that exceed Bell''s limit. Hidden variable theories can''t. Every experiment since 1982 has confirmed quantum mechanics. Einstein was wrong. Nature really is that strange."}, {"type": "insight", "content": "Entangled particles don''t communicate—that would violate relativity. Instead, their correlations were established when they were created. But those correlations are stronger than any classical explanation allows."}]}'
    ),
    (
      mod_entanglement,
      'what-entanglement-means',
      'What Entanglement Means',
      'The true nature of quantum connections.',
      '~7 min',
      3,
      '{"discovery_year": 2022, "key_figures": ["John Clauser", "Alain Aspect", "Anton Zeilinger"], "breakthrough_description": "The 2022 Nobel Prize recognized experiments with entangled photons, proving Bell inequality violations and establishing quantum information science.", "original_work": "Nobel Prize in Physics 2022"}',
      '{"sections": [{"type": "intro", "content": "Entanglement doesn''t send information faster than light. You can''t use it to communicate instantaneously. So what does it actually mean?"}, {"type": "text", "content": "Entangled particles are not two separate things with a mysterious connection. They''re one quantum system that happens to be spread across space. The ''spooky'' correlations aren''t signals—they''re a single object behaving as a single object."}, {"type": "insight", "content": "Entanglement powers quantum computing, quantum cryptography, and quantum teleportation. It''s not magic—it''s the natural behavior of quantum systems. The strangeness is in our classical intuitions, not in nature."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

END $$;
