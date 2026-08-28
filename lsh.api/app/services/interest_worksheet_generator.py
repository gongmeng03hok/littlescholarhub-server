"""
services/interest_worksheet_generator.py
Generates real, grade-appropriate worksheets themed around the site's 9
"interest" tags (animals, dinosaurs, space, ocean, fantasy, vehicles,
holidays, sports, nature), across the 9 core topics (phonics, reading,
math, art, story, workbooks, logic, feelings, manners). Used by a one-off
seeding script — output PDFs are stored as BLOBs in dbo.UploadedFiles, not
regenerated per request.

All facts/passages are original, general-knowledge content written for
this project — not sourced from any particular book, article, or site.
"""

import random

THEMES = {
    "animals": {
        "label": "Animals", "emoji": "animal friends",
        "facts": [
            "A giraffe's tongue can be up to 20 inches long.",
            "Elephants are the only mammals that can't jump.",
            "A group of lions is called a pride.",
            "Owls can turn their heads almost all the way around.",
        ],
        "words": ["cat", "dog", "lion", "fish", "bird", "frog", "bear", "duck"],
        "passage": {
            0: "Animals live all around us. Cats and dogs live in our homes. Lions and bears live in the wild.",
            1: "Animals come in every shape and size. Some animals, like elephants, are huge. Some animals, like ants, are tiny. Every animal has a special way to find food and stay safe.",
            2: "Animals have adapted in amazing ways to survive in their habitats. A polar bear's thick fur keeps it warm in freezing ice. A camel can go many days without water in the hot desert. These adaptations help each animal thrive where it lives.",
        },
    },
    "dinosaurs": {
        "label": "Dinosaurs", "emoji": "dinosaur discoveries",
        "facts": [
            "Dinosaurs lived on Earth for about 165 million years.",
            "The Tyrannosaurus rex had teeth as long as bananas.",
            "Some dinosaurs, like Triceratops, were plant-eaters.",
            "Scientists learn about dinosaurs by studying fossils.",
        ],
        "words": ["dino", "bone", "fossil", "roar", "claw", "tail", "egg", "huge"],
        "passage": {
            0: "Dinosaurs lived a long, long time ago. Some dinosaurs were as big as a house. Some dinosaurs were as small as a chicken.",
            1: "Dinosaurs ruled the Earth millions of years ago. Some, like the T-Rex, ate meat. Others, like the Triceratops, ate plants. Today we learn about them from fossils dug out of the ground.",
            2: "Paleontologists are scientists who study dinosaur fossils to learn how these animals lived. By examining bones, teeth, and footprints, they can figure out what a dinosaur ate, how fast it moved, and even what color some feathers might have been.",
        },
    },
    "space": {
        "label": "Space", "emoji": "space exploration",
        "facts": [
            "The Sun is a star, and it is much bigger than Earth.",
            "A day on Venus is longer than a year on Venus.",
            "Astronauts float in space because there is very little gravity.",
            "Saturn's rings are made of ice and rock.",
        ],
        "words": ["star", "moon", "rocket", "planet", "orbit", "comet", "space", "sun"],
        "passage": {
            0: "Space is up in the sky. The Moon glows at night. The Sun is bright in the day.",
            1: "Our solar system has eight planets that orbit the Sun. Earth is the only planet we know of with life. Astronauts travel to space in rockets to explore and learn.",
            2: "Astronomers use powerful telescopes to study stars, planets, and galaxies far beyond our solar system. Light from the most distant stars takes millions of years to reach Earth, so looking into space is like looking back in time.",
        },
    },
    "ocean": {
        "label": "Ocean", "emoji": "ocean life",
        "facts": [
            "The ocean covers more than 70% of Earth's surface.",
            "A blue whale is the largest animal to have ever lived.",
            "Octopuses have three hearts and blue blood.",
            "Coral reefs are home to thousands of species of fish.",
        ],
        "words": ["fish", "wave", "shell", "crab", "whale", "coral", "swim", "deep"],
        "passage": {
            0: "The ocean is full of water. Fish swim in the ocean. Crabs walk on the sand.",
            1: "The ocean is home to millions of animals, from tiny shrimp to giant whales. Coral reefs are colorful underwater cities full of fish. Scientists have explored only a small part of the deep ocean.",
            2: "The ocean regulates Earth's climate by absorbing heat and carbon dioxide. Deep-sea creatures have adapted to survive crushing pressure and total darkness, some even creating their own light through a process called bioluminescence.",
        },
    },
    "fantasy": {
        "label": "Fantasy", "emoji": "fantasy tales",
        "facts": [
            "Dragons appear in stories from cultures all over the world.",
            "A unicorn is often shown as a horse with a single horn.",
            "Fairy tales often teach a lesson through magic and adventure.",
            "Castles in fantasy stories often have towers and moats.",
        ],
        "words": ["dragon", "magic", "castle", "quest", "wizard", "spell", "brave", "sword"],
        "passage": {
            0: "In fantasy stories, dragons can fly. Wizards can do magic. Brave heroes go on quests.",
            1: "Fantasy stories are full of magic, brave heroes, and imaginary creatures. A hero might solve a riddle, cross a magic forest, or help a dragon in trouble.",
            2: "Fantasy as a genre lets writers imagine worlds with their own rules — magic systems, mythical creatures, and epic quests. Many fantasy stories still explore very real themes, like courage, friendship, and doing what's right.",
        },
    },
    "vehicles": {
        "label": "Vehicles", "emoji": "vehicles on the go",
        "facts": [
            "The first cars were invented in the late 1800s.",
            "A jumbo jet has over six million parts.",
            "Trains can be powered by diesel, electricity, or steam.",
            "The fastest trains in the world can travel over 300 miles per hour.",
        ],
        "words": ["car", "train", "plane", "boat", "truck", "bike", "wheel", "engine"],
        "passage": {
            0: "Cars drive on roads. Trains ride on tracks. Planes fly in the sky.",
            1: "Vehicles help people travel and move things from place to place. Cars and trucks drive on roads. Trains run on tracks. Planes fly through the sky, and boats sail on water.",
            2: "Engineers design vehicles to be faster, safer, and more efficient. Electric cars run on batteries instead of gasoline, producing fewer emissions. High-speed trains use powerful engines and streamlined designs to reduce air resistance.",
        },
    },
    "holidays": {
        "label": "Holidays", "emoji": "holiday celebrations",
        "facts": [
            "Different cultures celebrate holidays in their own special ways.",
            "Many holidays celebrate the changing of the seasons.",
            "Some holidays are celebrated with parades, music, and food.",
            "A birthday is a personal holiday that happens every year.",
        ],
        "words": ["party", "gift", "cake", "family", "friend", "song", "candle", "wish"],
        "passage": {
            0: "Holidays are fun days. We see family. We eat yummy food.",
            1: "Holidays are special days when families and friends come together. People celebrate with food, music, and sometimes gifts. Every culture has its own favorite holidays.",
            2: "Holidays often mark important events in a culture's history, religion, or the changing seasons. Traditions passed down through generations — special foods, songs, or decorations — help people feel connected to their family and community.",
        },
    },
    "sports": {
        "label": "Sports", "emoji": "sports and games",
        "facts": [
            "Soccer is the most popular sport in the world.",
            "The Olympic Games began in ancient Greece.",
            "Basketball was invented by James Naismith in 1891.",
            "Swimming is a great full-body exercise.",
        ],
        "words": ["ball", "team", "goal", "run", "jump", "win", "coach", "score"],
        "passage": {
            0: "Sports are fun to play. We kick a ball. We run and jump.",
            1: "Sports help us stay healthy and have fun with friends. Team sports like soccer and basketball teach us to work together. Practice helps us get better at any sport.",
            2: "Playing sports builds physical strength as well as teamwork, discipline, and resilience. Athletes train for years to master their skills, and even the best athletes learn important lessons from losing as well as winning.",
        },
    },
    "nature": {
        "label": "Nature", "emoji": "the natural world",
        "facts": [
            "Trees release oxygen that we need to breathe.",
            "A rainbow appears when sunlight passes through raindrops.",
            "Bees help plants grow by carrying pollen from flower to flower.",
            "The four seasons are spring, summer, fall, and winter.",
        ],
        "words": ["tree", "flower", "leaf", "rain", "sun", "wind", "seed", "grow"],
        "passage": {
            0: "Nature is all around us. Trees grow tall. Flowers are pretty colors.",
            1: "Nature includes plants, animals, weather, and the land around us. Trees give us oxygen and shade. Rain helps plants grow. Every season brings new changes outside.",
            2: "Ecosystems are communities of living things that depend on each other and their environment. A single change, like fewer bees pollinating flowers, can affect an entire food chain, showing how connected nature really is.",
        },
    },
}

