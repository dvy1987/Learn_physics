/*
  # Add Historical Context to Existing Lessons

  Updates all existing lessons with historical_context JSONB data containing:
  - discovery_year: When the concept was discovered/formulated
  - key_figures: Scientists involved
  - breakthrough_description: Historical significance
  - original_work: Original paper/book if applicable
*/

-- Update lessons in "Is Time the Same for Everyone?" module
UPDATE lessons SET historical_context = '{"discovery_year": 1905, "key_figures": ["Albert Einstein", "Hendrik Lorentz", "Henri Poincaré"], "breakthrough_description": "Before Einstein, physicists assumed absolute time existed throughout the universe. This was the foundation of Newtonian mechanics for over 200 years.", "original_work": "Classical mechanics tradition"}'
WHERE slug = 'when-everyone-thought-time-was-absolute';

UPDATE lessons SET historical_context = '{"discovery_year": 1905, "key_figures": ["Albert Einstein", "James Clerk Maxwell"], "breakthrough_description": "Einstein postulated that the speed of light is constant for all observers, a radical idea that emerged from Maxwell''s equations of electromagnetism.", "original_work": "On the Electrodynamics of Moving Bodies (Einstein, 1905)"}'
WHERE slug = 'the-speed-limit-of-the-universe';

UPDATE lessons SET historical_context = '{"discovery_year": 1905, "key_figures": ["Albert Einstein"], "breakthrough_description": "Time dilation was one of the most startling predictions of special relativity—that moving clocks tick slower. It has since been confirmed by countless experiments.", "original_work": "On the Electrodynamics of Moving Bodies (Einstein, 1905)"}'
WHERE slug = 'time-dilation-without-equations';

-- Update lessons in "Why Does Reality Feel Random?" module
UPDATE lessons SET historical_context = '{"discovery_year": 1687, "key_figures": ["Isaac Newton", "Pierre-Simon Laplace"], "breakthrough_description": "Classical mechanics promised a clockwork universe where, given initial conditions, all future states could be predicted. Laplace''s demon embodied this deterministic dream.", "original_work": "Principia Mathematica (Newton, 1687)"}'
WHERE slug = 'the-world-before-quantum-mechanics';

UPDATE lessons SET historical_context = '{"discovery_year": 1900, "key_figures": ["Max Planck"], "breakthrough_description": "Planck solved the black-body radiation problem by proposing energy comes in discrete packets (quanta), reluctantly launching the quantum revolution.", "original_work": "On the Theory of the Energy Distribution Law of the Normal Spectrum (Planck, 1900)"}'
WHERE slug = 'the-quantum-leap';

UPDATE lessons SET historical_context = '{"discovery_year": 1926, "key_figures": ["Max Born", "Werner Heisenberg", "Erwin Schrödinger"], "breakthrough_description": "Born interpreted the wave function as a probability amplitude, establishing that quantum mechanics only predicts probabilities, not certainties.", "original_work": "Zur Quantenmechanik der Stoßvorgänge (Born, 1926)"}'
WHERE slug = 'probability-as-reality';

-- Update lessons in "What Is Space Made Of?" module
UPDATE lessons SET historical_context = '{"discovery_year": 1915, "key_figures": ["Albert Einstein"], "breakthrough_description": "Einstein''s general relativity revealed that space and time form a dynamic fabric that curves in response to matter and energy.", "original_work": "The Field Equations of Gravitation (Einstein, 1915)"}'
WHERE slug = 'the-fabric-we-cant-see';

UPDATE lessons SET historical_context = '{"discovery_year": 1915, "key_figures": ["Albert Einstein"], "breakthrough_description": "Einstein''s revolutionary insight: gravity is not a force pulling objects together, but the curvature of spacetime itself.", "original_work": "The Foundation of the General Theory of Relativity (Einstein, 1916)"}'
WHERE slug = 'gravity-is-not-a-force';

UPDATE lessons SET historical_context = '{"discovery_year": 2015, "key_figures": ["LIGO Scientific Collaboration", "Kip Thorne", "Rainer Weiss", "Barry Barish"], "breakthrough_description": "After 100 years since Einstein predicted them, gravitational waves were finally detected from two merging black holes 1.3 billion light years away.", "original_work": "Observation of Gravitational Waves from a Binary Black Hole Merger (LIGO, 2016)"}'
WHERE slug = 'spacetime-ripples';

