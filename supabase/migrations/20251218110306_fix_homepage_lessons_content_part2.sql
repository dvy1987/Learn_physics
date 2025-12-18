/*
  # Fix Homepage-Linked Lessons Content (Part 2 of 3)

  This migration continues fixing homepage-linked lessons.

  1. Lessons Updated (Part 2)
    - When Everyone Thought Time Was Absolute (4 exercises)
    - The Fabric We Can't See (4 exercises)
    - The World Before Quantum Mechanics (4 exercises)
    - The Limits of Classical Computers (4 exercises)
*/

-- Lesson 5: When Everyone Thought Time Was Absolute
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Quick question: is a second in New York the same as a second in Tokyo? On Mars? In a moving spaceship? For thousands of years, the answer seemed so obviously yes that it barely needed asking.',
  'human_context', E'Newton built his entire physics on the idea of absolute time: "Absolute, true, and mathematical time, of itself, and from its own nature, flows equably without regard to anything external."\n\nWhat he meant: there''s a universal clock. Everyone, everywhere, no matter how they''re moving, experiences the same flow of time. Events that are simultaneous for one person are simultaneous for everyone.\n\nThis made intuitive sense. We can synchronize clocks. We can agree on what "now" means. Time seemed like the one fixed backdrop against which everything else happened.',
  'concept_reveal', E'Einstein asked a deceptively simple question: How do you actually synchronize two clocks that are far apart?\n\nYou might say: send a light signal from one to the other. But light takes time to travel. How do you account for that delay? You need to know the distance and the speed of light. But measuring distance requires synchronized clocks. You''re stuck in a loop.\n\nEinstein realized the whole idea of absolute simultaneity—of a universal "now"—was built on an assumption we couldn''t actually verify. And when he worked through the mathematics carefully, treating the speed of light as the fundamental constant, absolute time fell apart.\n\nTime isn''t a fixed backdrop. It''s relative. It passes at different rates for different observers, depending on their motion.',
  'insight_moment', 'There is no universal clock. Time is personal.',
  'reflection_prompt', 'Think about how we measure time—with clocks, with the motion of planets, with atomic vibrations. What if all these processes can run at different rates for different observers? Time isn''t something we discover; it''s something we measure. And measurements can disagree.',
  'forward_motion', 'If time isn''t absolute, what made Einstein realize this? There was a paradox about light that forced his hand.'
)
WHERE slug = 'when-everyone-thought-time-was-absolute';

-- Add exercises
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 1,
  'Imagine you''re on a train moving at half the speed of light. You shine a flashlight toward the front of the train. How fast is the light moving relative to the ground?',
  'Common sense says add the speeds. But what if light always moves at the same speed, no matter what?',
  'The light moves at exactly the speed of light—not faster. This seems impossible, but it''s what experiments show. If light speed is constant for everyone, something else has to give. That something is time. Time must pass differently for the moving train to make the math work out.'
FROM lessons WHERE slug = 'when-everyone-thought-time-was-absolute'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 2,
  'Have you ever watched a video call with someone on the other side of the world and noticed a slight delay? That''s light speed lag. But does that delay mean "now" is different for you and them?',
  'The delay is about information traveling, not about time itself running differently.',
  'At everyday speeds and distances, time dilation is so tiny it''s irrelevant. The delay you see in video calls is just the time light takes to travel—both of you are experiencing time at essentially the same rate. Time dilation only becomes noticeable at extreme speeds or near massive objects.'
FROM lessons WHERE slug = 'when-everyone-thought-time-was-absolute'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 3,
  'Two events happen: Event A is lightning striking in New York, and Event B is lightning striking in Los Angeles. You see them as simultaneous. Your friend is flying overhead in a fast plane. Could they see Event A happen before Event B?',
  'If there''s no absolute time, maybe "simultaneous" isn''t universal.',
  'Yes—they might see A before B, or B before A, depending on their direction and speed. Simultaneity is relative. Events that are "at the same time" for you might not be "at the same time" for someone moving relative to you. There''s no universal "now."'
FROM lessons WHERE slug = 'when-everyone-thought-time-was-absolute'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 4,
  'Why does it feel like time is absolute? Why does our intuition tell us everyone experiences the same "now"?',
  'Think about the speeds we experience in everyday life compared to the speed of light.',
  'We move slowly compared to light speed. At everyday speeds, time dilation is real but minuscule—differences of nanoseconds. Our brains evolved in a slow-moving world, so we developed intuitions for absolute time. Those intuitions work fine for survival, but they''re approximations that break down at high speeds.'