TOPICS = ["phonics", "reading", "math", "art", "story", "workbooks", "logic", "feelings", "manners"]

GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]


def _grade_band(grade_id: int) -> int:
    if grade_id <= 1: return 0    # TK-K
    if grade_id <= 3: return 1    # 1st-3rd
    return 2                      # 4th-6th


def _grade_label(grade_id: int) -> str:
    return GRADE_LABELS[grade_id] if 0 <= grade_id < len(GRADE_LABELS) else str(grade_id)


# ── Topic generators ──────────────────────────────────────────────────────

def gen_phonics(grade_id: int, interest_slug: str) -> bytes:
    from services.worksheet_pdf_generator import _build
    theme = THEMES[interest_slug]
    words = theme["words"]
    probs = [f"{w}  ->  first letter: ___   circle the vowels" for w in words]
    return _build(f"{theme['label']} Word Sounds", f"Practice beginning sounds and vowels with {theme['emoji']}.",
                  probs, f"Phonics . {theme['label']} . Grade {_grade_label(grade_id)}", cols=1, col_w=6.5)


def gen_reading(grade_id: int, interest_slug: str) -> bytes:
    from services.worksheet_pdf_generator import _text_page
    theme = THEMES[interest_slug]
    band = _grade_band(grade_id)
    passage = theme["passage"][band]
    blocks = [
        (f"About {theme['label']}", passage),
        ("Question 1", "What is this passage mostly about?"),
        ("Question 2", "Name one fact you learned from this passage."),
        ("Question 3", "Write one sentence of your own about " + theme["label"].lower() + "."),
    ]
    return _text_page(f"Reading: {theme['label']}", "Read the passage, then answer the questions.",
                       blocks, f"Reading Comprehension . {theme['label']} . Grade {_grade_label(grade_id)}")


