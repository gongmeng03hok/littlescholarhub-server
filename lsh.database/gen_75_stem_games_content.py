# -*- coding: utf-8 -*-
"""
Generates lsh.database/75_stem_games_content.sql -- adds a "STEM Challenge
Games" category to the existing 'stem_engineering' subject_area (always-on,
no schema/proc changes needed) for every grade TK-6. Each grade gets a pool
of 14 hand-crafted games spanning building/engineering challenges, unplugged
coding, sorting/data/pattern games, and predict-then-test science
experiments, using simple household materials only. target_count=7 (fixed,
NOT the ~65% auto-rebalance ratio used elsewhere) means the existing
NEWID()-sampling rotation in usp_GetOrCreateWeeklyPacket serves a different
7-of-14 combination most weeks a grade's stem_engineering category is
selected, without any manual per-week authoring.

Follows the exact proven pattern from gen_68_outdoor_games_content.py.

Run with: python gen_75_stem_games_content.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), tip
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🏗️ Tallest Cup Tower",
        "objective": "Practice stacking cups carefully to build the tallest tower you can.",
        "materials": ["10 plastic or paper cups"],
        "steps": [
            "Stack the cups one on top of another, biggest ones at the bottom.",
            "Go slow and steady so the tower doesn't wobble.",
            "Count how many cups tall your tower is!",
            "If it falls, that's okay -- stack it again.",
        ],
        "tip": "Every engineer tests, and towers fall sometimes -- that's how we learn to build better!",
    },
    {
        "name": "🌉 Block Bridge for Teddy",
        "objective": "Build a simple bridge with blocks that a toy can cross over a 'river.'",
        "materials": ["Building blocks", "A small toy (like a stuffed animal)", "A towel or string to mark a 'river'"],
        "steps": [
            "Lay a towel on the floor to be your pretend river.",
            "Stack blocks on each side, then lay a flat block across the top to connect them.",
            "Walk your toy carefully across the bridge.",
            "Try making the river wider and see if your bridge still reaches!",
        ],
        "tip": "Bridges connect two sides so nobody has to get wet -- great job, builder!",
    },
    {
        "name": "⛵ Foil Boat Float Test",
        "objective": "Guess whether a foil boat will float, then test it in water.",
        "materials": ["A small piece of aluminum foil", "A bowl or tub of water"],
        "steps": [
            "Shape the foil into a little boat with an adult's help.",
            "Guess out loud: will it float or sink?",
            "Gently place the boat on the water.",
            "Cheer if it floats -- try reshaping it if it sinks!",
        ],
        "tip": "Guessing first and then testing is exactly what scientists do!",
    },
    {
        "name": "✈️ First Flight Paper Airplane",
        "objective": "Fly a simple paper airplane and measure how far it goes using big steps.",
        "materials": ["1 sheet of paper"],
        "steps": [
            "An adult helps fold a simple paper airplane.",
            "Stand behind a starting line and throw it gently.",
            "Count how many big steps away it landed.",
            "Try again and see if you can go even farther!",
        ],
        "tip": "Every throw is a chance to try again -- that's what makes flying fun!",
    },
    {
        "name": "🤖 Robot Friend Directions",
        "objective": "Practice giving and following simple step-by-step directions, just like programming a robot.",
        "materials": ["Open floor space"],
        "steps": [
            "One person is the 'programmer,' the other is the 'robot.'",
            "The programmer gives one simple direction at a time, like 'walk forward 3 steps.'",
            "The 'robot' follows the direction exactly, like a real robot would.",
            "Take turns being the programmer and the robot!",
        ],
        "tip": "Robots (and computers) only do exactly what they're told -- that's why clear directions matter!",
    },
    {
        "name": "🗺️ Follow the Arrow Path",
        "objective": "Follow a simple path of arrow cards laid on the floor from start to finish.",
        "materials": ["5-6 large arrow cards or drawings (forward, left, right)"],
        "steps": [
            "An adult lays arrow cards in a simple line on the floor.",
            "Walk along the path, following each arrow's direction.",
            "Cheer when you reach the end!",
            "Rearrange the arrows and try a new path.",
        ],
        "tip": "Following the arrows in order got you all the way to the end -- nice work!",
    },
    {
        "name": "🔤 Sort the Shapes Game",
        "objective": "Sort a mixed pile of shapes into matching groups.",
        "materials": ["A mixed pile of shape blocks or buttons (circles, squares, triangles)"],
        "steps": [
            "Dump all the shapes into one big pile.",
            "Make a group for each shape type.",
            "Move each shape to its matching group.",
            "Count how many are in each group when you're done!",
        ],
        "tip": "Grouping things that are alike helps us find and count them faster.",
    },
    {
        "name": "🔵 Copy My Pattern",
        "objective": "Copy a simple repeating pattern using blocks or beads.",
        "materials": ["10-12 blocks or beads in 2 colors"],
        "steps": [
            "An adult makes a simple pattern, like red-blue-red-blue.",
            "Look closely at the pattern.",
            "Copy the exact same pattern using your own blocks.",
            "Try making your own pattern for someone else to copy!",
        ],
        "tip": "Patterns repeat in a predictable way -- spotting that repeat is the first step to reading any code.",
    },
    {
        "name": "📊 Favorite Color Vote",
        "objective": "Take a simple vote and count the results together.",
        "materials": ["Paper", "Crayons or markers"],
        "steps": [
            "Ask 5 family members or friends their favorite color.",
            "Make a tally mark on paper for each answer.",
            "Count the tally marks for each color together.",
            "Say out loud which color got the most votes!",
        ],
        "tip": "Counting up everyone's answers is the very first step of data collection.",
    },
    {
        "name": "🪨 Sink or Float Guess",
        "objective": "Guess whether household objects will sink or float, then test them in water.",
        "materials": ["A bowl or tub of water", "5-6 small household objects (spoon, cork, rock, leaf, coin)"],
        "steps": [
            "Look at each object and guess: sink or float?",
            "Gently place one object in the water and watch.",
            "Cheer for a correct guess!",
            "Try the next object and guess again.",
        ],
        "tip": "Guessing before testing is exactly how scientists start every experiment.",
    },
    {
        "name": "🎈 Balloon Rocket Zoom",
        "objective": "Watch a balloon rocket zoom along a string and enjoy the surprise of air power.",
        "materials": ["1 balloon", "A long piece of string", "A straw", "Tape"],
        "steps": [
            "An adult sets up a string across a room, threaded through a straw, pulled tight.",
            "An adult tapes an inflated (but not tied) balloon to the straw.",
            "Let go of the balloon and watch it zoom along the string!",
            "Try it again -- did it go the same way?",
        ],
        "tip": "Air rushing out is what pushed your rocket forward -- that's the same idea behind real rockets!",
    },
    {
        "name": "🧸 Soft Landing for Teddy",
        "objective": "Explore how a soft cushion protects a toy dropped from a low height.",
        "materials": ["A small stuffed toy", "A pillow or folded blanket"],
        "steps": [
            "Hold the toy up at a low height (like standing height) over the pillow.",
            "Drop the toy gently onto the pillow and watch what happens.",
            "Try dropping it onto the hard floor instead (with a grown-up's okay) and compare.",
            "Talk about why the pillow felt like a softer landing!",
        ],
        "tip": "A soft cushion spreads out the bump, which is why pillows make landings feel gentler.",
    },
    {
        "name": "🚀 Pom-Pom Push Launch",
        "objective": "Push a pom-pom along a simple ramp and watch it launch off the end.",
        "materials": ["A pom-pom or cotton ball", "A book propped up as a ramp"],
        "steps": [
            "Prop up a book to make a ramp.",
            "Place the pom-pom at the top.",
            "Gently let it go and watch it roll and launch off the bottom.",
            "Try it again from a taller ramp!",
        ],
        "tip": "Ramps use gravity to help push things forward -- no batteries needed!",
    },
    {
        "name": "📚 Paper Plate Strong Shelf",
        "objective": "Test which of two paper shapes holds a toy without collapsing.",
        "materials": ["2 paper plates or sheets of paper", "A small lightweight toy"],
        "steps": [
            "Lay one paper flat between two books like a little shelf.",
            "Place the toy on top and see what happens.",
            "Fold the second paper into an accordion (zigzag) shape and try again as a shelf.",
            "Compare -- which shape held the toy better?",
        ],
        "tip": "A folded shape held up better than a flat one -- folding makes paper stronger!",
    },
]


GAMES[1] = [
    {
        "name": "🏗️ Cup Tower Champion",
        "objective": "Build the tallest possible tower using cups and compare designs with a partner.",
        "materials": ["10-12 plastic cups"],
        "steps": [
            "Build your tallest tower using all the cups.",
            "Measure it with your hands (how many hand-lengths tall?).",
            "Knock it down gently and try again with a different stacking order.",
            "See if your second tower is taller than your first!",
        ],
        "tip": "Trying it a second way is exactly what real engineers do -- retesting makes designs better.",
    },
    {
        "name": "🌉 Paper Bridge Crossing",
        "objective": "Build a paper bridge that spans a gap and can hold a small toy.",
        "materials": ["1 sheet of paper", "2 stacks of books (to make a gap)", "A small toy car or block"],
        "steps": [
            "Set up two book stacks with a gap between them.",
            "Lay the paper flat across the gap like a bridge.",
            "Carefully roll the small toy across the bridge.",
            "If the paper sags too much, try folding it before laying it across.",
        ],
        "tip": "A flat sheet bends easily, but a folded sheet is much stronger -- folding is an engineering trick!",
    },
    {
        "name": "⛵ Cup Boat Cargo Test",
        "objective": "Test how many small toys a floating cup boat can carry before sinking.",
        "materials": ["1 small plastic cup", "A bowl or tub of water", "Small toys or coins as cargo"],
        "steps": [
            "Float the cup gently on the water like a boat.",
            "Add one small toy as cargo.",
            "Keep adding toys one at a time, counting as you go.",
            "Stop and cheer when you find the number that makes it sink!",
        ],
        "tip": "Even a simple cup can carry cargo -- that's how real boats work too!",
    },
    {
        "name": "✈️ Paper Airplane Distance Hop",
        "objective": "Throw a paper airplane and compare distances across a few tries.",
        "materials": ["1-2 sheets of paper", "A starting line marker"],
        "steps": [
            "Fold a simple paper airplane.",
            "Throw it from the starting line and mark where it lands.",
            "Throw it two more times, marking each spot.",
            "See which of your three throws went the farthest!",
        ],
        "tip": "Not every throw goes the same distance -- that's normal, even for real pilots!",
    },
    {
        "name": "🤖 Program-a-Friend Walk",
        "objective": "Give a short sequence of two or three directions for a partner-robot to follow in order.",
        "materials": ["Open floor space", "A small toy as a 'goal' to reach"],
        "steps": [
            "Place a toy a few steps away as the goal.",
            "Give your robot-friend 2-3 directions in a row, like 'forward 2 steps, turn left, forward 1 step.'",
            "The robot-friend follows the directions exactly, one at a time, to try to reach the toy.",
            "Take turns programming each other!",
        ],
        "tip": "Giving directions in the right order matters -- computers follow steps exactly in order, too.",
    },
    {
        "name": "🗺️ Arrow Card Maze",
        "objective": "Follow a short sequence of arrow cards through a simple maze shape to reach a goal.",
        "materials": ["6-8 arrow cards", "A small toy as the goal"],
        "steps": [
            "Lay out arrow cards in a path with one turn to reach the goal toy.",
            "Walk the path one arrow at a time, in order.",
            "If you reach the goal, celebrate!",
            "Rearrange the arrows to make a new, trickier path.",
        ],
        "tip": "A maze with a turn is trickier than a straight line -- you handled it like a pro!",
    },
    {
        "name": "🔢 Sort by Size Game",
        "objective": "Sort a collection of objects from smallest to largest.",
        "materials": ["8-10 small household objects of different sizes (blocks, spoons, toys)"],
        "steps": [
            "Gather your objects in one pile.",
            "Pick the smallest one and set it down first.",
            "Keep picking the next-smallest object and lining it up in order.",
            "Check your line from smallest to largest when you're done!",
        ],
        "tip": "Putting things in order by size is a math skill computers and scientists use too -- you just did it!",
    },
    {
        "name": "🔵 Pattern Detective Game",
        "objective": "Figure out what comes next in a simple repeating pattern.",
        "materials": ["12-15 blocks, beads, or shapes in 2-3 colors"],
        "steps": [
            "An adult lays out a pattern but stops partway, like red-blue-red-blue-red-___.",
            "Study the pattern to figure out what should come next.",
            "Place the correct next piece.",
            "Try laying out your own pattern and leaving a blank for someone else to solve!",
        ],
        "tip": "Being a pattern detective means looking for what repeats -- that's a skill mathematicians use every day.",
    },
    {
        "name": "📊 Class Snack Survey",
        "objective": "Survey a few people about a favorite snack and count the results.",
        "materials": ["Paper", "Pencil or crayon"],
        "steps": [
            "Pick 2-3 snack choices to ask about (like apple, cracker, cheese).",
            "Ask at least 5 people which one they like best.",
            "Make a tally mark for each answer under the right snack.",
            "Count up the tallies and see which snack won!",
        ],
        "tip": "Asking the same question to everyone is what makes a survey fair.",
    },
    {
        "name": "🪨 Sink or Float Sorting Game",
        "objective": "Sort a group of objects into 'sink' and 'float' groups after testing each in water.",
        "materials": ["A bowl or tub of water", "8 small household objects", "2 paper labels: 'Sink' and 'Float'"],
        "steps": [
            "Lay out your 'Sink' and 'Float' labels on the table.",
            "Test each object one at a time in the water.",
            "Place the object under the correct label based on what happened.",
            "Look at your two groups when you're done -- what do the float objects have in common?",
        ],
        "tip": "Sorting your results after testing helps you spot patterns you might otherwise miss.",
    },
    {
        "name": "🎈 Balloon Rocket Race",
        "objective": "Race two balloon rockets along strings and see which one travels the fastest.",
        "materials": ["2 balloons", "2 long pieces of string", "2 straws", "Tape"],
        "steps": [
            "Set up two balloon rocket strings side-by-side.",
            "Blow up both balloons the same amount and tape them to their straws.",
            "Let go of both balloons at the same time.",
            "Watch which rocket wins the race!",
        ],
        "tip": "Racing two rockets at once is a fun way to compare -- did the winner surprise you?",
    },
    {
        "name": "🧸 Cushion Catch Challenge",
        "objective": "Build a simple soft catcher to protect a small ball dropped from a chair.",
        "materials": ["A small ball", "A pillow, blanket, or folded towel", "A chair (adult supervises the drop)"],
        "steps": [
            "Set up your soft catcher (pillow or blanket) on the floor.",
            "With an adult, drop the ball from the chair height onto the catcher.",
            "Watch and check -- did the ball bounce or land gently?",
            "Try adding more padding and see if the landing gets even softer.",
        ],
        "tip": "More cushioning usually means a gentler landing -- you're already thinking like an engineer!",
    },
    {
        "name": "🚀 Ramp Roll Race",
        "objective": "Roll a ball down a ramp and see how far it travels after leaving the ramp.",
        "materials": ["A small ball", "A book or board propped up as a ramp", "A measuring tape or string with marks"],
        "steps": [
            "Set up your ramp using a propped-up book.",
            "Let the ball roll down and off the end.",
            "Measure where it stopped.",
            "Try again from a taller ramp and compare distances!",
        ],
        "tip": "A taller ramp usually sends the ball rolling farther -- you're testing gravity's power!",
    },
    {
        "name": "📚 Strongest Shape Test",
        "objective": "Test flat, rolled, and folded paper shapes to see which holds a small object best.",
        "materials": ["3 sheets of paper", "A small toy or block", "2 books to rest the paper between"],
        "steps": [
            "Test a flat sheet of paper as a bridge between two books, placing the toy on top.",
            "Roll a second sheet into a tube shape and test it the same way.",
            "Fold a third sheet into a zigzag shape and test it the same way.",
            "Compare all three -- which held the toy the best without collapsing?",
        ],
        "tip": "Shape changes strength even when the amount of paper stays exactly the same -- a great engineering discovery!",
    },
]


GAMES[2] = [
    {
        "name": "🏗️ Tallest Paper Tower",
        "objective": "Build a free-standing tower out of rolled paper tubes and tape.",
        "materials": ["5 sheets of paper", "Tape"],
        "steps": [
            "Roll each sheet of paper into a tight tube and tape it closed.",
            "Stand the tubes up and tape them together to build upward.",
            "Measure your tower's height with a ruler or string.",
            "Try rearranging the tubes to build it even taller.",
        ],
        "tip": "Tall towers need a wide, steady base -- just like a real building!",
    },
    {
        "name": "🌉 Popsicle Stick Bridge",
        "objective": "Build a bridge from craft sticks that spans a gap and holds a small object.",
        "materials": ["10-15 craft sticks (or cut paper strips)", "Tape", "2 stacks of books", "A coin"],
        "steps": [
            "Set up two book stacks with a gap between them.",
            "Lay and tape craft sticks together to span the gap.",
            "Place a coin in the middle of your bridge.",
            "If it holds, try adding a second coin!",
        ],
        "tip": "A bridge that holds even one coin is already doing real engineering work!",
    },
    {
        "name": "⛵ Coin-Carrying Boat",
        "objective": "Build a simple foil boat and test how many coins it can carry before sinking.",
        "materials": ["A piece of aluminum foil (about the size of a sheet of paper)", "A bowl or tub of water", "A pile of coins"],
        "steps": [
            "Shape the foil into a boat with sides high enough to hold cargo.",
            "Float the boat on the water.",
            "Add coins to the boat one at a time, counting as you go.",
            "Record how many coins it held before sinking!",
        ],
        "tip": "Boats with taller sides usually hold more cargo before water gets in.",
    },
    {
        "name": "✈️ Paper Airplane Distance Test",
        "objective": "Fold and test a paper airplane, then try folding it a new way to compare distances.",
        "materials": ["2 sheets of paper", "Measuring tape or a long string with marks"],
        "steps": [
            "Fold your first paper airplane and throw it from a starting line.",
            "Measure how far it flew.",
            "Fold a second airplane a different way and throw it.",
            "Measure and compare -- which design flew farther?",
        ],
        "tip": "Small changes in folding can make a big difference in how far a plane flies.",
    },
    {
        "name": "🤖 Step-by-Step Robot Program",
        "objective": "Write out a full sequence of movement directions on paper before your robot-friend runs it.",
        "materials": ["Paper and pencil", "Open floor space", "A toy or marker as the goal"],
        "steps": [
            "Write down a numbered list of directions (forward, turn, stop) to get your robot-friend to a goal.",
            "Hand your written 'program' to your robot-friend.",
            "The robot-friend follows your written steps exactly, one at a time.",
            "If they don't reach the goal, look at your program and fix it!",
        ],
        "tip": "Writing the program down first (instead of calling out directions) is exactly how real programmers work.",
    },
    {
        "name": "🗺️ Coding Maze Challenge",
        "objective": "Write a sequence of movement instructions to solve a simple chalk or tape maze.",
        "materials": ["Sidewalk chalk or tape", "Paper and pencil"],
        "steps": [
            "Draw or tape down a simple maze on the floor or driveway with one path to the goal.",
            "Write down the sequence of moves (forward, left, right) needed to solve it.",
            "Walk the maze exactly following your written instructions.",
            "If you get stuck, fix your instructions and try again.",
        ],
        "tip": "Writing your plan before moving helps you catch mistakes before they happen.",
    },
    {
        "name": "🔠 Sort Two Ways Challenge",
        "objective": "Sort the same set of objects using two different rules to show that sorting rules can change the groups.",
        "materials": ["10-12 small household objects (mixed colors and sizes)"],
        "steps": [
            "Sort your objects into groups by color.",
            "Count and record how many are in each color group.",
            "Now re-sort the same objects into groups by size instead.",
            "Compare -- did the groups look different with a new sorting rule?",
        ],
        "tip": "The same pile of things can be sorted many different ways -- the rule you choose changes the picture.",
    },
    {
        "name": "🔵 Extend the Pattern Challenge",
        "objective": "Extend a given pattern several steps further and explain the rule you used.",
        "materials": ["15-20 small objects in 2-3 colors or shapes"],
        "steps": [
            "Look at a pattern someone else laid out (at least 4-6 pieces long).",
            "Figure out the repeating rule.",
            "Extend the pattern 4 more pieces using your own objects.",
            "Say the rule out loud, like 'red, blue, blue, repeat.'",
        ],
        "tip": "Saying the rule out loud proves you really understand the pattern, not just guessing.",
    },
    {
        "name": "📊 Tally and Count Challenge",
        "objective": "Collect tally data on a chosen question and turn it into simple counts.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Choose a simple yes/no or pick-one question to ask around the house.",
            "Ask at least 6 people and make a tally mark for each answer.",
            "Add up the tallies for each answer choice.",
            "Write a sentence about which answer was most common.",
        ],
        "tip": "Turning tally marks into a total count is your first step toward becoming a data scientist!",
    },
    {
        "name": "🪨 Predict and Test: Sink or Float",
        "objective": "Write a prediction for each object before testing, then check how many predictions were correct.",
        "materials": ["A bowl or tub of water", "8-10 small household objects", "Paper and pencil"],
        "steps": [
            "List your objects on paper with a 'predict' column next to each.",
            "Write sink or float for every object before testing any of them.",
            "Test each object and write down what actually happened.",
            "Count how many of your predictions were correct!",
        ],
        "tip": "Even scientists get some predictions wrong -- that's exactly how we learn what's really true.",
    },
    {
        "name": "🎈 Balloon Rocket Distance Test",
        "objective": "Measure how far a balloon rocket travels and try to beat your own distance.",
        "materials": ["1-2 balloons", "A long string", "A straw", "Tape", "Measuring tape or string with marks"],
        "steps": [
            "Set up your balloon rocket string.",
            "Blow up the balloon, tape it to the straw, and let go.",
            "Measure how far along the string it traveled.",
            "Blow it up again and try to beat your distance!",
        ],
        "tip": "Measuring your results (not just watching) is how you know if you're really improving.",
    },
    {
        "name": "🧸 Cotton Ball Cushion Challenge",
        "objective": "Build a cushion from cotton balls and paper to protect a small toy dropped from table height.",
        "materials": ["A small toy figure", "10-15 cotton balls", "Paper or a small box", "Tape"],
        "steps": [
            "Build a small nest or box padded with cotton balls.",
            "Place the toy inside the padded nest.",
            "With an adult, drop it from table height and check if the toy is okay.",
            "If it wasn't protected enough, add more cotton and try again.",
        ],
        "tip": "Padding on all sides -- not just the bottom -- protects best against a fall.",
    },
    {
        "name": "🚀 Spoon Catapult Toss",
        "objective": "Build a simple spoon catapult and measure how far it launches a pom-pom.",
        "materials": ["A plastic spoon", "A pencil or small dowel to use as a pivot", "A pom-pom or small soft ball", "Measuring tape"],
        "steps": [
            "Rest the spoon over the pencil to make a simple see-saw catapult.",
            "Place the pom-pom in the spoon's bowl.",
            "Press down on the spoon handle and let go to launch it.",
            "Measure how far it flew, then try again!",
        ],
        "tip": "A catapult stores up energy when you press down, then releases it all at once -- that's what makes the launch.",
    },
    {
        "name": "📚 Paper Column Strength Test",
        "objective": "Build paper columns of different shapes and test how much weight each can hold before buckling.",
        "materials": ["3 sheets of paper", "Tape", "A small book or a stack of coins for weight testing"],
        "steps": [
            "Roll one sheet into a round tube column and tape it closed.",
            "Fold another sheet into a triangle-shaped column and tape it closed.",
            "Fold a third sheet into a square-shaped column and tape it closed.",
            "Stand each column up and gently add weight on top, one at a time, until each buckles -- compare which held the most.",
        ],
        "tip": "Different shapes hold weight differently, even using the exact same amount of paper.",
    },
]


GAMES[3] = [
    {
        "name": "🏗️ Index Card Tower Challenge",
        "objective": "Design a tower using only index cards and tape that stands on its own.",
        "materials": ["15 index cards (or cut cardstock)", "Tape"],
        "steps": [
            "Fold or roll cards into shapes (tubes, triangles, fans) to use as building pieces.",
            "Stack and tape your shapes into a tower that can stand by itself.",
            "Measure the final height.",
            "Take it apart and try a new shape combination to beat your height.",
        ],
        "tip": "Folded shapes are much stronger than flat cards -- shape changes strength!",
    },
    {
        "name": "🌉 Coin-Crossing Bridge Challenge",
        "objective": "Design a paper bridge that can hold as many coins as possible without collapsing.",
        "materials": ["2 sheets of paper", "Tape", "2 stacks of books", "A pile of coins"],
        "steps": [
            "Set up a gap between two book stacks.",
            "Fold or shape your paper into a bridge and tape it in place across the gap.",
            "Add coins to the middle of the bridge one at a time, counting as you go.",
            "Record how many coins your bridge held before it sagged to the table.",
        ],
        "tip": "Folded paper (like a zigzag) holds far more weight than flat paper -- try it and see!",
    },
    {
        "name": "⛵ Foil Boat Cargo Challenge",
        "objective": "Design a foil boat to hold the maximum number of pennies before sinking.",
        "materials": ["A piece of aluminum foil", "A bowl or tub of water", "A pile of pennies or coins"],
        "steps": [
            "Shape your foil into a boat, thinking about how wide and deep to make it.",
            "Float it and add pennies one at a time, counting as you go.",
            "Record the total number of pennies it held.",
            "Reshape your boat and try to beat your first score!",
        ],
        "tip": "A wider, flatter boat usually floats more cargo than a narrow one -- shape really matters.",
    },
    {
        "name": "✈️ Two Airplane Design Face-off",
        "objective": "Design and test two different paper airplanes to determine which flies farther.",
        "materials": ["2 sheets of paper", "Measuring tape or string", "Paper and pencil to record results"],
        "steps": [
            "Fold two different airplane designs -- try to make them look different from each other.",
            "Throw each one three times, recording the distance each time.",
            "Find the average (or best) distance for each design.",
            "Decide which design wins, and think about why.",
        ],
        "tip": "Testing each design more than once helps you trust your results -- one lucky throw isn't proof!",
    },
    {
        "name": "🤖 Robot Obstacle Program",
        "objective": "Write a sequence of commands that guides a robot-friend safely around an obstacle to a goal.",
        "materials": ["Paper and pencil", "A few soft objects as obstacles", "A toy or marker as the goal"],
        "steps": [
            "Set up 1-2 soft obstacles between the start and a goal.",
            "Write a numbered program of directions that avoids the obstacles.",
            "Your robot-friend follows your program exactly, without helping figure out the path themselves.",
            "If they bump an obstacle, revise your program and try again!",
        ],
        "tip": "Planning around obstacles before you run the program saves a lot of do-overs -- that's smart programming.",
    },
    {
        "name": "🗺️ Grid Maze Program",
        "objective": "Write step-by-step instructions to move a token through a paper grid maze to the goal.",
        "materials": ["Paper with a drawn grid maze", "A small token or coin", "Pencil"],
        "steps": [
            "Draw a simple grid maze on paper with a start and goal square.",
            "Write out the moves (up, down, left, right, how many squares) to get the token from start to goal.",
            "Move the token exactly following your written steps.",
            "If it lands in the wrong square, revise your instructions and try again.",
        ],
        "tip": "Every wrong turn just means one more clue for how to fix your next program.",
    },
    {
        "name": "🗂️ Mystery Sorting Rule",
        "objective": "Sort objects by a secret rule and have a partner guess the rule by observing the groups.",
        "materials": ["10-15 small household objects", "A card to write your secret rule on"],
        "steps": [
            "Pick a secret sorting rule (like 'things that are round' or 'things smaller than a spoon') and write it down without showing anyone.",
            "Sort the objects into 'yes' and 'no' groups following your rule.",
            "Have a partner look at the groups and guess your rule.",
            "Reveal your rule and check if they guessed correctly -- then switch roles!",
        ],
        "tip": "Figuring out a hidden pattern from grouped examples is exactly what data scientists do.",
    },
    {
        "name": "🔵 Growing Pattern Challenge",
        "objective": "Build and extend a growing pattern (like AAB, ABB) instead of a simple repeating one.",
        "materials": ["20+ small objects in 2 colors"],
        "steps": [
            "Build a growing pattern, like 1 red - 2 blue - 1 red - 2 blue.",
            "Notice how it's different from a simple repeating pattern -- the groups have counts that matter.",
            "Extend the pattern 3 more groups.",
            "Try inventing your own growing pattern (like 1-2-3 counting groups) for a partner to extend!",
        ],
        "tip": "Growing patterns show up in real math sequences -- you're getting an early look at algebra thinking.",
    },
    {
        "name": "📊 Bar Graph Builder Challenge",
        "objective": "Survey family members and turn the results into a simple hand-drawn bar graph.",
        "materials": ["Paper", "Pencil", "Ruler (optional)"],
        "steps": [
            "Ask at least 6 family members or friends a question with 3 answer choices.",
            "Tally the results for each choice.",
            "Draw a bar graph: one bar per answer choice, with height showing how many people chose it.",
            "Label your bars and say which one is tallest.",
        ],
        "tip": "A bar graph turns numbers into a picture you can understand at a glance.",
    },
    {
        "name": "🪨 Sink or Float Data Chart",
        "objective": "Build a data chart of sink/float results and identify a pattern in materials.",
        "materials": ["A bowl or tub of water", "10 small household objects (mix of plastic, wood, metal, rubber)", "Paper and pencil"],
        "steps": [
            "Make a 3-column chart: Object, Material, Result.",
            "Test every object and fill in the result column.",
            "Look down the material column -- do certain materials always sink, and others always float?",
            "Write one sentence describing the pattern you found.",
        ],
        "tip": "Once you spot a material pattern, you can predict new objects without even testing them!",
    },
    {
        "name": "🎈 Balloon Rocket Design Challenge",
        "objective": "Test how balloon size affects rocket travel distance.",
        "materials": ["3 balloons (different sizes to blow up)", "A long string", "A straw", "Tape", "Measuring tape"],
        "steps": [
            "Blow up your first balloon just a little and test its distance.",
            "Blow up a second balloon medium-full and test its distance.",
            "Blow up a third balloon as full as you safely can and test its distance.",
            "Compare all three distances -- did more air always mean farther travel?",
        ],
        "tip": "More isn't always better in engineering -- sometimes there's a 'just right' amount, and testing is how you find it.",
    },
    {
        "name": "🧸 Package Protector Challenge",
        "objective": "Build a padded box to protect a small toy from a short supervised drop.",
        "materials": ["A small toy figure", "A small box", "Padding materials (cotton balls, paper scraps, bubble wrap)", "Tape"],
        "steps": [
            "Pack your box with padding material, placing the toy in the center surrounded on all sides.",
            "Seal the box with tape.",
            "With an adult, drop the box from a set height (like a chair).",
            "Open it up and check if the toy survived -- if not, redesign your padding and try again.",
        ],
        "tip": "Padding on every side of the object, not just underneath, is the key to real package protection.",
    },
    {
        "name": "🚀 Catapult Distance Challenge",
        "objective": "Test and compare catapult launch distances across several tries.",
        "materials": ["A plastic spoon", "A pencil (pivot)", "A pom-pom or small ball", "Measuring tape", "Paper and pencil"],
        "steps": [
            "Set up your spoon catapult.",
            "Launch the pom-pom 3 times, measuring and recording each distance.",
            "Find your best (longest) distance.",
            "Try changing how hard you press before launching -- does more force always mean farther?",
        ],
        "tip": "Comparing multiple launches shows you which technique actually gets the best results.",
    },
    {
        "name": "📚 How Many Books? Challenge",
        "objective": "Test how many light books a rolled paper column can hold before collapsing.",
        "materials": ["2-3 sheets of paper", "Tape", "Several lightweight books"],
        "steps": [
            "Roll a sheet of paper into a sturdy tube and tape it closed.",
            "Stand the tube upright and carefully add one book flat on top.",
            "Keep adding books one at a time, counting as you go.",
            "Record how many books it held before collapsing, then try a wider or taller tube to compare!",
        ],
        "tip": "A wider tube usually holds more weight than a narrow one -- try it and see if that's true for you.",
    },
]


GAMES[4] = [
    {
        "name": "🏗️ Tape-Limited Tower Challenge",
        "objective": "Build the tallest self-standing tower while working within a strict tape limit.",
        "materials": ["20 sheets of scrap paper", "Exactly 10 small pieces of tape"],
        "steps": [
            "Plan your tower design before you start building -- tape is limited!",
            "Build using only your 10 pieces of tape.",
            "Measure your finished tower's height.",
            "If it collapses, note why, then try again with a smarter tape plan.",
        ],
        "tip": "Working within a limit forces creative solutions -- real engineers always work within a budget.",
    },
    {
        "name": "🌉 Load-Bearing Bridge Challenge",
        "objective": "Build a bridge that spans a fixed distance and test how much weight it can hold.",
        "materials": ["3-4 sheets of paper or craft sticks", "Tape", "2 stacks of books set a ruler-length apart", "Coins or dried beans"],
        "steps": [
            "Set the book stacks exactly one ruler-length apart.",
            "Build a bridge that reaches all the way across the gap.",
            "Add coins to the center, one at a time, recording the count as you go.",
            "Note the total right before the bridge fails, then try a design change and retest.",
        ],
        "tip": "The middle of a bridge is usually the weakest point -- reinforcing it is a real engineering strategy.",
    },
    {
        "name": "⛵ Design-Your-Own Boat Challenge",
        "objective": "Design an original boat from one sheet of foil to carry the most cargo possible, testing and comparing two versions.",
        "materials": ["2 sheets of aluminum foil", "A bowl or tub of water", "Cargo (coins, dried beans, or small blocks)"],
        "steps": [
            "Design and build your first boat, using only one sheet of foil.",
            "Test it by adding cargo until it sinks, and record the total.",
            "Build a second, different-shaped boat from your second sheet.",
            "Compare which design carried more cargo, and think about why.",
        ],
        "tip": "Comparing two designs side by side is how engineers figure out what actually works best.",
    },
    {
        "name": "✈️ Airplane Design Lab",
        "objective": "Test three different paper airplane designs and record which flies the farthest.",
        "materials": ["3 sheets of paper", "Measuring tape or string", "Paper and pencil for a data table"],
        "steps": [
            "Fold three differently-shaped airplanes (try changing wing width or nose shape).",
            "Throw each one twice from the same starting line, recording both distances.",
            "Record all six distances in a data table.",
            "Circle your best-performing design and describe what made it different.",
        ],
        "tip": "Recording every trial -- not just the best one -- gives you the full, honest picture.",
    },
    {
        "name": "🤖 Debug the Robot Program",
        "objective": "Find and fix an intentional mistake in a written robot program, practicing the skill of debugging.",
        "materials": ["Paper and pencil", "Open floor space", "A toy or marker as the goal"],
        "steps": [
            "One player secretly writes a program with one mistake in it (a wrong direction or missing step).",
            "The robot-friend follows the program exactly as written, even if it leads the wrong way.",
            "Together, figure out which step caused the problem -- that's the 'bug.'",
            "Fix the bug and run the corrected program to reach the goal.",
        ],
        "tip": "Finding a bug isn't a failure -- it's a normal, expected part of every programmer's job.",
    },
    {
        "name": "🗺️ Shortest Path Coding Challenge",
        "objective": "Find and write the most efficient (fewest-step) set of instructions to solve a maze.",
        "materials": ["Paper with a drawn grid maze (multiple possible paths)", "A token", "Pencil"],
        "steps": [
            "Draw a maze with more than one possible path to the goal.",
            "Find and write out the path that uses the fewest total moves.",
            "Test your instructions by moving the token exactly as written.",
            "Compare with a partner's maze solution -- whose path used fewer steps?",
        ],
        "tip": "Finding the shortest path isn't just neat -- it's exactly what real navigation apps and robots try to do.",
    },
    {
        "name": "🗂️ Venn Diagram Sort Challenge",
        "objective": "Sort a collection into two overlapping categories using a physical Venn diagram made of string or hoops.",
        "materials": ["2 pieces of string or 2 hula hoops (to make overlapping circles)", "15-20 small household objects"],
        "steps": [
            "Lay out two overlapping circles with string or hoops.",
            "Label one circle 'red' and the other 'round' (or two categories of your choice).",
            "Sort each object into the correct circle -- or into the overlap if it fits both.",
            "Check the overlap area: what do those objects have in common?",
        ],
        "tip": "The overlap in a Venn diagram shows what two categories share -- a powerful way to compare things.",
    },
    {
        "name": "🔵 Create-a-Pattern Challenge",
        "objective": "Design an original, moderately complex pattern for a partner to figure out and solve.",
        "materials": ["20-25 small objects (colors, shapes, or sizes)", "Paper and pencil"],
        "steps": [
            "Design your own repeating or growing pattern using at least 3 different objects.",
            "Lay it out at least 8 pieces long, then remove the last 2-3 pieces.",
            "Hand it to a partner and have them figure out and complete the missing pieces.",
            "Check together -- did they find your exact rule?",
        ],
        "tip": "Designing a pattern is harder than solving one -- you have to think one step ahead of your partner!",
    },
    {
        "name": "📊 Data Hunt Challenge",
        "objective": "Collect and graph real data by counting item types found around the house.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pick a category to count around the house (like book colors, shoe types, or spoon vs. fork count).",
            "Walk around and tally each item you find into its category.",
            "Draw a bar graph showing your final counts.",
            "Write one sentence describing the pattern you notice in your data.",
        ],
        "tip": "Real data doesn't come pre-organized -- collecting and sorting it yourself is real scientific work.",
    },
    {
        "name": "🪨 Sink or Float Investigation",
        "objective": "Investigate sink/float results across a wider set of objects and look for a material-based pattern.",
        "materials": ["A bowl or tub of water", "12-15 small household objects", "Paper and pencil for a data table"],
        "steps": [
            "Build a data table with columns for object, material, and predicted vs. actual result.",
            "Predict every object first, then test them all and record actual results.",
            "Group your results by material type (metal, wood, plastic, etc.).",
            "Write a conclusion: which material types were the most predictable, and which surprised you?",
        ],
        "tip": "Comparing predicted vs. actual results shows you exactly where your understanding needs updating.",
    },
    {
        "name": "🎈 Balloon Rocket Fair Test Challenge",
        "objective": "Run a fair test changing only the straw size to isolate its effect on rocket distance.",
        "materials": ["2-3 balloons", "A long string", "Straws of 2-3 different widths", "Tape", "Measuring tape"],
        "steps": [
            "Blow up each balloon to the exact same size (use a piece of tape as a size marker) to keep that part fair.",
            "Test the rocket with a narrow straw and record the distance.",
            "Test the rocket with a wider straw, keeping the balloon size the same, and record the distance.",
            "Compare -- did straw width alone make a difference?",
        ],
        "tip": "Keeping the balloon size exactly the same each time is what makes this a true fair test of the straw.",
    },
    {
        "name": "🥚 Egg-Safe Landing Challenge",
        "objective": "Design a protective capsule for a raw egg (or a wrapped ice cube for a mess-free version) to survive a short supervised drop.",
        "materials": ["1 raw egg (or a wrapped ice cube as a mess-free substitute)", "A small box or cup", "Padding materials (cotton balls, paper, tissue)", "Tape"],
        "steps": [
            "Build a padded capsule with your egg (or ice cube) centered and surrounded on all sides.",
            "With an adult, drop the capsule from a set low height onto a hard surface.",
            "Carefully open the capsule and check for cracks (or check the ice cube substitute for melting/damage).",
            "If it didn't survive, add more padding around the weak spot and test again.",
        ],
        "tip": "Even a raw egg can survive a fall with the right padding -- that's the whole idea behind protective packaging.",
    },
    {
        "name": "🚀 Catapult Design Challenge",
        "objective": "Build a rubber-band-powered catapult, test its distance, and adjust the design to improve it.",
        "materials": ["A plastic spoon", "A pencil (pivot)", "A rubber band", "A pom-pom or small ball", "Measuring tape"],
        "steps": [
            "Attach a rubber band to add extra launching power to your spoon catapult.",
            "Test-launch and measure the distance.",
            "Adjust the pivot point or rubber band tension and test again.",
            "Compare your before-and-after distances to see if your adjustment helped.",
        ],
        "tip": "Adjusting one part of a design and re-testing is the fastest way engineers make real improvements.",
    },
    {
        "name": "📚 Shape Strength Investigation",
        "objective": "Systematically test cylinder, triangle, and square paper columns to determine which shape holds the most weight.",
        "materials": ["3 sheets of paper (same size)", "Tape", "Small weights (books or coins) for testing", "Paper and pencil for a data table"],
        "steps": [
            "Build a cylinder, a triangular column, and a square column, each from an identical sheet of paper.",
            "Test each column's maximum weight capacity, adding weight until it buckles, and record results in a data table.",
            "Rank the three shapes from strongest to weakest.",
            "Write one sentence explaining which shape won and why you think that shape resists buckling best.",
        ],
        "tip": "This is one of the most famous tests in engineering -- triangles and cylinders usually beat squares because they resist bending in every direction.",
    },
]


GAMES[5] = [
    {
        "name": "🏗️ Newspaper Skyscraper Challenge",
        "objective": "Engineer a tall tower from newspaper that can support the weight of a book on top.",
        "materials": ["5-6 sheets of newspaper or scrap paper", "Tape"],
        "steps": [
            "Roll newspaper sheets into sturdy tubes for support columns.",
            "Build a tower structure using the tubes, taping joints for stability.",
            "Carefully place a lightweight book flat on top.",
            "If it wobbles or collapses, adjust your base and try again.",
        ],
        "tip": "A wide base and a light top load are the secret to a skyscraper that doesn't tip!",
    },
    {
        "name": "🌉 Two-Paper Bridge Challenge",
        "objective": "Engineer a bridge using only two sheets of paper and tape, then test and improve it through iteration.",
        "materials": ["Exactly 2 sheets of paper", "Tape", "2 stacks of books", "Coins or dried beans for weight testing"],
        "steps": [
            "Plan how to fold or shape just two sheets of paper into a strong bridge.",
            "Build and tape your bridge across the gap between the books.",
            "Load coins onto the bridge until it fails, recording the total.",
            "Rebuild using only your same two sheets in a new shape, and compare your results.",
        ],
        "tip": "Using fewer materials well is just as important to engineers as using more materials -- efficiency matters!",
    },
    {
        "name": "⛵ Cargo Capacity Boat Challenge",
        "objective": "Iterate on a boat design across three versions, recording cargo capacity data for each to find the best design.",
        "materials": ["3 sheets of aluminum foil", "A bowl or tub of water", "Cargo (coins or dried beans)", "Paper and pencil for a data table"],
        "steps": [
            "Build your first boat and test its cargo capacity, recording the result.",
            "Change one thing about the design (deeper sides, wider base, etc.) and build version 2.",
            "Test version 2 and record its capacity, then build and test version 3.",
            "Compare all three results in your data table and identify your best design.",
        ],
        "tip": "Changing one thing at a time between versions is how you know what actually made the difference.",
    },
    {
        "name": "✈️ Distance vs. Design Challenge",
        "objective": "Investigate how changing wing shape affects flight distance using a recorded data table.",
        "materials": ["4 sheets of paper", "Measuring tape or string", "Paper and pencil for a data table"],
        "steps": [
            "Fold a base airplane design and test it, recording the distance.",
            "Change only the wings (wider, narrower, angled up) and test again, recording distance.",
            "Repeat with two more wing variations, keeping everything else the same.",
            "Study your data table -- which wing change had the biggest effect on distance?",
        ],
        "tip": "Changing only one part of the design at a time is called a 'fair test' -- it's how you know what really caused the change.",
    },
    {
        "name": "🤖 Loop Command Challenge",
        "objective": "Use a 'loop' instruction (repeat a set of steps several times) to shorten a robot program.",
        "materials": ["Paper and pencil", "Open floor space", "Markers to lay out a repeating path"],
        "steps": [
            "Set up a path that repeats the same shape several times (like a zigzag).",
            "Instead of writing each step separately, write a 'loop': 'Repeat 3 times: forward 2 steps, turn right.'",
            "Your robot-friend follows the loop instruction exactly, repeating the steps the stated number of times.",
            "Compare how many lines your loop program took versus writing every step out separately.",
        ],
        "tip": "Loops let programmers say 'repeat this' instead of writing the same steps over and over -- real code uses this trick constantly.",
    },
    {
        "name": "🗺️ Maze Algorithm Challenge",
        "objective": "Write precise, unambiguous instructions for a partner to solve a maze without looking at it themselves.",
        "materials": ["Paper with a drawn grid maze", "A blindfold or simple barrier (a folder) to block the maze from the solver's view", "Pencil"],
        "steps": [
            "One partner studies the maze and writes exact step-by-step instructions.",
            "The other partner (without looking at the maze) follows only the written instructions to trace the path on a matching blank grid.",
            "Compare the traced path to the real maze -- did the instructions work?",
            "If not, discuss what was unclear or missing, and rewrite the instructions to fix it.",
        ],
        "tip": "If your partner couldn't follow it perfectly, the instructions -- not your partner -- needed fixing. That's the programmer's job.",
    },
    {
        "name": "🗂️ Classify the Collection Challenge",
        "objective": "Design an original multi-level classification system for a household collection.",
        "materials": ["20+ small household objects (a mixed drawer or toy bin works well)", "Paper and pencil"],
        "steps": [
            "Choose a big collection of mixed objects to classify.",
            "Create a main category system (like 'made of' -- plastic, wood, metal, paper).",
            "Within each main category, create at least one sub-group (like 'plastic -- toys' vs 'plastic -- tools').",
            "Draw your classification system as a simple tree diagram on paper.",
        ],
        "tip": "Multi-level classification (categories within categories) is how scientists organize everything from animals to elements.",
    },
    {
        "name": "🔵 Number Pattern Code Challenge",
        "objective": "Identify the rule behind a number pattern and use it to predict several more terms.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Write a number pattern with a hidden rule, like 2, 4, 6, 8, ___ or 3, 6, 12, 24, ___.",
            "Study the differences (or ratios) between numbers to find the rule.",
            "Predict and write the next 3 numbers in the sequence.",
            "Swap patterns with a partner and solve each other's!",
        ],
        "tip": "Every number pattern has a rule hiding inside it -- finding that rule is the heart of algebra.",
    },
    {
        "name": "📊 Survey & Graph Challenge",
        "objective": "Design an original survey question, collect data, graph it, and draw a conclusion from the results.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Write your own survey question with 3-4 possible answers.",
            "Ask at least 8 people and record their answers with tally marks.",
            "Create a labeled bar graph of your results.",
            "Write a conclusion sentence: what does your graph tell you about people's answers?",
        ],
        "tip": "A good conclusion connects your graph back to a real statement about what the data shows -- that's the whole point of collecting it.",
    },
    {
        "name": "🪨 What Makes It Float? Challenge",
        "objective": "Test same-weight objects of different shapes to explore how shape affects floating, introducing the idea of density in kid-friendly terms.",
        "materials": ["A bowl or tub of water", "A ball of modeling clay (or foil) that can be reshaped", "Paper and pencil"],
        "steps": [
            "Roll your clay (or foil) into a tight ball and test if it sinks or floats.",
            "Reshape the exact same amount of clay into a flat, wide bowl shape and test it again.",
            "Compare: did the same amount of material sink in one shape but float in another?",
            "Explain in your own words why shape -- not just what something's made of -- affects floating.",
        ],
        "tip": "Spreading the same weight over a wider area is the secret behind why boats (and this clay bowl) float.",
    },
    {
        "name": "🎈 Balloon Rocket Engineering Challenge",
        "objective": "Design a lightweight capsule attached to a balloon rocket and test how it affects travel distance.",
        "materials": ["2-3 balloons", "A long string", "A straw", "Tape", "A small paper cup or folded paper capsule", "Measuring tape"],
        "steps": [
            "Test your balloon rocket's baseline distance with no capsule attached.",
            "Build a lightweight paper capsule and attach it to the rocket.",
            "Test the rocket again with the capsule attached and record the new distance.",
            "Compare the two distances and explain what effect the extra weight had.",
        ],
        "tip": "Adding weight to a design almost always changes performance -- engineers always test 'before and after' an add-on.",
    },
    {
        "name": "🥚 Egg Drop Engineering Challenge",
        "objective": "Engineer an egg-protection capsule within a limited material budget and test it from increasing heights.",
        "materials": ["1 raw egg (or a wrapped ice cube as a mess-free substitute)", "A limited kit: 1 small box, 10 cotton balls, 5 pieces of tape", "A ruler or tape measure"],
        "steps": [
            "Design and build your capsule using only your limited materials.",
            "Test-drop from a low height first (like 1 foot) with an adult supervising.",
            "If it survives, raise the height gradually and retest, recording the highest successful height.",
            "If it breaks, note what happened and think about what you'd change with the same limited materials.",
        ],
        "tip": "Working within a strict material budget forces the smartest possible design -- that's real engineering constraint-solving.",
    },
    {
        "name": "🚀 Ramp Angle Investigation",
        "objective": "Investigate how ramp steepness affects rolling distance using a fair test.",
        "materials": ["A small ball", "A book or board that can be propped at different angles", "Books to prop the ramp at different heights", "Measuring tape"],
        "steps": [
            "Set your ramp at a low angle and roll the ball, measuring the total distance traveled.",
            "Raise the ramp to a medium angle (keeping the ball and rolling surface exactly the same) and test again.",
            "Raise it to a steep angle and test a third time.",
            "Graph or chart your three distances -- does a steeper ramp always mean farther travel?",
        ],
        "tip": "Keeping everything the same except the ramp angle is what makes this a true fair test of steepness.",
    },
    {
        "name": "📚 Strongest Shape Engineering Challenge",
        "objective": "Design and iterate a paper column within a strict one-sheet material constraint to maximize weight held.",
        "materials": ["3 sheets of paper (one for each of 3 attempts)", "Tape", "Small weights (books or coins) for testing", "Paper and pencil for a data table"],
        "steps": [
            "Design and build your first column using exactly one sheet of paper, then test its max weight capacity.",
            "Redesign using your second sheet, changing the shape or fold pattern based on what you learned.",
            "Test your second design and record whether it improved.",
            "Build and test a third version, aiming to beat both previous results, and record all three in your data table.",
        ],
        "tip": "Sticking to a strict one-sheet limit across every version is what makes this a fair comparison between your own designs.",
    },
]


GAMES[6] = [
    {
        "name": "🏗️ Spaghetti Tower Challenge",
        "objective": "Design and test a freestanding tower using uncooked spaghetti and tape, then record which design held the most weight.",
        "materials": ["20 pieces of uncooked spaghetti", "Tape", "A small paper cup", "Coins or dried beans for weight testing"],
        "steps": [
            "Build a tower using spaghetti as the frame and tape as the connector.",
            "Attach the paper cup to the top of your tower.",
            "Add coins to the cup one at a time until the tower buckles -- count how many it held.",
            "Redesign and test a second tower, then compare which design held more weight and why.",
        ],
        "tip": "Triangles brace better than squares -- most engineers reach for triangle shapes when strength matters!",
    },
    {
        "name": "🌉 Longest-Span Bridge Challenge",
        "objective": "Design a bridge to span the longest possible distance while still holding a set amount of weight, recording results in a data table.",
        "materials": ["5-6 craft sticks or paper strips", "Tape", "Books to create an adjustable gap", "Coins for weight testing", "Paper and pencil for a data table"],
        "steps": [
            "Build a bridge design and test the maximum gap it can span while still holding 5 coins.",
            "Record the span distance and coin count in a data table.",
            "Redesign to try increasing the span without losing weight capacity.",
            "Compare your two designs -- which had the better span-to-strength ratio?",
        ],
        "tip": "Longer spans need cleverer support -- that's why real bridges use triangle trusses underneath.",
    },
    {
        "name": "⛵ Maximum Cargo Boat Engineering Challenge",
        "objective": "Design and test multiple boat versions to maximize cargo capacity, graphing the results to identify design trends.",
        "materials": ["3-4 sheets of aluminum foil", "A bowl or tub of water", "Cargo (coins or dried beans)", "Paper and pencil for a graph"],
        "steps": [
            "Design and test at least 3 different boat shapes, recording the cargo count each held.",
            "Make a simple bar graph comparing the cargo capacity of each design.",
            "Look at your graph and identify which shape features (wide, deep, boxy) held the most.",
            "Build one final 'best guess' design combining your best features and test it.",
        ],
        "tip": "Graphing your results turns raw numbers into a pattern you can actually see and use.",
    },
    {
        "name": "✈️ Aerodynamics Design Challenge",
        "objective": "Conduct a fair test on paper airplane design, changing one variable at a time and analyzing which variable matters most.",
        "materials": ["5 sheets of paper", "Measuring tape or string", "Paper and pencil for a data table"],
        "steps": [
            "Choose one variable to test (paper weight, wing width, or fold count) and build two versions differing only in that variable.",
            "Fly each version three times, recording all distances in a table.",
            "Calculate the average distance for each version.",
            "Write a sentence stating which version performed better and why you think that variable made the difference.",
        ],
        "tip": "Changing only one variable at a time is the core of fair scientific testing -- it's what separates a guess from real evidence.",
    },
    {
        "name": "🤖 If-Then Robot Challenge",
        "objective": "Introduce conditional logic by writing 'if-then' rules for a robot-friend to follow when reaching a decision point.",
        "materials": ["Paper and pencil", "Open floor space", "Markers for a fork-in-the-path course"],
        "steps": [
            "Set up a path with a fork where the robot-friend must choose a direction.",
            "Write a conditional rule, like 'If you reach a wall, turn right. If you reach an open space, keep going forward.'",
            "Your robot-friend follows the program exactly, applying the if-then rule at the decision point.",
            "Test the program on two different paths and see if the same rule still works for both.",
        ],
        "tip": "'If-then' rules let a program make decisions on its own -- this is a building block of real computer logic.",
    },
    {
        "name": "🗺️ Efficient Algorithm Challenge",
        "objective": "Compare multiple valid maze solutions to determine which is most efficient, and explain what 'efficient' means in this context.",
        "materials": ["Paper with a drawn grid maze (multiple valid paths)", "Pencil", "Paper and pencil for a comparison table"],
        "steps": [
            "Find at least two different valid paths through the maze and write instructions for each.",
            "Count the total number of moves in each path.",
            "Record both path lengths in a table and identify the shorter (more efficient) one.",
            "Write a sentence explaining why a shorter set of instructions can still solve the same problem just as well.",
        ],
        "tip": "In computer science, doing the same job in fewer steps is called 'efficiency' -- it's a core engineering goal.",
    },
    {
        "name": "🗂️ Data Categories Design Challenge",
        "objective": "Design a logical sorting system for a large item collection and explain the reasoning behind your categories.",
        "materials": ["25-30 small household objects (books, toys, or a junk drawer work well)", "Paper and pencil"],
        "steps": [
            "Design at least 3 categories that could organize your whole collection with no leftover items.",
            "Sort every item into a category, keeping a tally count for each.",
            "Check: does every item fit somewhere, and does no item obviously fit two categories?",
            "Write 2-3 sentences explaining why you chose those categories and how you'd adjust them if a strange new item didn't fit.",
        ],
        "tip": "Good categories cover every case with no overlap -- that's the same standard real data organizers use.",
    },
    {
        "name": "🔵 Pattern Rule Challenge",
        "objective": "Find the mathematical rule behind a pattern and express it in words and in a table.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Create a number or shape pattern with at least 6 terms.",
            "Make a table with 'term number' in one column and 'value' in the other.",
            "Study the table to find the rule connecting term number to value (like 'multiply by 2, then add 1').",
            "Use your rule to predict the value of term number 10 without building it out by hand.",
        ],
        "tip": "Writing a rule that predicts any term -- even far-away ones -- is exactly what a math formula does.",
    },
    {
        "name": "📊 Data Analysis Challenge",
        "objective": "Collect numeric measurement data, calculate an average, and graph the results.",
        "materials": ["Paper", "Pencil", "A measuring tool (ruler, tape measure, or a scale)"],
        "steps": [
            "Choose something measurable to collect data on (like the length of 8 different household objects, or step counts across a room).",
            "Measure and record 8-10 data points.",
            "Add all your numbers together and divide by how many you collected to find the average.",
            "Graph your data points and mark where the average falls on the graph.",
        ],
        "tip": "The average gives you one number that summarizes a whole set of data -- it's one of the most useful tools in math.",
    },
    {
        "name": "🪨 Density Detective Challenge",
        "objective": "Investigate and explain the sink/float pattern across a wide range of materials using the concept of density.",
        "materials": ["A bowl or tub of water", "15+ small household objects of different materials", "Paper and pencil for a data table"],
        "steps": [
            "Test and record sink/float results for all your objects, noting the material of each.",
            "Group results by material and look for a consistent pattern.",
            "Recall which everyday materials are generally 'light for their size' (float) versus 'heavy for their size' (sink).",
            "Write a short explanation connecting your data to the idea that floating depends on weight compared to size, not weight alone.",
        ],
        "tip": "This 'weight compared to size' idea is called density -- you just investigated one of the biggest ideas in physical science.",
    },
    {
        "name": "🎈 Balloon Rocket Optimization Challenge",
        "objective": "Run multiple trials of a balloon rocket design, calculate an average distance, and iterate to improve it.",
        "materials": ["4-5 balloons", "A long string", "A straw", "Tape", "Measuring tape", "Paper and pencil for a data table"],
        "steps": [
            "Run 3 trials of your rocket design, recording each distance in a data table.",
            "Calculate the average distance across the 3 trials.",
            "Make one design change (straw angle, balloon size, or string tautness) and run 3 more trials.",
            "Compare the two averages -- did your change improve performance?",
        ],
        "tip": "One trial can be lucky or unlucky, but an average across several tells you what's really true.",
    },
    {
        "name": "🥚 Impact Protection Challenge",
        "objective": "Design an egg-protection capsule, test it from a measured starting height, and increase the height across iterations to find its breaking point.",
        "materials": ["2-3 raw eggs (or wrapped ice cubes)", "Building materials (box, cotton balls, tape, paper)", "A tape measure", "Paper and pencil for a data table"],
        "steps": [
            "Build your first capsule design and test-drop it from a measured 2-foot height, recording pass/fail.",
            "If it survives, increase the height in 1-foot increments, recording each result in a data table.",
            "When it fails, note the exact height and think about which part of the design likely failed.",
            "Build a second, improved capsule and repeat the height tests to see if it survives higher drops.",
        ],
        "tip": "Recording the exact height where a design fails tells you precisely how much stronger your next version needs to be.",
    },
    {
        "name": "🚀 Catapult Engineering Challenge",
        "objective": "Design a catapult with an adjustable launch angle and test performance across multiple angle settings.",
        "materials": ["A plastic spoon or craft-stick catapult frame", "A pencil (pivot)", "A rubber band", "A pom-pom or small ball", "Measuring tape", "Paper and pencil for a data table"],
        "steps": [
            "Build your catapult so the pivot or angle can be adjusted between tests.",
            "Test-launch at a low angle setting, recording the distance.",
            "Adjust to a medium and then a steep angle, recording distance for each.",
            "Identify which angle setting produced the longest launch, and record all results in your data table.",
        ],
        "tip": "Testing across a full range of settings -- not just one -- is how you find the true best design, not just a good-enough one.",
    },
    {
        "name": "📚 Load Test Engineering Challenge",
        "objective": "Systematically test multiple column shapes with a full data table and calculate the maximum load per shape.",
        "materials": ["4-5 sheets of paper", "Tape", "Small weights (coins or dried beans, counted individually)", "Paper and pencil for a data table"],
        "steps": [
            "Build at least 3 different column shapes, one sheet of paper each.",
            "Test each column by adding weights one at a time, counting the exact number added before buckling.",
            "Record the total weight (number of coins/beans) held by each shape in a data table.",
            "Calculate which shape held the most weight per sheet of paper used, and explain your reasoning in writing.",
        ],
        "tip": "Measuring load per exact same amount of material is how real engineers fairly compare different structural designs.",
    },
]


GAMES[7] = [
    {
        "name": "🏗️ Free-Standing Tower Engineering Challenge",
        "objective": "Apply a strict material budget to design a tower, test its weight capacity, and reflect on which structural shape performed best.",
        "materials": ["30 index cards or paper strips", "Tape (measured, e.g. 50 cm total)", "A small paper cup", "Coins or dried beans for weight testing", "Paper and pencil for a data table"],
        "steps": [
            "Sketch your design first, staying within the material budget.",
            "Build the tower and attach a cup to the top for weight-testing.",
            "Add coins one at a time, recording the total weight in a data table each round until it fails.",
            "Rebuild with one deliberate change (shape, base width, or bracing) and retest -- record whether the new design held more or less weight, and explain why.",
        ],
        "tip": "Recording your data and comparing designs is the real engineering process -- it's not just building, it's improving.",
    },
    {
        "name": "🌉 Bridge Design Trade-Off Challenge",
        "objective": "Investigate the trade-off between bridge span and strength, and explain the engineering reasoning behind the results.",
        "materials": ["8-10 craft sticks or paper strips", "Tape", "Books to create an adjustable gap", "Coins for weight testing", "Paper and pencil for a data table"],
        "steps": [
            "Build a bridge and test it at three different span lengths, recording the maximum weight held at each length.",
            "Graph or chart your results (span vs. weight held).",
            "Identify the pattern -- does a longer span always mean less strength?",
            "Write one sentence explaining what your data shows about the trade-off between span and strength.",
        ],
        "tip": "Every real bridge design balances span, strength, and materials -- you just did real structural engineering.",
    },
    {
        "name": "⛵ Boat Hull Design Challenge",
        "objective": "Systematically compare different hull shapes for cargo capacity and explain the buoyancy principle behind the results.",
        "materials": ["4 sheets of aluminum foil", "A bowl or tub of water", "Cargo (coins or dried beans)", "Paper and pencil for a data table"],
        "steps": [
            "Build four boats with distinctly different hull shapes (flat, round, boxy, pointed).",
            "Test each one's cargo capacity, recording results in a data table.",
            "Rank the hull shapes from most to least cargo held.",
            "Write one or two sentences explaining, in your own words, why the winning shape displaces more water and floats more weight.",
        ],
        "tip": "A boat floats by pushing water out of the way -- the more water it displaces, the more weight it can carry.",
    },
    {
        "name": "✈️ Flight Engineering Challenge",
        "objective": "Design a paper airplane under material constraints, run multiple controlled trials, and reflect on the importance of variable control.",
        "materials": ["1 sheet of paper only (constraint)", "Tape (max 3 pieces)", "Measuring tape or string", "Paper and pencil for a data table"],
        "steps": [
            "Design your best airplane using only the allowed sheet of paper and tape.",
            "Fly it 5 times from the same spot in the same way, recording every distance.",
            "Calculate the average distance across all 5 trials.",
            "Reflect in writing: why does flying multiple trials give a more reliable result than a single throw?",
        ],
        "tip": "Averaging multiple trials smooths out lucky or unlucky throws -- real engineers never trust just one test.",
    },
    {
        "name": "🤖 Full Program Design Challenge",
        "objective": "Design a complete program combining loops and conditionals to navigate a complex path, then debug a partner's program.",
        "materials": ["Paper and pencil", "Open floor space", "Markers to lay out a multi-turn course"],
        "steps": [
            "Design a course with turns, a repeating section, and a decision point.",
            "Write a full program for it using at least one loop and one if-then rule.",
            "Trade programs with a partner and run their program exactly as written on your robot-friend.",
            "If it fails partway, work together to find and fix the bug, then rerun it successfully.",
        ],
        "tip": "Combining loops, conditionals, and careful debugging is exactly what real software engineers do every day.",
    },
    {
        "name": "🗺️ Maze Optimization Challenge",
        "objective": "Write a maze-solving algorithm using loop notation for repeated moves, then measure and compare its efficiency to a non-looped version.",
        "materials": ["Paper with a drawn grid maze that has a repeating straight section", "Pencil", "Paper and pencil for a data table"],
        "steps": [
            "Write out the full maze solution move-by-move (e.g., 'forward, forward, forward, forward, turn left').",
            "Rewrite the same solution using loop notation for the repeated section (e.g., 'repeat 4 times: forward. Then turn left.').",
            "Count the total written lines/instructions for each version and compare in a table.",
            "Explain in writing why the loop version does the same job with fewer written instructions.",
        ],
        "tip": "Real programming languages use loops for exactly this reason -- shorter code that does the same job is easier to read and fix.",
    },
    {
        "name": "🗂️ Sorting Algorithm Race",
        "objective": "Physically perform a simple sorting algorithm (comparing and swapping pairs) on number cards and time how long it takes.",
        "materials": ["10 index cards, each with a different random number written on it", "A stopwatch or phone timer"],
        "steps": [
            "Lay your 10 number cards in a random row.",
            "Using only 'compare two neighboring cards and swap if out of order,' work left to right and repeat full passes until the whole row is in order (this is called a 'bubble sort').",
            "Time how long it takes and count how many total swaps you made.",
            "Shuffle and try again -- did you finish faster or with fewer swaps the second time?",
        ],
        "tip": "You just performed a real sorting algorithm by hand -- computers do the exact same compare-and-swap steps, just much faster.",
    },
    {
        "name": "🔵 Pattern & Sequence Design Challenge",
        "objective": "Design a multi-step pattern with a clear rule, then challenge a partner to discover the rule and predict a distant term.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Design an original pattern (numbers or shapes) with a rule that takes at least two steps to describe (like 'double it, then subtract 1').",
            "Write out the first 5 terms only, keeping your rule secret.",
            "Give it to a partner and challenge them to find the rule and predict term number 10.",
            "Check their answer against your actual rule, and discuss any tricky parts that made it hard to find.",
        ],
        "tip": "A pattern that takes real thinking to crack is more fun to design than one that's too easy -- that's the mark of a good puzzle-maker.",
    },
    {
        "name": "📊 Data Investigation Challenge",
        "objective": "Formulate an original data question, collect and graph evidence, and write a data-based conclusion.",
        "materials": ["Paper", "Pencil", "A measuring tool if needed"],
        "steps": [
            "Write down a real question you're curious about that data could answer (like 'do taller family members have bigger feet?').",
            "Collect at least 8-10 data points relevant to your question.",
            "Graph your data in a way that helps answer the question (bar graph, line graph, or scatter of points).",
            "Write a short data-based conclusion: does your evidence support a 'yes,' 'no,' or 'not enough data yet' answer?",
        ],
        "tip": "Starting with a real question and following the evidence -- even to an uncertain answer -- is exactly how real data investigations work.",
    },
    {
        "name": "🪨 Buoyancy Engineering Challenge",
        "objective": "Redesign a naturally sinking object to make it float by adding materials, iterating through multiple versions.",
        "materials": ["A bowl or tub of water", "A small heavy object that sinks (like a metal washer or heavy bolt)", "Aluminum foil or modeling clay", "Paper and pencil for a data table"],
        "steps": [
            "Confirm your heavy object sinks on its own.",
            "Wrap or attach foil/clay around it in a shape designed to add floating volume, then retest.",
            "If it still sinks, redesign with a wider or more boat-like shape and test again -- track each version in a data table.",
            "Once it floats, explain in writing what design change finally made the difference and why.",
        ],
        "tip": "You just applied real buoyancy engineering -- adding the right shape and volume can make even heavy things float.",
    },
    {
        "name": "🎈 Balloon Rocket Payload Challenge",
        "objective": "Determine the maximum payload a balloon rocket can carry while still traveling a minimum distance, using a full data table and written reflection.",
        "materials": ["5+ balloons", "A long string", "A straw", "Tape", "Small weights (paper clips or coins)", "Measuring tape", "Paper and pencil for a data table"],
        "steps": [
            "Test your rocket's unloaded distance and set a minimum distance goal (e.g., at least half the string's length).",
            "Attach a small weight to the rocket and test whether it still reaches the minimum distance.",
            "Keep adding weight in small increments, recording payload and distance in a data table after each test.",
            "Identify the maximum payload that still met your minimum distance, and write a short reflection on the trade-off between payload and performance.",
        ],
        "tip": "Every real rocket and cargo vehicle has to balance how much it carries against how far or fast it can go -- you just tackled that same trade-off.",
    },
    {
        "name": "🥚 Egg Drop Redesign Challenge",
        "objective": "Iterate through three full capsule redesigns, recording data on each, and reflect on which single design change mattered most.",
        "materials": ["3 raw eggs (or wrapped ice cubes)", "Building materials (box, cotton balls, tape, paper, straws)", "A tape measure", "Paper and pencil for a data table"],
        "steps": [
            "Build version 1 of your capsule and test-drop it from a fixed height (like 4 feet), recording the result.",
            "Redesign with exactly one deliberate change (more padding, a different shape, a shock-absorbing layer) to build version 2, and test it from the same height.",
            "Build a third version with another single change, and test it too, recording all results in your data table.",
            "Write a reflection identifying which single change made the biggest difference in survival, and explain your reasoning.",
        ],
        "tip": "Changing one variable per version is what makes your data trustworthy -- now you know exactly which change mattered, not just that something worked.",
    },
    {
        "name": "🚀 Projectile Distance Optimization Challenge",
        "objective": "Systematically vary launch angle and pull-back force one at a time to find the combination that maximizes distance.",
        "materials": ["A craft-stick or spoon catapult with an adjustable pivot", "A rubber band", "A pom-pom or small ball", "Measuring tape", "Paper and pencil for a data table"],
        "steps": [
            "Fix the pull-back force and test 3 different launch angles, recording distance for each in a data table.",
            "Identify your best angle, then fix that angle and test 3 different pull-back forces, recording each distance.",
            "Identify your best pull-back force from that round.",
            "Combine your best angle and best pull-back force in one final launch, and compare it to all your earlier results -- was it truly your longest?",
        ],
        "tip": "Testing one variable at a time before combining your best settings is a real optimization strategy engineers use to fine-tune designs.",
    },
    {
        "name": "📚 Structural Engineering Challenge",
        "objective": "Design a paper structure under a strict material budget to hold the maximum possible weight, and reflect on why triangulated shapes resist buckling.",
        "materials": ["Exactly 3 sheets of paper and 15 cm of tape (fixed budget)", "Small weights (coins or dried beans) for load-testing", "Paper and pencil for a data table"],
        "steps": [
            "Sketch your structure design before building, planning to use triangulated shapes for strength within your fixed budget.",
            "Build your structure exactly within the material limit.",
            "Load-test it by adding weight gradually, recording the total held in a data table right up to the point of failure.",
            "Write a short reflection explaining, using the idea of triangulation, why your design held (or didn't hold) as much weight as you expected.",
        ],
        "tip": "Triangles can't collapse into a different shape the way squares can -- that's why triangulated structures like bridges and cranes are built the way they are.",
    },
]


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    # Plain ASCII " | " separator -- a non-ASCII middle-dot separator here
    # previously got double-UTF8-encoded somewhere in the sqlcmd/ODBC file-
    # reading pipeline (confirmed live: " · " landed in the DB as the
    # literal 4-character sequence " Â· "), and a plain comma is
    # ambiguous since several material descriptions already contain commas
    # inside their own parenthetical text (e.g. "(coins, dried beans, or
    # small blocks)").
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to try the challenge!")


def emit_sql():
    out = []
    out.append("-- 75_stem_games_content.sql")
    out.append("-- Adds a 'STEM Challenge Games' category to the existing always-on")
    out.append("-- 'stem_engineering' subject_area for every grade (TK-6th) -- no schema")
    out.append("-- or proc changes needed, reuses dbo.PacketSubjectAreas/")
    out.append("-- usp_GetOrCreateWeeklyPacket exactly as-is.")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual")
    out.append("-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation")
    out.append("-- serves a different 7-of-14 combination most weeks a grade's")
    out.append("-- stem_engineering category is selected, satisfying \"7 STEM challenge")
    out.append("-- games, different set each week\" without any manual per-week authoring.")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions (already-shipped diagram type, renders as a numbered list in")
    out.append("-- both the app and print -- see 63_whole_child_rotation.sql and")
    out.append("-- 68_outdoor_games_content.sql), and answer_text carries the closing")
    out.append("-- engineering-mindset tip.")
    out.append("-- See gen_75_stem_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'stem_engineering' AND category_name = N'STEM Challenge Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_stem_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'stem_engineering', N'STEM Challenge Games', 'space_heavy', 7, N'Build, test, and experiment with a hands-on STEM challenge!', 0);"
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
    # "\n" to "\r\n" -- without it, every embedded "\n\n" inside a prompt
    # string (used to separate Name/Objective/Materials) gets written as a
    # literal "\r\n" into the SQL file, which then lands as-is inside the
    # quoted N'...' string literal and gets stored corrupted in the database.
    # Hit this for real on this exact content type before (68_outdoor_games).
    with open(r"D:\Project\www\littlescholarhub\lsh.database\75_stem_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 75_stem_games_content.sql", file=sys.stderr)
