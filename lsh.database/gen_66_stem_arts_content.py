# -*- coding: utf-8 -*-
"""
Generates lsh.database/66_stem_arts_content.sql — Whole-Child Curriculum
expansion, batch 3: 'stem_engineering' (MIT STEM/Coding, Caltech Science &
Experimentation, Georgia Tech Engineering & Robotics, UIUC CS/Math/Data)
and 'arts' (Visual Art, Music & Performing Arts, Creative Writing &
Storytelling). Same pattern as gen_64/gen_65 — see those files for the
helper docstrings. Run with: python gen_migration_66.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]


def q_fill(prompt, answer, diagram_type=None, diagram_data=None):
    return {"qtype": "fill_blank", "prompt": prompt, "choices": None, "answer": answer,
            "diagram_type": diagram_type, "diagram_data": diagram_data}


def q_mc(prompt, choices, answer, diagram_type=None, diagram_data=None):
    return {"qtype": "multiple_choice", "prompt": prompt, "choices": choices, "answer": answer,
            "diagram_type": diagram_type, "diagram_data": diagram_data}


def q_short(prompt, answer, diagram_type=None, diagram_data=None):
    return {"qtype": "short_response", "prompt": prompt, "choices": None, "answer": answer,
            "diagram_type": diagram_type, "diagram_data": diagram_data}


def q_match(prompt, left, right, pairs, answer_note=""):
    choices = {"left": left, "right": right}
    answer = json.dumps(pairs)
    return {"qtype": "matching", "prompt": prompt, "choices": choices, "answer": answer,
            "diagram_type": None, "diagram_data": None}


def q_seq(prompt, steps, answer):
    return {"qtype": "short_response", "prompt": prompt, "choices": None, "answer": answer,
            "diagram_type": "sequence_steps", "diagram_data": {"steps": steps}}


CATEGORIES = []


# ═══════════════════════════════════════════════════════════════════════
# STEM 1/4: MIT — STEM, Engineering & Coding
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "mit_stem", "subject_area": "stem_engineering", "category_name": "STEM, Engineering & Coding", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Which simple machine helps you roll something up to a higher spot?", ["Ramp", "Lever", "Wheel"], "Ramp"),
                q_mc("A see-saw is an example of a...", ["Lever", "Ramp", "Pulley"], "Lever"),
                q_short("Name a simple machine you've seen or used.", "Answers will vary."),
                q_mc("A ramp helps you...", ["Move something up or down more easily", "Make something disappear", "Make noise"], "Move something up or down more easily"),
                q_short("Draw a picture of a ramp being used.", "Answers will vary."),
                q_mc("Simple machines help people...", ["Do work more easily", "Make things harder", "Nothing useful"], "Do work more easily"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Take on the build-a-tower challenge!",
            "questions": [
                q_short("What materials would you use to build the tallest tower you can?", "Answers will vary."),
                q_mc("A strong tower base should be...", ["Wide, to help it balance", "As thin as possible", "Made only of paper"], "Wide, to help it balance"),
                q_short("If your tower fell over, what would you try differently next time?", "Answers will vary."),
                q_mc("Why does a wide base usually make a tower more stable?", ["It spreads the weight out and resists tipping over", "Wide bases make towers weaker", "Base width doesn't matter"], "It spreads the weight out and resists tipping over"),
                q_short("Draw your tower design before building it.", "Answers will vary."),
                q_mc("Testing your tower after building it helps you...", ["See if your design actually works", "Nothing, testing is a waste of time", "Make the tower shorter"], "See if your design actually works"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice unplugged coding by sequencing arrows to move a character.",
            "questions": [
                q_seq("Sequence the arrows to move a character from start to the treasure: up, right, right, down.", ["Up", "Right", "Right", "Down"], "Up, right, right, down."),
                q_mc("In coding, a 'sequence' is...", ["A set of steps done in order", "A random guess", "A single step only"], "A set of steps done in order"),
                q_short("Write your own 3-arrow sequence to move a character forward, then turn.", "Answers will vary."),
                q_mc("If you put the arrows in the WRONG order, what happens?", ["The character goes the wrong way", "Nothing changes", "The character disappears"], "The character goes the wrong way"),
                q_short("Why does the ORDER of the arrows matter so much in coding?", "Each step happens one after another, so the wrong order leads to the wrong result."),
                q_mc("Coding without a computer, using arrows or cards, is called...", ["Unplugged coding", "Plugged coding", "No coding at all"], "Unplugged coding"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Explore simple circuits and levers.",
            "questions": [
                q_mc("A simple circuit needs a power source, wires, and a...", ["Light bulb or device to power", "Nothing else", "A lever"], "Light bulb or device to power"),
                q_mc("If a circuit has a break in the wire, what happens?", ["The circuit won't work", "It works even better", "Nothing changes"], "The circuit won't work"),
                q_short("Draw a simple circuit with a battery, a wire, and a light bulb.", "Answers will vary."),
                q_mc("A lever helps you lift a heavy object by...", ["Using a pivot point to multiply your force", "Making the object lighter", "Removing gravity"], "Using a pivot point to multiply your force"),
                q_short("Name one place you might see a lever used in real life.", "Answers will vary (e.g., a seesaw, a bottle opener, scissors)."),
                q_mc("Circuits and levers are both examples of...", ["Simple tools that make work easier", "Living things", "Foods"], "Simple tools that make work easier"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Solve coding logic puzzles using if/then sequencing.",
            "questions": [
                q_short("Write an IF/THEN rule for a robot: 'IF it sees a wall, THEN ___.'", "Answers will vary (e.g., 'THEN it turns right.')."),
                q_mc("An IF/THEN statement lets a program...", ["Make a decision based on a condition", "Always do the exact same thing no matter what", "Skip all its steps"], "Make a decision based on a condition"),
                q_short("Write your own IF/THEN rule for a game character.", "Answers will vary."),
                q_mc("IF a robot's battery is low, THEN it should probably...", ["Go recharge", "Move faster", "Stop working forever"], "Go recharge"),
                q_short("Why are IF/THEN rules useful for programming instead of just one long list of steps?", "They let the program react differently depending on what's happening, not just repeat the same steps blindly."),
                q_mc("A coding logic puzzle usually asks you to...", ["Figure out the right sequence and conditions to solve a problem", "Draw a picture with no logic involved", "Memorize random facts"], "Figure out the right sequence and conditions to solve a problem"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design, build, and test a bridge challenge.",
            "questions": [
                q_short("What materials would you use to build a bridge that can hold weight?", "Answers will vary."),
                q_seq("Put the engineering design steps in order for this bridge challenge.", ["Plan your bridge design", "Build it with your materials", "Test it with weight", "Improve it based on what happened"], "Plan, build, test, improve."),
                q_short("What shape (like a triangle) might make a bridge stronger, and why?", "Triangles are strong shapes that resist bending, so triangle supports help distribute weight."),
                q_mc("If your bridge collapses during testing, that means...", ["You learned something useful for your next design", "You should give up on engineering", "Nothing, testing doesn't matter"], "You learned something useful for your next design"),
                q_short("How would you test how much weight your bridge can hold?", "Answers will vary (e.g., adding weights gradually until it fails)."),
                q_mc("Why do engineers build and test PROTOTYPES before a final design?", ["Testing reveals weaknesses you can't predict just by planning", "Prototypes are a waste of time", "The first design is always perfect"], "Testing reveals weaknesses you can't predict just by planning"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Get an intro to algorithms and flowcharts.",
            "questions": [
                q_short("What is an algorithm? Explain in your own words.", "A step-by-step set of instructions for solving a problem or completing a task."),
                q_seq("Write a simple algorithm (as ordered steps) for making a peanut butter sandwich.", ["Get bread", "Spread peanut butter", "Put the slices together"], "Answers will vary but should be a clear, ordered sequence."),
                q_mc("A flowchart uses shapes and arrows to show...", ["The steps and decisions in a process", "A piece of art with no meaning", "A list with no order"], "The steps and decisions in a process"),
                q_short("Draw a simple flowchart for deciding whether to bring an umbrella (hint: start with 'Is it raining?').", "Answers will vary — should include a decision point (yes/no) leading to different outcomes."),
                q_mc("Why do programmers often plan with flowcharts BEFORE writing code?", ["It helps them think through the logic clearly first", "Flowcharts have nothing to do with programming", "It's required by law"], "It helps them think through the logic clearly first"),
                q_short("Why might an algorithm with unclear or missing steps cause problems?", "Whoever (or whatever) follows the algorithm might not know what to do, or do the wrong thing."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Complete a mini engineering design project: plan, build, test, improve.",
            "questions": [
                q_short("Choose a simple engineering challenge (like a paper airplane that flies far, or a container that protects an egg drop). Describe your PLAN.", "Answers will vary."),
                q_short("Describe how you BUILT your design based on the plan.", "Answers will vary."),
                q_short("Describe how you TESTED your design, and what happened.", "Answers will vary."),
                q_short("Describe how you would IMPROVE your design based on the test results.", "Answers will vary."),
                q_mc("The engineering design cycle (plan, build, test, improve) is usually...", ["Repeated multiple times to get a better result", "Only ever done once", "Done in a random order"], "Repeated multiple times to get a better result"),
                q_mc("Why is 'improve' an important final step, not just 'test'?", ["Testing shows what's wrong, but improving actually fixes it", "Improving is unnecessary once you've tested", "The improve step should come before testing"], "Testing shows what's wrong, but improving actually fixes it"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# STEM 2/4: Caltech — Science & Experimentation
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "caltech_sci", "subject_area": "stem_engineering", "category_name": "Science & Experimentation", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Which sense would you use to find a flower on a nature walk?", ["Smell or sight", "Taste", "Hearing only"], "Smell or sight"),
                q_short("Name one thing you might see, hear, or smell outside.", "Answers will vary."),
                q_mc("On a nature walk, scientists...", ["Observe things closely", "Ignore everything around them", "Stay inside"], "Observe things closely"),
                q_short("Draw one thing you noticed on a walk outside (real or imagined).", "Answers will vary."),
                q_mc("Which sense helps you feel if a leaf is smooth or rough?", ["Touch", "Taste", "Hearing"], "Touch"),
                q_short("What is your favorite thing to notice outside?", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Predict whether objects will sink or float, then test them!",
            "questions": [
                q_mc("Do you predict a rock will sink or float?", ["Sink", "Float"], "Sink"),
                q_mc("Do you predict a small piece of wood will sink or float?", ["Float", "Sink"], "Float"),
                q_short("Pick an object. Predict if it will sink or float, then explain why you think so.", "Answers will vary."),
                q_mc("A prediction is...", ["A guess based on what you already know", "Always 100% correct", "The same thing as a fact"], "A guess based on what you already know"),
                q_short("Why do scientists make predictions BEFORE testing something?", "It helps them think about what they expect and compare it to what actually happens."),
                q_mc("If your prediction was wrong, that means...", ["You learned something new", "You're bad at science", "The experiment was pointless"], "You learned something new"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Keep a simple observation journal — draw and describe what you notice.",
            "questions": [
                q_short("Pick something to observe (a plant, a bug, the sky). Draw it and describe 2 things you notice.", "Answers will vary."),
                q_mc("An observation journal helps scientists...", ["Remember and record what they noticed", "Forget their findings quickly", "Skip taking notes"], "Remember and record what they noticed"),
                q_short("Why is it useful to WRITE DOWN observations instead of just remembering them?", "Written notes don't get forgotten and can be checked or compared later."),
                q_mc("A good observation describes...", ["What you actually see, not just what you think or feel", "Only your opinion", "Something you imagined"], "What you actually see, not just what you think or feel"),
                q_short("Observe the same thing again tomorrow (or later today). Did anything change?", "Answers will vary."),
                q_mc("Careful observation is an important first step in...", ["The scientific process", "Cooking dinner", "Playing a video game"], "The scientific process"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Try a predict-observe-record mini experiment.",
            "questions": [
                q_short("PREDICT: what do you think will happen if you put an ice cube in warm water?", "Answers will vary (e.g., it will melt)."),
                q_short("OBSERVE: describe what actually happens when you (or someone) tries it.", "Answers will vary."),
                q_short("RECORD: write down your results clearly.", "Answers will vary."),
                q_mc("The 'predict-observe-record' method helps scientists...", ["Compare what they expected to what really happened", "Skip actually doing the experiment", "Guess randomly with no structure"], "Compare what they expected to what really happened"),
                q_mc("If your observation matched your prediction, what does that suggest?", ["Your prediction was based on good reasoning", "The experiment failed", "Nothing useful"], "Your prediction was based on good reasoning"),
                q_short("Why is the RECORD step important, even after you've already observed the result?", "Recording keeps an accurate record you can refer back to or share with others."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice writing a hypothesis and running a simple experiment.",
            "questions": [
                q_short("Write a hypothesis (a testable guess) about what happens to a plant with no sunlight.", "Answers will vary (e.g., 'I think the plant will not grow well without sunlight.')."),
                q_mc("A hypothesis should be...", ["Testable — you can actually check if it's true", "Impossible to test", "Just a random statement"], "Testable — you can actually check if it's true"),
                q_short("Design a simple experiment to test your hypothesis above.", "Answers will vary."),
                q_mc("A hypothesis is different from a fact because...", ["It hasn't been tested/proven yet", "It's always true", "It's the same as an opinion with no reasoning"], "It hasn't been tested/proven yet"),
                q_short("What result would PROVE your hypothesis wrong?", "Answers will vary (e.g., if the plant grew fine without sunlight)."),
                q_mc("Why do scientists write a hypothesis BEFORE running an experiment?", ["It gives the experiment a clear question to test", "Hypotheses are written after, not before", "It's not actually necessary"], "It gives the experiment a clear question to test"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Learn about variables: what changes, and what stays the same.",
            "questions": [
                q_short("In a plant-growth experiment testing sunlight, what is the ONE thing you'd change (the variable)?", "The amount of sunlight the plant gets."),
                q_short("What things should stay the SAME between your test plants (besides sunlight)?", "Water amount, soil type, pot size, temperature, etc."),
                q_mc("Changing only ONE variable at a time in an experiment helps you...", ["Know that variable caused the result, not something else", "Get faster but less accurate results", "Confuse your results"], "Know that variable caused the result, not something else"),
                q_mc("If you changed BOTH sunlight AND water amount at once, what problem would that cause?", ["You couldn't tell which change caused the result", "Nothing, that's actually the best method", "The experiment would be more accurate"], "You couldn't tell which change caused the result"),
                q_short("Why is keeping everything else the SAME (except your variable) important for a fair test?", "It isolates the effect of the one thing you're testing, making the results reliable."),
                q_short("Design your own simple experiment, clearly stating your variable and what stays constant.", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a controlled experiment.",
            "questions": [
                q_short("Pick a question to test (e.g., 'Does music affect how fast people solve a puzzle?'). Write it as a hypothesis.", "Answers will vary."),
                q_short("Describe your CONTROL group (the group with no change) and your TEST group (the group with the variable changed).", "Answers will vary."),
                q_mc("A control group in an experiment is used to...", ["Compare against, to see if the variable really made a difference", "Make the experiment take longer", "Nothing important"], "Compare against, to see if the variable really made a difference"),
                q_short("Why might an experiment WITHOUT a control group give misleading results?", "Without something to compare to, you can't tell if the variable actually caused the change."),
                q_mc("A well-controlled experiment usually has...", ["One clear variable, a control group, and consistent conditions", "Many different variables changing all at once", "No plan at all"], "One clear variable, a control group, and consistent conditions"),
                q_short("Design a simple controlled experiment for a question of your own choosing.", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Plan a science-fair-style project: question, hypothesis, method, data.",
            "questions": [
                q_short("Write a clear scientific QUESTION for your project.", "Answers will vary."),
                q_short("Write your HYPOTHESIS (testable prediction) for that question.", "Answers will vary."),
                q_short("Describe your METHOD — how would you actually test your hypothesis, step by step?", "Answers will vary."),
                q_short("What DATA would you collect, and how would you record it?", "Answers will vary."),
                q_mc("A strong science fair project plan includes...", ["A clear question, hypothesis, method, and data plan — all connected", "Just an interesting topic with no real plan", "Only a hypothesis, nothing else"], "A clear question, hypothesis, method, and data plan — all connected"),
                q_mc("Why is planning your DATA COLLECTION method in advance important?", ["It ensures you gather the right information to actually answer your question", "Data doesn't matter for science projects", "You should decide what data to collect after the experiment is done"], "It ensures you gather the right information to actually answer your question"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# STEM 3/4: Georgia Tech — Engineering & Robotics
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "gt_robotics", "subject_area": "stem_engineering", "category_name": "Engineering & Robotics", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("Build the tallest tower you can with blocks. How many blocks did you use?", "Answers will vary."),
                q_mc("A wide base helps a block tower...", ["Stay standing without falling", "Fall over faster", "Disappear"], "Stay standing without falling"),
                q_short("What happened when your tower got too tall? Why do you think that happened?", "Answers will vary (e.g., it got wobbly and fell)."),
                q_mc("Building with blocks is a way to practice...", ["Engineering and building skills", "Cooking", "Reading"], "Engineering and building skills"),
                q_short("Draw your tallest tower.", "Answers will vary."),
                q_mc("If your tower falls, what should you do?", ["Try building it again, maybe differently", "Give up on building forever", "Never try again"], "Try building it again, maybe differently"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Measure objects using non-standard units (like paperclips or blocks).",
            "questions": [
                q_short("How many paperclips long is your pencil (a guess is fine if you don't have one)?", "Answers will vary."),
                q_mc("A non-standard unit for measuring is something like...", ["A paperclip or a block", "A ruler with inches", "A stopwatch"], "A paperclip or a block"),
                q_short("Measure your desk or table using a non-standard unit. How many did it take?", "Answers will vary."),
                q_mc("Why might two people get different answers measuring the same object with paperclips?", ["Their paperclips (or how they measured) might be slightly different sizes", "Measuring is always exactly the same for everyone", "Objects change size when measured"], "Their paperclips (or how they measured) might be slightly different sizes"),
                q_short("Why might scientists prefer standard units (like inches) over non-standard ones (like paperclips)?", "Standard units are the same everywhere, so everyone gets the same answer."),
                q_mc("Measuring helps engineers...", ["Know exact sizes so things fit together correctly", "Guess randomly", "Skip planning"], "Know exact sizes so things fit together correctly"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Sequence a simple robot's path using arrows on a grid.",
            "questions": [
                q_seq("Sequence the robot's path from start to the goal: forward, forward, turn right, forward.", ["Forward", "Forward", "Turn right", "Forward"], "Forward, forward, turn right, forward."),
                q_mc("A robot follows instructions...", ["In the exact order it's given them", "In a random order", "Only sometimes"], "In the exact order it's given them"),
                q_short("Write your own path for a robot to go around an obstacle in the middle of a grid.", "Answers will vary."),
                q_mc("If a robot's path sequence has an error, what happens?", ["The robot goes to the wrong place", "The robot fixes itself automatically", "Nothing changes"], "The robot goes to the wrong place"),
                q_short("Why is planning a robot's path on paper first (before running it) a good idea?", "It lets you catch mistakes before the robot actually moves."),
                q_mc("A grid with arrows is a way to practice...", ["Robot path planning and sequencing", "Painting", "Singing"], "Robot path planning and sequencing"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice measuring in inches and centimeters.",
            "questions": [
                q_fill("A pencil is about 7 inches long. About how many centimeters is that (roughly, 1 inch ≈ 2.5 cm)?", "About 17-18 cm"),
                q_mc("A ruler is used to measure...", ["Length", "Weight", "Temperature"], "Length"),
                q_short("Measure 3 objects around you in inches or centimeters, and record their lengths.", "Answers will vary."),
                q_mc("Which unit would you use to measure the length of a classroom — inches or feet?", ["Feet", "Inches", "Neither works"], "Feet"),
                q_short("Why is it important to line up a ruler's zero mark exactly with the start of what you're measuring?", "Otherwise the measurement will be inaccurate."),
                q_mc("Engineers rely on accurate measurement because...", ["Parts need to fit together precisely", "Measurement doesn't actually matter", "Guessing is just as good"], "Parts need to fit together precisely"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Build a vehicle challenge and measure your results.",
            "questions": [
                q_short("Design a simple vehicle (real or on paper) using materials like straws, wheels, or cardboard.", "Answers will vary."),
                q_short("Measure how far your vehicle travels after one push. Record the distance.", "Answers will vary."),
                q_mc("If your vehicle doesn't travel far, what could you try changing?", ["The wheels, weight, or shape", "Nothing, it can't be improved", "The color only"], "The wheels, weight, or shape"),
                q_short("Why is measuring your vehicle's distance important, not just watching it move?", "Measuring gives you an exact number to compare between different designs."),
                q_mc("Comparing measurements between different vehicle designs helps you...", ["Figure out which design works best", "Nothing useful", "Guess randomly which is best"], "Figure out which design works best"),
                q_short("What would you change about your vehicle design to make it travel farther next time?", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Explore robotics logic: loops and conditionals (unplugged).",
            "questions": [
                q_short("Write a LOOP instruction for a robot: 'REPEAT 3 TIMES: move forward.' What would the robot do?", "It would move forward 3 times in a row."),
                q_mc("A loop in programming means...", ["Repeating a set of instructions multiple times", "Doing something only once", "Stopping the program"], "Repeating a set of instructions multiple times"),
                q_short("Write your own conditional rule: 'IF the robot detects an obstacle, THEN ___.'", "Answers will vary (e.g., 'THEN it stops or turns.')."),
                q_mc("Why is a loop more efficient than writing the same instruction 10 separate times?", ["It's shorter and easier to change if you need a different number of repeats", "Loops and repeated instructions do completely different things", "Loops are always slower"], "It's shorter and easier to change if you need a different number of repeats"),
                q_short("Combine a loop AND a conditional: write instructions for a robot to repeat moving forward UNTIL it hits a wall.", "Answers will vary (e.g., 'REPEAT: move forward. IF wall detected, THEN stop.')."),
                q_mc("Loops and conditionals together let a program...", ["React to its environment while repeating useful actions", "Do nothing at all", "Only work if a human controls every single step"], "React to its environment while repeating useful actions"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Take on a structural engineering challenge: test weight and strength.",
            "questions": [
                q_short("Design a structure (like a paper tower or bridge) meant to hold as much weight as possible.", "Answers will vary."),
                q_short("Test your structure by adding weight gradually. How much did it hold before failing?", "Answers will vary."),
                q_mc("Triangular shapes are often used in engineering because they...", ["Resist bending and distribute weight well", "Are the easiest shape to draw", "Look nicer than other shapes"], "Resist bending and distribute weight well"),
                q_short("What part of your structure failed first under weight? Why do you think that happened?", "Answers will vary."),
                q_mc("Testing a structure's strength helps engineers...", ["Know its real-world limits before it's actually used", "Nothing useful", "Guess randomly about safety"], "Know its real-world limits before it's actually used"),
                q_short("Redesign your structure to be stronger, based on what you learned from testing.", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Complete a robotics/engineering capstone: design, build, test, iterate.",
            "questions": [
                q_short("Choose a robotics or engineering challenge. Describe your initial DESIGN.", "Answers will vary."),
                q_short("Describe how you (or would) BUILD your design.", "Answers will vary."),
                q_short("Describe your TEST results — what worked, what didn't?", "Answers will vary."),
                q_short("Describe how you ITERATED (improved) your design based on the test.", "Answers will vary."),
                q_mc("'Iterate' means...", ["Making repeated, improved versions based on feedback", "Doing something only once, perfectly", "Giving up after the first try"], "Making repeated, improved versions based on feedback"),
                q_mc("Why do real engineers go through MANY iterations instead of stopping at the first working version?", ["Each iteration usually improves performance, safety, or efficiency", "The first version is always the best possible one", "Iterating wastes time with no benefit"], "Each iteration usually improves performance, safety, or efficiency"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# STEM 4/4: UIUC — Computer Science, Math & Data
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "uiuc_data", "subject_area": "stem_engineering", "category_name": "Computer Science, Math & Data", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_fill("What comes next in the pattern? Red, Blue, Red, Blue, ___", "Red"),
                q_fill("What comes next in the pattern? Circle, Circle, Square, Circle, Circle, Square, ___", "Circle"),
                q_mc("A pattern is something that...", ["Repeats in a predictable way", "Is completely random", "Never repeats"], "Repeats in a predictable way"),
                q_short("Make your own AB pattern using shapes or colors.", "Answers will vary."),
                q_short("Make your own ABC pattern using shapes or colors.", "Answers will vary."),
                q_mc("Finding patterns is an important skill for...", ["Computer scientists and mathematicians", "No one in particular", "Only artists"], "Computer scientists and mathematicians"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice number bonds and simple patterns.",
            "questions": [
                q_fill("Number bond: 3 + ___ = 5", "2"),
                q_fill("Number bond: 4 + ___ = 10", "6"),
                q_fill("What comes next? 2, 4, 6, 8, ___", "10"),
                q_fill("What comes next? 5, 10, 15, 20, ___", "25"),
                q_short("Explain how number bonds show two numbers that make a target number.", "A number bond shows a pair of numbers that add up to a specific total."),
                q_mc("Number patterns like counting by 2s or 5s help you...", ["Predict what number comes next", "Nothing useful", "Only work for counting to 10"], "Predict what number comes next"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Build addition/subtraction fact fluency.",
            "questions": [
                q_fill("7 + 6 = ___", "13"),
                q_fill("9 + 8 = ___", "17"),
                q_fill("15 - 7 = ___", "8"),
                q_fill("12 - 5 = ___", "7"),
                q_fill("6 + 6 = ___", "12"),
                q_short("Why is knowing your addition/subtraction facts quickly (fluently) useful for harder math later?", "It frees up your brain to focus on new, harder problems instead of basic facts."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice multiplication facts and spot number patterns.",
            "questions": [
                q_fill("6 x 7 = ___", "42"),
                q_fill("8 x 9 = ___", "72"),
                q_fill("What comes next? 3, 6, 9, 12, ___", "15"),
                q_fill("What comes next? 5, 10, 20, 40, ___", "80"),
                q_short("Describe the pattern rule for: 5, 10, 20, 40, 80 (hint: what happens each time?)", "Each number doubles the one before it."),
                q_mc("Finding the RULE behind a number pattern helps you...", ["Predict future numbers in the sequence without counting each one", "Nothing useful", "Only works for that one specific pattern"], "Predict future numbers in the sequence without counting each one"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice basic algorithms and flowcharts with numbers.",
            "questions": [
                q_short("Write a step-by-step algorithm (in order) for finding the largest number in a list of 3 numbers.", "Answers will vary (e.g., compare the first two, keep the bigger, compare with the third)."),
                q_mc("An algorithm for solving a math problem is...", ["A clear set of steps that always leads to the answer", "A random guess", "Only useful for computers, not people"], "A clear set of steps that always leads to the answer"),
                q_short("Draw a simple flowchart for deciding if a number is even or odd.", "Answers will vary — should include a decision point (divisible by 2?) leading to yes/no outcomes."),
                q_mc("Why might writing an algorithm help you solve similar problems FASTER in the future?", ["You can reuse the same clear steps instead of figuring it out from scratch each time", "Algorithms only work once and can't be reused", "Algorithms make problems harder to solve"], "You can reuse the same clear steps instead of figuring it out from scratch each time"),
                q_short("Test your even/odd algorithm on the number 17. Does it correctly identify it as odd?", "Yes — 17 divided by 2 has a remainder, so it's odd."),
                q_short("Test your even/odd algorithm on the number 24. What does it say?", "Even — 24 divided by 2 has no remainder."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Collect data and represent it in a pictograph.",
            "questions": [
                q_short("Collect a small set of data (e.g., ask 5 friends their favorite color). List your results.", "Answers will vary."),
                q_short("Design a pictograph to show your data, with a key explaining what each picture represents.", "Answers will vary."),
                q_mc("A pictograph uses...", ["Small pictures or symbols to represent data amounts", "Only numbers, no pictures", "Random doodles with no meaning"], "Small pictures or symbols to represent data amounts"),
                q_mc("Why does a pictograph need a KEY (explaining what one picture equals)?", ["Without it, no one would know how many each symbol represents", "Keys are optional and never necessary", "Pictographs don't actually need a key"], "Without it, no one would know how many each symbol represents"),
                q_short("Looking at your pictograph, what's one thing you can tell at a glance from the data?", "Answers will vary (e.g., which category had the most/fewest)."),
                q_mc("Collecting and graphing real data helps you...", ["See patterns and answer questions using evidence", "Nothing useful", "Only matters for scientists, not everyday questions"], "See patterns and answer questions using evidence"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice fractions and decimals, and extend a pattern.",
            "questions": [
                q_fill("What is 1/2 written as a decimal?", "0.5"),
                q_fill("What is 3/4 written as a decimal?", "0.75"),
                q_fill("What comes next in the pattern? 0.1, 0.2, 0.3, 0.4, ___", "0.5"),
                q_fill("What comes next in the pattern? 1/8, 2/8, 3/8, 4/8, ___", "5/8"),
                q_short("Explain how a fraction and a decimal can represent the same amount.", "Both show a part of a whole — a fraction like 1/2 equals the decimal 0.5."),
                q_mc("Why is it useful to be able to convert between fractions and decimals?", ["Some situations are easier with one form than the other", "They're never actually related", "Only fractions are ever useful"], "Some situations are easier with one form than the other"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Get an intro to algebra and complete a simple data analysis project.",
            "questions": [
                q_fill("Solve for x: x + 5 = 12", "x = 7"),
                q_fill("Solve for x: 3x = 21", "x = 7"),
                q_mc("In algebra, a variable (like x) represents...", ["An unknown number you're solving for", "A fixed number that never changes", "A word, not a number"], "An unknown number you're solving for"),
                q_short("Collect a small data set (real or made up) and describe one pattern or trend you notice in it.", "Answers will vary."),
                q_short("Why might a data analysis project use a chart or graph instead of just listing numbers?", "Visuals can make patterns and trends easier to spot at a glance than a plain list of numbers."),
                q_mc("Algebra and data analysis are connected because...", ["Both involve finding and using patterns/relationships between numbers", "They have nothing in common", "Algebra is only about words, not numbers"], "Both involve finding and using patterns/relationships between numbers"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# ARTS 1/3: Visual Art Appreciation & Drawing
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "visual_art", "subject_area": "arts", "category_name": "Visual Art Appreciation & Drawing", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Which color do you get by mixing red and yellow?", ["Orange", "Green", "Purple"], "Orange"),
                q_mc("Which color do you get by mixing blue and yellow?", ["Green", "Orange", "Red"], "Green"),
                q_short("Draw anything you'd like! What did you draw?", "Answers will vary."),
                q_mc("What color is a typical banana?", ["Yellow", "Blue", "Purple"], "Yellow"),
                q_short("Name your favorite color and one thing that color.", "Answers will vary."),
                q_mc("Which color do you get by mixing red and blue?", ["Purple", "Green", "Orange"], "Purple"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Create art using different shapes.",
            "questions": [
                q_short("Draw a picture using only circles, squares, and triangles.", "Answers will vary."),
                q_mc("Which shape has 4 equal sides?", ["Square", "Triangle", "Circle"], "Square"),
                q_short("What did you make using shapes (an animal, a house, something else)?", "Answers will vary."),
                q_mc("Artists sometimes use simple shapes to...", ["Build up bigger, more complex pictures", "Avoid drawing anything", "Erase their work"], "Build up bigger, more complex pictures"),
                q_short("Which shape did you use the MOST in your drawing?", "Answers will vary."),
                q_mc("Combining shapes to make a picture is an example of...", ["Visual art", "Music", "Math only"], "Visual art"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Look closely at a famous painting and describe what you see.",
            "questions": [
                q_short("Pick a famous painting (or any artwork). What is the FIRST thing you notice?", "Answers will vary."),
                q_short("What colors are used the most in the painting?", "Answers will vary."),
                q_short("What do you think is happening in the painting?", "Answers will vary."),
                q_mc("Looking closely at art before judging it is called...", ["Observation", "Guessing", "Ignoring it"], "Observation"),
                q_short("How does the painting make you feel? Why do you think that is?", "Answers will vary."),
                q_mc("Why might two people notice different things in the same painting?", ["People pay attention to different details based on their own interests", "Everyone always notices the exact same things", "Paintings only have one correct interpretation"], "People pay attention to different details based on their own interests"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn the basics of color theory: warm vs. cool colors.",
            "questions": [
                q_match("Sort each color as WARM or COOL.", ["Red", "Blue", "Orange", "Green"], ["Warm", "Cool", "Warm", "Cool"], [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("Warm colors often remind people of...", ["Sun and fire", "Ocean and ice", "Nothing in particular"], "Sun and fire"),
                q_mc("Cool colors often remind people of...", ["Water and sky", "Fire and heat", "Nothing in particular"], "Water and sky"),
                q_short("Draw a small picture using ONLY warm colors.", "Answers will vary — should use reds/oranges/yellows."),
                q_short("Draw a small picture using ONLY cool colors.", "Answers will vary — should use blues/greens/purples."),
                q_mc("Artists use warm and cool colors to...", ["Create different moods or feelings in their art", "Make art harder to see", "Follow strict rules with no creative purpose"], "Create different moods or feelings in their art"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare the styles of two different artists.",
            "questions": [
                q_short("Pick two artists (or artworks) to compare. Describe one difference in their styles.", "Answers will vary."),
                q_short("Describe one similarity between the two artists' work.", "Answers will vary."),
                q_mc("An artist's 'style' refers to...", ["The distinctive way they create their art", "Only the colors they use", "Something that never changes between artists"], "The distinctive way they create their art"),
                q_short("Which of the two artists' styles do you like more, and why?", "Answers will vary."),
                q_mc("Comparing artists' styles helps you...", ["Notice and appreciate different artistic choices", "Decide which artist is 'better' with no other reasoning", "Nothing useful"], "Notice and appreciate different artistic choices"),
                q_short("If you could combine elements of both artists' styles, what would your art look like?", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice the basics of perspective drawing.",
            "questions": [
                q_mc("In perspective drawing, objects that are FARTHER away should look...", ["Smaller", "Bigger", "The same size"], "Smaller"),
                q_short("Draw a simple road that appears to go far into the distance using perspective.", "Answers will vary — road should narrow toward a vanishing point."),
                q_mc("A 'vanishing point' in perspective drawing is...", ["The point where parallel lines appear to meet in the distance", "The exact center of the page", "A place you erase"], "The point where parallel lines appear to meet in the distance"),
                q_short("Why does perspective drawing make a flat picture look more 3D and realistic?", "It mimics how our eyes actually see depth and distance in real life."),
                q_mc("Without perspective, drawings often look...", ["Flat, with everything the same size", "More realistic", "Impossible to draw"], "Flat, with everything the same size"),
                q_short("Practice drawing 3 objects at different distances using the perspective rule (farther = smaller).", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Research and write a mini art-history report.",
            "questions": [
                q_short("Choose an artist or art movement to research. Name your topic.", "Answers will vary."),
                q_short("List 3 facts you learned about your chosen artist or movement.", "Answers will vary."),
                q_short("What makes your chosen artist or movement's work distinctive?", "Answers will vary."),
                q_mc("A good art-history report should include...", ["Real facts and context about the art", "Only your personal opinion, no facts", "Random unrelated information"], "Real facts and context about the art"),
                q_short("How did the time period or events happening then influence this artist's work?", "Answers will vary."),
                q_mc("Understanding art history helps you...", ["Appreciate why art looks the way it does in different eras", "Nothing useful", "Only matters for professional artists"], "Appreciate why art looks the way it does in different eras"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Create an original artwork and write an artist's statement about it.",
            "questions": [
                q_short("Describe (or create) an original artwork. What is it, and what materials did you use?", "Answers will vary."),
                q_short("What inspired your artwork?", "Answers will vary."),
                q_short("Write an artist's statement explaining the meaning or message behind your work.", "Answers will vary."),
                q_mc("An artist's statement is meant to...", ["Explain the artist's intention and meaning behind the work", "Replace the need to actually look at the art", "List only the materials used, nothing else"], "Explain the artist's intention and meaning behind the work"),
                q_short("What choice (color, subject, style) in your artwork are you most proud of, and why?", "Answers will vary."),
                q_mc("Why might an artist's statement help a viewer understand the art better?", ["It gives context and intention that might not be obvious just from looking", "Statements never add anything useful", "Viewers should never read about the art, only look at it"], "It gives context and intention that might not be obvious just from looking"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# ARTS 2/3: Music & Performing Arts
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "music", "subject_area": "arts", "category_name": "Music & Performing Arts", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_seq("Clap this rhythm pattern in order: clap, clap, pause, clap.", ["Clap", "Clap", "Pause", "Clap"], "Clap, clap, pause, clap."),
                q_mc("A rhythm is a pattern of...", ["Sounds and pauses", "Colors", "Smells"], "Sounds and pauses"),
                q_short("Make up your own simple clapping pattern with 4 claps or pauses.", "Answers will vary."),
                q_mc("Clapping along to music helps you practice...", ["Rhythm", "Drawing", "Reading"], "Rhythm"),
                q_short("Name a song you like to clap or dance along to.", "Answers will vary."),
                q_mc("A pattern that repeats in music, like clap-clap-pause, is an example of...", ["Rhythm", "A color", "A shape"], "Rhythm"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Match instrument sounds to their names.",
            "questions": [
                q_match("Match the instrument to how it makes sound.", ["Drum", "Guitar", "Flute", "Piano"], ["Hit/struck", "Strummed strings", "Blown air", "Keys pressed"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("Which instrument do you blow into to make sound?", ["Flute", "Drum", "Guitar"], "Flute"),
                q_mc("Which instrument has strings you pluck or strum?", ["Guitar", "Drum", "Flute"], "Guitar"),
                q_short("Name your favorite instrument and describe its sound.", "Answers will vary."),
                q_mc("Which instrument do you hit or tap to make sound?", ["Drum", "Flute", "Guitar"], "Drum"),
                q_short("If you could learn to play one instrument, which would you choose and why?", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Try simple rhythm notation — reading beats on a page.",
            "questions": [
                q_mc("In simple rhythm notation, a long line often means...", ["A longer sound or beat", "A shorter sound", "No sound at all"], "A longer sound or beat"),
                q_short("Clap out a rhythm pattern shown as: long, short, short, long.", "Long clap, two quick claps, long clap."),
                q_mc("Rhythm notation helps musicians...", ["Play the same rhythm consistently, even without hearing it first", "Never play the same thing twice", "Ignore timing completely"], "Play the same rhythm consistently, even without hearing it first"),
                q_short("Create your own simple rhythm pattern using long and short marks.", "Answers will vary."),
                q_mc("Why might written rhythm notation be useful for a group of musicians playing together?", ["Everyone can follow the same timing without guessing", "Notation makes music harder to play together", "Groups never need to match their timing"], "Everyone can follow the same timing without guessing"),
                q_short("Practice clapping your rhythm pattern from above 3 times in a row, keeping it steady.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Write song lyrics by filling in the blanks.",
            "questions": [
                q_short("Complete this lyric: 'The sun is shining, the sky is ___, today is a ___ day.'", "Answers will vary (e.g., 'blue', 'wonderful')."),
                q_mc("Song lyrics often...", ["Rhyme or follow a pattern", "Have no structure at all", "Are always about the weather"], "Rhyme or follow a pattern"),
                q_short("Write 2 lines of your own song lyrics about something you like.", "Answers will vary."),
                q_mc("Rhyming words in lyrics can help make a song...", ["Catchy and easier to remember", "Harder to sing", "Less musical"], "Catchy and easier to remember"),
                q_short("What word rhymes with 'day'? Use it to finish a lyric line.", "Answers will vary (e.g., 'play', 'stay')."),
                q_mc("Writing your own lyrics is a way to practice...", ["Creative self-expression through music", "Only math skills", "Nothing related to music"], "Creative self-expression through music"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare two different musical genres.",
            "questions": [
                q_short("Pick two music genres (like pop and classical). Describe one difference between them.", "Answers will vary."),
                q_short("Describe one similarity between the two genres.", "Answers will vary."),
                q_mc("A 'genre' of music refers to...", ["A category or style of music", "A single specific song", "An instrument"], "A category or style of music"),
                q_short("Which of the two genres do you personally prefer, and why?", "Answers will vary."),
                q_mc("Comparing genres helps you...", ["Notice how different musical styles create different moods", "Nothing useful", "Prove one genre is objectively the best"], "Notice how different musical styles create different moods"),
                q_short("Name a song from each of your two genres that you know.", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice reading basic music notation.",
            "questions": [
                q_mc("On a musical staff, notes that are higher on the staff represent...", ["Higher-pitched sounds", "Louder sounds", "Longer sounds"], "Higher-pitched sounds"),
                q_short("What does a 'quarter note' generally represent in rhythm compared to a 'half note'?", "A quarter note is typically half the length (duration) of a half note."),
                q_mc("Reading music notation lets a musician...", ["Play a piece correctly without having heard it first", "Ignore the actual notes", "Play any random notes they want"], "Play a piece correctly without having heard it first"),
                q_short("Why might learning to read music notation take practice, similar to learning to read words?", "Both involve learning a symbol system that represents sound/meaning, which takes repetition to master."),
                q_mc("A time signature at the start of music notation tells you...", ["How the beats are grouped in each measure", "What instrument to play", "The song's title"], "How the beats are grouped in each measure"),
                q_short("Try clapping a simple rhythm shown in basic notation (quarter notes = 1 clap each).", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a short song or poem with rhythm.",
            "questions": [
                q_short("Write a short song or poem (at least 4 lines) with a clear rhythm or rhyme scheme.", "Answers will vary."),
                q_mc("A rhyme scheme is...", ["The pattern of rhyming words at the end of each line", "The tempo of a song", "The instrument used"], "The pattern of rhyming words at the end of each line"),
                q_short("Read your song/poem aloud. Does the rhythm feel consistent? Where does it feel off?", "Answers will vary."),
                q_mc("Why might writers revise a song or poem's wording to better fit the rhythm?", ["Word choice affects how smoothly the piece flows when spoken or sung", "Rhythm doesn't matter once the words are written", "Revision is never necessary for song lyrics"], "Word choice affects how smoothly the piece flows when spoken or sung"),
                q_short("What is your song/poem about, and why did you choose that topic?", "Answers will vary."),
                q_mc("Combining rhythm and meaning in a song/poem is a skill that involves...", ["Both technical craft (rhythm/rhyme) and creative expression", "Only following strict rules with no creativity", "Pure randomness with no structure"], "Both technical craft (rhythm/rhyme) and creative expression"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Reflect on and critique a musical or theatrical performance.",
            "questions": [
                q_short("Describe a performance you've seen or heard (live, recorded, or a class performance). What stood out to you?", "Answers will vary."),
                q_short("What did the performer(s) do well?", "Answers will vary."),
                q_short("What is one constructive suggestion you'd offer to help the performance improve?", "Answers will vary — should be specific and constructive, not just negative."),
                q_mc("A constructive critique should...", ["Balance what worked well with specific, helpful suggestions", "Only point out flaws with no positives", "Avoid saying anything specific at all"], "Balance what worked well with specific, helpful suggestions"),
                q_mc("Reflecting on a performance (your own or someone else's) helps you...", ["Grow and improve as a performer or audience member", "Nothing useful", "Only matters for professional critics"], "Grow and improve as a performer or audience member"),
                q_short("If this were YOUR performance, what's one thing you'd want honest feedback about?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# ARTS 3/3: Creative Writing & Storytelling
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "creative_writing", "subject_area": "arts", "category_name": "Creative Writing & Storytelling", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("Draw a picture of a story in your imagination, then tell a grown-up about it.", "Answers will vary."),
                q_mc("A story usually has a...", ["Beginning, middle, and end", "Only a middle", "No characters at all"], "Beginning, middle, and end"),
                q_short("Who is the main character in your story?", "Answers will vary."),
                q_mc("The main character in a story is...", ["The person or animal the story is mostly about", "Always a real person", "Never important"], "The person or animal the story is mostly about"),
                q_short("What happens at the END of your story?", "Answers will vary."),
                q_mc("Telling a story out loud is called...", ["Storytelling", "Singing", "Drawing"], "Storytelling"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Use a picture prompt to start your own story.",
            "questions": [
                q_short("Look at (or imagine) a picture of a magical forest. Start a story about what happens there.", "Answers will vary."),
                q_mc("A 'story starter' is meant to...", ["Give you an idea to begin writing your own story", "Finish the whole story for you", "Have nothing to do with your story"], "Give you an idea to begin writing your own story"),
                q_short("Who would be the main character in your forest story?", "Answers will vary."),
                q_mc("Using a picture prompt can help writers who...", ["Aren't sure what to write about yet", "Already have a finished story", "Never want to write"], "Aren't sure what to write about yet"),
                q_short("What problem or adventure could happen in your forest story?", "Answers will vary."),
                q_short("Finish your story with a sentence about how it ends.", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Write a complete 3-sentence story.",
            "questions": [
                q_short("Write sentence 1 of your story: introduce a character and setting.", "Answers will vary."),
                q_short("Write sentence 2 of your story: describe a problem or event.", "Answers will vary."),
                q_short("Write sentence 3 of your story: describe how it ends.", "Answers will vary."),
                q_mc("Even a very short story should have...", ["A beginning, middle, and end", "Only one part", "No characters"], "A beginning, middle, and end"),
                q_short("Read your 3-sentence story out loud. Does it make sense from start to finish?", "Answers will vary."),
                q_mc("Writing a short story helps you practice...", ["Telling a complete story with limited words", "Nothing useful", "Only spelling, not storytelling"], "Telling a complete story with limited words"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Fill out a story map: character, setting, problem, solution.",
            "questions": [
                q_short("CHARACTER: who is your story about?", "Answers will vary."),
                q_short("SETTING: where and when does your story take place?", "Answers will vary."),
                q_short("PROBLEM: what problem does your character face?", "Answers will vary."),
                q_short("SOLUTION: how does your character solve the problem?", "Answers will vary."),
                q_mc("A story map helps writers...", ["Plan the key parts of a story before writing it in full", "Skip planning entirely", "Draw a literal map, not plan a story"], "Plan the key parts of a story before writing it in full"),
                q_mc("Why is the PROBLEM an important part of most stories?", ["It creates the challenge the character must work through, driving the plot", "Stories don't actually need a problem", "The problem should always be solved instantly"], "It creates the challenge the character must work through, driving the plot"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a short story that includes dialogue.",
            "questions": [
                q_short("Write a short story (5+ sentences) that includes at least one line of dialogue (something a character says).", "Answers will vary — should include quoted dialogue."),
                q_mc("Dialogue in a story is...", ["Words that characters actually say, usually in quotation marks", "The narrator's description of events", "Never used in stories"], "Words that characters actually say, usually in quotation marks"),
                q_short("Why might dialogue make a story feel more alive than only description?", "It lets readers hear characters' own voices and personalities directly."),
                q_mc("Which is an example of dialogue?", ["'I'm scared,' said Maya.", "Maya was scared.", "The forest was dark and quiet."], "'I'm scared,' said Maya."),
                q_short("Add one more line of dialogue to your story, from a different character.", "Answers will vary."),
                q_mc("Dialogue is usually punctuated using...", ["Quotation marks", "Parentheses", "No punctuation at all"], "Quotation marks"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a creative story in a specific genre — mystery or fantasy.",
            "questions": [
                q_short("Choose mystery OR fantasy. Write the opening paragraph of a story in that genre.", "Answers will vary."),
                q_mc("A mystery story usually centers on...", ["A puzzle or question the character tries to solve", "A magical creature", "No plot at all"], "A puzzle or question the character tries to solve"),
                q_mc("A fantasy story usually includes...", ["Magic or fantastical elements not found in the real world", "Only real, everyday events", "No characters"], "Magic or fantastical elements not found in the real world"),
                q_short("What genre-specific element (a clue, a magic power, etc.) did you include in your story?", "Answers will vary."),
                q_mc("Writing within a specific genre helps a writer...", ["Focus their story around that genre's expectations and conventions", "Have zero rules or structure", "Avoid needing a plot"], "Focus their story around that genre's expectations and conventions"),
                q_short("Continue your story with one more paragraph.", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a multi-paragraph narrative.",
            "questions": [
                q_short("Write a narrative (story) with at least 3 paragraphs: a beginning, middle, and end paragraph.", "Answers will vary."),
                q_mc("Each paragraph in a multi-paragraph story usually...", ["Focuses on a different part or moment of the story", "Repeats the exact same sentence", "Has no connection to the others"], "Focuses on a different part or moment of the story"),
                q_short("How does your middle paragraph build tension or develop the story from your beginning?", "Answers will vary."),
                q_mc("A strong ending paragraph should...", ["Resolve the story's main problem or conflict", "Introduce a brand new unrelated problem", "Be left completely unfinished"], "Resolve the story's main problem or conflict"),
                q_short("Read your narrative and check: does each paragraph clearly connect to the next?", "Answers will vary."),
                q_short("What transition words or phrases did you use to move between paragraphs?", "Answers will vary (e.g., 'Later that day,' 'Then,' 'Finally')."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write, then edit and revise, an original short story.",
            "questions": [
                q_short("Write an original short story (several paragraphs) with a clear beginning, middle, and end.", "Answers will vary."),
                q_short("Reread your story. What's one part that could be clearer or more interesting?", "Answers will vary."),
                q_mc("Editing and revising a story means...", ["Reviewing and improving your writing after the first draft", "Writing the exact same draft again unchanged", "Something only professional authors do"], "Reviewing and improving your writing after the first draft"),
                q_short("Revise the part you identified above — rewrite it to be clearer or more engaging.", "Answers will vary."),
                q_mc("Why is revising almost always necessary, even for skilled writers?", ["First drafts rarely capture the best version of an idea right away", "First drafts are always perfect and need no changes", "Revising makes writing worse"], "First drafts rarely capture the best version of an idea right away"),
                q_short("What is the biggest improvement between your first draft and your revised version?", "Answers will vary."),
            ],
        },
    },
})

def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def rebalance_target_counts():
    for cat in CATEGORIES:
        for grade_id, gc in cat["grades"].items():
            n = len(gc["questions"])
            min_target = 6 if cat.get("is_core") else 4
            gc["target_count"] = max(min_target, round(n * 0.65))


def emit():
    rebalance_target_counts()
    out = []
    out.append("-- 66_stem_arts_content.sql")
    out.append("-- Whole-Child Curriculum expansion, batch 3: content for the 'stem_engineering'")
    out.append("-- (MIT STEM/Coding, Caltech Science & Experimentation, Georgia Tech Engineering &")
    out.append("-- Robotics, UIUC CS/Math/Data) and 'arts' (Visual Art, Music & Performing Arts,")
    out.append("-- Creative Writing & Storytelling) subject_area groups, hand-crafted across all")
    out.append("-- 8 grades from the curriculum matrix the site owner provided. Requires")
    out.append("-- 63_whole_child_rotation.sql to already be applied. See gen_66_stem_arts_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'stem_engineering')")
    out.append("BEGIN")

    for cat in CATEGORIES:
        for grade_id in GRADE_IDS:
            gc = cat["grades"].get(grade_id)
            if not gc:
                continue
            var = f"@cat_{cat['key']}_{grade_id}"
            is_core_sql = "1" if cat.get("is_core") else "0"
            intro = esc(gc.get("intro_text"))
            out.append(f"    DECLARE {var} INT;")
            out.append(
                f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
                f"        VALUES ({grade_id}, '{cat['subject_area']}', {esc(cat['category_name'])}, '{gc['layout_type']}', {gc['target_count']}, {intro}, {is_core_sql});"
            )
            out.append(f"    SET {var} = SCOPE_IDENTITY();")
            for qi, q in enumerate(gc["questions"], start=1):
                cols = ["category_id", "question_type", "prompt", "choices_json", "answer_text", "sort_order"]
                choices_sql = "NULL" if q["choices"] is None else esc(json.dumps(q["choices"], ensure_ascii=False))
                vals = [var, esc(q["qtype"]), esc(q["prompt"]), choices_sql, esc(q["answer"]), str(qi)]
                if q["diagram_type"]:
                    cols += ["diagram_type", "diagram_data"]
                    vals += [esc(q["diagram_type"]), esc(json.dumps(q["diagram_data"], ensure_ascii=False))]
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
    for cat in CATEGORIES:
        grades = sorted(cat["grades"].keys())
        if grades != list(range(8)):
            print(f"INCOMPLETE: {cat['key']} has grades {grades}, missing {sorted(set(range(8)) - set(grades))}")
            ok = False
    return ok


if __name__ == "__main__":
    import sys
    if not check_completeness():
        sys.exit(1)
    total_q = sum(len(gc["questions"]) for cat in CATEGORIES for gc in cat["grades"].values())
    total_cat = sum(len(cat["grades"]) for cat in CATEGORIES)
    print(f"Categories: {total_cat}, Questions: {total_q}", file=sys.stderr)
    with open(r"D:\Project\www\littlescholarhub\lsh.database\66_stem_arts_content.sql", "w", encoding="utf-8") as f:
        f.write(emit())
    print("Wrote 66_stem_arts_content.sql", file=sys.stderr)
