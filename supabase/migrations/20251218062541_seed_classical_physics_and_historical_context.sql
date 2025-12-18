/*
  # Seed Classical Physics Content and Historical Context

  1. New Modules - Classical Foundations (Level 1, order_index -4 to -1 to appear first)
    - "Why do things move?" - Newton's Laws (1687)
    - "What is energy, really?" - Energy concepts (Leibniz 1686, Joule 1843)
    - "Why can't you push yourself?" - Momentum and Action-Reaction
    - "Why do things fall the same way?" - Galileo's insights on falling bodies

  2. New Modules - Deeper Mechanics (Level 2)
    - "What is a Hamiltonian?" - Hamilton's formulation (1833)
    - "The lazy universe" - Principle of Least Action (Euler, Lagrange 1750s)

  3. Updates to Existing Lessons
    - Add historical_context to all lessons
*/

-- Insert new Classical Foundations modules
INSERT INTO modules (slug, title, description, intro_copy, order_index, level, level_label)
VALUES 
  (
    'why-do-things-move',
    'Why Do Things Move?',
    'The laws that govern every motion in the universe.',
    'Before Newton, people thought objects needed constant pushing to keep moving. A rolling ball eventually stops, after all. But Newton saw deeper—he realized that stopping is the weird part, not moving. This insight changed everything we thought we knew about motion.',
    -4,
    1,
    'Foundations'
  ),
  (
    'what-is-energy-really',
    'What Is Energy, Really?',
    'The invisible quantity that nature always conserves.',
    'Energy is one of those words everyone uses but few truly understand. It''s not a substance you can hold. It''s not a force. It''s something more subtle—a quantity that, remarkably, never changes in total, only transforms from one form to another. This discovery took centuries.',
    -3,
    1,
    'Foundations'
  ),
  (
    'why-cant-you-push-yourself',
    'Why Can''t You Push Yourself?',
    'The surprising truth about forces and momentum.',
    'Try pushing yourself while standing on ice. You can''t move forward without pushing something backward. This isn''t just practical advice—it''s a fundamental law of nature that governs everything from rockets to the recoil of a gun.',
    -2,
    1,
    'Foundations'
  ),
  (
    'why-do-things-fall-the-same-way',
    'Why Do Things Fall the Same Way?',
    'Galileo''s revolutionary insight about gravity.',
    'Drop a feather and a hammer in a vacuum, and they hit the ground at exactly the same moment. This shocked people in Galileo''s time—surely heavier things should fall faster? But no. This simple observation contains a profound truth that would later lead Einstein to general relativity.',
    -1,
    1,
    'Foundations'
  ),
  (
    'what-is-a-hamiltonian',
    'What Is a Hamiltonian?',
    'The physicist''s favorite way to describe motion.',
    'There''s a reason physicists love the Hamiltonian formulation. It takes everything about a system—position, momentum, energy—and packages it into one elegant function. Once you have the Hamiltonian, you have everything. It''s like having a master key to a building.',
    12,
    2,
    'Going Deeper'
  ),
  (
    'the-lazy-universe',
    'The Lazy Universe',
    'Why nature always takes the path of least action.',
    'Light takes the fastest path. A ball follows a curve that minimizes something called "action." The universe, it seems, is remarkably efficient. This principle—the principle of least action—is one of the most beautiful and powerful ideas in all of physics.',
    13,
    2,
    'Going Deeper'
  )
ON CONFLICT (slug) DO NOTHING;

-- Get module IDs for inserting lessons
DO $$
DECLARE
  mod_why_move uuid;
  mod_energy uuid;
  mod_push uuid;
  mod_fall uuid;
  mod_hamiltonian uuid;
  mod_lazy uuid;
