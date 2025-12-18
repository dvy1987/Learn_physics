/*
  # Fix Homepage-Linked Lessons Content (Part 1 of 3)

  This migration fixes the 12 priority homepage-linked lessons first.

  1. Content Format Changes
    - Converts from incorrect `{"sections": [...]}` format
    - Updates to correct 6-field format: gentle_entry, human_context, concept_reveal, insight_moment, reflection_prompt, forward_motion
    - Uses conversational, casual tone appropriate for curious beginners

  2. Exercise Creation
    - Adds 4-5 exercises per lesson
    - Mix of thought experiments and reflection questions
    - Each exercise includes: question, hint, and insight

  3. Lessons Updated (Part 1)
    - The World in Motion (4 exercises)
    - The Conservation Revelation (5 exercises)
    - Action and Reaction (4 exercises)
    - Galileo's Revolutionary Experiment (4 exercises)
*/

-- Lesson 1: The World in Motion
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Here''s something weird: for most of human history, people believed that moving things naturally slow down and stop. It seemed obvious. Push a cart, and it stops. Slide a book across a table, and it stops. Everything stops, right?',
  'human_context', E'Aristotle watched the world carefully and concluded that rest was the natural state of things. Motion required constant effort. Stop pushing, and things returned to rest. For nearly 2,000 years, this made perfect sense to everyone.\n\nThen someone started asking uncomfortable questions. Why does an arrow keep flying after it leaves the bow? Why do ships keep gliding even when the wind dies? Maybe the answers people gave got complicated, but the core idea held: motion needs a cause.\n\nWhat if everyone had it backwards?',
  'concept_reveal', E'Turns out, Aristotle was looking at the world through a filter he didn''t know was there: friction. Friction is everywhere on Earth—air resistance, surface roughness, all the little forces that make things stop.\n\nBut motion itself? Motion doesn''t need a cause. Motion is natural. What needs explanation is stopping. In the emptiness of space, give something a push and it keeps going forever. Not because something is pushing it. Just because there''s nothing to stop it.\n\nThis is what Newton realized: objects in motion stay in motion unless something interferes. The cart stops because of friction. The book stops because of friction. Remove friction, and they''d keep going.',
  'insight_moment', 'Motion is the default. Stopping is what requires explanation.',
  'reflection_prompt', 'Think about the last time you slid on ice or a smooth floor. Remember that feeling of not quite being in control? That''s what motion without much friction feels like. It''s not weird—it''s natural.',
  'forward_motion', 'If motion is natural, what does that say about forces? Newton had more surprises in store.'
)
WHERE slug = 'the-world-in-motion';

-- Add exercises for "The World in Motion"
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  1,
  'Imagine you''re an astronaut floating in deep space, far from any planets or stars. You throw a baseball. What happens to it? Does it slow down? Stop? Keep going?',
  'Think about what would make it stop. Is there air resistance? Gravity? Any friction at all?',
  'The baseball keeps going at exactly the same speed, in exactly the same direction, forever. Motion doesn''t need fuel or energy to continue—it''s the natural state. This seems strange to us only because we''ve never experienced a world without friction.'
FROM lessons WHERE slug = 'the-world-in-motion'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'reflection',
  2,
  'Have you ever been in a car that braked suddenly? You felt yourself lurch forward. Why does your body want to keep moving when the car stops?',
  'Your body isn''t trying to move forward. It''s trying to continue what it was already doing.',
  'Your body was moving with the car. When the car stops, your body wants to keep moving at the same speed. That''s Newton''s first law at work—your body is trying to maintain its motion. The seatbelt is what stops you, not any natural tendency to rest.'
FROM lessons WHERE slug = 'the-world-in-motion'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  3,
  'Picture a perfectly smooth ice rink that goes on forever, with no air. You push a hockey puck. How far does it go before stopping?',
  'What would make it stop? If there''s no friction and no air resistance, what force would slow it down?',
  'It never stops. It keeps sliding forever. This isn''t science fiction—it''s what motion actually looks like when you remove friction. Earth is unusual because friction is everywhere. Motion without friction is the universe''s default.'
