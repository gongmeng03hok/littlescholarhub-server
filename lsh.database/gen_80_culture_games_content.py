# -*- coding: utf-8 -*-
"""
Generates lsh.database/80_culture_games_content.sql -- adds a "Traditions &
Culture Games" category to the existing 'culture' subject_area (already
shipped -- no schema/proc changes needed) for every grade TK-6th. Each
grade gets a pool of 14 hand-crafted games, each inspired by a real
traditional/folk game tradition from a different world region (Africa,
China/Vietnam, Scandinavia, India, Mexico, South/Southeast Asia, global
Indigenous traditions, France/Mediterranean, Japan/Korea/Caribbean, West
Africa, Philippines) -- all with fully ORIGINAL rule-writing (no rules,
rhymes, or chants copied from any existing source), kept secular and
respectful, and spread across many different regions rather than
concentrated in one or two. See gen_68_outdoor_games_content.py, this
file's proven template.

Run with: python gen_80_culture_games_content.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), tip
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "\U0001FAA8 Pebble Pit Count",
        "objective": "Practice counting small stones into cups, inspired by pit-and-stone counting games played for generations across many African communities.",
        "materials": ["12 small stones or dried beans", "2 small cups or bowls"],
        "steps": [
            "Set the two cups side by side.",
            "Take turns dropping one stone into a cup while counting out loud.",
            "Keep going until all the stones are in cups.",
            "Count together how many stones ended up in each cup!",
        ],
        "tip": "Counting out loud together makes it easy to keep track as you go.",
    },
    {
        "name": "\U0001FA84 Shuttlecock Keepy-Up",
        "objective": "Practice gentle kicking and balance, inspired by shuttlecock-kicking games long enjoyed in China and Vietnam.",
        "materials": ["A soft balled-up sock or beanbag"],
        "steps": [
            "Stand in a small circle with a grown-up or friend.",
            "Gently kick the soft sock up so someone else can catch it.",
            "Take turns kicking and catching, staying in your circle.",
            "See how many kicks you can do together before it touches the ground!",
        ],
        "tip": "Soft, gentle kicks work best -- this is about teamwork, not power.",
    },
    {
        "name": "\U0001F9F1 Toppling Blocks Challenge",
        "objective": "Practice aiming and throwing, inspired by wooden block-toppling yard games traditionally played in Scandinavia.",
        "materials": ["5-6 small blocks or empty boxes", "1 soft ball"],
        "steps": [
            "Stack the blocks in a row standing up.",
            "Stand a few steps back.",
            "Take turns gently rolling the ball to knock blocks down.",
            "Cheer every time a block topples over!",
        ],
        "tip": "A slow, aimed roll knocks down more blocks than a fast wild one.",
    },
    {
        "name": "\U0001F3A8 Chalk Pattern Wheel",
        "objective": "Practice drawing simple round patterns, inspired by rangoli floor-art traditions from India.",
        "materials": ["Sidewalk chalk or crayons and paper"],
        "steps": [
            "Draw one big circle to start.",
            "Fill it with simple shapes and dots in bright colors.",
            "Add more circles and patterns around it if you'd like.",
            "Step back and admire your colorful pattern together!",
        ],
        "tip": "There's no wrong way to fill your circle -- every pattern is special.",
    },
    {
        "name": "\U0001F0CF Calling Cards Match",
        "objective": "Practice matching pictures, inspired by picture-calling card games traditionally played in Mexico.",
        "materials": ["6-8 simple picture cards (draw or print pairs of matching pictures)"],
        "steps": [
            "Spread the picture cards face up on the floor.",
            "A grown-up calls out one picture's name.",
            "Find and point to that picture as fast as you can.",
            "Take turns calling out the next picture!",
        ],
        "tip": "Look carefully at each picture before the next one is called.",
    },
    {
        "name": "\U0001FA81 Paper Kite Flutter",
        "objective": "Practice a simple craft and gentle running, inspired by kite-flying traditions loved across South and Southeast Asia.",
        "materials": ["1 sheet of paper", "A little tape", "A short piece of string"],
        "steps": [
            "With a grown-up, fold or tape the paper into a simple kite shape.",
            "Tape a short string to the front.",
            "Hold the string and walk (or gently jog) so the paper flutters behind you.",
            "See whose paper kite flutters the highest!",
        ],
        "tip": "A light breeze or a happy little run makes the paper flutter best.",
    },
    {
        "name": "\U0001FAA2 Simple String Loop",
        "objective": "Practice hand movements with a loop of string, inspired by string-figure games found in cultures all over the world.",
        "materials": ["A loop of string or yarn, tied at the ends"],
        "steps": [
            "Loop the string loosely around your fingers.",
            "With help, stretch it out to make a simple shape, like a triangle.",
            "Show a friend your shape.",
            "Try making a different shape together!",
        ],
        "tip": "It's okay if the shape looks wobbly -- every try makes a new pattern.",
    },
    {
        "name": "\U0001F3B1 Rolling Ball Target",
        "objective": "Practice rolling a ball toward a target, inspired by boules-style rolling games traditionally played in France and along the Mediterranean.",
        "materials": ["1 small ball as a target", "2-3 larger soft balls"],
        "steps": [
            "Place the small ball on the ground a few steps away.",
            "Take turns gently rolling a larger ball, trying to get close to it.",
            "See whose ball landed the closest.",
            "Roll again and try to get even closer!",
        ],
        "tip": "A slow, careful roll is easier to aim than a fast one.",
    },
    {
        "name": "\u26AA Marble Roll Match",
        "objective": "Practice rolling and aiming small objects, inspired by marble games played by children in many cultures around the world.",
        "materials": ["4-5 marbles or small round objects", "A hula hoop or chalk circle"],
        "steps": [
            "Draw or place a circle on the ground.",
            "Take turns gently rolling a marble, trying to land it inside the circle.",
            "Count how many marbles land inside.",
            "Collect them and roll again!",
        ],
        "tip": "Rolling low and slow keeps your marble from bouncing out of the circle.",
    },
    {
        "name": "\U0001FA84 Ring Toss Catch",
        "objective": "Practice tossing and catching, inspired by ring-and-pin catching games from Indigenous traditions of North America.",
        "materials": ["1 soft ring (or a paper ring taped closed)", "A cone or bottle"],
        "steps": [
            "Stand a small ring-toss cone or bottle upright nearby.",
            "Hold the ring and gently toss it toward the cone.",
            "Cheer when the ring lands around it!",
            "Take turns tossing again and again.",
        ],
        "tip": "A gentle underhand toss is easier to aim than a hard throw.",
    },
    {
        "name": "\U0001F44F Clap-Along Rhyme",
        "objective": "Practice a simple clapping pattern with a partner, inspired by hand-clapping game traditions found in cultures worldwide.",
        "materials": ["None -- just you and a partner"],
        "steps": [
            "Face a partner and hold up both hands.",
            "Clap your own hands together, then clap both hands with your partner.",
            "Repeat the pattern together, saying a simple made-up rhyme as you clap.",
            "Try clapping a little faster once you've got it!",
        ],
        "tip": "It's okay to giggle and miss a clap -- try again from the start!",
    },
    {
        "name": "\U0001FA80 Spinning Top Watch",
        "objective": "Practice careful watching and turn-taking, inspired by spinning-top traditions enjoyed in Japan, Korea, and the Caribbean.",
        "materials": ["1 simple spinning top (or a bottle cap spun by hand)"],
        "steps": [
            "A grown-up spins the top on a flat surface.",
            "Watch closely and count how many seconds it spins.",
            "Cheer when it wobbles to a stop.",
            "Take turns spinning it again!",
        ],
        "tip": "Watching quietly helps you count every second the top spins.",
    },
    {
        "name": "\u2753 Animal Riddle Circle",
        "objective": "Practice listening for clues, inspired by riddle-telling traditions long shared in storytelling circles across West Africa.",
        "materials": ["None -- just a group and your imagination"],
        "steps": [
            "A grown-up describes an animal with simple clues, like 'I am big and gray and have a long trunk.'",
            "Guess which animal it is.",
            "Clap when you guess correctly!",
            "Take turns giving the next animal clue.",
        ],
        "tip": "Listening to every clue before guessing helps you get it right!",
    },
    {
        "name": "\U0001F463 Simple Rhythm Steps",
        "objective": "Practice stepping to a beat, inspired by rhythmic stepping games and dances found in Philippine culture and beyond.",
        "materials": ["None -- just open floor space"],
        "steps": [
            "A grown-up claps a simple steady beat.",
            "Step side to side in time with the clapping.",
            "Try clapping your own hands along with your steps too.",
            "See if you can keep going without missing a beat!",
        ],
        "tip": "Listening closely to the beat helps your feet stay right on time.",
    },
]


GAMES[1] = [
    {
        "name": "\U0001FAA8 Two-Cup Pit Count",
        "objective": "Practice counting and simple strategy moving stones between cups, inspired by pit-and-stone counting games played for generations across many African communities.",
        "materials": ["16 small stones or dried beans", "2 small cups or bowls"],
        "steps": [
            "Place 8 stones in each cup.",
            "Take turns moving 1-3 stones from your cup into your partner's cup.",
            "Count out loud each time you move stones.",
            "See how the totals change back and forth as you keep playing!",
        ],
        "tip": "Counting carefully each turn keeps the game fair for both players.",
    },
    {
        "name": "\U0001FA84 Shuttlecock Circle Count",
        "objective": "Practice kicking accuracy and counting together, inspired by shuttlecock-kicking games long enjoyed in China and Vietnam.",
        "materials": ["A soft balled-up sock or beanbag"],
        "steps": [
            "Stand in a circle of 3 or more players.",
            "Gently kick the sock to a friend across the circle.",
            "Count out loud together every successful kick.",
            "Try to beat your group's best count from last time!",
        ],
        "tip": "Watching where your friend is standing before you kick helps your aim.",
    },
    {
        "name": "\U0001F9F1 Block Toppling Score",
        "objective": "Practice aiming and simple scorekeeping, inspired by wooden block-toppling yard games traditionally played in Scandinavia.",
        "materials": ["6 small blocks or empty boxes", "1 soft ball"],
        "steps": [
            "Stand the blocks up in a row a few steps away.",
            "Take turns rolling the ball to knock blocks down.",
            "Count how many blocks each person knocks down in their turn.",
            "Stand the blocks back up and play another round!",
        ],
        "tip": "Aiming for the middle of the row can sometimes topple more than one block.",
    },
    {
        "name": "\U0001F3A8 Symmetry Pattern Draw",
        "objective": "Practice drawing a pattern that matches on both sides, inspired by symmetrical rangoli floor-art traditions from India.",
        "materials": ["Sidewalk chalk or crayons and paper"],
        "steps": [
            "Draw one line straight down the middle of your space.",
            "Draw a simple shape or dot pattern on one side.",
            "Copy the exact same pattern on the other side, like a mirror.",
            "Add color to your finished symmetrical design!",
        ],
        "tip": "Checking back and forth between both sides as you go keeps them matching.",
    },
    {
        "name": "\U0001F0CF Memory Match Cards",
        "objective": "Practice remembering picture locations, inspired by picture-calling and matching card games traditionally played in Mexico.",
        "materials": ["8 matching picture-pair cards (16 cards total)"],
        "steps": [
            "Lay all the cards face down in rows.",
            "Take turns flipping two cards to try to find a matching pair.",
            "If they match, keep them and go again; if not, flip them back and pass your turn.",
            "See who collects the most matching pairs!",
        ],
        "tip": "Try to remember where cards were even when they don't match -- it helps next time!",
    },
    {
        "name": "\U0001FA81 Kite Flight Distance",
        "objective": "Practice a simple craft and measuring how far you can make it flutter, inspired by kite-flying traditions loved across South and Southeast Asia.",
        "materials": ["1 sheet of paper", "Tape", "String", "Sidewalk chalk (optional, to mark distance)"],
        "steps": [
            "Fold or tape the paper into a simple kite shape and attach a string.",
            "Mark a starting line with chalk.",
            "Walk or jog forward holding your kite string, letting it flutter behind you.",
            "Mark how far you walked before it touched the ground, then try to beat it!",
        ],
        "tip": "A steady jog keeps a paper kite fluttering longer than starting and stopping.",
    },
    {
        "name": "\U0001FAA2 Two-Shape String Challenge",
        "objective": "Practice making and changing hand shapes with string, inspired by string-figure games found in cultures all over the world.",
        "materials": ["A loop of string or yarn, tied at the ends"],
        "steps": [
            "Loop the string around your fingers to make a simple shape.",
            "Show a partner, then carefully change your fingers to make a second, different shape.",
            "Let your partner try copying both shapes.",
            "Take turns inventing a new shape of your own!",
        ],
        "tip": "Moving one finger at a time makes it much easier to change from one shape to the next.",
    },
    {
        "name": "\U0001F3B1 Closest Roll Wins",
        "objective": "Practice rolling and comparing distances, inspired by boules-style rolling games traditionally played in France and along the Mediterranean.",
        "materials": ["1 small target ball", "3 larger soft balls per player"],
        "steps": [
            "Place the target ball on the ground a few steps away.",
            "Each player rolls their balls, trying to land closest to the target.",
            "Compare together whose ball ended up closest.",
            "Play again and see who wins the most rounds!",
        ],
        "tip": "Watching how far your first roll went helps you adjust your next one.",
    },
    {
        "name": "\u26AA Marble Circle Knockout",
        "objective": "Practice aiming one marble at another, inspired by marble games played by children in many cultures around the world.",
        "materials": ["6-8 marbles or small round objects", "A hula hoop or chalk circle"],
        "steps": [
            "Place several marbles inside a chalk circle.",
            "Take turns gently rolling one marble from outside the circle to knock others out.",
            "Collect any marble you knock all the way out.",
            "See who collects the most marbles by the end!",
        ],
        "tip": "Aiming at the edge of a marble, not straight at the middle, often knocks it farther.",
    },
    {
        "name": "\U0001FA84 Ring Toss Points",
        "objective": "Practice tossing accuracy and simple scoring, inspired by ring-and-pin catching games from Indigenous traditions of North America.",
        "materials": ["3 soft rings", "1-2 cones or bottles at different distances"],
        "steps": [
            "Set up cones at a close distance and a farther distance.",
            "Take turns tossing rings, scoring more points for the farther cone.",
            "Add up your points after 3 tosses each.",
            "Play another round and try to beat your own score!",
        ],
        "tip": "A gentle, arcing toss lands more accurately than a flat, hard throw.",
    },
    {
        "name": "\U0001F44F Two-Partner Clap Pattern",
        "objective": "Practice a slightly longer clapping sequence with a partner, inspired by hand-clapping game traditions found in cultures worldwide.",
        "materials": ["None -- just you and a partner"],
        "steps": [
            "Face your partner and invent a 4-step clap pattern together (like clap-own-hands, clap-partner, clap-own, clap-partner).",
            "Practice it slowly a few times until you both remember it.",
            "Speed it up once you both have it down.",
            "Try making up your own new pattern with a rhyme!",
        ],
        "tip": "Practicing slowly first makes speeding up later much easier.",
    },
    {
        "name": "\U0001FA80 Spin Time Contest",
        "objective": "Practice counting seconds and comparing results, inspired by spinning-top traditions enjoyed in Japan, Korea, and the Caribbean.",
        "materials": ["1-2 simple spinning tops (or bottle caps spun by hand)"],
        "steps": [
            "Take turns spinning your top on a flat surface.",
            "Count out loud together how many seconds each spin lasts.",
            "Keep track of whose spin lasted the longest.",
            "Try again and see if you can beat your own best time!",
        ],
        "tip": "A firm, quick flick of the wrist usually makes a top spin longer.",
    },
    {
        "name": "\u2753 Two-Clue Riddle Round",
        "objective": "Practice giving and following short clues, inspired by riddle-telling traditions long shared in storytelling circles across West Africa.",
        "materials": ["None -- just a group and your imagination"],
        "steps": [
            "One player thinks of an animal or object and gives one clue.",
            "If no one guesses, give a second clue.",
            "Whoever guesses first gets to give the next riddle.",
            "Keep the riddles going around the group!",
        ],
        "tip": "A good clue describes something without giving the whole answer away too fast.",
    },
    {
        "name": "\U0001F463 Beat-and-Clap Steps",
        "objective": "Practice combining footsteps and claps to a steady beat, inspired by rhythmic stepping games and dances found in Philippine culture and beyond.",
        "materials": ["None -- just open floor space"],
        "steps": [
            "Start with a steady clapped beat from a partner or grown-up.",
            "Step side to side while clapping your own hands on every other beat.",
            "Try adding a small hop on the beat once you've got the pattern.",
            "See how long you can keep the pattern going without losing the beat!",
        ],
        "tip": "Counting '1, 2, 3, 4' quietly in your head helps you stay right on the beat.",
    },
]


GAMES[2] = [
    {
        "name": "\U0001FAA8 Pit Row Strategy",
        "objective": "Practice planning several moves ahead while counting stones between pits, inspired by pit-and-stone counting games played for generations across many African communities.",
        "materials": ["18 small stones or dried beans", "4 small cups or bowls arranged in a row"],
        "steps": [
            "Place 3 stones in each of the 4 cups.",
            "On your turn, scoop all stones from one of your cups and drop one into each cup going forward.",
            "Take turns doing this, watching how the stones spread out.",
            "Talk about which cup you picked and why after a few rounds!",
        ],
        "tip": "Picking a cup with just the right number of stones can help you land your last one in a cup you like.",
    },
    {
        "name": "\U0001FA84 Shuttlecock Rally Count",
        "objective": "Practice sustained accuracy in a group, inspired by shuttlecock-kicking games long enjoyed in China and Vietnam.",
        "materials": ["A soft balled-up sock or beanbag"],
        "steps": [
            "Stand in a circle with your group.",
            "Kick the sock to keep it going without letting it touch the ground.",
            "Count every kick out loud as a team.",
            "Try to beat your team's highest rally count!",
        ],
        "tip": "Calling out 'mine!' before you kick helps avoid bumping into a teammate.",
    },
    {
        "name": "\U0001F9F1 Precision Block Topple",
        "objective": "Practice aiming for a specific target block, inspired by wooden block-toppling yard games traditionally played in Scandinavia.",
        "materials": ["6 small blocks with numbers or letters on them", "1 soft ball per player"],
        "steps": [
            "Label each block with a number and stand them in a row.",
            "Before rolling, call out which numbered block you're aiming for.",
            "Roll and see if you topple the block you called.",
            "Score a point for every block you knock down that you actually called!",
        ],
        "tip": "Lining your body up directly with your target block before rolling improves your aim.",
    },
    {
        "name": "\U0001F3A8 Four-Fold Pattern Design",
        "objective": "Practice repeating a pattern in four matching sections, inspired by geometric rangoli floor-art traditions from India.",
        "materials": ["Sidewalk chalk or crayons and paper"],
        "steps": [
            "Draw a large circle and divide it into four equal sections with two crossing lines.",
            "Design a small pattern in just one section.",
            "Copy that exact same pattern into the other three sections.",
            "Add color once all four sections match!",
        ],
        "tip": "Turning your paper as you draw each section can make copying the pattern easier.",
    },
    {
        "name": "\U0001F0CF Category Match Round",
        "objective": "Practice sorting picture cards into matching categories, inspired by picture-calling and matching card games traditionally played in Mexico.",
        "materials": ["16-20 picture cards from a few categories (animals, food, weather, etc.)"],
        "steps": [
            "Shuffle all the cards together and deal them out evenly.",
            "Take turns calling out a category, like 'animals!'",
            "Everyone places down any matching cards from their hand.",
            "Play until all cards are sorted -- see who placed the most!",
        ],
        "tip": "Sorting your cards by category in your hand first makes them faster to spot.",
    },
    {
        "name": "\U0001FA81 Kite Steering Challenge",
        "objective": "Practice controlling a simple kite's flutter path, inspired by kite-flying traditions loved across South and Southeast Asia.",
        "materials": ["1 sheet of paper", "Tape", "String", "2 cones to mark a path"],
        "steps": [
            "Build your simple paper kite and attach a string.",
            "Set up two cones a short distance apart as a path to follow.",
            "Jog your kite along the path between the cones, trying to keep it fluttering the whole way.",
            "Try again and see if you can complete the path without it touching the ground!",
        ],
        "tip": "Keeping a steady, even pace works better than sudden bursts of speed.",
    },
    {
        "name": "\U0001FAA2 Three-Shape String Story",
        "objective": "Practice transitioning between multiple hand shapes in a sequence, inspired by string-figure games found in cultures all over the world.",
        "materials": ["A loop of string or yarn, tied at the ends"],
        "steps": [
            "Make a first shape with the string on your fingers.",
            "Carefully change your fingers to turn it into a second shape, then a third.",
            "Practice the sequence until you can go through all three smoothly.",
            "Perform your three-shape sequence for a partner!",
        ],
        "tip": "Doing one finger movement at a time, and checking the shape after each one, prevents tangles.",
    },
    {
        "name": "\U0001F3B1 Team Rolling Points",
        "objective": "Practice rolling with teammates and combining scores, inspired by boules-style rolling games traditionally played in France and along the Mediterranean.",
        "materials": ["1 small target ball", "2 larger soft balls per team"],
        "steps": [
            "Split into two small teams and place the target ball a few steps away.",
            "Each team member rolls, trying to land closest to the target.",
            "Add up how many of your team's balls are closer than the other team's closest ball.",
            "Play several rounds and keep a running team score!",
        ],
        "tip": "A teammate calling out how close the last roll landed helps the next roller aim better.",
    },
    {
        "name": "\u26AA Marble Ring Tournament",
        "objective": "Practice aiming under a bit of pressure in a mini tournament, inspired by marble games played by children in many cultures around the world.",
        "materials": ["8-10 marbles or small round objects", "A hula hoop or chalk circle"],
        "steps": [
            "Place marbles inside a chalk circle and take turns trying to knock them out.",
            "Play head-to-head matches -- whoever knocks out more marbles in their turns wins the round.",
            "Winners play winners until you have a tournament champion.",
            "Reset the circle and play again!",
        ],
        "tip": "Watching how your opponent's marble curves can help you predict your own roll.",
    },
    {
        "name": "\U0001FA84 Multi-Distance Ring Toss",
        "objective": "Practice adjusting your toss for different distances and scoring, inspired by ring-and-pin catching games from Indigenous traditions of North America.",
        "materials": ["4 soft rings", "3 cones set at close, medium, and far distances"],
        "steps": [
            "Set up three cones at close, medium, and far distances, each worth different points.",
            "Take turns tossing all 4 rings, choosing which cone to aim for each time.",
            "Add up your total points after your turn.",
            "Play several rounds and track your best score!",
        ],
        "tip": "Aiming for the closer cone first can help you warm up your toss before trying the farther one.",
    },
    {
        "name": "\U0001F44F Rhyming Clap Chain",
        "objective": "Practice a clapping pattern paired with an original rhyming chant, inspired by hand-clapping game traditions found in cultures worldwide.",
        "materials": ["None -- just you and a partner"],
        "steps": [
            "With a partner, make up a short 2-line rhyme about something silly.",
            "Invent a clap pattern to go along with each line.",
            "Practice saying the rhyme while clapping the pattern together.",
            "Teach your rhyme and pattern to another pair!",
        ],
        "tip": "Keeping the clap pattern simple at first makes it easier to add the rhyme on top.",
    },
    {
        "name": "\U0001FA80 Top Battle Arena",
        "objective": "Practice spinning technique and friendly competition, inspired by spinning-top traditions enjoyed in Japan, Korea, and the Caribbean.",
        "materials": ["2-3 simple spinning tops (or bottle caps spun by hand)", "A shallow box or circle as the arena"],
        "steps": [
            "Mark a small circle or shallow box as the spinning 'arena.'",
            "Two players spin their tops inside the arena at the same time.",
            "Whoever's top spins the longest, or stays inside the arena, wins the round.",
            "Take turns and see who wins the most rounds!",
        ],
        "tip": "Spinning near the center of the arena gives your top more room before it wanders out.",
    },
    {
        "name": "\u2753 Three-Clue Riddle Challenge",
        "objective": "Practice crafting riddles with exactly three clues, inspired by riddle-telling traditions long shared in storytelling circles across West Africa.",
        "materials": ["Paper and pencil (optional, for writing clues)"],
        "steps": [
            "Pick a secret object or animal and write (or think of) exactly three clues about it, from tricky to easier.",
            "Share your clues one at a time with the group.",
            "See how many clues it takes before someone guesses correctly.",
            "Take turns being the riddle-giver!",
        ],
        "tip": "Starting with your trickiest clue makes the riddle more fun to solve.",
    },
    {
        "name": "\U0001F463 Four-Beat Step Pattern",
        "objective": "Practice a repeating four-beat footwork pattern, inspired by rhythmic stepping games and dances found in Philippine culture and beyond.",
        "materials": ["None -- just open floor space"],
        "steps": [
            "Learn a simple 4-beat pattern: step right, together, step left, together.",
            "Practice it slowly to a clapped or counted beat.",
            "Once comfortable, try doing it with a partner side by side.",
            "Speed up together once you both have the pattern down!",
        ],
        "tip": "Practicing the pattern without music first, just counting beats, builds a strong foundation.",
    },
]


GAMES[3] = [
    {
        "name": "\U0001FAA8 Sowing Pit Strategy",
        "objective": "Practice multi-step planning while sowing stones around a row of pits, inspired by pit-and-stone counting games played for generations across many African communities.",
        "materials": ["24 small stones or dried beans", "6 small cups or bowls arranged in a row"],
        "steps": [
            "Place 4 stones in each of the 6 cups.",
            "On your turn, scoop all stones from one cup and drop one into each following cup, going around the row.",
            "Take turns, trying to plan which cup gives you the best next move.",
            "Play until the stones settle into an interesting pattern, then talk about your strategy!",
        ],
        "tip": "Thinking one move ahead about where your last stone will land helps you plan your turn.",
    },
    {
        "name": "\U0001FA84 Shuttlecock Trick Rally",
        "objective": "Practice a variety of kicking techniques in a rally, inspired by shuttlecock-kicking games long enjoyed in China and Vietnam.",
        "materials": ["A soft balled-up sock or beanbag"],
        "steps": [
            "Stand in a circle and agree on 2-3 allowed kick types (inside foot, heel, knee bump).",
            "Rally the sock around, calling out which kick type you used.",
            "Count how many total kicks your group gets using all the different types.",
            "Try to beat your group's best combined rally count!",
        ],
        "tip": "Calling out your kick type as you use it helps everyone track the group's variety.",
    },
    {
        "name": "\U0001F9F1 Points-Value Block Topple",
        "objective": "Practice strategic aiming with different point values, inspired by wooden block-toppling yard games traditionally played in Scandinavia.",
        "materials": ["6 blocks labeled with different point values", "1 ball per player"],
        "steps": [
            "Arrange blocks in a row, giving harder-to-hit blocks a higher point value.",
            "Take turns rolling, adding up the value of any blocks you topple.",
            "Play 3 rounds each, resetting the blocks between rounds.",
            "See who scores the highest total across all their rounds!",
        ],
        "tip": "Sometimes aiming for a lower-value block you can reliably hit beats risking a miss on a high-value one.",
    },
    {
        "name": "\U0001F3A8 Radial Symmetry Pattern",
        "objective": "Practice designing a pattern with matching sections radiating from a center point, inspired by rangoli floor-art traditions from India.",
        "materials": ["Sidewalk chalk or crayons and paper", "A small object to trace a center circle (optional)"],
        "steps": [
            "Draw a small circle in the center of your space.",
            "Divide the space around it into 6 equal sections, like slices of a pie.",
            "Design one slice's pattern, then repeat it in all 6 sections.",
            "Add color, keeping the color pattern matching in every slice too!",
        ],
        "tip": "Working outward from the center in the same order each time keeps every slice consistent.",
    },
    {
        "name": "\U0001F0CF Storytelling Card Round",
        "objective": "Practice building a short story using drawn cards in order, inspired by picture-calling card game traditions from Mexico.",
        "materials": ["10-12 picture cards (characters, places, objects)"],
        "steps": [
            "Shuffle the cards and place them face down in a pile.",
            "Each player draws 3 cards and has a minute to think of a short story connecting all three.",
            "Take turns telling your mini stories to the group.",
            "Vote together on the most creative connection!",
        ],
        "tip": "The most surprising story connections often come from linking cards in an unexpected order.",
    },
    {
        "name": "\U0001FA81 Kite Design & Distance Trial",
        "objective": "Practice engineering a paper kite for better flight and testing it, inspired by kite-flying traditions loved across South and Southeast Asia.",
        "materials": ["2-3 sheets of paper", "Tape", "String", "Sidewalk chalk to mark distance"],
        "steps": [
            "Build a first simple paper kite and test how far you can fly it, marking the distance.",
            "Redesign it once (different shape, added tail, different string length) to try to improve it.",
            "Test your redesigned kite and compare the new distance to your first try.",
            "Discuss which change made the biggest difference!",
        ],
        "tip": "Changing only one thing at a time between tests makes it clear what actually helped.",
    },
    {
        "name": "\U0001FAA2 Teach-a-Shape String Chain",
        "objective": "Practice teaching and learning string figures from each other, inspired by string-figure games found in cultures all over the world.",
        "materials": ["A loop of string or yarn per player, tied at the ends"],
        "steps": [
            "Each player practices making their own string shape until they can do it smoothly.",
            "Pair up and teach your shape to your partner, step by step.",
            "Learn your partner's shape in return.",
            "See how many total shapes your whole group can now do together!",
        ],
        "tip": "Breaking your shape into small numbered steps makes it much easier to teach someone else.",
    },
    {
        "name": "\U0001F3B1 Scoring Zone Roll",
        "objective": "Practice rolling with strategy using scoring zones, inspired by boules-style rolling games traditionally played in France and along the Mediterranean.",
        "materials": ["Sidewalk chalk to draw scoring zones", "1 small target ball", "3 larger soft balls per player"],
        "steps": [
            "Draw rings of chalk around the target ball, worth more points closer to the middle.",
            "Take turns rolling, trying to land in the highest-scoring zone.",
            "Add up your points after 3 rolls each.",
            "Play a second round and see if you can improve your score!",
        ],
        "tip": "A ball already close to the target can sometimes be used as a bumper to help your next roll settle nearby.",
    },
    {
        "name": "\u26AA Marble Ring Championship",
        "objective": "Practice a bracket-style marble tournament with simple strategy, inspired by marble games played by children in many cultures around the world.",
        "materials": ["10-12 marbles or small round objects", "A hula hoop or chalk circle"],
        "steps": [
            "Set up a bracket so players face off two at a time.",
            "In each match, whoever knocks more marbles out of the circle advances.",
            "Keep playing matches until one champion remains.",
            "Reset the circle and hold a rematch with new marble placements!",
        ],
        "tip": "Aiming to knock out marbles near the circle's edge is usually easier than ones near the center.",
    },
    {
        "name": "\U0001FA84 Ring Toss Relay Points",
        "objective": "Practice tossing accuracy under a team-relay format, inspired by ring-and-pin catching games from Indigenous traditions of North America.",
        "materials": ["6 soft rings", "3 cones at different distances", "2 cones for a relay start line"],
        "steps": [
            "Split into two teams lined up at a start line.",
            "One player at a time runs up, tosses all their rings at the distance cones, then tags the next teammate.",
            "Add up your whole team's points after everyone has gone.",
            "Play a second round and see if your team can beat its own score!",
        ],
        "tip": "Calling out encouragement to your current thrower helps keep the whole team's energy up.",
    },
    {
        "name": "\U0001F44F Call-and-Response Clap Song",
        "objective": "Practice a longer call-and-response clapping routine with an original chant, inspired by hand-clapping game traditions found in cultures worldwide.",
        "materials": ["None -- just a small group"],
        "steps": [
            "As a group, invent a short call-and-response chant (one leader line, one group response line).",
            "Create a clap pattern for the leader's line and a different one for the group's response.",
            "Practice the full call-and-response with clapping until it flows smoothly.",
            "Perform it for another group and teach it to them!",
        ],
        "tip": "Keeping the leader and response clap patterns clearly different helps everyone know when to switch.",
    },
    {
        "name": "\U0001FA80 Top Endurance League",
        "objective": "Practice technique refinement across multiple rounds, inspired by spinning-top traditions enjoyed in Japan, Korea, and the Caribbean.",
        "materials": ["2-3 simple spinning tops (or bottle caps spun by hand)", "A timer or clock"],
        "steps": [
            "Each player gets 3 spins, timed with a clock or timer.",
            "Record your longest spin time out of the 3 tries.",
            "Compare your longest times as a group.",
            "Adjust your technique and play a second league round to try to beat your record!",
        ],
        "tip": "A consistent, practiced flick usually beats a rushed, extra-hard one.",
    },
    {
        "name": "\u2753 Original Riddle Exchange",
        "objective": "Practice writing and trading original riddles with the group, inspired by riddle-telling traditions long shared in storytelling circles across West Africa.",
        "materials": ["Paper and pencil, one per player"],
        "steps": [
            "Each player secretly writes an original riddle about an everyday object.",
            "Fold up your riddle and trade with another player.",
            "Read the riddle you received aloud to the group and try to solve it together.",
            "Reveal the answer and discuss what made the riddle tricky or clear!",
        ],
        "tip": "A riddle that describes what something DOES, not just what it looks like, is often trickier and more fun.",
    },
    {
        "name": "\U0001F463 Six-Beat Partner Steps",
        "objective": "Practice a longer partner footwork routine set to a steady beat, inspired by rhythmic stepping games and dances found in Philippine culture and beyond.",
        "materials": ["None -- just open floor space"],
        "steps": [
            "Learn a 6-beat pattern with a partner: 3 steps forward together, 3 steps back together.",
            "Practice slowly to a counted or clapped beat until it's smooth.",
            "Add a small turn or clap on the final beat once you're both confident.",
            "Perform your full routine for another pair!",
        ],
        "tip": "Locking eyes with your partner while stepping helps you both stay perfectly in time.",
    },
]


GAMES[4] = [
    {
        "name": "\U0001FAA8 Full-Row Sowing Match",
        "objective": "Practice a fuller version of pit-and-stone strategy across two rows of pits, inspired by pit-and-stone counting games played for generations across many African communities.",
        "materials": ["36 small stones or dried beans", "8 small cups or bowls in two rows of 4 (one row per player)"],
        "steps": [
            "Place 4 stones in each of the 8 cups, four cups belonging to each player.",
            "On your turn, scoop all stones from one of your own cups and sow one into each following cup around both rows.",
            "If your last stone lands in an empty cup on your own side, you may capture the stones across from it.",
            "Play until all cups are empty, then count who captured the most stones!",
        ],
        "tip": "Watching which of your cups are close to becoming empty helps you set up a capture in advance.",
    },
    {
        "name": "\U0001FA84 Shuttlecock Skill Relay",
        "objective": "Practice a sequence of shuttlecock-kicking skills in a timed relay, inspired by shuttlecock-kicking games long enjoyed in China and Vietnam.",
        "materials": ["A soft balled-up sock or beanbag per team", "A timer"],
        "steps": [
            "Split into small teams and agree on a sequence of 3 kicking skills (like inside-foot, alternate-foot, knee bump) each player must complete in order.",
            "Time how long it takes each team to have everyone complete the full sequence without dropping the sock.",
            "If a player drops it, they restart their own sequence, not the whole team.",
            "Compare team times and try a second round to beat them!",
        ],
        "tip": "Slowing down slightly on the trickiest skill in your sequence often saves time overall by avoiding drops.",
    },
    {
        "name": "\U0001F9F1 Team Block Topple League",
        "objective": "Practice team strategy and turn order for maximum points, inspired by wooden block-toppling yard games traditionally played in Scandinavia.",
        "materials": ["8 blocks labeled with point values", "2 balls per team"],
        "steps": [
            "Split into two teams and set the labeled blocks up between them.",
            "Teams alternate turns, discussing as a group which blocks to aim for before each roll.",
            "Track a running team score across several rounds.",
            "The team with the highest total score after 4 rounds wins!",
        ],
        "tip": "Deciding your target as a team before rolling, instead of changing your mind mid-throw, usually helps aim.",
    },
    {
        "name": "\U0001F3A8 Eight-Fold Mandala Pattern",
        "objective": "Practice precise geometric repetition across eight matching sections, inspired by intricate rangoli floor-art traditions from India.",
        "materials": ["Sidewalk chalk or crayons and paper", "A ruler or straight edge (optional)"],
        "steps": [
            "Draw a center point and divide the space around it into 8 equal sections using straight lines.",
            "Design a detailed pattern in one section, using at least 3 different shapes.",
            "Carefully repeat the exact same pattern in all 8 sections.",
            "Color the finished mandala, keeping the color scheme consistent across all sections!",
        ],
        "tip": "Measuring your angles evenly with a ruler before drawing keeps all 8 sections truly matching.",
    },
    {
        "name": "\U0001F0CF Five-Card Story Chain",
        "objective": "Practice building a longer connected story with a group using drawn cards, inspired by picture-calling card game traditions from Mexico.",
        "materials": ["15-20 picture cards (characters, places, objects, events)"],
        "steps": [
            "Shuffle the cards and deal 5 to each player, keeping them hidden.",
            "Going around the group, each player adds one card and one story sentence that connects to what came before.",
            "Keep going until every player has used all 5 of their cards.",
            "Read the whole connected story aloud together from start to finish!",
        ],
        "tip": "Listening carefully to the last sentence before adding your own keeps the story making sense.",
    },
    {
        "name": "\U0001FA81 Kite Engineering Trials",
        "objective": "Practice a full design-test-redesign engineering cycle, inspired by kite-flying traditions loved across South and Southeast Asia.",
        "materials": ["3-4 sheets of paper", "Tape", "String of different lengths", "Sidewalk chalk to mark distances"],
        "steps": [
            "Build and test a first kite design, recording the distance it flew.",
            "Change exactly one variable (tail length, string length, or shape) and test again.",
            "Repeat for a third design, changing one more variable.",
            "Compare all three results and discuss which single change helped the most!",
        ],
        "tip": "Keeping a simple written record of each design's changes and results makes comparing them much easier.",
    },
    {
        "name": "\U0001FAA2 String Figure Story Sequence",
        "objective": "Practice performing a sequence of string figures that tells a simple story, inspired by string-figure games found in cultures all over the world.",
        "materials": ["A loop of string or yarn per player, tied at the ends"],
        "steps": [
            "Learn 2-3 different string figures on your own first.",
            "Decide on a simple story that connects your figures in order (like a shape becoming a different shape).",
            "Practice transitioning smoothly from one figure to the next as you narrate the story.",
            "Perform your string-figure story for another group!",
        ],
        "tip": "Practicing just the transition between two figures, separately from the full figures themselves, makes the whole sequence smoother.",
    },
    {
        "name": "\U0001F3B1 Doubles Rolling Strategy",
        "objective": "Practice coordinating with a partner in a doubles rolling match, inspired by boules-style rolling games traditionally played in France and along the Mediterranean.",
        "materials": ["1 small target ball", "3 larger soft balls per team of two"],
        "steps": [
            "Play in teams of two against another team of two.",
            "Partners take turns rolling, discussing strategy between rolls (protect a close ball, or knock away an opponent's).",
            "Score points for the team with the closest ball after all rolls in a round.",
            "Play several rounds and see which team scores more overall!",
        ],
        "tip": "Sometimes rolling to gently bump your own teammate's ball closer is a smarter move than aiming fresh at the target.",
    },
    {
        "name": "\u26AA Marble Strategy League",
        "objective": "Practice choosing which marbles to target for maximum advantage, inspired by marble games played by children in many cultures around the world.",
        "materials": ["12-15 marbles or small round objects of different sizes", "A hula hoop or chalk circle"],
        "steps": [
            "Mix marbles of different sizes inside the circle.",
            "Before each roll, discuss as a group which marble is the smartest target and why.",
            "Take turns rolling, trying to knock out your chosen target.",
            "Total up marbles won and discuss which target choices worked out best!",
        ],
        "tip": "A cluster of marbles close together can sometimes be knocked out together with one well-aimed roll.",
    },
    {
        "name": "\U0001FA84 Precision Ring Toss League",
        "objective": "Practice consistent accuracy across a multi-round scoring league, inspired by ring-and-pin catching games from Indigenous traditions of North America.",
        "materials": ["8 soft rings", "3 cones at close, medium, and far distances"],
        "steps": [
            "Play 3 full rounds, tossing all 8 rings across the distances each round.",
            "Record your total score for each round separately.",
            "Compare your three round scores to see if you're improving.",
            "Discuss what adjustment helped your score go up (or figure out what to try differently next time)!",
        ],
        "tip": "Keeping your toss motion exactly the same every time makes your results easier to predict and improve.",
    },
    {
        "name": "\U0001F44F Layered Clap Composition",
        "objective": "Practice combining multiple clap patterns into one longer group composition, inspired by hand-clapping game traditions found in cultures worldwide.",
        "materials": ["None -- just a small group"],
        "steps": [
            "Each pair in the group invents their own short clap pattern with an original rhyme.",
            "Arrange the group so each pair's pattern plays one after another, like sections of a song.",
            "Practice performing all the patterns back to back smoothly.",
            "Perform the full layered composition for an audience!",
        ],
        "tip": "Deciding a clear signal for when one pair's section ends and the next begins keeps the whole group in sync.",
    },
    {
        "name": "\U0001FA80 Top Design & Distance Test",
        "objective": "Practice testing how a top's design affects its spin, inspired by spinning-top traditions enjoyed in Japan, Korea, and the Caribbean.",
        "materials": ["2-3 tops or bottle caps of different sizes/weights", "A timer"],
        "steps": [
            "Test and time each top's spin separately, recording the results.",
            "Discuss what might make one top spin longer than another (size, weight, shape).",
            "Test your idea by trying a new way of spinning (different flick strength, different surface).",
            "Share what you discovered about spin time with the group!",
        ],
        "tip": "Testing on the exact same flat surface each time keeps your comparison fair.",
    },
    {
        "name": "\u2753 Riddle-Writing Workshop",
        "objective": "Practice crafting a riddle with a misleading first clue and a clarifying final clue, inspired by riddle-telling traditions long shared in storytelling circles across West Africa.",
        "materials": ["Paper and pencil, one per player"],
        "steps": [
            "Pick a secret object and write a first clue that sounds like it could mean something else entirely.",
            "Write a final clue that makes the true answer clear.",
            "Share just your first clue with the group and see what they guess.",
            "Reveal your final clue and the answer, then discuss what made the misdirection work!",
        ],
        "tip": "The best riddles trick you honestly -- every clue should still be completely true, just easy to misread.",
    },
    {
        "name": "\U0001F463 Eight-Beat Group Routine",
        "objective": "Practice a longer group footwork routine performed in unison, inspired by rhythmic stepping games and dances found in Philippine culture and beyond.",
        "materials": ["None -- just open floor space"],
        "steps": [
            "As a group, learn an 8-beat pattern combining steps, a turn, and a clap.",
            "Practice in smaller pairs first until everyone knows the sequence.",
            "Combine into one full group line and practice staying together.",
            "Perform the full routine together, all in time with the same beat!",
        ],
        "tip": "Watching the person in the middle of the group, not just the leader, helps everyone stay together.",
    },
]


GAMES[5] = [
    {
        "name": "\U0001FAA8 Capture Strategy Match",
        "objective": "Practice deeper multi-turn planning in a full pit-and-stone capturing match, inspired by pit-and-stone counting games played for generations across many African communities.",
        "materials": ["48 small stones or dried beans", "12 small cups or bowls in two rows of 6"],
        "steps": [
            "Place 4 stones in each of the 12 cups, six belonging to each player.",
            "Sow stones one at a time into each following cup around the board on your turn.",
            "Capture an opponent's cup's stones whenever your last sown stone lands there and brings it to exactly 2 or 3 stones.",
            "Play until the board is empty and count who captured the most stones overall!",
        ],
        "tip": "Thinking two turns ahead about which cups might reach 2 or 3 stones helps you plan a capture in advance.",
    },
    {
        "name": "\U0001FA84 Freestyle Trick Chain",
        "objective": "Practice chaining together multiple kicking tricks in one continuous sequence, inspired by shuttlecock-kicking games long enjoyed in China and Vietnam.",
        "materials": ["A soft balled-up sock or beanbag"],
        "steps": [
            "Each player invents a 3-trick chain (like inside-foot, then knee, then alternate-foot) they must perform without letting it drop.",
            "Take turns performing your chain for the group.",
            "Add up how many tricks in a row each person completes before a drop.",
            "Try adding a 4th trick to your chain once your first three feel solid!",
        ],
        "tip": "Practicing the transition between two tricks, not just each trick alone, is usually where drops happen.",
    },
    {
        "name": "\U0001F9F1 Tournament Bracket Topple",
        "objective": "Practice head-to-head strategic aiming across a full bracket tournament, inspired by wooden block-toppling yard games traditionally played in Scandinavia.",
        "materials": ["8 blocks labeled with point values", "2 balls per match"],
        "steps": [
            "Set up a bracket so players or small teams face off one match at a time.",
            "In each match, both players get 3 rolls, and higher total points wins the match.",
            "Winners advance to the next round of the bracket until a champion is decided.",
            "Discuss strategy differences between the matches after the tournament!",
        ],
        "tip": "In a close match, aiming for a block you're confident about beats risking a low-percentage shot at a high-value one.",
    },
    {
        "name": "\U0001F3A8 Twelve-Fold Precision Mandala",
        "objective": "Practice highly precise geometric repetition across twelve matching sections, inspired by intricate rangoli floor-art traditions from India.",
        "materials": ["Sidewalk chalk or crayons and paper", "A ruler or straight edge"],
        "steps": [
            "Measure and mark 12 equal sections radiating from a center point.",
            "Design a detailed pattern with at least 4 elements in one section.",
            "Precisely repeat the pattern in every section, checking your measurements as you go.",
            "Color the completed mandala and reflect on which section was hardest to match exactly!",
        ],
        "tip": "Measuring the angle between sections before you start drawing prevents small errors from adding up around the circle.",
    },
    {
        "name": "\U0001F0CF Branching Story Cards",
        "objective": "Practice building a story with a branching choice point using drawn cards, inspired by picture-calling card game traditions from Mexico.",
        "materials": ["15-20 picture cards (characters, places, objects, events)"],
        "steps": [
            "As a group, draw cards and build a story together up to one dramatic decision point.",
            "Split into two smaller groups, each drawing new cards to continue the story down a different path from that point.",
            "Each smaller group tells their ending to the whole group.",
            "Discuss how the same starting story led to two very different endings!",
        ],
        "tip": "Keeping the decision point itself clear and specific makes the two branching endings easier to compare.",
    },
    {
        "name": "\U0001FA81 Kite Aerodynamics Investigation",
        "objective": "Practice forming and testing a hypothesis about what makes a kite fly farther, inspired by kite-flying traditions loved across South and Southeast Asia.",
        "materials": ["4-5 sheets of paper", "Tape", "String of different lengths", "Paper and pencil for recording results"],
        "steps": [
            "Write down a hypothesis: predict which single change (tail length, shape, string length) will improve flight the most.",
            "Build a baseline kite and test it, recording the distance.",
            "Build a second kite changing only the variable in your hypothesis, and test it.",
            "Compare the results to your hypothesis and explain whether the evidence supported your prediction!",
        ],
        "tip": "A hypothesis that turns out wrong is still useful -- it tells you just as much as one that turns out right.",
    },
    {
        "name": "\U0001FAA2 Teach-the-Group String Circuit",
        "objective": "Practice leading others through a multi-step string figure as an instructor, inspired by string-figure games found in cultures all over the world.",
        "materials": ["A loop of string or yarn per player, tied at the ends"],
        "steps": [
            "Each player masters one string figure well enough to teach it.",
            "Set up small teaching stations, one per figure, with one 'teacher' at each.",
            "Rotate the whole group through every station, learning each figure from its teacher.",
            "At the end, see how many total figures everyone can now perform!",
        ],
        "tip": "A good teacher slows down at exactly the step where most people get stuck, not just the whole sequence evenly.",
    },
    {
        "name": "\U0001F3B1 Championship Doubles League",
        "objective": "Practice sustained team strategy across a multi-round doubles league, inspired by boules-style rolling games traditionally played in France and along the Mediterranean.",
        "materials": ["1 small target ball", "3 larger soft balls per team of two"],
        "steps": [
            "Play a league of several doubles matches, rotating which pairs play each other.",
            "Track wins for each team across all matches.",
            "Discuss as a group which team strategies (blocking, bumping, direct aiming) worked best overall.",
            "Play a final championship match between the top two teams!",
        ],
        "tip": "Noticing patterns in what worked across several matches, not just one, reveals the strongest strategies.",
    },
    {
        "name": "\u26AA Marble Trade-Off League",
        "objective": "Practice weighing risk versus reward when choosing marble targets, inspired by marble games played by children in many cultures around the world.",
        "materials": ["15-18 marbles or small round objects of different sizes", "A hula hoop or chalk circle"],
        "steps": [
            "Assign higher point values to marbles that are harder to reach in the circle.",
            "Before each roll, players must call their target and its point value.",
            "Score points only for marbles you successfully knock out that you actually called.",
            "Total scores across several rounds and discuss which risk levels paid off!",
        ],
        "tip": "Calling a safer, lower-value target when you're behind late in the game can sometimes be the smarter risk.",
    },
    {
        "name": "\U0001FA84 Ring Toss Handicap League",
        "objective": "Practice adapting strategy under a scoring handicap system, inspired by ring-and-pin catching games from Indigenous traditions of North America.",
        "materials": ["8 soft rings", "4 cones at varied distances with different point values"],
        "steps": [
            "Assign each player a small handicap (an extra ring, or a farther starting line) based on a practice round.",
            "Play a full scored round using the handicaps to keep matches close.",
            "Add up final scores including the handicap adjustments.",
            "Discuss whether the handicap system made the competition feel fairer!",
        ],
        "tip": "A fair handicap makes every player feel like they have a real chance -- discuss as a group what felt balanced.",
    },
    {
        "name": "\U0001F44F Original Multi-Part Clap Suite",
        "objective": "Practice composing a multi-part clapping piece with an original rhyme across several sections, inspired by hand-clapping game traditions found in cultures worldwide.",
        "materials": ["None -- just a small group"],
        "steps": [
            "As a group, write an original 3-verse rhyme, one verse per section of your clap composition.",
            "Design a distinct clap pattern for each verse, getting slightly faster or more complex each time.",
            "Practice performing all three sections back to back without stopping.",
            "Perform your full clap suite for another group and teach it to them!",
        ],
        "tip": "Rehearsing the transitions between sections separately, not just each section alone, keeps the whole suite smooth.",
    },
    {
        "name": "\U0001FA80 Top Design Lab",
        "objective": "Practice a full investigation into how weight and shape affect spin duration and stability, inspired by spinning-top traditions enjoyed in Japan, Korea, and the Caribbean.",
        "materials": ["3-4 tops or bottle caps of varied sizes/weights", "A timer", "Paper and pencil for recording data"],
        "steps": [
            "Test and time each top's spin three separate times, recording all the results.",
            "Calculate each top's average spin time from its three tries.",
            "Rank the tops from longest to shortest average spin and discuss possible reasons why.",
            "Present your findings and reasoning to the group!",
        ],
        "tip": "Averaging several tries, instead of trusting just one spin, gives a much more reliable comparison.",
    },
    {
        "name": "\u2753 Layered Riddle Challenge",
        "objective": "Practice writing a riddle with three layered clues that each narrow the answer down further, inspired by riddle-telling traditions long shared in storytelling circles across West Africa.",
        "materials": ["Paper and pencil, one per player"],
        "steps": [
            "Pick a secret object and write three clues, each one narrowing down the possibilities more than the last.",
            "Reveal your clues to the group one at a time, pausing for guesses after each.",
            "Track how many clues it took different guessers to solve it.",
            "Discuss as a group what made the second clue especially helpful (or not)!",
        ],
        "tip": "A well-layered riddle should feel solvable by the second clue for someone paying close attention.",
    },
    {
        "name": "\U0001F463 Full Group Choreography",
        "objective": "Practice choreographing and performing a full-length group stepping routine, inspired by rhythmic stepping games and dances found in Philippine culture and beyond.",
        "materials": ["None -- just open floor space"],
        "steps": [
            "As a group, combine several beat patterns you already know into one longer routine.",
            "Assign small sections to pairs or trios to refine, then rejoin as a full group.",
            "Rehearse the complete routine from start to finish several times.",
            "Perform the finished routine together for an audience!",
        ],
        "tip": "Marking a clear 'reset' beat between sections helps the whole group stay aligned through a longer routine.",
    },
]


GAMES[6] = [
    {
        "name": "\U0001FAA8 Advanced Capture Tournament",
        "objective": "Practice reading an opponent's full board position to plan captures several turns ahead, inspired by pit-and-stone counting games played for generations across many African communities.",
        "materials": ["48 small stones or dried beans", "12 small cups or bowls in two rows of 6"],
        "steps": [
            "Play a full capturing match, but this time announce your general strategy plan out loud before your turn (without giving away exact moves).",
            "Take turns sowing and capturing as usual, tracking the running captured total for each player.",
            "After the match, discuss which announced strategies actually played out as planned.",
            "Play a second match applying one lesson learned from the first!",
        ],
        "tip": "An opponent who knows your general strategy can still be surprised by exactly which cup you choose and when.",
    },
    {
        "name": "\U0001FA84 Choreographed Trick Performance",
        "objective": "Practice choreographing a full kicking-trick performance with a partner, inspired by shuttlecock-kicking games long enjoyed in China and Vietnam.",
        "materials": ["A soft balled-up sock or beanbag per pair"],
        "steps": [
            "With a partner, design a performance combining at least 5 different kicking tricks passed back and forth.",
            "Rehearse the sequence until you can perform it smoothly without dropping the sock.",
            "Perform your choreographed routine for the group.",
            "Give and receive one specific piece of feedback with another pair!",
        ],
        "tip": "Building in a brief 'reset' moment between tricky sections gives you a safety net if a pass goes slightly off.",
    },
    {
        "name": "\U0001F9F1 Full Season Topple League",
        "objective": "Practice tracking statistics and refining strategy across a season-long tournament, inspired by wooden block-toppling yard games traditionally played in Scandinavia.",
        "materials": ["8 blocks labeled with point values", "2 balls per match", "Paper to track a season standings chart"],
        "steps": [
            "Play a round-robin league where every player faces every other player once.",
            "Track each match's score on a shared standings chart.",
            "After all matches, rank players by total points across the whole season.",
            "Discuss what strategy the top-ranked player used most consistently!",
        ],
        "tip": "A strategy that works well in one match might not be optimal against every opponent -- notice who adapts.",
    },
    {
        "name": "\U0001F3A8 Original Mandala Design Challenge",
        "objective": "Practice designing an original geometric mandala pattern from scratch rather than copying a set structure, inspired by intricate rangoli floor-art traditions from India.",
        "materials": ["Sidewalk chalk or crayons and paper", "A ruler or straight edge", "A compass or round object to trace circles"],
        "steps": [
            "Plan your own number of matching sections (choose anywhere from 6 to 16) and sketch your design idea first on paper.",
            "Carefully measure and mark your chosen sections around a center point.",
            "Execute your original pattern design across every section with precision.",
            "Present your finished mandala to the group and explain your design choices!",
        ],
        "tip": "Sketching a rough plan on scrap paper first saves you from having to erase a big, carefully measured design.",
    },
    {
        "name": "\U0001F0CF Collaborative Anthology Cards",
        "objective": "Practice building several interconnected short stories that share recurring characters, inspired by picture-calling card game traditions from Mexico.",
        "materials": ["20-25 picture cards (characters, places, objects, events)"],
        "steps": [
            "As a group, agree on 2-3 recurring characters that must appear across every story told.",
            "Split into small groups, each drawing cards and writing a short story featuring at least one recurring character.",
            "Share all the stories aloud, noticing how each group interpreted the shared characters differently.",
            "Discuss how the stories could connect into one larger anthology!",
        ],
        "tip": "Giving each recurring character just a few fixed traits, and leaving the rest open, gives every group room to interpret them differently.",
    },
    {
        "name": "\U0001FA81 Full Kite Engineering Report",
        "objective": "Practice a complete engineering design cycle with a written report, inspired by kite-flying traditions loved across South and Southeast Asia.",
        "materials": ["5-6 sheets of paper", "Tape", "String of different lengths", "Paper and pencil for a written report"],
        "steps": [
            "Design, build, and test three different kite variations, recording distance and stability for each.",
            "Identify your best-performing design and explain in writing why you think it worked best.",
            "Build one final 'best of all worlds' kite combining your favorite features from the three tests.",
            "Test your final design and present your full findings to the group!",
        ],
        "tip": "The most useful engineering reports explain not just what worked, but what you expected and whether you were right.",
    },
    {
        "name": "\U0001FAA2 String Figure Innovation Challenge",
        "objective": "Practice inventing an original string figure inspired by traditional techniques, and documenting it clearly, inspired by string-figure games found in cultures all over the world.",
        "materials": ["A loop of string or yarn per player, tied at the ends", "Paper and pencil"],
        "steps": [
            "Master at least two traditional-style figures using techniques you've learned before.",
            "Experiment with combining or extending those techniques to invent your own original shape.",
            "Write clear step-by-step instructions so someone else could recreate your new figure.",
            "Trade instructions with a partner and see if they can successfully make your invented shape!",
        ],
        "tip": "Testing your own written instructions on yourself first, from scratch, reveals steps you might have accidentally skipped.",
    },
    {
        "name": "\U0001F3B1 Strategic Doubles Championship",
        "objective": "Practice high-level team communication and adaptive strategy in a championship match, inspired by boules-style rolling games traditionally played in France and along the Mediterranean.",
        "materials": ["1 small target ball", "3 larger soft balls per team of two"],
        "steps": [
            "Play a best-of-3 championship series between two doubles teams.",
            "Between rounds, each team huddles briefly to adjust strategy based on what the other team is doing.",
            "Play all three rounds, tracking which team wins each one.",
            "After the match, both teams share one strategy adjustment they made and why!",
        ],
        "tip": "The best mid-match adjustments respond to what actually happened, not just the plan you started with.",
    },
    {
        "name": "\u26AA Marble Economics Challenge",
        "objective": "Practice managing a limited number of 'turns' as a resource across a full match, inspired by marble games played by children in many cultures around the world.",
        "materials": ["18-20 marbles or small round objects of different sizes", "A hula hoop or chalk circle"],
        "steps": [
            "Give each player a fixed budget of exactly 8 rolls for the whole match.",
            "Players must decide when to spend rolls on safe, reliable targets versus risky, high-value ones.",
            "Play until every player has used all 8 of their rolls.",
            "Compare final marble totals and discuss how each player budgeted their rolls!",
        ],
        "tip": "Spending your riskiest rolls early, while you still have rolls left to recover from a miss, is often a smarter budget than saving them for last.",
    },
    {
        "name": "\U0001FA84 Championship Handicap Series",
        "objective": "Practice competing fairly in a mixed-skill group using a self-designed handicap system, inspired by ring-and-pin catching games from Indigenous traditions of North America.",
        "materials": ["8 soft rings", "4 cones at varied distances", "Paper to design a handicap chart"],
        "steps": [
            "As a group, play one practice round and use the results to design a fair handicap chart together.",
            "Play a full scored series using your own handicap system.",
            "Compare final scores to see whether the series felt genuinely competitive for everyone.",
            "Revise your handicap chart based on what you learned, for next time!",
        ],
        "tip": "A good handicap system, once players see the results, usually needs at least one honest adjustment.",
    },
    {
        "name": "\U0001F44F Full Ensemble Clap Performance",
        "objective": "Practice composing and performing a full multi-section clap piece for a larger ensemble, inspired by hand-clapping game traditions found in cultures worldwide.",
        "materials": ["None -- just a full group"],
        "steps": [
            "As a whole group, write an original multi-verse rhyme with a clear beginning, build-up, and ending.",
            "Assign different sub-groups to different sections, each designing its own clap pattern that connects smoothly to the next.",
            "Rehearse the full ensemble piece from start to finish as one group.",
            "Perform the complete piece for an audience outside your group!",
        ],
        "tip": "A shared cue word at the very end of each section (spoken together) keeps a large ensemble transitioning together.",
    },
    {
        "name": "\U0001FA80 Top Physics Investigation",
        "objective": "Practice forming and testing a scientific explanation for why some tops spin longer than others, inspired by spinning-top traditions enjoyed in Japan, Korea, and the Caribbean.",
        "materials": ["4-5 tops or bottle caps of varied sizes/weights/shapes", "A timer", "Paper and pencil for recording data"],
        "steps": [
            "Propose an explanation (a hypothesis) for what makes a top spin longest -- weight, shape, or spin technique.",
            "Design a fair test that changes only the one factor in your hypothesis, keeping everything else the same.",
            "Run your test multiple times and record the data.",
            "Present whether your data supported or disproved your original hypothesis, and why!",
        ],
        "tip": "A hypothesis your data disproves is just as scientifically valuable as one it confirms -- both teach you something real.",
    },
    {
        "name": "\u2753 Riddle Master Showcase",
        "objective": "Practice crafting and presenting a polished original riddle with a satisfying reveal, inspired by riddle-telling traditions long shared in storytelling circles across West Africa.",
        "materials": ["Paper and pencil, one per player"],
        "steps": [
            "Draft an original riddle with layered clues, then revise it at least once based on feedback from a partner.",
            "Practice presenting your riddle with clear pacing and a dramatic pause before the reveal.",
            "Present your polished riddle to the full group.",
            "As an audience, discuss what made the best riddles of the showcase especially satisfying to solve!",
        ],
        "tip": "Revising a riddle after hearing how someone else actually guessed at it usually improves it more than writing alone ever could.",
    },
    {
        "name": "\U0001F463 Original Ensemble Choreography",
        "objective": "Practice choreographing an original full-group stepping routine from scratch, inspired by rhythmic stepping games and dances found in Philippine culture and beyond.",
        "materials": ["None -- just open floor space"],
        "steps": [
            "As a group, invent an entirely original beat pattern and footwork sequence, not reusing a routine from before.",
            "Divide into small groups to choreograph different sections, then combine them into one full routine.",
            "Rehearse the complete original routine together until it flows as one piece.",
            "Perform your original choreography for an audience and explain your creative choices!",
        ],
        "tip": "The transitions you invent between two sections often end up being the most memorable and original part of the whole routine.",
    },
]


GAMES[7] = GAMES[6]


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 80_culture_games_content.sql")
    out.append("-- Adds a 'Traditions & Culture Games' category to the existing always-on")
    out.append("-- 'culture' subject_area for every grade (TK-6th) -- no schema or proc")
    out.append("-- changes needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket")
    out.append("-- exactly as-is.")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual")
    out.append("-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation")
    out.append("-- serves a different 7-of-14 combination most weeks a grade's culture")
    out.append("-- category is selected.")
    out.append("--")
    out.append("-- Games are each inspired by a real traditional/folk game from a different")
    out.append("-- world region (Africa, China/Vietnam, Scandinavia, India, Mexico, South/")
    out.append("-- Southeast Asia, global Indigenous traditions, France/Mediterranean, Japan/")
    out.append("-- Korea/Caribbean, West Africa, Philippines) with fully ORIGINAL rule-writing")
    out.append("-- -- no rules, rhymes, or chants copied from any existing source. Kept")
    out.append("-- secular and respectful throughout.")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions. See gen_80_culture_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'culture' AND category_name = N'Traditions & Culture Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_culture_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'culture', N'Traditions & Culture Games', 'space_heavy', 7, N'Play a traditional game inspired by cultures from around the world!', 0);"
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
    with open(r"D:\Project\www\littlescholarhub\lsh.database\80_culture_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 80_culture_games_content.sql", file=sys.stderr)