FROM lessons WHERE slug = 'when-everyone-thought-time-was-absolute'
ON CONFLICT DO NOTHING;

-- Lesson 6: The Fabric We Can't See
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Newton''s gravity was incredibly successful. It predicted planetary motions, explained tides, let us calculate orbits. But Newton himself admitted something troubling: he had no idea how it actually worked.',
  'human_context', E'How does the Sun "know" where Earth is? They''re separated by 93 million miles of empty space. Yet somehow gravity reaches across that void, instantly, pulling Earth into its orbit.\n\nNewton called this "action at a distance" and found it philosophically absurd. In a letter to a colleague, he wrote that the idea of gravity acting across empty space was "so great an absurdity that no man who has any competence in philosophical matters can ever fall into it."\n\nBut his equations worked, so physicists used them for centuries. How gravity worked was a mystery for another genius to solve.',
  'concept_reveal', E'Einstein had a radically different idea: gravity isn''t a force at all. It''s geometry.\n\nSpace isn''t empty nothingness—it''s a thing, a fabric that can bend and curve. Mass curves this fabric. Objects follow the curves. What we call "falling" is actually moving in a straight line through curved space.\n\nPicture a trampoline. Place a bowling ball in the center—it creates a dip. Roll a marble nearby, and it curves toward the bowling ball, not because the bowling ball is pulling it, but because it''s following the curved surface.\n\nThat''s roughly how gravity works. The Sun warps spacetime around it. Earth isn''t being pulled—it''s following the straightest possible path through curved spacetime. That path happens to be an orbit.',
  'insight_moment', 'Gravity isn''t a force pulling you down. It''s the shape of spacetime itself.',
  'reflection_prompt', 'Imagine you''re an ant walking on a sphere. You try to walk in a straight line, but you end up going in a circle around the sphere. That''s what Earth is doing around the Sun—following a straight line through curved space.',
  'forward_motion', 'If mass curves spacetime, what evidence do we have that this is actually what''s happening?'
)
WHERE slug = 'the-fabric-we-cant-see';

-- Add exercises
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 1,
  'If you drop a ball, it falls down. General relativity says it''s actually moving in a straight line through curved spacetime. How can falling down be straight?',
  'Think about what "straight" means. It means the shortest path between two points.',
  'In curved spacetime, the shortest path through space and time is what looks like "falling" to us. The ball isn''t being pulled—it''s taking the straightest possible route through geometry that''s been curved by Earth''s mass. "Down" is just the direction spacetime curves.'
FROM lessons WHERE slug = 'the-fabric-we-cant-see'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 2,
  'When you''re in an airplane cruising smoothly, you don''t feel like you''re moving. But if the plane turns or changes speed, you feel it immediately. Why?',
  'What''s the difference between constant motion and changing motion?',
  'Constant straight-line motion feels like rest—it''s also straight through spacetime. But turning or accelerating means your path through spacetime is curving. You feel forces when your trajectory bends. This is why astronauts in orbit feel weightless—they''re in free fall, following a straight path through curved spacetime.'
FROM lessons WHERE slug = 'the-fabric-we-cant-see'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 3,
  'Imagine spacetime is like a rubber sheet. Place a heavy ball (the Sun) in the center. Now roll a small marble (Earth) nearby. What happens?',
  'The sheet is curved by the heavy ball. The marble moves on this curved surface.',
  'The marble curves around the heavy ball—just like Earth orbits the Sun. This is a limited analogy (real spacetime has four dimensions, not two), but it captures the key idea: mass warps geometry, and objects follow the warped paths. No invisible force required.'
FROM lessons WHERE slug = 'the-fabric-we-cant-see'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 4,
  'Have you ever watched an object orbit in a video—a satellite around Earth, or a planet around the Sun? It looks like something is pulling it inward. But what if nothing is pulling?',
  'What if the object is actually moving straight, and space itself is curved?',
  'The object is trying to move straight. But "straight through curved spacetime" looks like an orbit to us. It''s like drawing a "straight line" on a globe—you end up with a circle. The object feels no force. From its perspective, it''s floating freely. We see curvature; it experiences none.'
