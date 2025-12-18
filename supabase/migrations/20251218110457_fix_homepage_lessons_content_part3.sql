/*
  # Fix Homepage-Linked Lessons Content (Part 3 of 3)

  This migration completes the homepage-linked lessons.

  1. Lessons Updated (Part 3 - Going Deeper section)
    - Nature's Optimization (4 exercises)
    - The Hidden Pattern (4 exercises)
    - The Mystery of Time's Arrow (4 exercises)
    - Einstein's Spooky Action (4 exercises)
*/

-- Lesson 9: Nature's Optimization (Going Deeper)
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Here''s something weird: light takes the fastest path. A ball rolling on a curved surface follows the path that minimizes something called "action." The universe seems to be optimizing, like it''s solving calculus problems.',
  'human_context', E'Hero of Alexandria, around 60 AD, noticed something odd about mirrors. Light bounces off a mirror at equal angles. But why? He realized: this is the shortest path from the source to the mirror to your eye.\n\nLater, Fermat realized light bending in water also takes the fastest path—not the shortest distance, but the fastest time. Light slows down in water, so it takes a bent path that minimizes travel time.\n\nBut the really strange part: how does light "know" which path is fastest? It''s not trying different routes. It just... does it.',
  'concept_reveal', E'In the 1700s, mathematicians discovered something profound: you can derive all of mechanics from a single principle. Nature minimizes (or more precisely, makes stationary) a quantity called "action."\n\nYou don''t need F=ma. You don''t need complicated force diagrams. Just say: "The path taken is the one that minimizes action," and all of classical mechanics falls out.\n\nWhat''s action? Roughly, it''s energy multiplied by time. Nature finds the path where this quantity is minimized. It''s not that nature is thinking or calculating. It''s that the laws of physics are structured this way at a deep level.\n\nThis "principle of least action" underlies everything: classical mechanics, electromagnetism, quantum mechanics, relativity. It''s the universe''s deepest rule.',
  'insight_moment', 'The universe doesn''t push and pull. It optimizes.',
  'reflection_prompt', 'Water flows downhill, taking the path of steepest descent. That''s obvious. But at a deeper level, everything in physics is doing something similar—following a path that minimizes or extremizes some quantity. Nature is efficient.',
  'forward_motion', 'If nature minimizes action, maybe there''s a reason. Maybe it''s connected to symmetry.'
)
WHERE slug = 'natures-optimization';

-- Add exercises
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 1,
  'Light travels from air into water and bends. Why does it bend? What''s it optimizing?',
  'Light is slower in water. What path minimizes total travel time?',
  'Light bends to minimize travel time. Going straight would mean spending more time in the slower medium (water). By bending, light spends less time in water and more in air, arriving faster. This is Fermat''s principle: light takes the path of least time. The bending angle depends on the speed difference.'
FROM lessons WHERE slug = 'natures-optimization'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 2,
  'Have you noticed that soap bubbles are always spherical? Why that shape?',
  'What''s special about a sphere? Think about surface area.',
  'A sphere has the smallest surface area for a given volume. The soap film is under tension—it wants to minimize surface area. Nature automatically finds the sphere because it''s the minimum-energy configuration. This is the principle of least action playing out: systems settle into configurations that minimize energy.'
FROM lessons WHERE slug = 'natures-optimization'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 3,
  'You throw a ball. It follows a parabolic arc. Is there something this arc is minimizing?',
  'The ball is affected by gravity and inertia. What quantity involves both energy and time?',
  'The ball''s path minimizes action—specifically, the integral of (kinetic energy minus potential energy) over time. Every other path you could imagine has more action. The universe "computes" this automatically. Newton''s laws and the principle of least action are two ways of describing the same physics.'
FROM lessons WHERE slug = 'natures-optimization'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 4,
  'Think about evolution. Species change over time, becoming better adapted to their environments. Is nature "optimizing" here too?',
  'Evolution isn''t teleological—there''s no goal. But what gets selected for?',
  'Evolution selects for reproductive success, which often correlates with efficiency (finding food with less energy, avoiding predators more effectively). But it''s not optimization in the physics sense—it''s statistical filtering. The physics optimization principle is more fundamental: it''s built into the laws themselves, not emergent from competition.'