BEGIN
  SELECT id INTO mod_why_move FROM modules WHERE slug = 'why-do-things-move';
  SELECT id INTO mod_energy FROM modules WHERE slug = 'what-is-energy-really';
  SELECT id INTO mod_push FROM modules WHERE slug = 'why-cant-you-push-yourself';
  SELECT id INTO mod_fall FROM modules WHERE slug = 'why-do-things-fall-the-same-way';
  SELECT id INTO mod_hamiltonian FROM modules WHERE slug = 'what-is-a-hamiltonian';
  SELECT id INTO mod_lazy FROM modules WHERE slug = 'the-lazy-universe';

  -- Lessons for "Why Do Things Move?"
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_why_move,
      'the-world-in-motion',
      'The World in Motion',
      'What Aristotle got wrong, and why it took 2000 years to notice.',
      '~5 min',
      1,
      '{"discovery_year": 1687, "key_figures": ["Isaac Newton", "Galileo Galilei"], "breakthrough_description": "Newton''s Principia Mathematica established that objects in motion stay in motion unless acted upon by a force—overturning 2000 years of Aristotelian physics.", "original_work": "Philosophiae Naturalis Principia Mathematica"}',
      '{"sections": [{"type": "intro", "content": "For over two thousand years, humanity believed that moving objects naturally come to rest. It seemed obvious—push a cart and it stops. But this ''obvious'' truth was wrong."}, {"type": "text", "content": "Aristotle taught that objects have a ''natural state'' of rest. Motion requires a cause; remove the cause, and motion stops. This made intuitive sense, but it missed something crucial: friction."}, {"type": "insight", "content": "Newton realized that objects don''t naturally stop—they''re stopped by friction, air resistance, and other forces. In the absence of all forces, an object would move forever."}]}'
    ),
    (
      mod_why_move,
      'newtons-first-law',
      'Newton''s First Law',
      'Why ''doing nothing'' is actually quite profound.',
      '~6 min',
      2,
      '{"discovery_year": 1687, "key_figures": ["Isaac Newton"], "breakthrough_description": "The law of inertia: every body continues in its state of rest or uniform motion unless compelled to change by forces impressed upon it.", "original_work": "Philosophiae Naturalis Principia Mathematica"}',
      '{"sections": [{"type": "intro", "content": "An object at rest stays at rest. An object in motion stays in motion. This sounds simple, but it''s one of the most revolutionary ideas in human history."}, {"type": "text", "content": "Newton''s first law tells us that the natural state of matter is not rest—it''s constant velocity. Whether that velocity is zero or a million miles per hour makes no difference. Only forces can change motion."}, {"type": "insight", "content": "This law implies something remarkable: there''s no experiment you can do inside a closed room that tells you whether you''re stationary or moving at constant speed. Physics looks the same either way."}]}'
    ),
    (
      mod_why_move,
      'the-meaning-of-f-equals-ma',
      'The Meaning of F=ma',
      'The most famous equation before E=mc², and what it really says.',
      '~7 min',
      3,
      '{"discovery_year": 1687, "key_figures": ["Isaac Newton"], "breakthrough_description": "Newton''s second law quantifies exactly how forces change motion: force equals mass times acceleration, connecting cause (force) to effect (acceleration) with perfect precision.", "original_work": "Philosophiae Naturalis Principia Mathematica"}',
      '{"sections": [{"type": "intro", "content": "F=ma. Three letters, one of the most powerful statements ever written. But what does it actually mean?"}, {"type": "text", "content": "Force causes acceleration, not velocity. Push something, and you don''t make it go fast—you make it speed up. The harder you push (more force), the faster it accelerates. The heavier it is (more mass), the slower it accelerates."}, {"type": "insight", "content": "Mass is resistance to acceleration. A bowling ball and a marble feel different not because they weigh different amounts (that''s gravity), but because it takes more force to change the bowling ball''s motion."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "What Is Energy, Really?"
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_energy,
      'the-conservation-revelation',
      'The Conservation Revelation',
      'Why energy can never be created or destroyed.',
      '~5 min',
      1,
      '{"discovery_year": 1843, "key_figures": ["James Prescott Joule", "Julius Robert Mayer", "Hermann von Helmholtz"], "breakthrough_description": "The mechanical equivalent of heat was established, proving that energy transforms but is always conserved—unifying mechanics and thermodynamics.", "original_work": "On the Mechanical Equivalent of Heat (Joule, 1845)"}',
      '{"sections": [{"type": "intro", "content": "Energy cannot be created or destroyed. It can only change form. This simple statement is one of the most powerful principles in all of science."}, {"type": "text", "content": "For centuries, people noticed that certain quantities seemed to be ''conserved''—they stayed the same even as systems changed. Kinetic energy could become potential energy and back again. But it took until the 1840s to realize this was universal."}, {"type": "insight", "content": "Conservation of energy connects everything: a falling rock, a warming cup of coffee, a speeding car. They''re all manifestations of the same underlying quantity transforming from one form to another."}]}'
    ),
    (
      mod_energy,
      'kinetic-and-potential',
      'Kinetic and Potential',
      'The two faces of mechanical energy.',
      '~6 min',
      2,
      '{"discovery_year": 1686, "key_figures": ["Gottfried Wilhelm Leibniz", "Christiaan Huygens"], "breakthrough_description": "Leibniz introduced ''vis viva'' (living force), arguing that mv² (twice the kinetic energy) is conserved in elastic collisions—laying the groundwork for energy conservation.", "original_work": "Brevis demonstratio erroris memorabilis Cartesii (Leibniz, 1686)"}',
      '{"sections": [{"type": "intro", "content": "A ball at the top of a hill has energy even while sitting still. A ball rolling on flat ground has energy because it''s moving. These are potential and kinetic energy."}, {"type": "text", "content": "Kinetic energy is the energy of motion: ½mv². Potential energy is stored energy, waiting to be released. A compressed spring, a lifted weight, a stretched rubber band—all hold potential energy."}, {"type": "insight", "content": "The beautiful thing is how they trade. As a pendulum swings, kinetic becomes potential becomes kinetic again, in an endless dance. The total never changes."}]}'
    ),
    (
      mod_energy,
      'work-the-energy-transfer',
      'Work: The Energy Transfer',
      'How forces move energy around.',
      '~6 min',
      3,
      '{"discovery_year": 1829, "key_figures": ["Gaspard-Gustave Coriolis"], "breakthrough_description": "Coriolis formalized the concept of ''work'' as force times distance, providing the mathematical framework for understanding energy transfer.", "original_work": "Du Calcul de l''Effet des Machines"}',
      '{"sections": [{"type": "intro", "content": "Work, in physics, has a precise meaning: it''s how you transfer energy from one thing to another using a force."}, {"type": "text", "content": "When you push a box across the floor, you do work on it. Your chemical energy (from food) becomes the box''s kinetic energy. Work equals force times distance—but only the force in the direction of motion counts."}, {"type": "insight", "content": "This is why holding a heavy box still is exhausting but does no work in physics terms. Your muscles burn energy, but none transfers to the box—it doesn''t move."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "Why Can't You Push Yourself?"
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_push,
      'action-and-reaction',
      'Action and Reaction',
      'Every force comes in pairs—no exceptions.',
      '~5 min',
      1,
      '{"discovery_year": 1687, "key_figures": ["Isaac Newton"], "breakthrough_description": "Newton''s third law revealed that forces always come in pairs: for every action, there is an equal and opposite reaction.", "original_work": "Philosophiae Naturalis Principia Mathematica"}',
      '{"sections": [{"type": "intro", "content": "You cannot push something without being pushed back. This isn''t just a statement about physics—it''s a fundamental law of the universe."}, {"type": "text", "content": "When you push against a wall, the wall pushes back against you with exactly the same force. When Earth pulls you down with gravity, you pull Earth up with the same force (though Earth barely moves because it''s so massive)."}, {"type": "insight", "content": "This is why rockets work in space. They don''t push against air—they push against their own exhaust. The exhaust pushes back, and the rocket accelerates."}]}'
    ),
    (
      mod_push,
      'momentum-the-quantity-of-motion',
      'Momentum: The Quantity of Motion',
      'Why a slow truck is harder to stop than a fast bicycle.',
      '~6 min',
      2,
      '{"discovery_year": 1687, "key_figures": ["Isaac Newton", "René Descartes"], "breakthrough_description": "Newton refined Descartes'' concept of ''quantity of motion'' into momentum (mass times velocity), showing it is always conserved in isolated systems.", "original_work": "Philosophiae Naturalis Principia Mathematica"}',
      '{"sections": [{"type": "intro", "content": "Momentum is mass times velocity: p = mv. It tells you how hard something is to stop."}, {"type": "text", "content": "A truck moving slowly can have more momentum than a bullet moving fast, because the truck is so much more massive. Momentum combines both the ''stuff'' and the ''speed'' into one quantity."}, {"type": "insight", "content": "Momentum is always conserved. In any collision, any explosion, any interaction—the total momentum before equals the total momentum after. This is one of nature''s unbreakable rules."}]}'
    ),
    (
      mod_push,
      'collisions-and-conservation',
      'Collisions and Conservation',
      'What really happens when things crash into each other.',
      '~7 min',
      3,
      '{"discovery_year": 1668, "key_figures": ["John Wallis", "Christopher Wren", "Christiaan Huygens"], "breakthrough_description": "The Royal Society''s collision experiments established momentum conservation as a fundamental principle, even before Newton formalized the laws of motion.", "original_work": "Proceedings of the Royal Society (1668)"}',
      '{"sections": [{"type": "intro", "content": "When two billiard balls collide, something remarkable happens: the total momentum doesn''t change, even though each ball''s momentum does."}, {"type": "text", "content": "In elastic collisions (like ideal billiard balls), both momentum AND kinetic energy are conserved. In inelastic collisions (like cars crashing), momentum is still conserved, but some kinetic energy becomes heat and sound."}, {"type": "insight", "content": "Conservation laws are the deepest principles in physics. They don''t tell you how things move—they tell you what''s impossible. And violating momentum conservation is impossible."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "Why Do Things Fall the Same Way?"
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_fall,
      'galileos-revolutionary-experiment',
      'Galileo''s Revolutionary Experiment',
      'The moment humanity learned to question the obvious.',
      '~5 min',
      1,
      '{"discovery_year": 1590, "key_figures": ["Galileo Galilei"], "breakthrough_description": "Galileo demonstrated (likely through inclined plane experiments, not the Tower of Pisa) that all objects fall at the same rate regardless of mass, overturning Aristotelian physics.", "original_work": "De Motu (On Motion), ~1590"}',
      '{"sections": [{"type": "intro", "content": "Aristotle taught that heavier objects fall faster. For nearly 2000 years, no one questioned this. Then came Galileo."}, {"type": "text", "content": "Whether Galileo actually dropped balls from the Leaning Tower of Pisa is debated. But his inclined plane experiments proved something shocking: all objects accelerate at the same rate when falling, regardless of their weight."}, {"type": "insight", "content": "Think about what this means. A feather and a bowling ball would hit the ground at the same time if not for air resistance. Mass doesn''t affect how fast you fall. This simple fact would later lead Einstein to general relativity."}]}'
    ),
    (
      mod_fall,
      'the-equivalence-principle-preview',
      'The Equivalence Principle Preview',
      'Why falling feels like floating.',
      '~6 min',
      2,
      '{"discovery_year": 1907, "key_figures": ["Albert Einstein"], "breakthrough_description": "Einstein''s ''happiest thought'' was realizing that a person in free fall feels no gravity—leading to the equivalence principle and eventually general relativity.", "original_work": "Einstein''s thought experiment, 1907"}',
      '{"sections": [{"type": "intro", "content": "Einstein called it ''the happiest thought of my life'': a person falling freely feels weightless. They can''t tell they''re falling."}, {"type": "text", "content": "If you''re in an elevator with the cable cut, everything falls together—you, your phone, a ball you release. From your perspective inside, there''s no way to know you''re falling. Gravity seems to have vanished."}, {"type": "insight", "content": "This is the equivalence principle in embryonic form. Gravity and acceleration are indistinguishable from the inside. This insight would eventually blossom into general relativity."}]}'
    ),
    (
      mod_fall,
      'the-universal-acceleration',
      'The Universal Acceleration',
      'Why 9.8 m/s² is the same for everything.',
      '~6 min',
      3,
      '{"discovery_year": 1687, "key_figures": ["Isaac Newton", "Galileo Galilei"], "breakthrough_description": "Newton explained why all objects fall equally: gravitational force is proportional to mass, but so is inertia. The two effects cancel exactly.", "original_work": "Philosophiae Naturalis Principia Mathematica"}',
      '{"sections": [{"type": "intro", "content": "Heavier objects feel more gravitational pull. But heavier objects are also harder to accelerate. These two effects cancel perfectly."}, {"type": "text", "content": "Gravitational force = mg. Resistance to acceleration = ma. Set them equal: mg = ma. The m cancels! So a = g for everything. This ''coincidence'' bothered physicists for centuries."}, {"type": "insight", "content": "Why should gravitational mass (how much gravity pulls you) equal inertial mass (how hard you are to accelerate)? Newton had no answer. Einstein realized this ''coincidence'' was a clue that gravity isn''t really a force at all."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "What Is a Hamiltonian?"
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_hamiltonian,
      'beyond-f-equals-ma',
      'Beyond F=ma',
      'Why physicists needed a new way to describe motion.',
      '~6 min',
      1,
      '{"discovery_year": 1833, "key_figures": ["William Rowan Hamilton"], "breakthrough_description": "Hamilton reformulated mechanics using energy rather than forces, creating a framework that would prove essential for quantum mechanics a century later.", "original_work": "On a General Method in Dynamics (1834)"}',
      '{"sections": [{"type": "intro", "content": "F=ma works beautifully for simple problems. But for complex systems—swinging pendulums, orbiting planets, vibrating molecules—there''s a better way."}, {"type": "text", "content": "Newton''s approach asks: what forces act, and what accelerations result? Hamilton''s approach asks: what is the total energy, and how does it flow between kinetic and potential forms?"}, {"type": "insight", "content": "The Hamiltonian perspective treats position and momentum as the fundamental variables, with energy as the master function that governs everything. It''s more abstract but far more powerful."}]}'
    ),
    (
      mod_hamiltonian,
      'energy-as-the-master-function',
      'Energy as the Master Function',
      'How knowing energy tells you everything.',
      '~7 min',
      2,
      '{"discovery_year": 1834, "key_figures": ["William Rowan Hamilton"], "breakthrough_description": "Hamilton showed that all of mechanics could be derived from a single function—the Hamiltonian—representing total energy.", "original_work": "On a General Method in Dynamics"}',
      '{"sections": [{"type": "intro", "content": "The Hamiltonian is simply the total energy of a system: kinetic plus potential. But from this single function, you can derive all the equations of motion."}, {"type": "text", "content": "Write H = T + V (kinetic plus potential energy) in terms of positions and momenta. Then Hamilton''s equations tell you exactly how positions and momenta change over time. Energy is the generator of time evolution."}, {"type": "insight", "content": "This is why the Hamiltonian became central to quantum mechanics. In quantum theory, the Hamiltonian operator determines how the wave function evolves. Energy governs everything."}]}'
    ),
    (
      mod_hamiltonian,
      'phase-space-the-bigger-picture',
      'Phase Space: The Bigger Picture',
      'Seeing motion as a flow through an abstract space.',
      '~7 min',
      3,
      '{"discovery_year": 1838, "key_figures": ["Joseph Liouville", "William Rowan Hamilton"], "breakthrough_description": "Liouville proved that phase space volume is conserved under Hamiltonian evolution, a fundamental theorem connecting mechanics to statistical physics.", "original_work": "Liouville''s Theorem (1838)"}',
      '{"sections": [{"type": "intro", "content": "Imagine a space where every point represents a complete state of a system—all positions and all momenta. This is phase space."}, {"type": "text", "content": "A pendulum''s phase space is two-dimensional: position (angle) and momentum. As the pendulum swings, its state traces an orbit through phase space. The Hamiltonian determines these orbits."}, {"type": "insight", "content": "Liouville proved something beautiful: the ''fluid'' of possible states flows through phase space without compression. This underlies the second law of thermodynamics and much of statistical mechanics."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

  -- Lessons for "The Lazy Universe"
  INSERT INTO lessons (module_id, slug, title, promise, time_estimate, order_index, historical_context, content)
  VALUES
    (
      mod_lazy,
      'natures-optimization',
      'Nature''s Optimization',
      'Why the universe seems to minimize something.',
      '~6 min',
      1,
      '{"discovery_year": 1744, "key_figures": ["Pierre Louis Maupertuis", "Leonhard Euler"], "breakthrough_description": "Maupertuis proposed that nature operates on a principle of least action, suggesting the universe is somehow ''optimal.'' Euler gave it mathematical form.", "original_work": "Methodus inveniendi (Euler, 1744)"}',
      '{"sections": [{"type": "intro", "content": "Light takes the path that minimizes travel time. A ball follows a trajectory that minimizes something called ''action.'' Why does nature optimize?"}, {"type": "text", "content": "The principle of least action says that the path a system takes between two points is the one that makes a certain quantity—the action—stationary (usually minimal). This is deeply strange."}, {"type": "insight", "content": "It''s as if the ball ''knows'' where it will end up and chooses the best path to get there. Of course it doesn''t really know—but the mathematics works as if it does."}]}'
    ),
    (
      mod_lazy,
      'the-lagrangian-way',
      'The Lagrangian Way',
      'A different flavor of mechanics, with deep connections.',
      '~7 min',
      2,
      '{"discovery_year": 1788, "key_figures": ["Joseph-Louis Lagrange"], "breakthrough_description": "Lagrange reformulated all of mechanics using a single function (the Lagrangian = kinetic minus potential energy) and a variational principle.", "original_work": "Mécanique analytique (1788)"}',
      '{"sections": [{"type": "intro", "content": "The Lagrangian is L = T - V: kinetic energy minus potential energy. From this simple function, all of mechanics follows."}, {"type": "text", "content": "Lagrange showed that the path nature chooses is the one that makes the ''action''—the integral of L over time—stationary. Apply calculus of variations, and out pop the equations of motion."}, {"type": "insight", "content": "The Lagrangian approach shines when dealing with constraints. A bead on a wire, a pendulum, a rolling wheel—problems that are nightmares in Newtonian mechanics become elegant in Lagrangian form."}]}'
    ),
    (
      mod_lazy,
      'symmetry-and-conservation',
      'Symmetry and Conservation',
      'Noether''s theorem: the deepest connection in physics.',
      '~8 min',
      3,
      '{"discovery_year": 1918, "key_figures": ["Emmy Noether"], "breakthrough_description": "Noether proved that every continuous symmetry of a physical system corresponds to a conserved quantity. Time symmetry gives energy conservation; space symmetry gives momentum conservation.", "original_work": "Invariante Variationsprobleme (1918)"}',
      '{"sections": [{"type": "intro", "content": "Emmy Noether discovered one of the most profound connections in all of physics: symmetry implies conservation."}, {"type": "text", "content": "If the laws of physics don''t change over time, energy is conserved. If they don''t change from place to place, momentum is conserved. If they don''t care which direction you face, angular momentum is conserved."}, {"type": "insight", "content": "This is breathtaking. Conservation laws aren''t arbitrary rules—they''re consequences of the universe''s symmetries. Noether''s theorem unifies all of mechanics under one beautiful principle."}]}'
    )
  ON CONFLICT (slug) DO NOTHING;

END $$;