FROM lessons WHERE slug = 'the-fabric-we-cant-see'
ON CONFLICT DO NOTHING;

-- Lesson 7: The World Before Quantum Mechanics
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'By 1900, physics seemed nearly complete. Newton''s laws explained motion. Maxwell''s equations explained light and electromagnetism. Scientists were confident: just a few details left to clean up. Then they looked at atoms.',
  'human_context', E'The first cracks appeared in seemingly small problems. Hot objects glowed—but they glowed the wrong colors according to classical physics. Classical theory predicted infinite energy at high frequencies, which was obviously wrong.\n\nThen there were atoms. Electrons orbit nuclei like planets orbit the Sun, right? But orbiting charges should radiate energy continuously, causing electrons to spiral into the nucleus in a fraction of a second. Every atom should collapse instantly. Yet atoms were stable.\n\nSomething was deeply wrong. The old rules didn''t work at small scales.',
  'concept_reveal', E'Max Planck, trying to fix the color problem, made a desperate move: what if energy doesn''t flow continuously? What if it comes in discrete chunks—quanta?\n\nIt was a mathematical trick at first. It worked, but Planck thought it was temporary—eventually someone would find the real classical explanation. They never did.\n\nEinstein took it further. Light, he said, isn''t just a wave—it''s also made of particles (photons), each carrying a quantum of energy. Bohr applied this to atoms: electrons can''t orbit at any distance. Only certain specific orbits are allowed. Energy is quantized.\n\nThe universe, at its smallest scales, is digital, not analog. Things come in discrete amounts. This tiny realization shattered classical physics.',
  'insight_moment', 'The universe doesn''t flow smoothly—it clicks, like frames in a film.',
  'reflection_prompt', 'Think about digital music. It''s not a continuous sound wave—it''s thousands of samples per second, discrete numbers. Play them fast enough and your ear hears continuous sound. Quantum mechanics says reality is like that: discrete at bottom, continuous only in appearance.',
  'forward_motion', 'If energy is quantized, what does that mean for how particles behave? The experiments got stranger.'
)
WHERE slug = 'the-world-before-quantum-mechanics';

-- Add exercises
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 1,
  'Imagine you could only walk in 1-foot steps—never shorter, never longer. Every movement is exactly 1 foot or 2 feet or 3 feet, but nothing in between. How would that feel different from normal walking?',
  'This is what "quantized" means—only discrete values allowed, no smooth transitions.',
  'This is how electrons behave around atoms. They can be at certain energy levels, but never between them. When they change levels, they jump instantly—no smooth transition. It''s as if the universe has a minimum step size for certain properties.'
FROM lessons WHERE slug = 'the-world-before-quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 2,
  'Have you noticed that light from a candle is yellow-orange, while light from the blue sky is... well, blue? Classical physics couldn''t explain why hot things glow specific colors.',
  'The color depends on temperature, but classical physics predicted all temperatures would produce infinite ultraviolet light.',
  'Planck solved this by saying light energy comes in discrete packets (quanta). The amount of energy in each packet depends on the frequency (color). This naturally explained why hot objects glow certain colors—and why they don''t produce infinite ultraviolet. The quantum nature of light was the first hint that reality is fundamentally grainy.'
FROM lessons WHERE slug = 'the-world-before-quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 3,
  'Classical physics says an orbiting electron should radiate energy and spiral into the nucleus in a tiny fraction of a second. But you''re made of atoms, and you''ve existed for years. Why didn''t you collapse?',
  'Something is preventing electrons from radiating energy continuously.',
  'Electrons in atoms can only exist at specific energy levels. They can''t spiral gradually—there''s no "in between." They can jump from one level to another by absorbing or emitting a photon, but they can''t exist between levels. This quantization saves atoms from collapsing. Without quantum mechanics, matter wouldn''t be stable.'
FROM lessons WHERE slug = 'the-world-before-quantum-mechanics'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 4,
  'Think about a light dimmer switch. You gradually turn it, and the light smoothly gets brighter or dimmer. But at the quantum level, what''s really happening?',
  'The light is made of photons—discrete particles.',
  'The dimmer changes how many photons per second are emitted. Brighter means more photons, dimmer means fewer. Each individual photon has the same energy (same color). The smooth brightness you see is an average over billions of quantum events per second. Smooth macroscopic behavior emerges from grainy quantum reality.'