def gen_math(grade_id: int, interest_slug: str) -> bytes:
    """Uses the live SQL-generated question pool (dbo.usp_GenerateMathQuestion
    plus the existing Python generators) so this worksheet's math content is
    the same real, dynamically-computed logic used elsewhere in the app."""
    from services.question_generator import QuestionGenerator
    from services.worksheet_pdf_generator import _build
    theme = THEMES[interest_slug]
    questions = QuestionGenerator.generate("math", grade_id, 10)
    probs = [q.get("question") or q.get("question_text") or "" for q in questions]
    return _build(f"{theme['label']} Math Challenge", f"Solve each problem — {theme['emoji']} edition!",
                  probs, f"Math . {theme['label']} . Grade {_grade_label(grade_id)}", cols=1, col_w=6.5)


def gen_art(grade_id: int, interest_slug: str) -> bytes:
    from services.worksheet_pdf_generator import _draw_your_own
    theme = THEMES[interest_slug]
    return _draw_your_own(f"Draw Your Own {theme['label']}", theme["facts"],
                           f"Draw & Color . {theme['label']} . Grade {_grade_label(grade_id)}")


def gen_story(grade_id: int, interest_slug: str) -> bytes:
    from services.worksheet_pdf_generator import _text_page
    theme = THEMES[interest_slug]
    blocks = [
        ("Story Starter", f"Write your own short story about {theme['label'].lower()}! "
                           f"Try to use these words: {', '.join(theme['words'][:5])}."),
        ("Beginning", "Who is your main character, and where are they?"),
        ("Middle", "What problem or adventure happens?"),
        ("End", "How does your story end?"),
    ]
    return _text_page(f"Story Activity: {theme['label']}", "Plan and write your own story.",
                       blocks, f"Story Activities . {theme['label']} . Grade {_grade_label(grade_id)}")


def gen_workbook(grade_id: int, interest_slug: str) -> bytes:
    from services.worksheet_pdf_generator import _tracing_items
    theme = THEMES[interest_slug]
    return _tracing_items(f"{theme['label']} Word Tracing", f"Trace each {theme['label']} word, then write it once on your own.",
                           theme["words"], f"Workbook Practice . {theme['label']} . Grade {_grade_label(grade_id)}")