FROM lessons WHERE slug = 'natures-optimization'
ON CONFLICT DO NOTHING;

-- Lesson 10: The Hidden Pattern (Going Deeper)
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Energy is conserved. Momentum is conserved. Angular momentum is conserved. For centuries, these seemed like separate facts discovered independently. Then Emmy Noether connected them all with a single, beautiful idea.',
  'human_context', E'Conservation laws were mysteries. Why is energy conserved? No one knew—it just seemed to be true, confirmed by endless experiments.\n\nIn 1918, Emmy Noether, a mathematician working in Germany, was investigating the mathematics of general relativity. She discovered something unexpected: a deep connection between symmetries and conservation laws.\n\nHer theorem was so profound that Einstein himself wrote about its importance. Yet Noether struggled to get recognition—she was a woman in an era when women couldn''t officially hold professorships. She lectured under a male colleague''s name.',
  'concept_reveal', E'Noether''s theorem says: every continuous symmetry of nature corresponds to a conserved quantity.\n\nWhat''s a symmetry? An operation you can do that doesn''t change the physics. For example: physics is the same today as tomorrow (symmetry in time). Therefore, energy is conserved.\n\nPhysics is the same here as in another location (symmetry in space). Therefore, momentum is conserved.\n\nPhysics doesn''t care which direction you face (rotational symmetry). Therefore, angular momentum is conserved.\n\nConservation laws aren''t separate facts. They''re all reflections of symmetries. The universe conserves quantities precisely because its laws are symmetric.',
  'insight_moment', 'Symmetry isn''t just beauty. It''s the reason anything is conserved at all.',
  'reflection_prompt', 'Think about a perfect sphere. It looks the same no matter how you rotate it. That symmetry means something physical: a spinning sphere conserves its angular momentum because the laws of physics are rotationally symmetric.',
  'forward_motion', 'If symmetry generates conservation laws, what happens when symmetry is broken?'
)
WHERE slug = 'the-hidden-pattern';

-- Add exercises
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 1,
  'Imagine the laws of physics changed every hour—gravity was different, light speed changed, everything fluctuated. Would energy be conserved?',
  'Energy conservation comes from time symmetry. If physics changes with time, what happens?',
  'Energy wouldn''t be conserved. If the laws of physics change over time, there''s no time symmetry, so Noether''s theorem says energy need not be conserved. The fact that energy is conserved tells us something profound: the laws of physics are the same at all times.'
FROM lessons WHERE slug = 'the-hidden-pattern'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 2,
  'You''re ice skating and you pull your arms in while spinning. You spin faster. Why? What''s being conserved?',
  'Think about rotational symmetry and angular momentum.',
  'Angular momentum is conserved because space is rotationally symmetric (physics doesn''t care which direction you face). When you pull your arms in, you reduce your moment of inertia. To keep angular momentum constant, your rotation speed must increase. This conservation law is a direct consequence of rotational symmetry.'
FROM lessons WHERE slug = 'the-hidden-pattern'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 3,
  'Imagine you''re in deep space, far from everything. You push on a wall that''s floating next to you. What happens to your total momentum?',
  'You push the wall one way; it pushes you the other way. What''s the total?',
  'Total momentum is conserved—it stays zero. You gain momentum in one direction, the wall gains equal momentum in the opposite direction. This is because space is translationally symmetric: physics is the same at every location. That symmetry guarantees momentum conservation.'
FROM lessons WHERE slug = 'the-hidden-pattern'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 4,
  'Have you ever noticed that physicists are obsessed with finding symmetries in nature? Why does symmetry matter so much?',
  'What do symmetries tell you about the laws of physics?',
  'Symmetries are the deepest structure of physical law. Every time physicists find a new symmetry, they find a new conserved quantity or discover a new connection between forces. Symmetry isn''t decoration—it''s the architecture. Finding symmetries is finding the rules that constrain how the universe can behave.'
FROM lessons WHERE slug = 'the-hidden-pattern'
ON CONFLICT DO NOTHING;

