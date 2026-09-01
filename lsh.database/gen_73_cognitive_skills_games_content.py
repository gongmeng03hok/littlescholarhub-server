# -*- coding: utf-8 -*-
"""
Generates lsh.database/73_cognitive_skills_games_content.sql — adds a
"Brain & Strategy Games" category to the existing 'cognitive_skills'
subject_area (already shipped alongside Critical Thinking, Design Thinking
& Innovation, Metacognition, Problem-Solving, Spatial Awareness — see
64_sel_cognitive_content.sql) for every grade TK-6th. Each grade gets a
pool of 14 hand-crafted thinking games spanning logic puzzles, spatial
challenges, quick strategy games, memory/pattern games, metacognitive
reflection games, and mini invent-a-solution design challenges.

target_count=7 (fixed, not the usual ~65% auto-rebalance ratio) means the
existing NEWID()-sampling rotation in usp_GetOrCreateWeeklyPacket serves a
different 7-of-14 combination most weeks a grade's cognitive_skills
category is selected, giving "7 brain games, different set each week"
without any manual per-week authoring. See gen_68_outdoor_games_content.py
for the proven template this file replicates.

Run with: python gen_73_cognitive_skills_games_content.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), tip
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🧸 Matching Pairs",
        "objective": "Practice remembering where things are by finding two toys that match.",
        "materials": ["6 pairs of small matching toys or objects", "A blanket or cloth to hide them under"],
        "steps": [
            "A grown-up lines up 4 objects (2 matching pairs) on the floor.",
            "Look closely at each object for a few seconds.",
            "Cover them with a cloth, then try to point to where each match is.",
            "Lift the cloth together and check if you remembered right!",
        ],
        "tip": "Looking closely before you guess helps your brain remember better.",
    },
    {
        "name": "🔵 What Comes Next?",
        "objective": "Practice noticing and continuing a simple color or shape pattern.",
        "materials": ["Colored blocks, buttons, or crayons (2-3 colors)"],
        "steps": [
            "A grown-up lines up a simple pattern, like red-blue-red-blue.",
            "Look at the pattern together and say the colors out loud.",
            "Guess what color comes next.",
            "Add the next piece and check if you were right!",
        ],
        "tip": "Patterns repeat — once you spot the rule, you can guess what's next!",
    },
    {
        "name": "🏗️ Tallest Tower",
        "objective": "Practice planning and balancing while building the tallest tower you can.",
        "materials": ["10-15 soft blocks or small stackable boxes"],
        "steps": [
            "Stack blocks one at a time to build a tower.",
            "Go slowly and check that each block is balanced before adding another.",
            "See how tall you can build before it wobbles.",
            "If it falls, laugh and try again — can you beat your height?",
        ],
        "tip": "Big blocks on the bottom, small ones on top — that's a builder's trick!",
    },
    {
        "name": "🙈 Hidden Object Peek",
        "objective": "Practice remembering an object after it disappears from view.",
        "materials": ["1 favorite small toy", "A cup or small box to hide it under"],
        "steps": [
            "Show the toy, then hide it under a cup while the child watches.",
            "Ask, 'Where did it go?'",
            "Let the child lift the cup to find it.",
            "Try hiding it under one of two cups and guess which one!",
        ],
        "tip": "Just because something is hidden doesn't mean it's gone — great thinking!",
    },
    {
        "name": "🧩 Big Piece Puzzle Race",
        "objective": "Practice looking at shapes and finding where they fit.",
        "materials": ["A simple 4-6 piece chunky puzzle"],
        "steps": [
            "Dump the puzzle pieces out on a table.",
            "Look at each piece's shape and edges.",
            "Try fitting a piece into the puzzle board.",
            "Keep going until every piece is in its spot!",
        ],
        "tip": "Turning a piece around and around helps you see where it fits.",
    },
    {
        "name": "👋 Copy My Moves",
        "objective": "Practice remembering and repeating a short sequence of actions.",
        "materials": ["None — just your body!"],
        "steps": [
            "A grown-up claps once, then touches their head.",
            "Try copying the same two moves in the same order.",
            "Add one more move to the sequence (clap, head, jump!).",
            "See how many moves you can remember in a row.",
        ],
        "tip": "Saying the moves out loud while you do them helps your brain remember.",
    },
    {
        "name": "🎨 Odd One Out",
        "objective": "Practice looking closely to spot which object doesn't belong.",
        "materials": ["4 small toys or objects (3 similar, 1 different)"],
        "steps": [
            "Line up 4 objects, like 3 spoons and 1 crayon.",
            "Look at all of them carefully.",
            "Point to the one that is different from the rest.",
            "Try again with a new group of 4 objects!",
        ],
        "tip": "Ask yourself: what do most of them have that this one doesn't?",
    },
    {
        "name": "🧱 Copy the Shape",
        "objective": "Practice looking at a simple block shape and building it the same way.",
        "materials": ["8-10 building blocks"],
        "steps": [
            "A grown-up builds a small, simple shape with 3-4 blocks.",
            "Look at the shape carefully.",
            "Use your own blocks to build the exact same shape.",
            "Compare the two shapes side by side — do they match?",
        ],
        "tip": "Looking at one block at a time makes copying a shape easier.",
    },
    {
        "name": "🐘 Animal Sound Match",
        "objective": "Practice thinking of the right answer by matching sounds to animals.",
        "materials": ["Pictures of 4-5 animals (or toy animals)"],
        "steps": [
            "Line up pictures or toys of a few animals.",
            "A grown-up makes an animal sound, like 'moo.'",
            "Point to the animal that makes that sound.",
            "Take turns making sounds for each other to guess!",
        ],
        "tip": "Thinking about what you already know about an animal helps you guess.",
    },
    {
        "name": "🪢 Which Path Goes There?",
        "objective": "Practice following a simple path with your eyes to solve a mini maze.",
        "materials": ["Paper with 2 simple squiggly lines drawn to 2 different pictures", "Crayon"],
        "steps": [
            "Draw two wiggly lines from a starting dot to two different pictures.",
            "Look at both lines with just your eyes (no tracing yet).",
            "Guess which line leads to which picture.",
            "Trace the line with a crayon to check your guess!",
        ],
        "tip": "Following a line slowly with your eyes helps you see where it goes.",
    },
    {
        "name": "🔺 Sort the Shapes",
        "objective": "Practice grouping objects by shape to notice what's the same.",
        "materials": ["A mixed pile of circles, squares, and triangles (paper or blocks)"],
        "steps": [
            "Spread out a mixed pile of shapes.",
            "Pick one shape and name it out loud.",
            "Put all the matching shapes into their own group.",
            "Keep sorting until every shape has a group!",
        ],
        "tip": "Grouping things that are alike is one of the first steps thinkers use.",
    },
    {
        "name": "🧠 Guess My Rule",
        "objective": "Practice figuring out a simple hidden rule by watching examples.",
        "materials": ["A few small toys (some soft, some hard — or some red, some not)"],
        "steps": [
            "A grown-up quietly picks a rule, like 'only soft things.'",
            "Grown-up puts one soft toy in a pile and says 'yes' and one hard toy outside it and says 'no.'",
            "Guess which pile a new toy belongs in.",
            "After a few tries, guess the grown-up's secret rule!",
        ],
        "tip": "Watching a few examples helps your brain figure out the hidden rule.",
    },
    {
        "name": "🌉 Build a Bridge",
        "objective": "Practice inventing a simple solution to hold up a toy using blocks.",
        "materials": ["Building blocks", "A small toy car or figure to cross the bridge"],
        "steps": [
            "Set two block towers a small gap apart.",
            "Think about how to connect them so a toy can cross.",
            "Try laying a flat block across the gap like a bridge.",
            "Test it by rolling the toy car across!",
        ],
        "tip": "If your first idea falls down, that's okay — try a new way!",
    },
    {
        "name": "💭 Happy or Tricky Face",
        "objective": "Practice noticing and naming how a puzzle or game made you feel.",
        "materials": ["None — just talking together"],
        "steps": [
            "After playing any game today, sit together for a moment.",
            "Ask, 'Did that feel easy, tricky, or in between?'",
            "Make a face that shows how it felt (smile, thinking face, big smile).",
            "Talk about what part was the trickiest.",
        ],
        "tip": "Noticing how a puzzle feels is the very first step to thinking about your thinking.",
    },
]


GAMES[1] = [
    {
        "name": "🧠 Memory Match Cards",
        "objective": "Practice remembering the location of matching pairs of cards.",
        "materials": ["8 cards (4 matching pairs) — drawn or index cards"],
        "steps": [
            "Lay all 8 cards face-down in rows.",
            "Flip two cards over to see if they match.",
            "If they don't match, flip them back down and remember where they were.",
            "Keep going until you've found all 4 pairs!",
        ],
        "tip": "Try to remember not just what you saw, but exactly where you saw it.",
    },
    {
        "name": "❌ Three in a Row",
        "objective": "Practice planning ahead to line up three marks while blocking a partner.",
        "materials": ["Paper with a 3x3 grid drawn", "Pencil or 2 colors of small tokens"],
        "steps": [
            "Draw a 3x3 grid on paper.",
            "Take turns placing your mark (X or O) in an empty square.",
            "Try to get 3 of your marks in a row, while watching what your partner is doing.",
            "First to get 3 in a row (across, down, or diagonal) wins!",
        ],
        "tip": "Watch your partner's marks too — sometimes blocking them is the smart move.",
    },
    {
        "name": "🔍 Spot the Difference",
        "objective": "Practice careful looking by comparing two nearly-identical drawings.",
        "materials": ["Two simple drawings of the same picture, with 3-4 small changes made to one"],
        "steps": [
            "Draw a simple picture (like a house), then copy it but change 3-4 small details.",
            "Look at both pictures side by side.",
            "Point out each difference you can find.",
            "Check together — did you find them all?",
        ],
        "tip": "Look at one small section at a time instead of the whole picture at once.",
    },
    {
        "name": "🧱 Copy the Block Tower",
        "objective": "Practice studying a structure carefully and rebuilding it from memory.",
        "materials": ["10-12 building blocks"],
        "steps": [
            "A partner builds a small tower using 5-6 blocks.",
            "Study it carefully for 10 seconds, then it gets covered or knocked down.",
            "Try to rebuild the exact same tower from memory.",
            "Compare with a new tower your partner builds to check!",
        ],
        "tip": "Saying the block order out loud while you look helps you remember it.",
    },
    {
        "name": "🗺️ Treasure Map Directions",
        "objective": "Practice following and giving step-by-step directions to find a hidden spot.",
        "materials": ["Small hidden object", "Open room or yard"],
        "steps": [
            "Hide a small object somewhere in the room.",
            "Give a partner 3-4 simple directions (forward, turn left, forward).",
            "Partner follows the directions exactly to try to find the object.",
            "Switch roles and hide a new object!",
        ],
        "tip": "Clear, simple directions — one step at a time — work best.",
    },
    {
        "name": "🔷 What's the Pattern?",
        "objective": "Practice figuring out and continuing a repeating pattern.",
        "materials": ["Colored blocks, beads, or crayons"],
        "steps": [
            "Line up a pattern with 3 or more repeats, like square-circle-circle.",
            "Study the pattern and figure out its repeating rule.",
            "Predict what shape comes next.",
            "Add it, then try making your own tricky pattern for a partner!",
        ],
        "tip": "Find the smallest repeating chunk — that's the secret to any pattern.",
    },
    {
        "name": "🏗️ Strongest Bridge Challenge",
        "objective": "Design and test a simple structure that can hold a small weight.",
        "materials": ["Building blocks or craft sticks", "A small toy to place on top as a test weight"],
        "steps": [
            "Think of a way to build a bridge or platform between two blocks.",
            "Build your idea.",
            "Test it by gently placing a small toy on top.",
            "If it falls, redesign it and test again!",
        ],
        "tip": "Real inventors expect their first try to need fixing — that's part of designing.",
    },
    {
        "name": "🎭 Guess the Category",
        "objective": "Practice thinking of examples that fit a hidden group.",
        "materials": ["None — just your imagination"],
        "steps": [
            "One player thinks of a secret category, like 'things that are cold.'",
            "They name one example (ice cream).",
            "Others guess more things that might fit, and the player says yes or no.",
            "Whoever guesses the secret category first picks the next one!",
        ],
        "tip": "Think about what all the 'yes' answers have in common.",
    },
    {
        "name": "🧩 Shape Puzzle Builder",
        "objective": "Practice fitting shapes together to fill in an outline.",
        "materials": ["Paper cut into 6-8 simple shapes", "A larger outline drawn on paper for the shapes to fill"],
        "steps": [
            "Draw a simple big outline (like a house or star) on paper.",
            "Cut smaller shapes that could fit inside pieces of it.",
            "Arrange the shapes to fill the outline without gaps.",
            "Trace around your finished design!",
        ],
        "tip": "Turning a shape sideways or upside down might help it fit better.",
    },
    {
        "name": "🧠 Remember the Order",
        "objective": "Practice holding a short sequence of words in your memory.",
        "materials": ["None — just listening and talking"],
        "steps": [
            "A grown-up says 3 words in a row, like 'apple, ball, cat.'",
            "Wait a few seconds, then repeat the words back in the same order.",
            "Try again with 4 words if that felt easy.",
            "Take turns being the one who says the words!",
        ],
        "tip": "Picturing each word as a little picture in your mind can help you remember it.",
    },
    {
        "name": "🐢 Slow Motion Detective",
        "objective": "Practice noticing small clues by observing something closely and describing it.",
        "materials": ["A mystery object in a bag or box"],
        "steps": [
            "A grown-up puts a small object inside a bag without showing it.",
            "Feel the object through the bag (or peek quickly) and think of 3 clues about it.",
            "Say your clues out loud, one at a time.",
            "Guess what the object is, then peek to check!",
        ],
        "tip": "Good detectives notice size, shape, and texture, not just one clue.",
    },
    {
        "name": "🔢 Number Line Hop",
        "objective": "Practice using logic to guess a hidden number using clues.",
        "materials": ["Paper with numbers 1-20 written in a line"],
        "steps": [
            "One player secretly picks a number between 1 and 20.",
            "Others guess a number, and the picker says 'higher' or 'lower.'",
            "Use each clue to narrow down your next guess.",
            "Keep guessing smarter until you find the secret number!",
        ],
        "tip": "Guessing right in the middle each time helps you find the number faster.",
    },
    {
        "name": "🎯 Invent a Game Rule",
        "objective": "Practice creating and explaining a brand-new simple rule for a familiar game.",
        "materials": ["A ball or beanbag"],
        "steps": [
            "Think of one new silly rule to add to a simple toss game (like 'only toss with your left hand').",
            "Explain your new rule to a partner.",
            "Play a few rounds using your invented rule.",
            "Ask your partner to invent a new rule too and try that one!",
        ],
        "tip": "Inventing new rules is a way of designing your very own game.",
    },
    {
        "name": "💭 Easy, Tricky, or Just Right?",
        "objective": "Practice reflecting on and describing how challenging a game felt.",
        "materials": ["None — just talking together"],
        "steps": [
            "After playing a game, pause and think back on it.",
            "Decide if it felt too easy, too tricky, or just right.",
            "Explain why you picked that answer.",
            "Think of one thing that would make it more fun next time!",
        ],
        "tip": "Thinking about how a challenge felt helps you pick better challenges next time.",
    },
]


GAMES[2] = [
    {
        "name": "🧠 Double Memory Match",
        "objective": "Practice remembering more card locations using a bigger matching grid.",
        "materials": ["12 cards (6 matching pairs)"],
        "steps": [
            "Lay all 12 cards face-down in a grid.",
            "Flip two cards at a time, trying to find a match.",
            "If it's not a match, flip both back and remember their spots.",
            "Keep playing until all 6 pairs are found — count your total flips!",
        ],
        "tip": "Try beating your own flip-count the next time you play.",
    },
    {
        "name": "⭕ Four in a Row Strategy",
        "objective": "Practice planning multiple moves ahead in a connect-the-dots strategy game.",
        "materials": ["Paper with a 4x4 grid of dots", "Pencil or 2 colors of tokens"],
        "steps": [
            "Draw a 4x4 grid of dots on paper.",
            "Take turns placing your token on a dot.",
            "Try to connect 4 of your tokens in a line while blocking your partner.",
            "First to connect 4 in a row wins — then swap who goes first!",
        ],
        "tip": "Look two moves ahead: what will your partner do after your turn?",
    },
    {
        "name": "🏙️ Block City Blueprint",
        "objective": "Practice planning a design on paper before building it with blocks.",
        "materials": ["Building blocks", "Paper and pencil"],
        "steps": [
            "Sketch a simple blueprint of a small building on paper first.",
            "Look at your blueprint and pick out the blocks you'll need.",
            "Build your design to match the blueprint as closely as you can.",
            "Compare your finished build to your sketch — how close was it?",
        ],
        "tip": "Planning first, then building, usually works better than building without a plan.",
    },
    {
        "name": "🗝️ Two-Step Code Breaker",
        "objective": "Practice using logic clues to crack a simple secret code.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "One player secretly writes a 3-symbol code using shapes or colors.",
            "The other guesses a 3-symbol sequence.",
            "The code-maker says how many symbols are correct (not positions).",
            "Use each clue to make a smarter next guess until it's cracked!",
        ],
        "tip": "Change just one symbol at a time so you know exactly what each clue means.",
    },
    {
        "name": "🧭 Mental Map Maze",
        "objective": "Practice picturing a path in your mind before tracing it.",
        "materials": ["A simple maze drawn on paper", "Pencil"],
        "steps": [
            "Look at a maze without touching your pencil to it yet.",
            "Trace the path with just your eyes to find a route to the end.",
            "Once you think you've found it, trace it with a pencil.",
            "Try a trickier maze and see if planning first still helps!",
        ],
        "tip": "Planning the whole route in your head first often beats guessing as you go.",
    },
    {
        "name": "🔤 Word Ladder Start",
        "objective": "Practice changing one letter at a time to turn one word into another.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Write a simple 3-letter word, like CAT.",
            "Change just one letter to make a brand-new real word (CAT to COT).",
            "Keep changing one letter at a time to make new words.",
            "See how many words you can make in a row!",
        ],
        "tip": "Say each new word out loud — sometimes hearing it helps you spot the next change.",
    },
    {
        "name": "🏗️ Tallest Paper Tower",
        "objective": "Design and test a free-standing tower using only paper and tape.",
        "materials": ["10 sheets of paper", "Tape", "A ruler (to measure)"],
        "steps": [
            "Think of a way to fold or roll paper to make it stand up tall.",
            "Build your tower using only paper and tape.",
            "Measure how tall it stands on its own.",
            "Redesign and try to beat your own height!",
        ],
        "tip": "Rolled or folded paper is much stronger than flat paper — try it and see.",
    },
    {
        "name": "🃏 Category Speed Round",
        "objective": "Practice thinking quickly of examples that belong to a category.",
        "materials": ["None — just quick thinking"],
        "steps": [
            "Pick a category, like 'animals' or 'fruits.'",
            "Take turns naming one example without repeating.",
            "Keep going faster each round — if you get stuck, you're out!",
            "Play again with a brand-new category.",
        ],
        "tip": "Grouping ideas in your head ahead of time (farm animals, zoo animals...) helps you think faster.",
    },
    {
        "name": "🧩 Tangram Shape Challenge",
        "objective": "Practice rotating and arranging shapes to build a bigger picture.",
        "materials": ["7 paper shapes cut into a simple tangram set (triangles, square, parallelogram)"],
        "steps": [
            "Cut a square of paper into 7 simple shapes (a basic tangram set).",
            "Try arranging all 7 pieces to build a picture, like a house or cat.",
            "If a piece doesn't fit, try rotating or flipping it.",
            "Once you finish one picture, try inventing your own!",
        ],
        "tip": "Flipping a piece over is allowed — don't forget that trick when stuck.",
    },
    {
        "name": "🎯 Twenty Questions Lite",
        "objective": "Practice asking smart yes/no questions to narrow down a hidden answer.",
        "materials": ["None — just thinking and talking"],
        "steps": [
            "One player secretly thinks of an animal.",
            "Others take turns asking yes/no questions to narrow it down.",
            "Use each answer to guide your next smarter question.",
            "Try to guess the animal in as few questions as possible!",
        ],
        "tip": "Big questions first ('Does it live in water?') narrow things down faster than small guesses.",
    },
    {
        "name": "🔧 Fix the Broken Toy Challenge",
        "objective": "Practice inventing a creative fix for a made-up broken-toy problem.",
        "materials": ["A toy (pretend it's 'broken' — like a wheel fell off)", "Craft supplies: tape, string, paper clips"],
        "steps": [
            "Pick a toy and imagine one part of it stopped working.",
            "Brainstorm 2-3 different ways you could fix it using your supplies.",
            "Pick your favorite idea and try building the fix.",
            "Test it out — did your fix work the way you hoped?",
        ],
        "tip": "Inventors almost always try more than one idea before finding the best one.",
    },
    {
        "name": "🧠 Where Am I Pointing?",
        "objective": "Practice using spatial words (left, right, above, below) to describe a location.",
        "materials": ["A simple picture with several objects on it"],
        "steps": [
            "Look at a busy picture with several objects together.",
            "One player secretly picks an object and describes its location using only direction words.",
            "The other player points to what they think is being described.",
            "Check if you found the right one, then switch turns!",
        ],
        "tip": "Precise words like 'above the tree, to the left of the house' work better than 'over there.'",
    },
    {
        "name": "🪞 Mirror Me Moves",
        "objective": "Practice copying a partner's movement pattern exactly like a mirror.",
        "materials": ["None — just two people and some space"],
        "steps": [
            "Stand facing a partner.",
            "One person slowly moves an arm, leg, or makes a face.",
            "The other copies it like a mirror reflection (opposite side).",
            "Switch who leads every 30 seconds!",
        ],
        "tip": "Watching closely and moving slowly makes mirroring much easier.",
    },
    {
        "name": "💭 My Thinking Steps",
        "objective": "Practice explaining out loud the steps you used to solve a puzzle.",
        "materials": ["Any puzzle or game played earlier"],
        "steps": [
            "After finishing a puzzle, pause before putting it away.",
            "Think back to the very first thing you tried.",
            "Explain out loud, step by step, what you did to solve it.",
            "Think of one thing you'd try first if you played again.",
        ],
        "tip": "Explaining your steps out loud helps your brain remember strategies for next time.",
    },
]


GAMES[3] = [
    {
        "name": "🧠 Speed Memory Grid",
        "objective": "Practice remembering a growing set of card locations under time pressure.",
        "materials": ["16 cards (8 matching pairs)", "A timer or phone stopwatch"],
        "steps": [
            "Lay all 16 cards face-down in a 4x4 grid.",
            "Time yourself finding all 8 matching pairs.",
            "Flip two cards at a time, remembering locations of cards you've already seen.",
            "Write down your time, then try to beat it in a rematch!",
        ],
        "tip": "Grouping the grid into sections in your mind can make it easier to track.",
    },
    {
        "name": "🔺 Five in a Row Strategy",
        "objective": "Practice thinking several moves ahead while blocking an opponent's plan.",
        "materials": ["Paper with a 6x6 grid", "Pencil or 2 colors of tokens"],
        "steps": [
            "Draw a 6x6 grid on paper.",
            "Take turns placing a token, trying to connect 5 in a row (any direction).",
            "Watch your partner's tokens closely — block them if they're close to 5.",
            "First to connect 5 in a row wins!",
        ],
        "tip": "A move that helps you AND blocks your partner is usually the strongest move.",
    },
    {
        "name": "🏗️ Load-Bearing Bridge",
        "objective": "Design, test, and improve a bridge that must hold a growing weight.",
        "materials": ["Craft sticks or paper strips", "Tape", "Small weights (coins or blocks) to test with"],
        "steps": [
            "Build a bridge across a gap using only craft sticks and tape.",
            "Test it by placing one coin on top, then adding coins one at a time.",
            "Note how many coins it holds before bending or breaking.",
            "Redesign one part and test again — did your fix add strength?",
        ],
        "tip": "Triangle shapes are much stronger than square shapes — engineers use this trick constantly.",
    },
    {
        "name": "🗝️ Three-Clue Code Breaker",
        "objective": "Practice using logical deduction to crack a hidden 4-symbol code.",
        "materials": ["Paper", "Pencil", "4 different colors or symbols"],
        "steps": [
            "One player secretly writes a 4-symbol code (repeats allowed).",
            "The other guesses a sequence of 4 symbols.",
            "The code-maker gives clues: how many are the right symbol, and how many are also in the right spot.",
            "Use the clues to narrow guesses until the code is cracked!",
        ],
        "tip": "Keep a written list of your guesses and clues — it's easy to lose track in your head.",
    },
    {
        "name": "🧭 Grid Coordinate Hunt",
        "objective": "Practice using row-and-column coordinates to locate hidden spots.",
        "materials": ["Paper with a labeled grid (A-E across, 1-5 down)", "Pencil"],
        "steps": [
            "Draw a 5x5 grid, labeling columns A-E and rows 1-5.",
            "One player secretly marks a hidden square, like C3, on their own hidden grid.",
            "The other guesses coordinates one at a time; the hider says 'hit' or 'miss.'",
            "Use each miss to narrow your next guess — find the hidden square!",
        ],
        "tip": "Guessing near the center first usually eliminates more possibilities than guessing an edge.",
    },
    {
        "name": "🔤 Word Ladder Challenge",
        "objective": "Practice changing one letter at a time to connect a start word to a target word.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pick a starting word and a target word with the same number of letters (COLD to WARM).",
            "Change exactly one letter at a time, making a real word each step.",
            "Keep going until you reach the target word.",
            "Try to reach it in the fewest steps possible!",
        ],
        "tip": "Sometimes it helps to work backward from the target word too.",
    },
    {
        "name": "🏙️ Blueprint Build Challenge",
        "objective": "Practice designing a structure to meet a specific requirement, then building it.",
        "materials": ["Building blocks or craft sticks", "Paper and pencil", "A small toy to test the design"],
        "steps": [
            "Pick a design challenge, like 'build a structure a toy car can drive under.'",
            "Sketch your plan on paper first.",
            "Build it to match your sketch.",
            "Test it with the toy — if it doesn't work, revise your blueprint and rebuild!",
        ],
        "tip": "Real designers redraw their blueprint after every failed test — that's not a mistake, it's the process.",
    },
    {
        "name": "🃏 Category Chain Reaction",
        "objective": "Practice connecting ideas by naming items that link category to category.",
        "materials": ["None — just quick thinking"],
        "steps": [
            "Start with a word, like 'apple.'",
            "The next player must name something connected to it, like 'apple' leads to 'tree.'",
            "Keep the chain going, explaining each connection out loud.",
            "See how long you can keep the chain before someone gets stuck!",
        ],
        "tip": "There's no single right answer — flexible thinking is what makes a good chain.",
    },
    {
        "name": "🧩 Tangram Silhouette Challenge",
        "objective": "Practice mentally rotating shapes to recreate a silhouette outline exactly.",
        "materials": ["A 7-piece paper tangram set", "A silhouette outline drawn or printed"],
        "steps": [
            "Look at a silhouette outline without touching the pieces yet.",
            "Plan in your head which shapes might fit where.",
            "Arrange all 7 tangram pieces to exactly fill the silhouette.",
            "Try a harder silhouette once you solve the first one!",
        ],
        "tip": "Picture rotating a piece in your mind before physically turning it — it builds your spatial thinking.",
    },
    {
        "name": "🎯 Twenty Questions Strategy",
        "objective": "Practice narrowing down a hidden answer using efficient, well-ordered questions.",
        "materials": ["None — just thinking and talking"],
        "steps": [
            "One player secretly thinks of any object, place, or person.",
            "Others ask only yes/no questions, starting broad and narrowing down.",
            "Keep track mentally of what's already been ruled out.",
            "Try to guess correctly in fewer than 15 questions!",
        ],
        "tip": "A great strategy is to split possibilities roughly in half with each question.",
    },
    {
        "name": "🔧 Redesign the Everyday Object",
        "objective": "Practice inventing an improved version of a common object to solve a problem.",
        "materials": ["Paper", "Pencil", "Craft supplies (optional, for a model)"],
        "steps": [
            "Pick a simple everyday object, like a backpack or umbrella.",
            "Think of one problem people have with it.",
            "Sketch (or build) your redesign that solves that problem.",
            "Explain your redesign to someone and see what they think!",
        ],
        "tip": "The best inventions usually solve just ONE clear problem really well.",
    },
    {
        "name": "🪞 Reverse Mirror Sequence",
        "objective": "Practice mentally reversing a sequence of movements to mirror it correctly.",
        "materials": ["None — just two people and some space"],
        "steps": [
            "One partner performs a sequence of 3 movements in a row.",
            "The other must copy it in mirror-image AND in reverse order.",
            "Check together if the reversed mirror sequence was correct.",
            "Switch roles and try a trickier sequence!",
        ],
        "tip": "Picture the whole sequence backward in your mind before you start moving.",
    },
    {
        "name": "🗺️ Shortest Path Planner",
        "objective": "Practice comparing multiple possible routes to find the most efficient one.",
        "materials": ["Paper with a simple map or grid drawn, with 2-3 stops marked", "Pencil"],
        "steps": [
            "Draw a simple map with a start point and 3 stops to visit.",
            "Sketch out 2 different possible routes that visit all stops.",
            "Count the steps or distance for each route.",
            "Pick the shorter route and explain why you chose it!",
        ],
        "tip": "Comparing more than one plan before choosing is exactly how real route-planning works.",
    },
    {
        "name": "💭 Strategy Replay",
        "objective": "Practice reflecting on which strategy worked and which didn't during a game.",
        "materials": ["Any strategy game played earlier this week"],
        "steps": [
            "After finishing a strategy game, think back over how you played.",
            "Identify one move or idea that worked well.",
            "Identify one move that didn't work as planned.",
            "Say out loud what you'd try differently next time.",
        ],
        "tip": "Thinking back on both your wins and your mistakes makes you a stronger strategist.",
    },
]


GAMES[4] = [
    {
        "name": "🧠 Memory Grid Master",
        "objective": "Practice tracking and recalling locations across a large matching grid under time pressure.",
        "materials": ["20 cards (10 matching pairs)", "A timer"],
        "steps": [
            "Lay all 20 cards face-down in a 4x5 grid.",
            "Time yourself finding all 10 pairs, flipping two cards per turn.",
            "Mentally note every card you see, even non-matches, for later.",
            "Record your time and try beating it in a rematch!",
        ],
        "tip": "Reviewing cards you've already seen (even the ones that didn't match) speeds up later turns.",
    },
    {
        "name": "🔺 Diagonal Strategy Grid",
        "objective": "Practice planning several moves ahead across rows, columns, and diagonals.",
        "materials": ["Paper with a 7x7 grid", "Pencil or 2 colors of tokens"],
        "steps": [
            "Draw a 7x7 grid; take turns placing a token, aiming to connect 5 in a row.",
            "Watch all directions (row, column, diagonal) for both your progress and your partner's.",
            "Play a move that blocks your partner while also building your own line, if possible.",
            "First to connect 5 in a row wins — discuss the winning strategy afterward!",
        ],
        "tip": "A move that creates two possible winning lines at once is very hard for an opponent to block.",
    },
    {
        "name": "🏗️ Maximum Weight Bridge",
        "objective": "Engineer, test, and refine a bridge design to hold the most weight for its material cost.",
        "materials": ["20 craft sticks", "Tape", "Small weights (coins) to test with", "Paper for sketching"],
        "steps": [
            "Sketch 2 different bridge designs on paper before building either one.",
            "Build your strongest design idea using no more than 20 craft sticks.",
            "Test it by adding coins one at a time until it fails, and record the count.",
            "Redesign the weakest part and rebuild to try beating your own score!",
        ],
        "tip": "Compare the weight held per stick used — the most 'efficient' design isn't always the biggest one.",
    },
    {
        "name": "🗝️ Four-Peg Code Breaker",
        "objective": "Practice systematic logical deduction to crack a hidden multi-symbol code.",
        "materials": ["Paper", "Pencil", "5-6 different colors or symbols"],
        "steps": [
            "One player secretly writes a 4-symbol code from 5-6 possible symbols (repeats allowed).",
            "The other guesses a full 4-symbol sequence.",
            "The code-maker gives feedback: correct symbol+position count, and correct symbol wrong-position count.",
            "Track every guess and clue in a chart, narrowing down until it's solved!",
        ],
        "tip": "A written chart of guesses and clues beats trying to hold it all in your head.",
    },
    {
        "name": "🧭 Battleship Coordinate Hunt",
        "objective": "Practice using a coordinate grid and probability thinking to find hidden targets.",
        "materials": ["Paper with two labeled 6x6 grids per player (columns A-F, rows 1-6)", "Pencil"],
        "steps": [
            "Each player secretly marks 3 hidden 'ships' (single squares) on their own grid.",
            "Take turns calling out coordinates to guess the other's ship locations.",
            "Mark hits and misses on your tracking grid to guide smarter future guesses.",
            "First to find all 3 of the other player's ships wins!",
        ],
        "tip": "After a hit, checking the squares right next to it is usually smarter than guessing randomly.",
    },
    {
        "name": "🔤 Word Ladder Puzzle Master",
        "objective": "Practice planning a multi-step chain of one-letter word changes to reach a target.",
        "materials": ["Paper", "Pencil", "A dictionary (optional, to check words)"],
        "steps": [
            "Pick a start word and a target word of equal length, like RICH to POOR.",
            "Plan possible middle words before committing to your first change.",
            "Change one letter at a time, keeping every step a real word.",
            "Compare your solution length with someone else's — who found a shorter ladder?",
        ],
        "tip": "Working from both ends toward the middle can reveal a shorter path than going straight through.",
    },
    {
        "name": "🏙️ Constraint Design Challenge",
        "objective": "Practice designing a structure that satisfies multiple specific requirements at once.",
        "materials": ["Building blocks or craft materials", "Paper and pencil", "A small object to test the design with"],
        "steps": [
            "Pick a design challenge with 2 requirements, like 'must hold a toy AND have a door.'",
            "Sketch 2 different plans that could meet both requirements.",
            "Build your best plan and test it against both requirements.",
            "If one requirement fails, revise just that part and retest!",
        ],
        "tip": "When a design has multiple requirements, check each one separately instead of just eyeballing the whole thing.",
    },
    {
        "name": "🃏 Category Chain Speed Round",
        "objective": "Practice quickly generating and justifying flexible category connections under time pressure.",
        "materials": ["A timer"],
        "steps": [
            "Start with any word and set a 60-second timer.",
            "Each player must name a connected word and briefly explain the link before time runs out.",
            "Keep the chain going, alternating turns, until time expires.",
            "Count how many links you made — try to beat your record next round!",
        ],
        "tip": "Unusual, creative connections count too, as long as you can explain the link.",
    },
    {
        "name": "🧩 Rotated Tangram Challenge",
        "objective": "Practice mentally rotating and flipping shapes without moving pieces until a plan is set.",
        "materials": ["A 7-piece paper tangram set", "A rotated or upside-down silhouette outline"],
        "steps": [
            "Look at a silhouette outline shown rotated or flipped from the 'normal' position.",
            "Plan in your head how each tangram piece needs to rotate to fit.",
            "Only after planning, move the pieces into place to fill the silhouette.",
            "Try a second silhouette using fewer 'trial and error' moves than the first!",
        ],
        "tip": "Mentally rotating a shape before touching it trains a skill engineers and architects use constantly.",
    },
    {
        "name": "🎯 Efficient Twenty Questions",
        "objective": "Practice using binary-split questioning strategy to minimize the number of guesses needed.",
        "materials": ["None — just thinking and talking"],
        "steps": [
            "One player secretly picks any object, person, or place.",
            "Others ask only yes/no questions, aiming to eliminate about half the possibilities each time.",
            "Track what's already been ruled in or out as you go.",
            "Try to correctly guess in fewer questions than your previous best!",
        ],
        "tip": "Questions like 'is it bigger than a chair?' cut possibilities in half far better than specific guesses.",
    },
    {
        "name": "🔧 Problem-Solution Pitch",
        "objective": "Practice identifying a real problem, inventing a solution, and explaining why it works.",
        "materials": ["Paper", "Pencil", "Craft supplies (optional, for a model)"],
        "steps": [
            "Think of a real small problem you notice at home or school.",
            "Brainstorm 2-3 possible solutions, listing a pro and con for each.",
            "Pick your best solution and sketch or build a simple model of it.",
            "Pitch your idea to someone, explaining the problem and why your solution helps!",
        ],
        "tip": "Explaining the 'why' behind your idea is just as important as the idea itself.",
    },
    {
        "name": "🪞 Multi-Step Mirror Reverse",
        "objective": "Practice holding and manipulating a longer movement sequence in working memory.",
        "materials": ["None — just two people and some space"],
        "steps": [
            "One partner performs a sequence of 4-5 movements in a row.",
            "The other must mentally reverse the order AND mirror each movement.",
            "Perform the reversed-mirrored sequence, then check together for accuracy.",
            "Take turns leading with increasingly longer sequences!",
        ],
        "tip": "Breaking the sequence into 2 smaller chunks in your memory makes reversing it much easier.",
    },
    {
        "name": "🗺️ Multi-Stop Route Optimizer",
        "objective": "Practice comparing several possible routes to find the most efficient order to visit multiple stops.",
        "materials": ["Paper with a simple map showing 4-5 stops and a start point", "Pencil"],
        "steps": [
            "Draw a map with a start point and 4-5 stops scattered around it.",
            "Sketch at least 2 different orders for visiting all the stops.",
            "Estimate the total distance or steps for each route.",
            "Choose the shortest route and explain your reasoning!",
        ],
        "tip": "This is the same kind of thinking delivery drivers and trip planners use every day.",
    },
    {
        "name": "💭 Strategy Debrief Journal",
        "objective": "Practice analyzing your own thinking process after a challenging game to improve future performance.",
        "materials": ["Paper", "Pencil", "Any strategy game played earlier this week"],
        "steps": [
            "After a strategy game, write down the strategy you used at the start.",
            "Note one moment where your strategy changed and why.",
            "Write one thing that worked well and one thing you'd change.",
            "Set one specific goal for your strategy next time you play!",
        ],
        "tip": "Writing your thinking down (not just saying it) makes the reflection stick longer.",
    },
]


GAMES[5] = [
    {
        "name": "🧠 Full Grid Memory Challenge",
        "objective": "Practice managing a large amount of spatial-memory information efficiently under time pressure.",
        "materials": ["24 cards (12 matching pairs)", "A timer"],
        "steps": [
            "Lay all 24 cards face-down in a 4x6 grid, and start the timer.",
            "Flip two cards per turn, working to find all 12 pairs.",
            "Use a mental system (like grouping the grid into quadrants) to track what you've seen.",
            "Record your total time and flip count, then challenge yourself to improve both!",
        ],
        "tip": "Competitive memory athletes use a system to organize what they see — try inventing your own.",
    },
    {
        "name": "🔺 Double-Threat Strategy Grid",
        "objective": "Practice recognizing and creating fork situations where two winning moves exist at once.",
        "materials": ["Paper with an 8x8 grid", "Pencil or 2 colors of tokens"],
        "steps": [
            "Draw an 8x8 grid; take turns placing tokens, aiming to connect 5 in a row.",
            "Look for a move that creates two possible winning lines simultaneously (a 'fork').",
            "Also watch for and block your partner's forks before they complete them.",
            "Play until someone connects 5, then discuss where the game's key turning point was!",
        ],
        "tip": "A fork is powerful because your opponent can only block one line — the other wins.",
    },
    {
        "name": "🏗️ Efficiency-Optimized Bridge",
        "objective": "Engineer a bridge that maximizes weight held per material used, applying trade-off thinking.",
        "materials": ["25 craft sticks", "Tape", "Small weights to test with", "Paper for sketching and data notes"],
        "steps": [
            "Sketch 2-3 different truss designs, predicting which will be strongest for its stick count.",
            "Build your top choice, using as few sticks as reasonably possible.",
            "Test with weights, recording your held-weight-to-stick-count ratio.",
            "Redesign to improve the ratio, and explain what trade-off you made!",
        ],
        "tip": "The strongest bridge isn't always the winner — the most efficient one (strength per stick) often is.",
    },
    {
        "name": "🗝️ Five-Peg Master Code",
        "objective": "Practice applying systematic elimination logic to crack a complex hidden code.",
        "materials": ["Paper", "Pencil", "6 different colors or symbols"],
        "steps": [
            "One player secretly writes a 5-symbol code from 6 possible symbols (repeats allowed).",
            "The other guesses a full sequence and receives feedback on correct symbol/position counts.",
            "Chart every guess and clue, and use logical elimination to rule out impossible codes.",
            "Try to crack the code in the fewest possible guesses — compare your best score!",
        ],
        "tip": "After a few guesses, some symbol combinations become logically impossible — cross them off to guess smarter.",
    },
    {
        "name": "🧭 Probability Battleship",
        "objective": "Practice applying probability thinking to make efficient guesses on a larger hidden grid.",
        "materials": ["Paper with two labeled 8x8 grids per player", "Pencil"],
        "steps": [
            "Each player secretly places 4 hidden ships (of different lengths) on their own grid.",
            "Take turns calling coordinates, tracking hits and misses on a record grid.",
            "After a hit, use the ship's likely length to predict and target nearby squares.",
            "First to sink all of the other player's ships wins!",
        ],
        "tip": "Longer ships have fewer possible positions — think about which squares are statistically more likely.",
    },
    {
        "name": "🔤 Two-Way Word Ladder",
        "objective": "Practice planning simultaneously from both a start and end word to find the shortest possible chain.",
        "materials": ["Paper", "Pencil", "A dictionary (optional, to verify words)"],
        "steps": [
            "Pick a challenging start and target word of equal length, like STONE to BREAD.",
            "Build possible word chains from the start AND separately from the end, working toward the middle.",
            "See where the two chains can connect into one full ladder.",
            "Count your total steps and try to beat it with a shorter chain next time!",
        ],
        "tip": "Meeting in the middle from both directions often finds a shorter path than working from one end only.",
    },
    {
        "name": "🏙️ Multi-Constraint Engineering Design",
        "objective": "Practice designing under 3+ simultaneous constraints and evaluating trade-offs between them.",
        "materials": ["Building materials (blocks, craft sticks, paper)", "Paper and pencil", "A test object"],
        "steps": [
            "Pick a challenge with 3 requirements (e.g., 'holds weight, uses under 15 pieces, has an opening').",
            "Sketch 2 different plans, noting which requirement each plan is weaker on.",
            "Build your strongest overall plan, and test it against all 3 requirements.",
            "Explain which requirement was hardest to satisfy and why!",
        ],
        "tip": "When requirements conflict, engineers pick the design with the best overall balance, not a perfect score on just one.",
    },
    {
        "name": "🃏 Rapid Category Web",
        "objective": "Practice building a web of flexible, justified connections between ideas under time pressure.",
        "materials": ["Paper", "Pencil", "A timer"],
        "steps": [
            "Write a starting word in the center of the paper.",
            "In 90 seconds, branch outward writing connected words, briefly justifying each link.",
            "Count how many valid connected branches you made.",
            "Compare webs with a partner — did you find different, equally valid connections?",
        ],
        "tip": "A web (not just a straight chain) lets you branch off in more than one direction — much faster.",
    },
    {
        "name": "🧩 Blind Tangram Planning",
        "objective": "Practice fully mentally solving a spatial puzzle before touching any pieces.",
        "materials": ["A 7-piece paper tangram set", "A complex silhouette outline"],
        "steps": [
            "Study a complex silhouette outline for up to 2 minutes without touching any pieces.",
            "Mentally plan the position and rotation of every single piece.",
            "Only once your full plan is set, place all 7 pieces to fill the silhouette.",
            "Compare how many pieces you placed correctly on the first try!",
        ],
        "tip": "This kind of full mental planning before acting is exactly what chess players and architects train.",
    },
    {
        "name": "🎯 Twenty Questions Championship",
        "objective": "Practice using optimal information-gathering strategy across a full multi-round competition.",
        "materials": ["None — just thinking and talking", "Paper to track scores (optional)"],
        "steps": [
            "Play several rounds of Twenty Questions, keeping score of questions used each round.",
            "For each round, plan your first 2-3 questions before asking, aiming to split possibilities evenly.",
            "After each round, briefly review which question wasted the most 'information.'",
            "Lowest total question count across all rounds wins the championship!",
        ],
        "tip": "A wasted question is one where the answer doesn't rule out many possibilities — avoid overly specific early guesses.",
    },
    {
        "name": "🔧 Real-World Problem Deep Dive",
        "objective": "Practice thoroughly analyzing a real problem from multiple angles before proposing a solution.",
        "materials": ["Paper", "Pencil", "Craft supplies (optional, for a model)"],
        "steps": [
            "Choose a real problem affecting your home, school, or community.",
            "List who is affected by the problem and what's been tried before, if anything.",
            "Brainstorm at least 3 different solution ideas, weighing a pro and con for each.",
            "Build or sketch your top idea, and prepare to explain your full reasoning!",
        ],
        "tip": "Understanding the problem deeply, before jumping to solutions, is what separates a good design process from a rushed one.",
    },
    {
        "name": "🪞 Chained Reflection Sequence",
        "objective": "Practice mentally transforming a long movement sequence through multiple operations at once.",
        "materials": ["None — just two or more people and some space"],
        "steps": [
            "One partner performs a sequence of 6+ movements in a row.",
            "The others must mentally reverse the order, mirror each movement, AND wait 5 seconds before starting.",
            "Perform the transformed sequence, then check accuracy together as a group.",
            "Take turns leading, and try adding one more transformation rule each round!",
        ],
        "tip": "Breaking a long sequence into smaller memorable chunks (chunking) is a real memory-science strategy.",
    },
    {
        "name": "🗺️ Traveling Route Challenge",
        "objective": "Practice solving a simplified version of finding the most efficient order to visit many locations.",
        "materials": ["Paper with a map showing 6-7 stops and a start/end point", "Pencil"],
        "steps": [
            "Draw a map with a start point and 6-7 scattered stops that must all be visited once.",
            "Try out at least 3 different visiting orders, estimating the total distance for each.",
            "Identify your shortest route found so far.",
            "Challenge a partner to try to beat your best route!",
        ],
        "tip": "This puzzle (visiting many stops in the shortest order) is a real, famously hard problem computer scientists still study.",
    },
    {
        "name": "💭 Metacognitive Strategy Audit",
        "objective": "Practice deeply analyzing your own problem-solving strategy to identify patterns across multiple games.",
        "materials": ["Paper", "Pencil", "Notes from at least 2 games played this week"],
        "steps": [
            "Review your notes or memory of 2 different strategy games you've played.",
            "Identify one strategy or habit that showed up in both games.",
            "Decide if that habit generally helps or hurts your performance.",
            "Write one specific, actionable change to try in your next game!",
        ],
        "tip": "Spotting a pattern across multiple games (not just one) reveals your real thinking habits, not just a lucky or unlucky moment.",
    },
]


GAMES[6] = [
    {
        "name": "🧠 Championship Memory Grid",
        "objective": "Practice managing a large-scale memory task using a personal organizational system.",
        "materials": ["30 cards (15 matching pairs)", "A timer", "Paper to sketch your system (optional)"],
        "steps": [
            "Lay all 30 cards face-down in a 5x6 grid, and start the timer.",
            "Before flipping, decide on a system for tracking what you see (grid coordinates, grouping, etc.).",
            "Find all 15 pairs, using your system to avoid re-checking known cards.",
            "Record your time and flip-efficiency (flips per pair found), then aim to beat both!",
        ],
        "tip": "Having a deliberate system beats relying on raw memory alone — that's true for real memory competitions too.",
    },
    {
        "name": "🔺 Grand Master Strategy Grid",
        "objective": "Practice advanced multi-move planning, including sacrificing a smaller advantage for a bigger one.",
        "materials": ["Paper with a 10x10 grid", "Pencil or 2 colors of tokens"],
        "steps": [
            "Draw a 10x10 grid; take turns placing tokens, aiming to connect 5 in a row.",
            "Plan at least 2 moves ahead, considering how your partner might respond to each option.",
            "Watch for opportunities to set up a fork (two threats at once) rather than just blocking.",
            "Play to a finish, then walk through the game together identifying the critical turning point!",
        ],
        "tip": "Sometimes ignoring a small threat to set up a bigger unstoppable one is the winning move — that's real strategic thinking.",
    },
    {
        "name": "🏗️ Optimized Load Bridge Engineering",
        "objective": "Apply structural engineering trade-off analysis to design the most efficient bridge possible.",
        "materials": ["30 craft sticks", "Tape", "A set of standard test weights (coins)", "Paper for data and sketches"],
        "steps": [
            "Research or recall one real bridge design principle (truss, arch, suspension) before sketching.",
            "Sketch 2-3 designs applying that principle, predicting relative strength and material cost.",
            "Build and test your best design, recording weight held versus sticks used.",
            "Write a short analysis: what worked, what you'd change, and why!",
        ],
        "tip": "Real bridge engineers always report a strength-to-material ratio, not just raw strength — try thinking the same way.",
    },
    {
        "name": "🗝️ Master Code Breaker",
        "objective": "Practice full systematic logical deduction to solve a complex multi-symbol code efficiently.",
        "materials": ["Paper", "Pencil", "6-8 different colors or symbols"],
        "steps": [
            "One player secretly writes a 5-symbol code from 8 possible symbols (repeats allowed).",
            "The other guesses, receiving position and symbol-match feedback each round.",
            "Build a logical elimination chart, tracking every impossible combination as you go.",
            "Try to crack the code using the theoretical minimum number of guesses — research shows it's possible in very few!",
        ],
        "tip": "Mathematicians have studied this exact game and shown it can always be solved in a small, fixed number of optimal guesses.",
    },
    {
        "name": "🧭 Strategic Probability Battleship",
        "objective": "Practice applying probability and Bayesian-style reasoning to optimize search efficiency.",
        "materials": ["Paper with two labeled 10x10 grids per player", "Pencil"],
        "steps": [
            "Each player secretly places 5 ships of varying lengths on their own grid.",
            "Take turns guessing coordinates, tracking probability 'heat' for likely ship locations based on misses.",
            "After every hit, calculate the most likely direction the rest of the ship extends.",
            "First to sink all the other player's ships wins — discuss your probability strategy afterward!",
        ],
        "tip": "Professional game theorists study exactly this kind of search-and-probability strategy — you're doing real applied math.",
    },
    {
        "name": "🔤 Constrained Word Ladder Challenge",
        "objective": "Practice solving a word-transformation puzzle under an added difficulty constraint.",
        "materials": ["Paper", "Pencil", "A dictionary (optional, to verify words)"],
        "steps": [
            "Pick a challenging start and target word, and add one constraint (e.g., every word must be 5 letters).",
            "Plan possible paths from both ends toward the middle, honoring the constraint.",
            "Build your full ladder, checking every word is real and meets the rule.",
            "Compare your ladder length with a partner's — whose solution was more efficient?",
        ],
        "tip": "Adding a constraint (like a fixed word length) makes the puzzle harder but often reveals a cleverer solution path.",
    },
    {
        "name": "🏙️ Trade-Off Engineering Studio",
        "objective": "Practice designing under competing constraints and clearly justifying the trade-offs made.",
        "materials": ["Building materials (blocks, craft sticks, paper)", "Paper and pencil", "A test object or scenario"],
        "steps": [
            "Pick a challenge with constraints that conflict (e.g., 'lightweight but very strong, and cheap' — using a set piece budget).",
            "Sketch 2-3 designs, explicitly labeling what each design sacrifices to gain something else.",
            "Build and test your chosen design against every constraint.",
            "Present your design, explaining exactly which trade-off you chose and why it made sense!",
        ],
        "tip": "Being able to explain WHY you gave something up is the mark of real engineering thinking, not just guessing.",
    },
    {
        "name": "🃏 Six-Degrees Connection Challenge",
        "objective": "Practice building a long, logically justified chain connecting two seemingly unrelated ideas.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pick two very different starting and ending words (like 'ocean' and 'guitar').",
            "Build a connected chain of ideas linking one to the other, explaining each link.",
            "Try to connect them in 6 steps or fewer.",
            "Challenge someone else to find an even shorter valid chain!",
        ],
        "tip": "This is inspired by the real 'six degrees of separation' idea — almost anything can be logically connected in surprisingly few steps.",
    },
    {
        "name": "🧩 Constraint Tangram Design",
        "objective": "Practice inventing an original silhouette design using all pieces under a specific rule.",
        "materials": ["A 7-piece paper tangram set", "Paper to trace your design"],
        "steps": [
            "Set yourself a design rule, like 'create an animal using every piece exactly once.'",
            "Plan mentally, then arrange all 7 pieces to create your original silhouette.",
            "Trace around your finished design onto paper.",
            "Challenge a partner to recreate your design using only your traced outline!",
        ],
        "tip": "Designing your own puzzle (not just solving one) exercises a completely different, more advanced part of spatial thinking.",
    },
    {
        "name": "🎯 Information Theory Guessing Game",
        "objective": "Practice using strategic questioning to minimize guesses across a large possibility space.",
        "materials": ["A picture or list showing 30+ possible items", "Paper to track eliminations"],
        "steps": [
            "One player secretly picks an item from a large set (30+ options shown to everyone).",
            "Others ask only yes/no questions, tracking eliminations on paper as they go.",
            "Aim to cut the remaining possibilities roughly in half with every question.",
            "Compare your final question count to the mathematical minimum needed for that many options!",
        ],
        "tip": "For 30+ items, splitting possibilities evenly means you can usually find the answer in about 5 well-chosen questions.",
    },
    {
        "name": "🔧 Full Design Thinking Sprint",
        "objective": "Practice the complete design-thinking cycle: empathize, define, ideate, prototype, and test.",
        "materials": ["Paper", "Pencil", "Craft supplies for a quick prototype"],
        "steps": [
            "Interview a family member or friend about one small frustration in their daily routine (empathize).",
            "Clearly define the specific problem in one sentence.",
            "Brainstorm at least 4 possible solutions before picking your favorite (ideate).",
            "Build a quick prototype and get feedback from that person, then note one improvement to make!",
        ],
        "tip": "This 5-step process — empathize, define, ideate, prototype, test — is the same cycle real product designers use.",
    },
    {
        "name": "🪞 Multi-Layer Transformation Chain",
        "objective": "Practice mentally applying and tracking several sequential transformations to a complex sequence.",
        "materials": ["None — just two or more people and some space"],
        "steps": [
            "One partner performs a sequence of 6-8 movements in a row.",
            "The others must apply 3 transformations in order: reverse it, mirror it, then skip every other movement.",
            "Perform the fully transformed sequence, then check accuracy together as a group.",
            "Take turns leading and inventing new transformation combinations to apply!",
        ],
        "tip": "Holding several transformation rules in mind at once and applying them in the right order is advanced working-memory training.",
    },
    {
        "name": "🗺️ Optimization Under Constraints",
        "objective": "Practice solving a route-planning puzzle with an added real-world constraint like a time or fuel budget.",
        "materials": ["Paper with a map showing 8+ stops and a start/end point", "Pencil"],
        "steps": [
            "Draw a map with a start point and 8+ stops, each with a different 'cost' (distance or time) to reach.",
            "Add a constraint: you can only visit 6 of the 8 stops within a limited total budget.",
            "Test different combinations of stops and orders to maximize value within the budget.",
            "Present your best solution and explain which stops you chose to skip and why!",
        ],
        "tip": "Choosing what NOT to do, given limited resources, is just as important a skill as planning what to do.",
    },
    {
        "name": "💭 Personal Strategy Portfolio",
        "objective": "Practice building a long-term, evidence-based understanding of your own thinking strengths and habits.",
        "materials": ["Paper or a notebook", "Pencil", "Notes from at least 3 different games played over time"],
        "steps": [
            "Review notes or memories from at least 3 different thinking games you've played recently.",
            "Identify one thinking strength that shows up consistently across them.",
            "Identify one habit that consistently holds you back or wastes time.",
            "Write a short 'strategy plan' with 2 specific things to try in your next challenging game!",
        ],
        "tip": "Tracking your thinking across many games — not just reflecting after one — is how real experts build lasting self-awareness.",
    },
]


GAMES[7] = [
    {
        "name": "🧠 Elite Memory Championship",
        "objective": "Practice applying an advanced personal memory system to master a large-scale recall challenge.",
        "materials": ["36 cards (18 matching pairs)", "A timer", "Paper to design your memory system"],
        "steps": [
            "Before starting, design and write out your own memory system (chunking, coordinates, story-linking, etc.).",
            "Lay all 36 cards face-down in a 6x6 grid, and start the timer.",
            "Find all 18 pairs using your system, refining it mid-game if it's not working well.",
            "Record your time and reflect on which part of your system helped most!",
        ],
        "tip": "World memory champions all use invented systems, not raw memorization — building your own is real cognitive science in action.",
    },
    {
        "name": "🔺 Tournament Strategy Grid",
        "objective": "Practice deep multi-move strategic planning across a full best-of-three match format.",
        "materials": ["Paper with a 12x12 grid", "Pencil or 2 colors of tokens"],
        "steps": [
            "Draw a 12x12 grid; play a best-of-3 match, connecting 5 in a row to win each game.",
            "Between games, discuss what opening strategy worked and adjust your approach.",
            "In each game, plan at least 3 moves ahead and watch for double-threat opportunities.",
            "Whoever wins 2 of 3 games is the match champion — analyze the deciding game together!",
        ],
        "tip": "Studying your own games afterward, like real strategy-game competitors do, improves your play faster than just playing more.",
    },
    {
        "name": "🏗️ Full Engineering Design Report",
        "objective": "Apply the complete engineering design process — research, design, build, test, iterate, report.",
        "materials": ["35 craft sticks", "Tape", "A set of standard test weights", "Paper for a written design report"],
        "steps": [
            "Research one real structural principle and explain in writing how it applies to your build.",
            "Sketch and label 2-3 candidate designs, predicting strength and material efficiency for each.",
            "Build and test your chosen design, recording data at each weight increment until failure.",
            "Write a short report: hypothesis, results, and what you'd change in version 2!",
        ],
        "tip": "Writing a real design report — not just building — is what turns a fun project into genuine engineering practice.",
    },
    {
        "name": "🗝️ Optimal-Strategy Code Breaker",
        "objective": "Practice applying a proven optimal opening strategy to minimize guesses in a logic-deduction game.",
        "materials": ["Paper", "Pencil", "8 different colors or symbols"],
        "steps": [
            "One player secretly writes a 5-symbol code from 8 symbols (repeats allowed).",
            "Before guessing, plan a fixed opening strategy designed to gather the most information possible.",
            "Guess and track feedback in a systematic elimination chart, adjusting your strategy as clues arrive.",
            "Try to consistently solve the code in 6 guesses or fewer across several rounds!",
        ],
        "tip": "This exact puzzle has a mathematically proven optimal strategy — see if you can rediscover its logic through play.",
    },
    {
        "name": "🧭 Adversarial Search Battleship",
        "objective": "Practice modeling an opponent's likely strategy while applying your own probability-based search.",
        "materials": ["Paper with two labeled 10x10 grids per player", "Pencil"],
        "steps": [
            "Each player secretly places 5 ships of varying lengths, thinking about where an opponent is LEAST likely to guess.",
            "Take turns guessing, tracking both your own probability map and guessing where your opponent might avoid.",
            "Adjust your placement strategy in a rematch based on what worked against you.",
            "Play a best-of-3 series and discuss which placement and search strategies were strongest!",
        ],
        "tip": "Thinking about how your OPPONENT thinks (not just the raw odds) is the next level up in game strategy — it's called 'theory of mind.'",
    },
    {
        "name": "🔤 Constrained Optimization Word Ladder",
        "objective": "Practice solving a word-transformation puzzle while optimizing for the shortest possible valid path.",
        "materials": ["Paper", "Pencil", "A dictionary (optional, to verify words)"],
        "steps": [
            "Pick a difficult start and target word pair, and set yourself a target step-count to beat.",
            "Work from both ends simultaneously, mapping possible middle connection points.",
            "Build your full ladder and verify every word is valid.",
            "Try a second, harder word pair, applying the strategy that worked best the first time!",
        ],
        "tip": "This puzzle mirrors real 'shortest-path' problems used in computer science and network routing.",
    },
    {
        "name": "🏙️ Systems-Level Design Challenge",
        "objective": "Practice designing a solution that considers how multiple interacting parts affect each other.",
        "materials": ["Building materials (blocks, craft sticks, paper)", "Paper and pencil", "A test scenario"],
        "steps": [
            "Pick a challenge involving multiple connected parts (e.g., a small town layout with roads, a bridge, and a park).",
            "Sketch how each part affects the others (e.g., where the bridge goes affects where the road can go).",
            "Build your design, checking that all parts work together, not just individually.",
            "Present your design, explaining one trade-off where improving one part meant compromising another!",
        ],
        "tip": "Thinking about how parts of a system affect each other, not just one piece at a time, is called 'systems thinking' — a core skill in real engineering.",
    },
    {
        "name": "🃏 Cross-Domain Connection Marathon",
        "objective": "Practice building sophisticated, well-reasoned chains of connection across very different domains of knowledge.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pick two words from completely different domains (like 'volcano' and 'symphony').",
            "Build the shortest logical chain of connected ideas linking them, explaining each link clearly.",
            "Try to reach the connection in 5 steps or fewer.",
            "Trade starting pairs with a partner and compare whose chain used more creative reasoning!",
        ],
        "tip": "The ability to find non-obvious connections across different fields is a hallmark of highly creative and innovative thinkers.",
    },
    {
        "name": "🧩 Original Puzzle Design Studio",
        "objective": "Practice designing an original spatial puzzle for someone else to solve, including a difficulty rating.",
        "materials": ["A 7-piece paper tangram set (or graph paper for a custom puzzle)", "Paper"],
        "steps": [
            "Design an original silhouette or spatial puzzle using your materials.",
            "Solve it yourself first to confirm it's actually solvable.",
            "Rate its difficulty (easy/medium/hard) and write one hint for solvers.",
            "Give it to a partner to solve, and see if your difficulty rating matched their experience!",
        ],
        "tip": "Designing a puzzle requires understanding the solution even more deeply than solving one does.",
    },
    {
        "name": "🎯 Optimal Information Strategy Game",
        "objective": "Practice applying formal information-theory reasoning to minimize guesses across a very large possibility space.",
        "materials": ["A list or picture showing 50+ possible items", "Paper to track eliminations"],
        "steps": [
            "One player secretly picks an item from a large set (50+ options).",
            "Others plan a strategy that splits possibilities as evenly as possible with each question.",
            "Track eliminations carefully, refining your questioning strategy as you go.",
            "Compare your final question count to the mathematical minimum for that many options (about 6)!",
        ],
        "tip": "This is a simplified version of how computer scientists measure the efficiency of real search and sorting algorithms.",
    },
    {
        "name": "🔧 Community Problem Design Sprint",
        "objective": "Practice the full design-thinking cycle applied to a genuine problem affecting a wider group of people.",
        "materials": ["Paper", "Pencil", "Craft supplies for a quick prototype"],
        "steps": [
            "Identify a real problem affecting your school, neighborhood, or community (not just yourself).",
            "Interview at least one other person affected by it to understand their perspective.",
            "Brainstorm and narrow down to your strongest solution idea, considering cost and feasibility.",
            "Build a prototype or detailed plan, and present it as if pitching to people who could actually implement it!",
        ],
        "tip": "The strongest designs come from deeply understanding a problem from other people's perspectives, not just your own.",
    },
    {
        "name": "🪞 Recursive Transformation Challenge",
        "objective": "Practice applying a transformation rule to its own output, testing deep working-memory and abstraction.",
        "materials": ["None — just two or more people and some space"],
        "steps": [
            "One partner performs a sequence of 5 movements.",
            "The group applies a transformation rule (like 'reverse and mirror') to create a new sequence.",
            "Now apply the SAME transformation rule again to that new sequence, and perform the final result.",
            "Check accuracy together, then invent a new transformation rule to apply recursively!",
        ],
        "tip": "Applying a rule to its own result is called recursion — a concept at the core of both math and computer programming.",
    },
    {
        "name": "🗺️ Real-World Logistics Simulation",
        "objective": "Practice solving a realistic, constrained optimization problem similar to real delivery or scheduling systems.",
        "materials": ["Paper with a map showing 10+ stops with varying priorities and a start/end point", "Pencil"],
        "steps": [
            "Draw a map with a start point and 10+ stops, each labeled with a priority level and a travel cost.",
            "Set a limited total budget (time, distance, or fuel) that can't cover every stop.",
            "Plan a route maximizing total priority value visited within budget, testing multiple combinations.",
            "Present your final route and defend why it's the best possible use of a limited budget!",
        ],
        "tip": "This mirrors exactly how real delivery companies and emergency responders plan efficient routes under real-world limits.",
    },
    {
        "name": "💭 Cognitive Strategy Research Project",
        "objective": "Practice conducting a small self-directed investigation into what thinking strategies work best for you personally.",
        "materials": ["Paper or a notebook", "Pencil", "Several different thinking games played over at least a week"],
        "steps": [
            "Choose 2 different strategies to test across multiple plays of the same type of game (e.g., planning ahead vs. reacting).",
            "Track your results and how each strategy felt across several games.",
            "Analyze which strategy performed better and think about why.",
            "Write a short conclusion with your personal 'best strategy' recommendation and evidence for it!",
        ],
        "tip": "This is literally the scientific method applied to your own brain — forming a hypothesis, testing it, and drawing conclusions.",
    },
]


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    # Plain ASCII " | " separator — a non-ASCII middle-dot separator here
    # previously got double-UTF8-encoded somewhere in the sqlcmd/ODBC file-
    # reading pipeline (confirmed live: " · " landed in the DB as the
    # literal 4-character sequence " Â· "), and a plain comma is
    # ambiguous since several material descriptions already contain commas
    # inside their own parenthetical text (e.g. "(leaf, rock, flower...)").
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 73_cognitive_skills_games_content.sql")
    out.append("-- Adds a 'Brain & Strategy Games' category to the existing always-on")
    out.append("-- 'cognitive_skills' subject_area for every grade (TK-6th) — no schema or")
    out.append("-- proc changes needed, reuses dbo.PacketSubjectAreas/")
    out.append("-- usp_GetOrCreateWeeklyPacket exactly as-is (see 64_sel_cognitive_content.sql")
    out.append("-- for the other cognitive_skills categories already shipped: Critical")
    out.append("-- Thinking, Design Thinking & Innovation, Metacognition, Problem-Solving,")
    out.append("-- Spatial Awareness).")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual")
    out.append("-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation")
    out.append("-- serves a different 7-of-14 combination most weeks a grade's")
    out.append("-- cognitive_skills category is selected, satisfying \"7 brain games,")
    out.append("-- different set each week\" without any manual per-week authoring.")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions (already-shipped diagram type, renders as a numbered list in")
    out.append("-- both the app and print — see 63_whole_child_rotation.sql).")
    out.append("-- See gen_73_cognitive_skills_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'cognitive_skills' AND category_name = N'Brain & Strategy Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_cog_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'cognitive_skills', N'Brain & Strategy Games', 'space_heavy', 7, N'Challenge your brain with a fun thinking game this week!', 0);"
        )
        out.append(f"    SET {var} = SCOPE_IDENTITY();")
        for qi, game in enumerate(games, start=1):
            prompt = build_prompt(game)
            diagram_data = {"steps": game["steps"]}
            cols = ["category_id", "question_type", "prompt", "choices_json", "answer_text", "sort_order", "diagram_type", "diagram_data"]
            vals = [var, esc("short_response"), esc(prompt), "NULL", esc(game["tip"]), str(qi),
                    esc("sequence_steps"), esc(json.dumps(diagram_data, ensure_ascii=False))]
            out.append(
                f"    INSERT INTO dbo.PacketQuestions ({', '.join(cols)}) VALUES\n"
                f"        ({', '.join(vals)});"
            )
        out.append("")

    out.append("END")
    out.append("GO")
    out.append("")
    out.append("DELETE FROM dbo.WeeklyPacketPlan;")
    out.append("GO")
    return "\n".join(out)


def check_completeness():
    ok = True
    for grade_id in GRADE_IDS:
        n = len(GAMES[grade_id])
        if n != 14:
            print(f"INCOMPLETE: grade {GRADE_LABELS[grade_id]} has {n} games, expected 14")
            ok = False
        names = [g["name"] for g in GAMES[grade_id]]
        if len(names) != len(set(names)):
            dupes = [n for n in names if names.count(n) > 1]
            print(f"DUPLICATE within grade {GRADE_LABELS[grade_id]}: {set(dupes)}")
            ok = False
        for game in GAMES[grade_id]:
            for key in ("name", "objective", "materials", "steps", "tip"):
                if key not in game or not game[key]:
                    print(f"MISSING '{key}' in grade {GRADE_LABELS[grade_id]} game {game.get('name')}")
                    ok = False
    return ok


if __name__ == "__main__":
    import sys
    if not check_completeness():
        sys.exit(1)
    total_games = sum(len(v) for v in GAMES.values())
    print(f"Grades: {len(GAMES)}, Total games: {total_games}", file=sys.stderr)
    # newline="" prevents Python's default Windows text-mode translation of
    # "\n" to "\r\n" — without it, every embedded "\n\n" inside a prompt
    # string (used to separate Name/Objective/Materials) gets written as a
    # literal "\r\n" into the SQL file, which then lands as-is inside the
    # quoted N'...' string literal and gets stored verbatim in the database.
    # Hit this for real on the outdoor-games batch: shipped 112 rows with
    # \r\n before catching it. See gen_68_outdoor_games_content.py.
    with open(r"D:\Project\www\littlescholarhub\lsh.database\73_cognitive_skills_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 73_cognitive_skills_games_content.sql", file=sys.stderr)