-- Update lessons in "Can We Compute With Uncertainty?" module
UPDATE lessons SET historical_context = '{"discovery_year": 1936, "key_figures": ["Alan Turing", "Alonzo Church"], "breakthrough_description": "Turing defined the theoretical limits of computation, showing that some problems are fundamentally undecidable regardless of computing power.", "original_work": "On Computable Numbers (Turing, 1936)"}'
WHERE slug = 'the-limits-of-classical-computers';

-- Update any quantum computing related lessons
UPDATE lessons SET historical_context = '{"discovery_year": 1981, "key_figures": ["Richard Feynman", "Yuri Manin"], "breakthrough_description": "Feynman proposed that quantum computers could simulate quantum systems exponentially faster than classical computers.", "original_work": "Simulating Physics with Computers (Feynman, 1982)"}'
WHERE slug = 'superposition-as-resource';

UPDATE lessons SET historical_context = '{"discovery_year": 1994, "key_figures": ["Peter Shor"], "breakthrough_description": "Shor''s algorithm showed quantum computers could factor large numbers exponentially faster than any known classical algorithm, threatening modern cryptography.", "original_work": "Algorithms for Quantum Computation (Shor, 1994)"}'
WHERE slug = 'quantum-parallelism';

-- Update black hole lessons
UPDATE lessons SET historical_context = '{"discovery_year": 1916, "key_figures": ["Karl Schwarzschild"], "breakthrough_description": "Schwarzschild solved Einstein''s equations for a spherical mass, discovering the event horizon radius—now called the Schwarzschild radius.", "original_work": "On the Gravitational Field of a Mass Point (Schwarzschild, 1916)"}'
WHERE slug LIKE '%event-horizon%' OR slug LIKE '%black-hole%';

-- Update quantum measurement lessons
UPDATE lessons SET historical_context = '{"discovery_year": 1927, "key_figures": ["Werner Heisenberg", "Niels Bohr"], "breakthrough_description": "Heisenberg showed that certain pairs of properties (like position and momentum) cannot both be known precisely—a fundamental limit, not a measurement problem.", "original_work": "Über den anschaulichen Inhalt der quantentheoretischen Kinematik und Mechanik (Heisenberg, 1927)"}'
WHERE slug LIKE '%observation%' OR slug LIKE '%measurement%';

-- Update gravitational wave lessons
UPDATE lessons SET historical_context = '{"discovery_year": 1916, "key_figures": ["Albert Einstein"], "breakthrough_description": "Einstein predicted that accelerating masses would create ripples in spacetime itself, though he doubted they could ever be detected.", "original_work": "Approximate Integration of the Field Equations of Gravitation (Einstein, 1916)"}'
WHERE slug LIKE '%gravitational-wave%' OR slug LIKE '%spacetime-ripple%';

-- Update spacetime lessons
UPDATE lessons SET historical_context = '{"discovery_year": 1908, "key_figures": ["Hermann Minkowski"], "breakthrough_description": "Minkowski united space and time into a single four-dimensional continuum, declaring ''space by itself, and time by itself, are doomed to fade away.''", "original_work": "Space and Time (Minkowski, 1908)"}'
WHERE slug LIKE '%space-and-time%' OR slug LIKE '%spacetime%';

-- Update quantum interpretation lessons
UPDATE lessons SET historical_context = '{"discovery_year": 1927, "key_figures": ["Niels Bohr", "Werner Heisenberg", "Max Born"], "breakthrough_description": "The Copenhagen interpretation became the orthodox view, though it sparked decades of debate about the nature of quantum reality.", "original_work": "Discussions at the Solvay Conference (1927)"}'
WHERE slug LIKE '%interpretation%';

-- Update lessons about quantum-relativity conflict
UPDATE lessons SET historical_context = '{"discovery_year": 1930, "key_figures": ["Paul Dirac", "Richard Feynman", "Julian Schwinger"], "breakthrough_description": "Attempts to merge quantum mechanics with special relativity led to quantum field theory, but gravity remains stubbornly resistant to quantization.", "original_work": "The Principles of Quantum Mechanics (Dirac, 1930)"}'
WHERE slug LIKE '%relativity-and-quantum%' OR slug LIKE '%conflict%';