FROM lessons WHERE slug = 'the-world-in-motion'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'reflection',
  4,
  'Think about pushing a shopping cart. Why does it feel easier to keep it moving than to get it started?',
  'Consider what you''re fighting against in each case.',
  'Getting it started, you''re fighting static friction. Keeping it moving, you''re only fighting the smaller rolling friction. But here''s the key: once it''s moving, it wants to keep moving. You''re just fighting friction, not fighting the motion itself. Motion is on your side.'
FROM lessons WHERE slug = 'the-world-in-motion'
ON CONFLICT DO NOTHING;

-- Lesson 2: The Conservation Revelation
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Energy is one of those words everyone uses but nobody can quite define. It''s not stuff you can hold. It''s not a thing with a location. Yet it''s the most important concept in all of physics. So what is it, really?',
  'human_context', E'For centuries, scientists noticed strange patterns. Water falling turns a wheel. Burning coal boils water into steam. A swinging pendulum gradually loses height. These all seemed like different phenomena.\n\nThen someone had a wild idea: what if there''s a single quantity that''s just... changing forms? What if the falling water doesn''t lose anything—it just trades height for motion? What if burning coal doesn''t create energy—it releases it?\n\nIt took decades to prove, but the idea revolutionized everything.',
  'concept_reveal', E'Energy is the universe''s currency. It transforms endlessly—motion to heat, heat to light, light to electricity, electricity to motion—but the total amount never changes.\n\nDrop a ball. It trades height (potential energy) for speed (kinetic energy). At the moment it hits the ground, all the potential energy has become kinetic. Then it bounces back up, trading kinetic back to potential. Energy flows back and forth, never appearing from nowhere, never disappearing.\n\nThis is conservation of energy: the universe''s absolute rule. Energy changes form constantly, but the total is fixed. It''s like having an account where you can convert dollars to euros to yen—but the total value never changes.',
  'insight_moment', 'Energy never disappears. It just hides in different forms.',
  'reflection_prompt', 'Think about the last time you were exhausted after exercising. Where did your energy "go"? It didn''t vanish—it became heat in your body, motion in the world around you, even sound waves when you breathed hard.',
  'forward_motion', 'If energy transforms but never disappears, what are the main forms it takes? And how do they trade back and forth?'
)
WHERE slug = 'the-conservation-revelation';

-- Add exercises for "The Conservation Revelation"
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  1,
  'Imagine you''re at the top of a water slide. You''re not moving yet, but you''re high up. At the bottom, you''re moving fast but you''re low. What happened to the "height" you lost?',
  'Think about the relationship between being high and being fast.',
  'Your height became your speed. Gravitational potential energy (height) transformed into kinetic energy (motion). The amount of speed you gained depends exactly on how much height you lost. The universe did perfect accounting—nothing was created or destroyed.'
FROM lessons WHERE slug = 'the-conservation-revelation'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'reflection',
  2,
  'Have you ever noticed your phone gets warm when it''s working hard? Where does that heat come from?',
  'Your phone is using electrical energy. If it gets warm, what form of energy is appearing?',
  'Electrical energy from the battery is transforming into heat (and light from the screen, and sound, and radio waves). The heat isn''t waste—it''s just another form energy takes. No energy is lost; it''s just not in the form you wanted.'
FROM lessons WHERE slug = 'the-conservation-revelation'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  3,
  'A pendulum swings back and forth. At the highest points, it stops for a moment. At the lowest point, it''s moving fastest. Where''s the energy at each moment?',
  'What does the pendulum have at the top that it doesn''t have at the bottom? What does it have at the bottom that it doesn''t have at the top?',
  'At the top: all potential energy, no kinetic. At the bottom: all kinetic energy, no potential. In between: a mix of both. The total is always the same. Energy sloshes back and forth between forms like water between two connected tanks.'
FROM lessons WHERE slug = 'the-conservation-revelation'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'reflection',
  4,
  'When you''re hungry, you eat food. What''s really happening in terms of energy?',
  'Food has chemical energy stored in its molecular bonds. Your body does something with that energy.',
  'You''re taking chemical potential energy (food) and transforming it into motion (muscle movement), heat (body temperature), electrical signals (nerves and brain), and other chemical energy (building and repairing cells). Eating is energy format conversion.'