def gen_logic(grade_id: int, interest_slug: str) -> bytes:
    from services.worksheet_pdf_generator import _build
    theme = THEMES[interest_slug]
    words = theme["words"]
    band = _grade_band(grade_id)
    if band == 0:
        probs = [
            f"Which one is different?  {words[0]}, {words[1]}, {words[2]}, banana",
            f"What comes next?  {words[0]}, {words[1]}, {words[0]}, {words[1]}, ___?",
            f"Circle the two words that rhyme with each other: {words[0]}, chair, {words[3]}, hair",
            f"How many {theme['label']} words are in this row? Count and write the number: {', '.join(words[:4])}",
        ]
    elif band == 1:
        probs = [
            f"What comes next in the pattern?  {words[0]}, {words[1]}, {words[2]}, {words[0]}, {words[1]}, ___, ___?",
            f"Which one doesn't belong, and why?  {words[0]}, {words[1]}, {words[2]}, {words[3]}, bicycle",
            f"Analogy: {words[0]} is to {theme['label']} as apple is to fruit. Explain the connection in your own words.",
            f"Sort these {theme['label']} words into two groups of your own choosing, and explain your rule: {', '.join(words)}",
        ]
    else:
        probs = [
            f"Pattern puzzle: {words[0]}, {words[2]}, {words[4]}, {words[1]}, {words[3]} — describe the rule that connects every other word.",
            f"Using only yes/no questions, how would you figure out which {theme['label']} word a partner is thinking of? Write 3 good questions.",
            f"Fact or opinion: \"{theme['facts'][0]}\" — which is it, and how do you know?",
            f"Create your own logic riddle using {theme['label'].lower()} words, then write the answer separately so a friend can solve it.",
        ]
    return _build(f"{theme['label']} Logic Puzzles", f"Sharpen your thinking with {theme['emoji']}!",
                  probs, f"Logic & Critical Thinking . {theme['label']} . Grade {_grade_label(grade_id)}", cols=1, col_w=6.5)


def gen_feelings(grade_id: int, interest_slug: str) -> bytes:
    from services.worksheet_pdf_generator import _text_page
    theme = THEMES[interest_slug]
    band = _grade_band(grade_id)
    if band == 0:
        blocks = [
            ("How Would You Feel?", f"Imagine you made a new friend who loves {theme['label']}! Draw your face: happy, surprised, or curious?"),
            ("Talk About It", "Tell a grown-up one thing that made you feel happy today."),
            ("Calm Down Breath", "Take 3 big, slow breaths. Draw a star each time you finish one."),
        ]
    elif band == 1:
        blocks = [
            ("Scenario", f"You worked hard on something about {theme['label'].lower()}, but a friend said it wasn't very good. How would you feel? What would you do?"),
            ("Name the Feeling", "Circle all the feelings you might have: proud, sad, angry, embarrassed, curious, disappointed."),
            ("What Helps?", "Write one thing that helps you feel better when you're upset."),
        ]
    else:
        blocks = [
            ("Scenario", f"Your team is working on a {theme['label'].lower()} project, and one teammate isn't doing their part. How do you feel, and how do you handle it fairly?"),
            ("Perspective-Taking", "Write the situation from your teammate's point of view. What might they be feeling?"),
            ("Reflection", "Describe a time you felt strongly about something and how you managed that feeling."),
        ]
    return _text_page(f"Feelings & Emotions: {theme['label']}", "Explore feelings through this week's theme.",
                       blocks, f"Feelings & Emotions . {theme['label']} . Grade {_grade_label(grade_id)}")


def gen_manners(grade_id: int, interest_slug: str) -> bytes:
    from services.worksheet_pdf_generator import _checklist
    theme = THEMES[interest_slug]
    band = _grade_band(grade_id)
    if band == 0:
        items = [
            f"Say 'please' when you ask for a toy or book from the {theme['label']} theme.",
            "Say 'thank you' when someone helps you.",
            "Share with a friend during playtime.",
            "Use kind words, even when you feel upset.",
            "Wait for your turn to talk.",
        ]
    elif band == 1:
        items = [
            f"Invite a friend to join your {theme['label'].lower()} game or activity.",
            "Say sorry and mean it when you make a mistake.",
            "Listen without interrupting when someone else is talking.",
            "Hold the door or help carry something for someone.",
            "Give a genuine compliment to a classmate this week.",
        ]
    else:
        items = [
            f"Include someone new in your {theme['label'].lower()} group project.",
            "Give constructive, kind feedback instead of criticism.",
            "Stand up respectfully for a classmate being treated unfairly.",
            "Write a thank-you note to someone who helped you.",
            "Practice active listening — repeat back what a friend said before replying.",
        ]
    return _checklist(f"Character & Manners: {theme['label']}", "Try each kindness challenge this week and check it off!",
                       items, f"Character & Manners . {theme['label']} . Grade {_grade_label(grade_id)}")


GENERATORS = {
    "phonics": gen_phonics, "reading": gen_reading, "math": gen_math,
    "art": gen_art, "story": gen_story, "workbooks": gen_workbook,
    "logic": gen_logic, "feelings": gen_feelings, "manners": gen_manners,
}


def generate(topic: str, grade_id: int, interest_slug: str) -> bytes:
    return GENERATORS[topic](grade_id, interest_slug)