FROM lessons WHERE slug = 'the-world-before-quantum-mechanics'
ON CONFLICT DO NOTHING;

-- Lesson 8: The Limits of Classical Computers
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Your laptop is astonishingly powerful. It can do billions of calculations per second. But there are problems—not hard problems, but fundamentally impossible problems—that would take longer than the age of the universe to solve. No amount of better chips helps.',
  'human_context', E'Richard Feynman, in 1982, was thinking about simulating physics on computers. To simulate 50 quantum particles perfectly, you''d need to track all their possible states simultaneously.\n\nHow many states? About 10^15 (a million billion). Your computer would need more memory than there are atoms in the observable universe. Want to simulate 100 particles? Now you''re at 10^30 states. It gets exponentially worse.\n\nAnd it''s not just quantum simulation. Factoring large numbers—breaking them into prime components—takes exponential time. A 300-digit number would take all the world''s computers millions of years to factor.',
  'concept_reveal', E'Feynman had an audacious idea: What if we built computers that work like quantum systems? Instead of fighting quantum behavior, harness it.\n\nA classical computer uses bits: 0 or 1. Clear, definite. A quantum computer uses qubits: 0, 1, or any combination of both simultaneously. This is superposition.\n\nTwo classical bits represent one of four states. Two qubits in superposition represent all four states at once. Add more qubits, and the number of simultaneous states explodes exponentially.\n\nA quantum computer doesn''t try possibilities one by one. It computes on all possibilities simultaneously, using quantum interference to amplify right answers and cancel wrong ones.',
  'insight_moment', 'Classical computers think in sequence. Quantum computers think in parallel—across all possibilities at once.',
  'reflection_prompt', 'Imagine searching for a needle in a haystack. A classical computer checks each piece of hay one by one. A quantum computer, in a sense, checks all pieces simultaneously. That''s the power—and the weirdness.',
  'forward_motion', 'If qubits can be in superposition, how do we actually use that for computation?'
)
WHERE slug = 'the-limits-of-classical-computers';

-- Add exercises
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 1,
  'Imagine you have a maze with 1,000 possible paths. You want to find the one path that leads to the exit. How long does it take a classical computer?',
  'It has to try paths one at a time (or maybe several in parallel, but still a tiny fraction of the total).',
  'In the worst case, it might need to try all 1,000 paths. If you double the size of the maze, you double the time needed. This is linear scaling. Some problems are much worse—exponential scaling, where doubling the problem size squares the time needed (or worse). Those problems quickly become impossible.'
FROM lessons WHERE slug = 'the-limits-of-classical-computers'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 2,
  'When you use a password, you trust that it''s hard for someone to guess. Why? If computers are so fast, why can''t they just try every possible password?',
  'Think about how many possible passwords exist. How long would it take to try them all?',
  'A 10-character password with letters, numbers, and symbols has about 70^10 ≈ 282 trillion possibilities. Even at a billion tries per second, that''s days or weeks. A 20-character password? Trillions of trillions of years. Exponential growth protects you. But quantum computers might change this calculus.'
FROM lessons WHERE slug = 'the-limits-of-classical-computers'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 3,
  'You want to simulate 10 coins flipping. Each coin can be heads or tails. To track all possibilities, how many states do you need to track?',
  '2 options per coin, 10 coins. It multiplies.',
  '2^10 = 1,024 states. Now imagine simulating 100 coins: 2^100 ≈ 10^30 states. Classical computers can''t track this—there isn''t enough memory in the universe. But a quantum system with 100 qubits naturally exists in superposition of all those states. Quantum systems are exponentially larger than classical descriptions of them.'
FROM lessons WHERE slug = 'the-limits-of-classical-computers'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 4,
  'Have you ever played a game where you try to find the optimal strategy? Like chess, or finding the shortest route through many cities? These seem different from password cracking, but they share a problem.',
  'What do they have in common? The number of possibilities you need to check.',
  'They''re all exponentially hard. Chess has about 10^120 possible games—more than atoms in the universe. The shortest route through 20 cities? About 10^18 possibilities. Classical computers can use clever tricks to approximate solutions, but exact answers for large versions become impossible. Quantum computers might help with some of these, but not all.'
FROM lessons WHERE slug = 'the-limits-of-classical-computers'
ON CONFLICT DO NOTHING;