FROM lessons WHERE slug = 'the-conservation-revelation'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  5,
  'If energy is always conserved, why do we worry about "running out of energy"? Why can''t we just keep reusing it?',
  'Think about the difference between energy existing and energy being useful.',
  'We never run out of energy—it''s always there. But useful energy (concentrated, organized) becomes less useful energy (spread out heat). You can''t un-scatter heat back into useful forms without spending more energy. Energy is conserved, but usefulness isn''t.'
FROM lessons WHERE slug = 'the-conservation-revelation'
ON CONFLICT DO NOTHING;

-- Lesson 3: Action and Reaction
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Try this: stand on a skateboard and push yourself forward. Can you move? Not by pushing your own body—you need to push against something else. Why? The answer reveals one of the universe''s deepest patterns.',
  'human_context', E'Newton noticed something odd about forces. When a horse pulls a cart, the cart pulls back on the horse. When you jump, you push down on the ground—and the ground pushes up on you. Forces always seem to come in pairs.\n\nBut here''s the strange part: if forces always come in equal and opposite pairs, why does anything ever move? If the cart pulls backward on the horse as hard as the horse pulls forward on the cart, shouldn''t they cancel out?\n\nNewton figured out why this isn''t a contradiction—it''s a fundamental law.',
  'concept_reveal', E'Every force creates an equal and opposite force, but they act on different objects. That''s the key.\n\nWhen you push on a wall, the wall pushes back on you with equal force. But the wall is heavy and attached to the building, so it doesn''t move. You''re light and mobile, so you move backward.\n\nWhen a rocket fires downward, hot gas pushes down. By Newton''s third law, the gas pushes up on the rocket with equal force. The gas flies one way; the rocket flies the other. No contradiction—just two objects pushing each other apart.\n\nYou can''t push yourself because pushing requires two objects. You push on something else, and it pushes back on you. Both forces happen simultaneously, automatically.',
  'insight_moment', 'Forces are interactions between objects. You can''t have a one-sided push.',
  'reflection_prompt', 'Next time you walk, pay attention to what you''re really doing. You''re not moving yourself forward—you''re pushing the Earth backward. The Earth is so massive it doesn''t noticeably move, but you do. Walking is a conversation with the planet.',
  'forward_motion', 'If forces come in pairs, what happens to motion? Does it come in pairs too?'
)
WHERE slug = 'action-and-reaction';

-- Add exercises for "Action and Reaction"
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  1,
  'You''re floating in the middle of a perfectly smooth, frictionless ice rink. No walls in reach. How can you get to the edge?',
  'You can''t push yourself, but you can push something else. What do you have with you?',
  'Throw your shoe (or anything you have). When you push the shoe away, it pushes you back in the opposite direction. You''ll slide slowly toward the edge. This is how astronauts maneuver in space—by throwing things or using jets of air.'
FROM lessons WHERE slug = 'action-and-reaction'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'reflection',
  2,
  'When you jump, you push down on the ground. Why don''t you see the Earth move downward?',
  'The Earth does get pushed. But how massive is it compared to you?',
  'The Earth does move downward—by an absolutely tiny amount. The force you exert on Earth equals the force Earth exerts on you. But force causes acceleration proportional to mass (F=ma). You have tiny mass, so you get big acceleration (you jump). Earth has huge mass, so it gets infinitesimal acceleration (unmeasurable).'
FROM lessons WHERE slug = 'action-and-reaction'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  3,
  'Two people on skateboards face each other and push off against each other''s hands. Who moves faster: the lighter person or the heavier person?',
  'They exert equal forces on each other. But how does mass affect acceleration?',
  'The lighter person moves faster. Same force, less mass, means more acceleration. If one person is twice as heavy, they''ll move at half the speed. The forces are equal and opposite, but the resulting motions depend on mass.'
FROM lessons WHERE slug = 'action-and-reaction'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'reflection',
  4,
  'Why can you swim? What are you pushing against, and what''s pushing you?',
  'Your hands and feet move water in one direction. What does the water do to you?',
  'You push water backward; water pushes you forward. It''s the same principle as walking or jumping, just in a fluid instead of on solid ground. Competitive swimmers maximize the amount of water they push, which maximizes the reaction force propelling them forward.'
FROM lessons WHERE slug = 'action-and-reaction'
ON CONFLICT DO NOTHING;