-- Lesson 11: The Mystery of Time's Arrow (Going Deeper)
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Drop a glass and it shatters. You never see the shards spontaneously leap back together into a glass. But why not? The laws of physics work perfectly well in reverse.',
  'human_context', E'Film a bouncing ball and play it backward—it looks fine. The physics is time-reversible. Film a glass shattering and play it backward—it looks absurd, impossible.\n\nYet every individual collision, every atomic interaction, obeys time-reversible laws. If you could precisely reverse the motion of every atom in the shattered glass, it would re-form. The laws allow it.\n\nSo why does time have a direction? Why do glasses shatter but never un-shatter? Ludwig Boltzmann figured it out in the 1870s, and the answer is beautiful.',
  'concept_reveal', E'The secret is probability.\n\nThere are very few ways for a glass to be intact. The atoms need to be arranged just so—smooth surface, specific shape, intact bonds. But there are an astronomical number of ways for a glass to be shattered—shards scattered in countless configurations.\n\nWhen you drop a glass, it transitions from one specific state (intact) to one of billions upon billions of states (shattered). The reverse—transitioning from one of billions of shattered states to the one specific intact state—is so improbable it never happens.\n\nThis is entropy: a measure of how many microscopic arrangements correspond to the same macroscopic state. High entropy = many arrangements. Low entropy = few arrangements.\n\nThe second law of thermodynamics: entropy tends to increase. Not because there''s a force toward disorder, but because disorder is overwhelmingly more probable.',
  'insight_moment', 'Time''s arrow is written in probability, not in the laws of physics.',
  'reflection_prompt', 'Shuffle a deck of cards. The chance you''ve arranged them in perfect order is 1 in 10^67. Shuffle them again, and you''ve almost certainly created a new arrangement no one in history has ever seen. Disorder is vast; order is rare.',
  'forward_motion', 'If entropy increases, where did the low entropy come from in the first place?'
)
WHERE slug = 'the-mystery-of-times-arrow';

-- Add exercises
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 1,
  'Imagine 100 coins on a table, all showing heads. You shake the table randomly. What happens to the coins?',
  'How many arrangements have all heads? How many have a mix of heads and tails?',
  'The coins will end up in a mixed state—roughly half heads, half tails. There''s exactly ONE arrangement with all heads, but there are billions of billions of arrangements with roughly half and half. Randomness doesn''t push you toward disorder; disorder is just overwhelmingly more probable. Entropy increases because there are more ways to be messy.'
FROM lessons WHERE slug = 'the-mystery-of-times-arrow'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 2,
  'Have you ever watched cream swirl into coffee? It never un-swirls back into separate cream and coffee. Why?',
  'Think about how many ways the molecules can be arranged.',
  'When cream is separate, molecules are organized—cream molecules here, coffee molecules there. Few arrangements. When mixed, molecules can be anywhere. Vastly many arrangements. Random molecular motion explores all arrangements, and "mixed" is overwhelmingly more common than "separated." That''s why mixing is easy and un-mixing never happens.'
FROM lessons WHERE slug = 'the-mystery-of-times-arrow'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 3,
  'If the laws of physics are time-reversible, could you actually un-shatter a glass by precisely reversing every atom''s motion?',
  'Technically the laws allow it. But practically?',
  'Technically yes—if you could reverse the position and velocity of every single atom. But there are something like 10^24 atoms in a glass. The precision required is impossible. Even a tiny error in one atom would propagate, and you''d get a different shattered configuration, not an intact glass. It''s allowed by physics, but impossible by probability.'
FROM lessons WHERE slug = 'the-mystery-of-times-arrow'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 4,
  'Think about cleaning your room. It gets messy naturally, but you have to work to make it neat. Why is disorder so easy?',
  'How many ways can your room be messy vs. neat?',
  'There are countless ways for your room to be messy—clothes anywhere, books scattered, papers strewn about. But very few ways for it to be "neat" by your standards. Random processes (you tossing things down) naturally create disorder because disorder is more probable. Making it neat requires energy and intention to impose one of the rare ordered configurations.'
FROM lessons WHERE slug = 'the-mystery-of-times-arrow'
ON CONFLICT DO NOTHING;

-- Lesson 12: Einstein's Spooky Action (Going Deeper)
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Einstein helped create quantum mechanics. Then he spent decades trying to prove it was incomplete. His strongest argument was something called entanglement—a phenomenon so strange he refused to believe it was real.',
  'human_context', E'Create two particles together in a special way, then separate them by miles. Measure one particle, and instantly—faster than light could travel—the other particle "knows" what happened. Its properties change immediately.\n\nEinstein found this absurd. Nothing can travel faster than light. How could one particle know what happened to the other? He thought this proved quantum mechanics was missing something.\n\nIn 1935, Einstein, Podolsky, and Rosen published a paper arguing that quantum mechanics must be incomplete. There must be "hidden variables"—properties the particles had all along, predetermined. Quantum mechanics just didn''t see them.',
  'concept_reveal', E'For 30 years, it was just a philosophical debate. Then in 1964, John Bell figured out how to test it. He derived an inequality—a mathematical limit on how correlated two particles can be if hidden variables exist.\n\nQuantum mechanics predicts correlations stronger than Bell''s limit. Hidden variable theories can''t. Experiments have been done thousands of times since 1982. Quantum mechanics wins every time.\n\nEinstein was wrong. Entanglement is real. The particles don''t communicate—that would violate relativity. Instead, they were created as one quantum system. When you measure one, you''re measuring part of a unified whole. The correlations were built-in from the start.\n\nEntangled particles aren''t two separate things mysteriously connected. They''re one thing that happens to be spread across space.',
  'insight_moment', 'Entanglement isn''t spooky communication. It''s quantum mechanics being quantum mechanics.',
  'reflection_prompt', 'Imagine twins separated at birth who make similar life choices. Is that mysterious communication, or shared genes? Entanglement is like that—shared origins creating correlations, not faster-than-light signals.',
  'forward_motion', 'If entanglement is real and confirmed, what can we actually do with it?'
)
WHERE slug = 'einsteins-spooky-action';

-- Add exercises
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 1,
  'Two particles are entangled. You measure one and it''s spin-up. Instantly, the other is spin-down, even though it''s miles away. Can you use this to send a message faster than light?',
  'You know your particle''s spin. You know the other is opposite. But can the other person tell you did something?',
  'No. The distant person sees random results until you share information classically (at light speed or slower). The correlations only appear when you compare notes. Entanglement can''t send messages—it creates correlations that are revealed later. No faster-than-light communication is possible.'
FROM lessons WHERE slug = 'einsteins-spooky-action'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 2,
  'Have you ever seen magic tricks where the magician''s assistant seems to know what card you picked, even though they''re in separate rooms? Could entanglement explain that?',
  'Think about what entanglement can and can''t do.',
  'No—that''s just a trick with hidden communication or pre-arrangement. Entanglement creates correlations, but it doesn''t let one person know what the other is doing in real-time. The magician uses classical signals (hidden microphones, pre-arranged codes, etc.). Entanglement is real, but it doesn''t enable telepathy.'
FROM lessons WHERE slug = 'einsteins-spooky-action'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'thought_experiment', 3,
  'Einstein''s hidden variable idea: particles have definite properties all along, we just don''t know them. Bell''s inequality tests this. What would it mean if experiments violate Bell''s inequality?',
  'Violating Bell''s inequality means nature is more correlated than any hidden variable theory allows.',
  'It means particles genuinely don''t have definite properties until measured. The properties are created by measurement, not revealed. Quantum mechanics is complete—there are no hidden variables determining outcomes in advance. Reality is fundamentally probabilistic and nonlocal. This has been confirmed thousands of times.'
FROM lessons WHERE slug = 'einsteins-spooky-action'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT id, 'reflection', 4,
  'Think about identical twins. They share genes, so they might make similar choices even if separated. Is entanglement similar—just shared properties?',
  'Twins have predetermined shared genes. Does entanglement work the same way?',
  'That was Einstein''s idea—hidden variables like shared genes. But Bell''s theorem proves nature is more correlated than any shared predetermined properties allow. Entanglement is deeper than shared origins. The particles are one quantum system, not two separate systems with shared traits. Measurement genuinely creates properties, not just reveals them.'
FROM lessons WHERE slug = 'einsteins-spooky-action'
ON CONFLICT DO NOTHING;