-- Lesson 4: Galileo's Revolutionary Experiment
UPDATE lessons
SET content = jsonb_build_object(
  'gentle_entry', 'Drop a feather and a hammer. Obviously the hammer hits first, right? That''s what everyone believed for 2,000 years. Then Galileo asked: what if we''re wrong?',
  'human_context', E'Aristotle taught that heavy objects fall faster than light objects. It made sense—drop a rock and a feather, and the rock wins easily. For centuries, no one questioned it.\n\nThen Galileo, being difficult, asked: what if the air is interfering? What if the feather falls slower not because it''s lighter, but because it catches more air?\n\nHe couldn''t test this in a vacuum—they didn''t have vacuum pumps yet. So he got creative. He rolled balls of different weights down ramps, which slows everything down enough to measure carefully. Different weights, same speed.',
  'concept_reveal', E'Galileo''s insight: gravity pulls on all objects equally, regardless of their mass. A hammer has more mass than a feather, yes—but gravity pulls harder on more mass, in exact proportion.\n\nThink of it this way: two objects have twice the mass of one, so gravity pulls twice as hard. But twice the mass also means twice as much inertia (resistance to acceleration). The two effects exactly cancel. Every object falls at the same rate.\n\nIn 1971, astronaut David Scott dropped a hammer and a feather on the Moon (no air). They hit the ground at the same instant. Galileo was right.\n\nThis fact—that gravitational mass equals inertial mass, exactly—is so precise it seems suspicious. Einstein eventually figured out why. But that''s a story for later.',
  'insight_moment', 'Gravity doesn''t care how much you weigh. It accelerates everything the same.',
  'reflection_prompt', 'If you''ve ever been in an elevator that suddenly drops, you felt that weird moment of weightlessness. For that instant, you were falling at the same rate as the elevator. Gravity was pulling you both equally.',
  'forward_motion', 'If everything falls the same way, what does that tell us about the nature of gravity itself?'
)
WHERE slug = 'galileos-revolutionary-experiment';

-- Add exercises for "Galileo's Revolutionary Experiment"
INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  1,
  'Imagine you drop two bowling balls at the same time: one is 10 pounds, the other is 20 pounds. Which hits the ground first?',
  'Forget about air resistance. Does gravity care about weight?',
  'They hit at exactly the same time. The 20-pound ball has twice the weight (gravity pulls twice as hard), but it also has twice the inertia (twice as hard to accelerate). These exactly cancel out. Same acceleration, same fall time.'
FROM lessons WHERE slug = 'galileos-revolutionary-experiment'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'reflection',
  2,
  'Why does a feather fall slower than a rock on Earth? If gravity accelerates everything equally, what''s going on?',
  'What''s different about Earth compared to the Moon where they fell together?',
  'Air resistance. The feather has a large surface area for its weight, so air pushes up on it significantly. The rock is dense and streamlined, so air barely affects it. Remove the air (like on the Moon), and they fall together. The difference isn''t gravity—it''s air.'
FROM lessons WHERE slug = 'galileos-revolutionary-experiment'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'thought_experiment',
  3,
  'You''re standing in an elevator with no windows. The cable snaps and you''re falling freely (don''t worry, there are safety brakes). You''re holding a ball. What happens if you let go of it?',
  'You''re falling. The ball is falling. Both are accelerating at the same rate due to gravity.',
  'The ball appears to float in front of you. You''re both falling at the same rate, so relative to you, the ball isn''t moving. This is what astronauts experience—constant free fall around Earth. "Weightlessness" is just falling.'
FROM lessons WHERE slug = 'galileos-revolutionary-experiment'
ON CONFLICT DO NOTHING;

INSERT INTO exercises (lesson_id, exercise_type, order_index, question, hint, insight)
SELECT
  id,
  'reflection',
  4,
  'Have you ever noticed that when you''re in a car that''s accelerating, you feel pushed back into your seat? Does that feel similar to anything else?',
  'Think about the feeling of weight. What creates that sensation?',
  'Acceleration feels like gravity. When the car accelerates forward, you feel pushed backward into the seat—similar to feeling pushed down by gravity. Einstein realized this wasn''t a coincidence: acceleration and gravity create identical sensations because they''re deeply related.'
FROM lessons WHERE slug = 'galileos-revolutionary-experiment'
ON CONFLICT DO NOTHING;
