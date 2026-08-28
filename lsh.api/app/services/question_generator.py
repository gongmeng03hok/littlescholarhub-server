"""
services/question_generator.py
Algorithmic question generation for TK–6 across all subjects.
No AI required — pure deterministic + randomised math/logic/phonics.
"""

import random
from math import gcd


class QuestionGenerator:
    """
    Generate curriculum-aligned questions algorithmically.
    All public methods return:
      {"question": str, "answer": str, "options": list[str] | None, "hint": str | None}
    """

    # ── Reference data ────────────────────────────────────────────────────────

    SIGHT_WORDS = {
        1: ["the","a","is","in","it","of","to","and","he","she","we","at","be","do","go"],
        2: ["was","for","that","his","her","they","with","this","have","from","one","had","by","not"],
        3: ["said","each","which","do","how","their","if","will","up","other","about","out","many","then"],
        4: ["time","could","when","come","made","may","part","over","new","sound","take","only","little"],
    }

    PHONICS_PATTERNS = {
        1: [
            ("c_t",   "a", "cat", "short vowel -a-"),
            ("d_g",   "o", "dog", "short vowel -o-"),
            ("h_t",   "i", "hit", "short vowel -i-"),
            ("p_n",   "a", "pan", "short vowel -a-"),
            ("b_g",   "u", "bug", "short vowel -u-"),
            ("r_d",   "e", "red", "short vowel -e-"),
        ],
        2: [
            ("tr__n", "ai", "train", "vowel digraph -ai-"),
            ("pl__",  "ay", "play",  "vowel digraph -ay-"),
            ("gr__n", "ee", "green", "vowel digraph -ee-"),
            ("b__t",  "oa", "boat",  "vowel digraph -oa-"),
            ("r__n",  "ai", "rain",  "vowel digraph -ai-"),
        ],
        3: [
            ("kn_ght", "i",  "knight", "silent k, igh"),
            ("wr_te",  "i",  "write",  "silent w"),
            ("ph_ne",  "o",  "phone",  "ph = /f/"),
            ("s_ght",  "i",  "sight",  "igh pattern"),
        ],
    }

    TANG_POEMS = [
        ("静夜思", "李白",   "床前明月光，疑是地上霜。举头望明月，低头思故乡。",
         "In front of my bed the moonlight is bright; I suspect it is frost on the ground."),
        ("春晓",  "孟浩然", "春眠不觉晓，处处闻啼鸟。夜来风雨声，花落知多少。",
         "Spring sleep, not aware of dawn; everywhere I hear birds singing."),
        ("登鹳雀楼","王之涣","白日依山尽，黄河入海流。欲穷千里目，更上一层楼。",
         "The white sun sets behind the mountains; the Yellow River flows into the sea."),
    ]

    GITA_TEACHINGS = [
        ("courage",     "A friend dares you to cheat on a test. True courage means:",
         "Saying no even when it is hard"),
        ("steadiness",  "You lose a game but want to quit forever. Steadiness means:",
         "Trying again with a calm mind"),
        ("kindness",    "You see someone eating alone at lunch. Kindness means:",
         "Inviting them to sit with you"),
        ("duty",        "Your chore is to water the plants, but you want to play. Duty means:",
         "Finishing your responsibility first"),
        ("honesty",     "You broke something by accident. Honesty means:",
         "Telling the truth right away"),
        ("compassion",  "A classmate is upset about a bad grade. Compassion means:",
         "Listening and offering to help"),
    ]

    SPANISH_VOCABULARY = [
        ("rojo",   "red"),   ("azul",  "blue"),  ("verde", "green"),
        ("perro",  "dog"),   ("gato",  "cat"),   ("casa",  "house"),
        ("libro",  "book"),  ("agua",  "water"), ("sol",   "sun"),
        ("luna",   "moon"),  ("niño",  "boy"),   ("niña",  "girl"),
    ]

    # 4th element: does the scenario still read correctly once a setting like
    # "At the aquarium," is prefixed? "You read your first chapter book" does not.
    FEELINGS = [
        ("happy", "You just got a surprise gift. You feel:", "happy", True),
        ("sad",   "Your best friend moved away. You feel:", "sad", False),
        ("angry", "Someone takes your toy without asking. You feel:", "angry", True),
        ("proud", "You read your first chapter book. You feel:", "proud", False),
        ("scared","You hear a loud thunder. You feel:", "scared", True),
        ("calm",  "You take 5 deep breaths. You feel:", "calm", True),
    ]

    NAMES   = ["Aanya","Kai","Noah","Mei","Sofia","Arjun","Leo","Zara","Mia","Ravi"]
    ITEMS   = ["apples","stickers","books","stamps","crayons","cookies","marbles","stars"]

    # ── Interest themes ──────────────────────────────────────────────────────
    #
    # The catalog is built as theme × subject × grade: "Ocean Math - Grade 4th",
    # "Dinosaurs Logic - Grade TK", "Space Manners - Grade TK" — 121 rows whose
    # titles promise a themed lesson. dbo.Worksheets.interest_tag already stores
    # the theme; it simply was never passed to the generator, so every one of
    # them served the same generic pool and the title read as a lie.
    #
    # Keys match interest_tag exactly. An unknown or empty theme falls through
    # to the generic content, so nothing here can break an untagged worksheet.

    THEME_ITEMS = {
        "animals":   ["puppies", "kittens", "rabbits", "ducklings", "paw prints"],
        "dinosaurs": ["dinosaur eggs", "fossils", "footprints", "bones", "spikes"],
        "space":     ["stars", "moon rocks", "rockets", "comets", "craters"],
        "ocean":     ["seashells", "starfish", "crabs", "pebbles", "bubbles"],
        "fantasy":   ["gold coins", "magic beans", "dragon scales", "lanterns", "keys"],
        "vehicles":  ["toy cars", "wheels", "trucks", "tickets", "traffic cones"],
        "holidays":  ["presents", "candles", "cards", "ribbons", "paper lanterns"],
        "sports":    ["soccer balls", "medals", "jerseys", "water bottles", "whistles"],
        "nature":    ["leaves", "acorns", "pinecones", "flowers", "smooth stones"],
    }

    # Odd-one-out sets: three that belong to the theme, one that plainly doesn't.
    THEME_ODD = {
        "animals":   (["dog", "cat", "rabbit", "bicycle"], "bicycle", "not an animal"),
        "dinosaurs": (["T-Rex", "Stegosaurus", "Triceratops", "hamster"], "hamster", "not a dinosaur"),
        "space":     (["Mars", "Jupiter", "Saturn", "London"], "London", "not a planet"),
        "ocean":     (["whale", "shark", "octopus", "camel"], "camel", "does not live in the sea"),
        "fantasy":   (["dragon", "wizard", "unicorn", "dentist"], "dentist", "not from a fairy tale"),
        "vehicles":  (["bus", "train", "airplane", "sandwich"], "sandwich", "not something you ride"),
        "holidays":  (["birthday", "Diwali", "New Year", "Tuesday"], "Tuesday", "not a holiday"),
        "sports":    (["soccer", "swimming", "basketball", "sleeping"], "sleeping", "not a sport"),
        "nature":    (["river", "forest", "mountain", "keyboard"], "keyboard", "not found outdoors"),
    }

    # Short passages for reading comprehension, one per theme.
    THEME_PASSAGE = {
        "animals":   ("A puppy wags its tail when it is happy. It also wags when it wants to play.",
                      "What does a wagging tail mean?", "The puppy is happy or wants to play"),
        "dinosaurs": ("Some dinosaurs ate only plants. Their flat teeth were good for grinding leaves.",
                      "Why did plant-eating dinosaurs have flat teeth?", "To grind up leaves"),
        "space":     ("The Moon has no air and no wind. Footprints left there stay for a very long time.",
                      "Why do footprints on the Moon last so long?", "There is no wind to blow them away"),
        "ocean":     ("A hermit crab does not grow its own shell. It finds an empty one and moves in.",
                      "Where does a hermit crab get its shell?", "It finds an empty shell and moves in"),
        "fantasy":   ("In the old story, the dragon guarded the bridge. It let travellers pass if they asked kindly.",
                      "How could travellers cross the bridge?", "By asking the dragon kindly"),
        "vehicles":  ("A fire engine carries its own water. That way it can start putting out a fire right away.",
                      "Why does a fire engine carry water?", "So it can start fighting the fire right away"),
        "holidays":  ("On Lunar New Year, families sweep the house before midnight to welcome good luck.",
                      "Why do families sweep before midnight?", "To welcome good luck"),
        "sports":    ("A relay team runs one at a time. Each runner passes a baton to the next.",
                      "What does a runner pass to the next runner?", "A baton"),
        "nature":    ("Trees drop their leaves in autumn. The fallen leaves rot and feed the soil.",
                      "What do fallen leaves do for the soil?", "They rot and feed it"),
    }

    # Where a manners / feelings moment happens, so the scenario fits the title.
    THEME_PLACE = {
        "animals":   "at the animal shelter",
        "dinosaurs": "at the dinosaur museum",
        "space":     "at the space centre",
        "ocean":     "at the aquarium",
        "fantasy":   "at the story corner",
        "vehicles":  "on the school bus",
        "holidays":  "at the holiday party",
        "sports":    "at soccer practice",
        "nature":    "on the nature walk",
    }

    # Phonics targets that belong to each theme, kept to the same
    # missing-letter shape as PHONICS_PATTERNS.
    THEME_PHONICS = {
        "animals":   [("c_t", "a", "cat", "short vowel -a-"), ("d_g", "o", "dog", "short vowel -o-")],
        "dinosaurs": [("b_ne", "o", "bone", "long vowel -o-"), ("eg_", "g", "egg", "double -g-")],
        "space":     [("st_r", "a", "star", "r-controlled -ar-"), ("m_on", "o", "moon", "vowel team -oo-")],
        "ocean":     [("f_sh", "i", "fish", "short vowel -i-"), ("cr_b", "a", "crab", "short vowel -a-")],
        "fantasy":   [("k_ng", "i", "king", "short vowel -i-"), ("w_nd", "a", "wand", "short vowel -a-")],
        "vehicles":  [("b_s", "u", "bus", "short vowel -u-"), ("v_n", "a", "van", "short vowel -a-")],
        "holidays":  [("g_ft", "i", "gift", "short vowel -i-"), ("c_ke", "a", "cake", "long vowel -a-")],
        "sports":    [("b_ll", "a", "ball", "short vowel -a-"), ("r_n", "u", "run", "short vowel -u-")],
        "nature":    [("l_af", "e", "leaf", "vowel team -ea-"), ("tr_e", "e", "tree", "vowel team -ee-")],
    }

    @classmethod
    def _theme(cls, theme: str) -> str:
        """Normalise an interest_tag; '' means no theme was supplied."""
        t = (theme or "").strip().lower()
        return t if t in cls.THEME_ITEMS else ""

    # ── Math ─────────────────────────────────────────────────────────────────

    @classmethod
    def math_addition(cls, grade: int, theme: str = "") -> dict:
        lims = {0:(1,5),1:(1,10),2:(1,20),3:(10,100),4:(100,999),5:(100,9999),6:(1000,99999)}
        lo, hi = lims.get(grade, (1,10))
        a, b = random.randint(lo, hi), random.randint(lo, hi)
        ans = a + b
        opts = cls._wrong_opts(ans, 3, step=random.choice([1,2,5,10]))
        return {"question": f"What is {a} + {b}?", "answer": str(ans),
                "options": opts, "hint": f"Start with {a} and count up {b} more."}

    @classmethod
    def math_subtraction(cls, grade: int, theme: str = "") -> dict:
        lims = {0:(2,5),1:(2,10),2:(5,20),3:(10,100),4:(50,500),5:(100,1000),6:(500,9999)}
        lo, hi = lims.get(grade, (2,10))
        a = random.randint(lo, hi)
        b = random.randint(1, a)
        ans = a - b
        opts = cls._wrong_opts(ans, 3)
        return {"question": f"What is {a} − {b}?", "answer": str(ans),
                "options": opts, "hint": f"Start at {a} and count back {b}."}

    @classmethod
    def math_multiplication(cls, grade: int, theme: str = "") -> dict:
        tables = {3:(2,5),4:(2,9),5:(2,12),6:(3,12)}
        lo, hi = tables.get(grade, (2,5))
        a, b = random.randint(lo, hi), random.randint(lo, hi)
        ans = a * b
        opts = cls._wrong_opts(ans, 3, step=a)
        return {"question": f"What is {a} × {b}?", "answer": str(ans),
                "options": opts, "hint": f"Think of {b} groups of {a}."}

    @classmethod
    def math_division(cls, grade: int, theme: str = "") -> dict:
        b = random.randint(2, 9 if grade >= 4 else 5)
        ans = random.randint(2, 12)
        a = b * ans
        opts = cls._wrong_opts(ans, 3)
        return {"question": f"What is {a} ÷ {b}?", "answer": str(ans),
                "options": opts, "hint": f"How many groups of {b} fit in {a}?"}

    @classmethod
    def math_fractions(cls, grade: int, theme: str = "") -> dict:
        denoms = {4:[2,3,4], 5:[4,5,8,10], 6:[3,4,6,8,10,12]}
        d = random.choice(denoms.get(grade, [2,4]))
        n1 = random.randint(1, d - 1)
        n2 = random.randint(1, d - 1)
        raw = n1 + n2
        g = gcd(raw, d)
        ans_n, ans_d = raw // g, d // g
        ans = f"{ans_n}/{ans_d}" if ans_d > 1 else str(ans_n)
        # Distractors are the classic fraction mistakes: adding the denominators
        # too, forgetting to simplify, and off-by-one on the numerator.
        wrong = [f"{raw}/{d + d}", f"{raw}/{d}", f"{max(1, raw - 1)}/{d}"]
        opts = list(dict.fromkeys([ans] + wrong))[:4]
        random.shuffle(opts)
        return {"question": f"Add the fractions:  {n1}/{d}  +  {n2}/{d}  = ?",
                "answer": ans, "options": opts,
                "hint": f"Add the numerators ({n1}+{n2}) and keep the denominator ({d}), then simplify."}

    @classmethod
    def math_percentage(cls, grade: int, theme: str = "") -> dict:
        """Grade 5-6 percentages."""
        whole = random.choice([10, 20, 50, 100, 200])
        pct   = random.choice([10, 25, 50, 75])
        ans   = whole * pct // 100
        opts  = cls._wrong_opts(ans, 3, step=5)
        return {"question": f"What is {pct}% of {whole}?", "answer": str(ans),
                "options": opts, "hint": f"Divide {whole} by 100 then multiply by {pct}."}

    @classmethod
    def math_word_problem(cls, grade: int, theme: str = "") -> dict:
        name = random.choice(cls.NAMES)
        th   = cls._theme(theme)
        item = random.choice(cls.THEME_ITEMS[th] if th else cls.ITEMS)
        op   = random.choice(["add","sub"])
        a    = random.randint(5, 30 if grade <= 3 else 100)
        b    = random.randint(1, min(a, 20))
        if op == "add":
            ans = a + b
            q   = f"{name} had {a} {item} and found {b} more. How many {item} does {name} have now?"
        else:
            ans = a - b
            q   = f"{name} had {a} {item} and gave away {b}. How many {item} are left?"
        opts = cls._wrong_opts(ans, 3, step=random.choice([1,2,3]))
        return {"question": q, "answer": str(ans), "options": opts, "hint": None}

    @classmethod
    def math_geometry(cls, grade: int, theme: str = "") -> dict:
        # Ordered by when the curriculum introduces them. Perimeter of a
        # rectangle is 3rd grade (CCSS 3.MD.8); area of a rectangle is 3rd-4th;
        # area of a triangle is 6th (6.G.1). Choosing uniformly meant a 3rd
        # grader was regularly handed the 6th-grade question.
        shapes = [
            ("square",    "perimeter", lambda a, b: 4 * a,        lambda a, b: f"side = {a}"),
            ("rectangle", "perimeter", lambda a, b: 2 * (a + b),  lambda a, b: f"length={a}, width={b}"),
        ]
        if grade >= 3:                      # 3rd grade and up
            shapes.append(
                ("rectangle", "area", lambda a, b: a * b, lambda a, b: f"length={a}, width={b}"))
        if grade >= 5:                      # 5th-6th
            shapes.append(
                ("triangle", "area", lambda a, b: a * b // 2, lambda a, b: f"base={a}, height={b}"))

        shape, measure, fn, params_fn = random.choice(shapes)
        hi = 12 if grade <= 3 else 20       # keep the arithmetic age-appropriate too
        a, b = random.randint(3, hi), random.randint(3, hi)
        if shape == "triangle":             # keep the halving exact
            b = b if (a * b) % 2 == 0 else b + 1
        ans = fn(a, b)
        params = params_fn(a, b)
        opts = cls._wrong_opts(int(ans), 3, step=2)
        return {
            "question": f"Find the {measure} of a {shape} with {params}.",
            "answer": str(int(ans)), "options": opts, "hint": None
        }

    # ── Math — SQL-generated (logic lives in dbo.usp_GenerateMathQuestion) ────
    # These call into SQL Server rather than computing in Python: the random
    # values, the correct answer, and the distractors are all produced by
    # the stored procedure itself.

    @classmethod
    def _sql_generate(cls, grade: int, topic: str) -> dict:
        from utils.db import qry
        try:
            row = qry("EXEC dbo.usp_GenerateMathQuestion @grade=?, @topic=?",
                      (grade, topic), fetch="one")
        except Exception:
            row = None
        if not row:
            return cls.math_addition(grade)  # DB unreachable — fall back rather than error

        opts = list(dict.fromkeys([row["correct_answer"], row["option2"], row["option3"], row["option4"]]))
        random.shuffle(opts)
        return {
            "question": row["question_text"], "answer": row["correct_answer"],
            "options": opts, "hint": row.get("hint"),
        }

    @classmethod
    def math_place_value(cls, grade: int, theme: str = "") -> dict:
        return cls._sql_generate(grade, "place_value")

    @classmethod
    def math_rounding(cls, grade: int, theme: str = "") -> dict:
        return cls._sql_generate(grade, "rounding")

    @classmethod
    def math_compare_numbers(cls, grade: int, theme: str = "") -> dict:
        return cls._sql_generate(grade, "compare_numbers")

    @classmethod
    def math_money_count(cls, grade: int, theme: str = "") -> dict:
        return cls._sql_generate(grade, "money_count")

    @classmethod
    def math_decimal_add(cls, grade: int, theme: str = "") -> dict:
        return cls._sql_generate(grade, "decimal_add")

    @classmethod
    def math_order_of_operations(cls, grade: int, theme: str = "") -> dict:
        return cls._sql_generate(grade, "order_of_operations")

    @classmethod
    def math_factors_primes(cls, grade: int, theme: str = "") -> dict:
        return cls._sql_generate(grade, "factors_primes")

    @classmethod
    def math_elapsed_time(cls, grade: int, theme: str = "") -> dict:
        return cls._sql_generate(grade, "elapsed_time")

    # ── Logic ─────────────────────────────────────────────────────────────────

    @classmethod
    def logic_sequence(cls, grade: int, theme: str = "") -> dict:
        step  = random.randint(2, 6) if grade >= 3 else random.randint(1, 3)
        start = random.randint(1, 10)
        seq   = [start + i * step for i in range(4)]
        ans   = start + 4 * step
        opts  = cls._wrong_opts(ans, 3, step=step)
        return {
            "question": "What comes next?  " + ",  ".join(map(str, seq)) + ",  ___",
            "answer": str(ans), "options": opts,
            "hint": f"Each number increases by {step}."
        }

    @classmethod
    def logic_odd_one_out(cls, grade: int, theme: str = "") -> dict:
        groups = [
            (["dog","cat","fish","car"],        "car",     "not an animal"),
            (["red","blue","happy","green"],     "happy",   "not a color"),
            (["2","4","7","8"],                 "7",       "odd number"),
            (["circle","triangle","square","Monday"], "Monday", "not a shape"),
            (["rose","tulip","daisy","oak"],    "oak",     "not a flower"),
            (["Paris","London","Berlin","Asia"],"Asia",    "not a city"),
        ]
        th = cls._theme(theme)
        items, ans, reason = cls.THEME_ODD[th] if th else random.choice(groups)
        shuffled = items[:]
        random.shuffle(shuffled)
        return {
            "question": "Which one does NOT belong?\n" + "   |   ".join(shuffled),
            "answer": ans, "options": shuffled, "hint": f"Think: which is {reason}?"
        }

    @classmethod
    def logic_pattern_grid(cls, grade: int, theme: str = "") -> dict:
        shapes  = ["▲","●","■","◆","★"]
        pattern = [random.choice(shapes) for _ in range(3)]
        full    = (pattern * 3)[:8]
        ans     = (pattern * 3)[8 % len(pattern)]
        opts    = list({ans} | set(random.sample(shapes, 3)))
        random.shuffle(opts)
        return {
            "question": "What comes next in the pattern?\n" + "  ".join(full) + "  ___",
            "answer": ans, "options": opts, "hint": "Find the repeating group."
        }

    # ── Phonics & Reading ─────────────────────────────────────────────────────

    @classmethod
    def phonics_fill_blank(cls, grade: int, theme: str = "") -> dict:
        th = cls._theme(theme)
        patterns = (cls.THEME_PHONICS[th] if th
                    else cls.PHONICS_PATTERNS.get(max(1, min(grade, 3)), cls.PHONICS_PATTERNS[1]))
        blank, letter, word, rule = random.choice(patterns)
        # Offer the other letters/digraphs from the same band as distractors, so
        # a child taps a choice instead of typing (see MIN_GRADE_ID / EARLY_MAX).
        pool = [p[1] for p in patterns if p[1] != letter]
        if len(pool) < 3:
            pool += [v for v in ("a", "e", "i", "o", "u") if v != letter]
        opts = list(dict.fromkeys([letter] + random.sample(pool, min(3, len(pool)))))
        random.shuffle(opts)
        return {
            "question": f"Fill in the missing letter(s):  '{blank}'",
            "answer": letter, "options": opts,
            "hint": f"Rule: {rule} — the word is '{word}'"
        }

    @classmethod
    def sight_word(cls, grade: int, theme: str = "") -> dict:
        words = cls.SIGHT_WORDS.get(min(grade, 4), cls.SIGHT_WORDS[2])
        target = random.choice(words)
        distractors = random.sample([w for w in words if w != target], min(3, len(words)-1))
        opts = [target] + distractors
        random.shuffle(opts)
        return {
            "question": f"Which word is spelled correctly?  (sight word: '{target}')",
            "answer": target, "options": opts, "hint": None
        }

    @classmethod
    def reading_comprehension(cls, grade: int, theme: str = "") -> dict:
        passages = [
            ("The sun rises in the east every morning. It gives us light and warmth.",
             "What does the sun give us?", "Light and warmth"),
            ("Bears hibernate in winter. They sleep to save energy when food is scarce.",
             "Why do bears hibernate?", "To save energy when food is scarce"),
            ("The water cycle has three steps: evaporation, condensation, and precipitation.",
             "What are the three steps of the water cycle?",
             "Evaporation, condensation, and precipitation"),
        ]
        th = cls._theme(theme)
        if th:
            passages = [cls.THEME_PASSAGE[th]] + passages
            passage, q, ans = passages[0]
        else:
            passage, q, ans = random.choice(passages)
        # The other passages' answers make honest distractors: all plausible
        # sentences, only one supported by the passage on screen.
        opts = [ans] + [a for _, _, a in passages if a != ans][:3]
        random.shuffle(opts)
        return {
            "question": f"Read: \"{passage}\"\n\n{q}",
            "answer": ans, "options": opts, "hint": "The answer is in the passage."
        }

    # ── Cultural: Chinese ─────────────────────────────────────────────────────

    @classmethod
    def pinyin_tone(cls, grade: int, theme: str = "") -> dict:
        syllables = [
            ("mā","1st — flat/high"),("má","2nd — rising"),
            ("mǎ","3rd — dip/low"),  ("mà","4th — falling"),
            ("bō","1st — flat"),     ("bó","2nd — rising"),
        ]
        syl, ans = random.choice(syllables)
        opts = list({ans} | {s[1] for s in random.sample(syllables, 3)})
        random.shuffle(opts)
        return {"question": f"What tone is the syllable '{syl}'?",
                "answer": ans, "options": opts[:4], "hint": "Count: flat, rise, dip, fall."}

    @classmethod
    def hanzi_meaning(cls, grade: int, theme: str = "") -> dict:
        chars = [
            ("一","one"),("二","two"),("三","three"),("四","four"),("五","five"),
            ("山","mountain"),("水","water"),("火","fire"),("木","wood"),("日","sun"),
            ("人","person"),("口","mouth"),("手","hand"),("大","big"),("小","small"),
        ]
        char, ans = random.choice(chars)
        distractors = random.sample([m for _, m in chars if m != ans], 3)
        opts = [ans] + distractors
        random.shuffle(opts)
        return {"question": f"What does the character '{char}' mean?",
                "answer": ans, "options": opts, "hint": "Think about its shape."}

    @classmethod
    def tang_poem_question(cls, grade: int, theme: str = "") -> dict:
        poem = random.choice(cls.TANG_POEMS)
        title, author, text, translation = poem
        q_type = random.choice(["author", "translation"])
        if q_type == "author":
            authors = [p[1] for p in cls.TANG_POEMS]
            opts = list(set(authors + ["杜甫","白居易","王维"]))[:4]
            random.shuffle(opts)
            return {"question": f"Who wrote the poem《{title}》?",
                    "answer": author, "options": opts, "hint": None}
        ans = text.split('，')[1].split('。')[0]
        # Second lines of the other poems — same register and length, so the
        # child picks by meaning rather than by shape.
        opts = [ans] + [p[2].split('，')[1].split('。')[0]
                        for p in cls.TANG_POEMS if p[0] != title]
        opts = list(dict.fromkeys(opts))
        random.shuffle(opts)
        return {"question": f"What is the first line of《{title}》?\n{text.split('，')[0]}，___",
                "answer": ans,
                "options": opts, "hint": f"Translation hint: {translation[:40]}..."}

    # ── Cultural: Indian / Gita ───────────────────────────────────────────────

    @classmethod
    def gita_teaching(cls, grade: int, theme: str = "") -> dict:
        value, scenario, ans = random.choice(cls.GITA_TEACHINGS)
        opts = [ans] + random.sample(
            [t[2] for t in cls.GITA_TEACHINGS if t[2] != ans], min(3, len(cls.GITA_TEACHINGS)-1)
        )
        random.shuffle(opts)
        return {"question": f"Gita Value — {value.upper()}\n\n{scenario}",
                "answer": ans, "options": opts[:4],
                "hint": f"The Gita teaches us about {value}."}

    # ── Cultural: Hispanic ────────────────────────────────────────────────────

    @classmethod
    def spanish_vocab(cls, grade: int, theme: str = "") -> dict:
        word, meaning = random.choice(cls.SPANISH_VOCABULARY)
        distractors = random.sample([m for _, m in cls.SPANISH_VOCABULARY if m != meaning], 3)
        opts = [meaning] + distractors
        random.shuffle(opts)
        return {"question": f"What does the Spanish word '{word}' mean in English?",
                "answer": meaning, "options": opts, "hint": None}

    @classmethod
    def hispanic_festival(cls, grade: int, theme: str = "") -> dict:
        festivals = [
            ("Día de los Muertos", "November 1-2", "honor ancestors"),
            ("Las Posadas",        "December 16-24","re-enact Mary & Joseph's journey"),
            ("Cinco de Mayo",      "May 5",          "celebrate a Mexican battle victory"),
            ("Three Kings Day",    "January 6",      "celebrate the Three Wise Men"),
        ]
        fest, date_, meaning = random.choice(festivals)
        return {"question": f"What is the purpose of '{fest}'?",
                "answer": f"To {meaning}",
                "options": [f"To {f[2]}" for f in festivals],
                "hint": f"'{fest}' is celebrated on {date_}."}

    # ── Social-Emotional ─────────────────────────────────────────────────────

    @classmethod
    def feelings_recognition(cls, grade: int, theme: str = "") -> dict:
        th = cls._theme(theme)
        pool = [f for f in cls.FEELINGS if f[3]] if th else cls.FEELINGS
        _, scenario, ans, _ok = random.choice(pool)
        if th:
            scenario = "%s, %s" % (cls.THEME_PLACE[th].capitalize(),
                                   scenario[0].lower() + scenario[1:])
        opts = [f[2] for f in cls.FEELINGS]
        random.shuffle(opts)
        return {"question": scenario, "answer": ans, "options": opts[:4],
                "hint": "How would YOU feel in this situation?"}

    @classmethod
    def manners_scenario(cls, grade: int, theme: str = "") -> dict:
        # place_ok marks a scenario that still makes sense once a setting is
        # prefixed. "You finish eating dinner … the cook" does not — prefixing
        # every scenario produced "At the aquarium, you finish eating dinner".
        scenarios = [
            ("Someone sneezes near you. What do you say?", "Bless you!", True),
            ("You want to interrupt someone talking. What should you do?",
             "Wait for a pause and say 'Excuse me'", True),
            ("You finish eating dinner. What do you say to the cook?",
             "Thank you for the meal", False),
            ("You bump into someone by accident. What do you say?",
             "I'm sorry / Excuse me", True),
        ]
        th = cls._theme(theme)
        pool = [s for s in scenarios if s[2]] if th else scenarios
        q, ans, _ok = random.choice(pool)
        if th:
            q = "%s, %s" % (cls.THEME_PLACE[th].capitalize(), q[0].lower() + q[1:])
        # Distractors come from the full set, not just the place-safe subset,
        # so a themed question still offers four plausible replies.
        opts = [ans] + [a for _q, a, _p in scenarios if a != ans]
        random.shuffle(opts)
        return {"question": q, "answer": ans, "options": opts[:4],
                "hint": "Think: what would be kind?"}


    # ── Early literacy: beginning sounds, rhyme, syllables, digraphs ─────────
    #: word -> initial phoneme. Kept deliberately small and concrete so a TK
    #: child meets words they can picture.
    BEGINNING_SOUNDS = {
        "s": ["sun", "sock", "sad", "sit", "sand"],
        "m": ["moon", "map", "mud", "man", "milk"],
        "t": ["top", "ten", "tap", "toe", "tub"],
        "b": ["bat", "bed", "bus", "bag", "box"],
        "c": ["cat", "cup", "cow", "car", "can"],
        "d": ["dog", "duck", "doll", "dad", "dig"],
        "f": ["fan", "fish", "fox", "fun", "farm"],
        "p": ["pig", "pen", "pot", "pan", "pup"],
        "r": ["rat", "run", "red", "rug", "rain"],
        "l": ["leg", "log", "lip", "lion", "leaf"],
    }

    RHYME_FAMILIES = [
        ("cat", ["hat", "bat", "mat", "rat"]),
        ("dog", ["log", "fog", "hog", "jog"]),
        ("sun", ["run", "fun", "bun", "pun"]),
        ("bed", ["red", "fed", "led", "shed"]),
        ("pig", ["big", "dig", "wig", "fig"]),
        ("hop", ["top", "mop", "pop", "stop"]),
        ("cake", ["lake", "bake", "rake", "snake"]),
        ("tree", ["bee", "see", "knee", "free"]),
        ("star", ["car", "far", "jar", "bar"]),
        ("light", ["night", "bright", "kite", "right"]),
    ]

    SYLLABLE_WORDS = [
        ("cat", 1), ("dog", 1), ("book", 1), ("hand", 1), ("green", 1),
        ("apple", 2), ("rabbit", 2), ("pencil", 2), ("garden", 2), ("winter", 2),
        ("banana", 3), ("elephant", 3), ("butterfly", 3), ("computer", 3),
        ("dinosaur", 3), ("umbrella", 3),
        ("caterpillar", 4), ("watermelon", 4), ("alligator", 4), ("helicopter", 4),
    ]

    DIGRAPHS = {
        "sh": ["ship", "shop", "shell", "shark", "shoe"],
        "ch": ["chair", "chin", "cheese", "chick", "chop"],
        "th": ["thumb", "think", "thin", "thick", "three"],
        "wh": ["whale", "wheel", "when", "white", "whisker"],
        "ph": ["phone", "photo", "graph", "dolphin", "elephant"],
    }

    @classmethod
    def beginning_sound(cls, grade: int, theme: str = "") -> dict:
        """Which word starts with a given sound. The whole point of the skill is
        hearing the first phoneme, so the sound is named, not spelled out."""
        letter = random.choice(list(cls.BEGINNING_SOUNDS.keys()))
        target = random.choice(cls.BEGINNING_SOUNDS[letter])
        others = [w for k, ws in cls.BEGINNING_SOUNDS.items() if k != letter for w in ws]
        opts = [target] + random.sample(others, 3)
        random.shuffle(opts)
        return {
            "question": f"Which word begins with the /{letter}/ sound?",
            "answer": target, "options": opts,
            "hint": f"Say each word out loud and listen to the very first sound.",
        }

    @classmethod
    def rhyming_words(cls, grade: int, theme: str = "") -> dict:
        base, family = random.choice(cls.RHYME_FAMILIES)
        target = random.choice(family)
        others = [w for b, fam in cls.RHYME_FAMILIES if b != base for w in fam]
        opts = [target] + random.sample(others, 3)
        random.shuffle(opts)
        return {
            "question": f"Which word rhymes with '{base}'?",
            "answer": target, "options": opts,
            "hint": "Rhyming words end with the same sound.",
        }

    @classmethod
    def syllable_count(cls, grade: int, theme: str = "") -> dict:
        # Longer words only once a child is past the earliest grades.
        pool = [w for w in cls.SYLLABLE_WORDS if w[1] <= (2 if grade <= 1 else 4)]
        word, n = random.choice(pool)
        # A one-syllable word has no n-1, so build up from n and only then
        # trim — otherwise the child is shown three choices instead of four.
        cand = [n, n + 1, n + 2, n - 1, n + 3]
        opts = []
        for v in cand:
            if v >= 1 and str(v) not in opts:
                opts.append(str(v))
            if len(opts) == 4:
                break
        random.shuffle(opts)
        return {
            "question": f"How many syllables are in '{word}'?",
            "answer": str(n), "options": opts,
            "hint": "Clap once for each beat you hear.",
        }

    @classmethod
    def digraph_id(cls, grade: int, theme: str = "") -> dict:
        """Two letters, one sound — sh, ch, th, wh, ph."""
        dg = random.choice(list(cls.DIGRAPHS.keys()))
        word = random.choice(cls.DIGRAPHS[dg])
        opts = [dg] + random.sample([d for d in cls.DIGRAPHS if d != dg], 3)
        random.shuffle(opts)
        return {
            "question": f"Which two letters make the sound you hear in '{word}'?",
            "answer": dg, "options": opts,
            "hint": "Two letters together can make one brand-new sound.",
        }

    @classmethod
    def skip_counting(cls, grade: int, theme: str = "") -> dict:
        step = random.choice([2, 5, 10] if grade <= 2 else [2, 3, 4, 5, 10, 25])
        start = step * random.randint(1, 4)
        seq = [start + i * step for i in range(4)]
        nxt = seq[-1] + step
        shown = ", ".join(str(x) for x in seq)
        opts = [str(nxt), str(nxt + step), str(max(0, nxt - step)), str(nxt + 1)]
        opts = list(dict.fromkeys(opts))
        while len(opts) < 4:
            opts.append(str(nxt + len(opts) * step + 1))
        random.shuffle(opts)
        return {
            "question": f"Count by {step}s.  {shown}, ___  —  what comes next?",
            "answer": str(nxt), "options": opts,
            "hint": f"Each step adds {step}.",
        }


    # ── Gap fillers: early geometry, sequencing, comparing, listening ────────
    SHAPES = [
        ("triangle", 3, 3, "three straight sides"),
        ("square", 4, 4, "four equal sides"),
        ("rectangle", 4, 4, "four sides, two long and two short"),
        ("pentagon", 5, 5, "five sides"),
        ("hexagon", 6, 6, "six sides"),
        ("circle", 0, 0, "no sides at all — it is round"),
    ]

    #: Three-step everyday sequences. Deliberately ordinary: the skill being
    #: tested is order, not vocabulary.
    SEQUENCES = [
        ("baking muffins", ["mix the batter", "bake the muffins", "eat a muffin"]),
        ("planting a seed", ["dig a hole", "water the seed", "watch it sprout"]),
        ("going to school", ["eat breakfast", "ride the bus", "sit at your desk"]),
        ("painting a picture", ["choose the colours", "paint the picture", "hang it up to dry"]),
        ("a butterfly", ["a tiny egg", "a hungry caterpillar", "a butterfly flies away"]),
        ("making a sandwich", ["get the bread", "add the filling", "take a bite"]),
        ("a rainy day", ["clouds turn grey", "rain falls down", "a rainbow appears"]),
        ("bedtime", ["put on pyjamas", "brush your teeth", "fall asleep"]),
    ]

    #: (thing A, thing B, true of both, true of A only, true of B only)
    COMPARISONS = [
        ("a desert", "a rainforest", "it is a habitat where animals live",
         "it gets very little rain", "it rains almost every day"),
        ("a frog", "a fish", "it lives near water",
         "it can hop on land", "it breathes with gills all its life"),
        ("the sun", "the moon", "we can see it from Earth",
         "it makes its own light", "it reflects light from the sun"),
        ("a bicycle", "a car", "it carries people from place to place",
         "you power it with your legs", "it needs fuel or a battery"),
        ("a poem", "a story", "it is written with words",
         "it often uses rhythm and rhyme", "it usually has a plot and characters"),
        ("an owl", "a bat", "it can fly and hunts at night",
         "it is a bird with feathers", "it is a mammal with fur"),
    ]

    #: Two-sentence passages for children who are listening, not yet reading.
    LISTENING = [
        ("Mei has a red umbrella. She takes it outside when it rains.",
         "What does Mei take outside when it rains?", "her umbrella",
         ["her umbrella", "her lunchbox", "her bicycle", "her cat"]),
        ("Arjun planted a small seed. In the spring it grew into a sunflower.",
         "What did the seed grow into?", "a sunflower",
         ["a sunflower", "a tree", "a rock", "a puppy"]),
        ("The cat sat on the warm windowsill. She watched the birds outside.",
         "Where did the cat sit?", "on the windowsill",
         ["on the windowsill", "under the bed", "in the garden", "on the bus"]),
        ("Ada lost her blue mitten in the snow. Her brother found it by the gate.",
         "Who found the mitten?", "her brother",
         ["her brother", "her teacher", "her dog", "nobody"]),
        ("Leo built a tall tower from blocks. It fell over with a crash.",
         "What happened to the tower?", "it fell over",
         ["it fell over", "it grew taller", "it turned blue", "it flew away"]),
        ("The baker made warm bread every morning. The whole street could smell it.",
         "What did the baker make?", "bread",
         ["bread", "soup", "shoes", "paint"]),
    ]

    @classmethod
    def shape_basics(cls, grade: int, theme: str = "") -> dict:
        # A TK child names circles, squares and triangles; pentagons and
        # hexagons arrive around 2nd. Choosing from the whole list meant
        # "How many sides does a pentagon have?" was being asked at TK.
        allowed = {"circle", "square", "triangle"}
        if grade >= 1:
            allowed.add("rectangle")
        if grade >= 2:
            allowed |= {"pentagon", "hexagon"}
        pool = [x for x in cls.SHAPES if x[0] in allowed] or cls.SHAPES
        name, sides, corners, why = random.choice(pool)
        if random.random() < 0.5:
            answer = str(sides)
            opts = list(dict.fromkeys([answer, str(sides + 1), str(max(0, sides - 1)), str(sides + 2)]))
            while len(opts) < 4:
                opts.append(str(int(opts[-1]) + 1))
            random.shuffle(opts)
            return {"question": f"How many sides does a {name} have?",
                    "answer": answer, "options": opts[:4],
                    "hint": f"A {name} has {why}."}
        others = [n for n, _, _, _ in pool if n != name] or \
                 [n for n, _, _, _ in cls.SHAPES if n != name]
        # At TK the age-appropriate pool is only circle/square/triangle, so there
        # are fewer than three distractors available — asking for three raised
        # ValueError and the whole request 500'd.
        picks = random.sample(others, min(3, len(others)))
        if len(picks) < 3:
            spare = [n for n, _, _, _ in cls.SHAPES if n != name and n not in picks]
            picks += spare[:3 - len(picks)]
        opts = [name] + picks
        random.shuffle(opts)
        return {"question": f"Which shape has {why}?",
                "answer": name, "options": opts,
                "hint": "Picture the shape and count around its edge."}

    @classmethod
    def story_sequence(cls, grade: int, theme: str = "") -> dict:
        label, steps = random.choice(cls.SEQUENCES)
        which = random.choice(["first", "next", "last"])
        idx = {"first": 0, "next": 1, "last": 2}[which]
        opts = list(steps)
        random.shuffle(opts)
        return {
            "question": (f"Think about {label}.  "
                         + "  •  ".join(steps)
                         + f"   —  What happens {which}?"),
            "answer": steps[idx], "options": opts,
            "hint": "Read the steps in order and find the one asked for.",
        }

    @classmethod
    def compare_contrast(cls, grade: int, theme: str = "") -> dict:
        a, b, both, only_a, only_b = random.choice(cls.COMPARISONS)
        if random.random() < 0.6:
            opts = [both, only_a, only_b, "neither one is real"]
            random.shuffle(opts)
            return {"question": f"Compare {a} and {b}.  Which is true of BOTH?",
                    "answer": both, "options": opts,
                    "hint": "Look for the thing they share, not the difference."}
        opts = [only_a, only_b, both, "both of them float"]
        random.shuffle(opts)
        return {"question": f"Compare {a} and {b}.  Which is true of {a} ONLY?",
                "answer": only_a, "options": opts,
                "hint": "Find what makes it different from the other one."}

    @classmethod
    def listening_comprehension(cls, grade: int, theme: str = "") -> dict:
        passage, q, ans, opts = random.choice(cls.LISTENING)
        opts = list(opts)
        random.shuffle(opts)
        return {
            "question": f'Listen:  "{passage}"   —  {q}',
            "answer": ans, "options": opts,
            "hint": "The answer is said out loud in the sentences.",
        }


    # ── Upper-grade literacy (4th-6th) ──────────────────────────────────────
    #: prefix -> (meaning, example base, example whole word)
    PREFIXES = [
        ("re",    "again",          "write",  "rewrite"),
        ("un",    "not",            "happy",  "unhappy"),
        ("pre",   "before",         "view",   "preview"),
        ("mis",   "wrongly",        "spell",  "misspell"),
        ("dis",   "opposite of",    "agree",  "disagree"),
        ("sub",   "under",          "marine", "submarine"),
        ("inter", "between",        "national", "international"),
        ("over",  "too much",       "cook",   "overcook"),
    ]

    SUFFIXES = [
        ("less", "without",              "fear",  "fearless"),
        ("ful",  "full of",              "hope",  "hopeful"),
        ("able", "able to be",           "read",  "readable"),
        ("er",   "one who does",         "teach", "teacher"),
        ("ness", "the state of being",   "kind",  "kindness"),
        ("ly",   "in that manner",       "quick", "quickly"),
    ]

    #: (sentence with ___, correct, distractors) — the classic confusions.
    HOMOPHONES = [
        ("I ate ___ apples for lunch.", "two", ["to", "too", "tow"]),
        ("___ going to be late.", "They're", ["Their", "There", "Theirs"]),
        ("Put the book over ___.", "there", ["their", "they're", "theirs"]),
        ("The dog wagged ___ tail.", "its", ["it's", "its'", "itis"]),
        ("Do you know ___ coat this is?", "whose", ["who's", "whos", "whose'"]),
        ("She walked ___ the door.", "through", ["threw", "thru", "throw"]),
        ("I could hear the ocean ___.", "roar", ["rower", "rawer", "roer"]),
        ("The knight rode all ___.", "night", ["knight", "nite", "gnat"]),
        ("Please ___ your name here.", "write", ["right", "rite", "wright"]),
        ("The wind ___ the leaves away.", "blew", ["blue", "bleu", "blow"]),
    ]

    #: (root, meaning, correct word, its meaning, distractors)
    ROOTS = [
        ("port",  "to carry",      "export",    "to carry goods out",      ["explore", "expand", "expire"]),
        ("dict",  "to say",        "predict",   "to say beforehand",       ["produce", "protect", "provide"]),
        ("scrib", "to write",      "describe",  "to write about",          ["decide", "declare", "deliver"]),
        ("aud",   "to hear",       "audience",  "people who listen",       ["autumn", "auction", "author"]),
        ("tele",  "far off",       "telescope", "a tool for seeing far",   ["telephone booth", "tellurium", "telling"]),
        ("bio",   "life",          "biology",   "the study of life",       ["biography shelf", "bionic arm", "bipod"]),
        ("geo",   "earth",         "geology",   "the study of the earth",  ["geometry set", "gerbil", "geyser"]),
        ("struct", "to build",     "construct", "to build something",      ["constrict", "consume", "consult"]),
    ]

    #: (word, synonym, antonym, extra distractors)
    SYN_ANT = [
        ("ancient",  "very old",     "modern",   ["noisy", "gentle"]),
        ("enormous", "very large",   "tiny",     ["quiet", "damp"]),
        ("rapid",    "very fast",    "slow",     ["heavy", "kind"]),
        ("weary",    "very tired",   "energetic", ["clever", "narrow"]),
        ("brave",    "full of courage", "cowardly", ["sleepy", "sticky"]),
        ("generous", "willing to give", "selfish", ["frozen", "curved"]),
        ("scarce",   "hard to find", "plentiful", ["polite", "circular"]),
    ]

    @classmethod
    def prefix_suffix(cls, grade: int, theme: str = "") -> dict:
        if random.random() < 0.5:
            pre, meaning, base, whole = random.choice(cls.PREFIXES)
            others = [p for p, _, _, _ in cls.PREFIXES if p != pre]
            opts = [pre] + random.sample(others, 3)
            random.shuffle(opts)
            return {
                "question": f"Which prefix means \u201c{meaning}\u201d, as in \u201c{whole}\u201d?",
                "answer": pre, "options": opts,
                "hint": f"A prefix goes on the front: {pre} + {base} = {whole}.",
            }
        suf, meaning, base, whole = random.choice(cls.SUFFIXES)
        others = [x for x, _, _, _ in cls.SUFFIXES if x != suf]
        opts = [suf] + random.sample(others, 3)
        random.shuffle(opts)
        return {
            "question": f"Which suffix means \u201c{meaning}\u201d, as in \u201c{whole}\u201d?",
            "answer": suf, "options": opts,
            "hint": f"A suffix goes on the end: {base} + {suf} = {whole}.",
        }

    @classmethod
    def homophone_choice(cls, grade: int, theme: str = "") -> dict:
        sentence, correct, wrong = random.choice(cls.HOMOPHONES)
        opts = [correct] + list(wrong[:3])
        random.shuffle(opts)
        return {
            "question": f"Choose the right word:  {sentence}",
            "answer": correct, "options": opts,
            "hint": "They sound alike \u2014 the spelling depends on the meaning.",
        }

    @classmethod
    def root_word(cls, grade: int, theme: str = "") -> dict:
        root, meaning, word, wmeaning, wrong = random.choice(cls.ROOTS)
        opts = [word] + list(wrong[:3])
        random.shuffle(opts)
        return {
            "question": (f"The root \u201c{root}\u201d means \u201c{meaning}\u201d.  "
                         f"Which word means \u201c{wmeaning}\u201d?"),
            "answer": word, "options": opts,
            "hint": f"Look for the root {root} inside the word.",
        }

    @classmethod
    def synonym_antonym(cls, grade: int, theme: str = "") -> dict:
        word, syn, ant, extra = random.choice(cls.SYN_ANT)
        if random.random() < 0.5:
            opts = [syn, ant] + list(extra[:2])
            random.shuffle(opts)
            return {"question": f"Which phrase means the SAME as \u201c{word}\u201d?",
                    "answer": syn, "options": opts,
                    "hint": "A synonym means the same thing."}
        opts = [ant, syn] + list(extra[:2])
        random.shuffle(opts)
        return {"question": f"Which word means the OPPOSITE of \u201c{word}\u201d?",
                "answer": ant, "options": opts,
                "hint": "An antonym means the reverse."}

    # ── Dispatch table ────────────────────────────────────────────────────────

    GENERATORS = {
        "math":      [math_addition, math_subtraction, math_multiplication,
                      math_division, math_word_problem, math_fractions,
                      math_percentage, math_geometry,
                      # SQL-generated (dbo.usp_GenerateMathQuestion) — logic lives in the DB
                      math_place_value, math_rounding, math_compare_numbers,
                      math_money_count, math_decimal_add, math_order_of_operations,
                      math_factors_primes, math_elapsed_time, skip_counting,
                      shape_basics],
        "phonics":   [phonics_fill_blank, sight_word, beginning_sound,
                      rhyming_words, syllable_count, digraph_id,
                      prefix_suffix, homophone_choice, root_word, synonym_antonym],
        # sight_word carries the early grades — a TK child cannot read a passage.
        "reading":   [sight_word, reading_comprehension, story_sequence,
                      compare_contrast, listening_comprehension],
        "logic":     [logic_sequence, logic_odd_one_out, logic_pattern_grid],
        "feelings":  [feelings_recognition],
        "manners":   [manners_scenario],
        "pinyin":    [pinyin_tone],
        "hanzi":     [hanzi_meaning],
        "tangshi":   [tang_poem_question],
        "gita":      [gita_teaching],
        "letras":    [spanish_vocab],
        "fiestas":   [hispanic_festival],
    }


    #: A worksheet title names a skill; this maps it to the generator that can
    #: actually produce it. Without this the title was a promise nothing kept —
    #: "Beginning Sounds: S, M, T" served medial vowels and sight words.
    SKILL_GENERATORS = {
        "beginning_sounds":  "beginning_sound",
        "rhyming":           "rhyming_words",
        "syllables":         "syllable_count",
        "digraphs":          "digraph_id",
        "skip_counting":     "skip_counting",
        "sight_words":       "sight_word",
        "vowels":            "phonics_fill_blank",
        "place_value":       "math_place_value",
        "addition":          "math_addition",
        "subtraction":       "math_subtraction",
        "multiplication":    "math_multiplication",
        "division":          "math_division",
        "fractions":         "math_fractions",
        "decimals":          "math_decimal_add",
        "percentage":        "math_percentage",
        "rounding":          "math_rounding",
        "money":             "math_money_count",
        "time":              "math_elapsed_time",
        "geometry":          ["shape_basics", "math_geometry"],
        "comparing":         ["math_compare_numbers", "compare_contrast"],
        "word_problems":     "math_word_problem",
        "factors_primes":    "math_factors_primes",
        "order_of_ops":      "math_order_of_operations",
        "patterns":          "logic_pattern_grid",
        "odd_one_out":       "logic_odd_one_out",
        "sequences":         ["story_sequence", "logic_sequence"],
        "comprehension":     ["reading_comprehension", "listening_comprehension"],
        "feelings":          "feelings_recognition",
        "manners":           "manners_scenario",
    }

    # ── Grade gating ─────────────────────────────────────────────────────────
    #
    # Earliest grade_id at which each generator may be used, keyed by function
    # name. grade_id is the dbo.Grades key, NOT a school year:
    #   0=TK  1=K  2=1st  3=2nd  4=3rd  5=4th  6=5th  7=6th
    #
    # Without this, generate() picked uniformly from every generator in the
    # subject, so a TK child was served "Find the area of a triangle" and
    # "What is 50% of 50?". The `grade` argument only ever tuned the numbers
    # *inside* a generator; it never decided which generators were eligible.
    MIN_GRADE_ID = {
        # math — roughly the US CCSS introduction point for each skill
        "math_addition":            0,   # TK: sums within 5
        "math_subtraction":         1,   # K
        "math_compare_numbers":     1,   # K
        "math_place_value":         2,   # 1st
        "math_word_problem":        2,   # 1st — needs reading
        "math_money_count":         3,   # 2nd
        "math_multiplication":      4,   # 3rd
        "math_rounding":            4,   # 3rd
        "math_elapsed_time":        3,   # 3rd
        "math_division":            4,   # 4th
        "math_geometry":            4,   # 4th
        "math_fractions":           5,   # 4th
        "math_decimal_add":         6,   # 5th
        "math_percentage":          6,   # 5th
        "math_order_of_operations": 6,   # 5th
        "math_factors_primes":      6,   # 5th
        # literacy
        "phonics_fill_blank":       0,
        "sight_word":               0,
        "beginning_sound":          0,   # TK — the first phonics skill
        "rhyming_words":            0,   # TK
        "syllable_count":           1,   # K — needs clapping/segmenting
        "digraph_id":               2,   # 2nd — sh/ch/th are taught after CVC
        "prefix_suffix":            4,   # 3rd — morphology starts here
        "homophone_choice":         3,   # 2nd — their/there/they're
        "synonym_antonym":          3,   # 2nd
        "root_word":                5,   # 4th — Greek and Latin roots
        "skip_counting":            1,   # K — counting by 2s/5s/10s
        "shape_basics":             0,   # TK — naming shapes, counting sides
        "story_sequence":           0,   # TK — first/next/last, read aloud
        "listening_comprehension":  0,   # TK — listening, not reading
        "compare_contrast":         3,   # 2nd — holding two ideas at once
        "reading_comprehension":    2,   # 1st — a passage to read
        # logic
        "logic_pattern_grid":       0,   # shapes, no reading
        "logic_odd_one_out":        1,
        "logic_sequence":           2,   # number sequences
        # social-emotional & cultural
        "feelings_recognition":     0,
        "manners_scenario":         0,
        "pinyin_tone":              0,
        "hanzi_meaning":            0,
        "spanish_vocab":            0,
        "hispanic_festival":        2,
        "tang_poem_question":       2,
        "gita_teaching":            2,
    }

    #: The upper end of each generator's band. MIN_GRADE_ID alone gave every
    #: generator a floor and no ceiling, so once one became eligible it stayed
    #: eligible forever - a 6th grader was still being asked which word rhymes
    #: with "cat". Anything absent here has no upper limit.
    MAX_GRADE_ID = {
        "beginning_sound":          2,   # TK-1st; past initial sounds by 2nd
        "rhyming_words":            2,   # TK-1st
        "listening_comprehension":  2,   # TK-1st; older children read for themselves
        "phonics_fill_blank":       4,   # TK-3rd; the patterns scale (CVC -> kn_ght)
        "sight_word":               3,   # TK-2nd
        "shape_basics":             3,   # naming shapes, counting sides
        "story_sequence":           4,   # TK-3rd
        "skip_counting":            4,   # K-3rd
        "logic_pattern_grid":       4,   # shape patterns; older get sequences
        "math_addition":            4,   # bare sums stop being the point after 3rd
        "math_subtraction":         4,
        "syllable_count":           7,   # counting becomes stress/chunking, not babyish
        "digraph_id":               5,
        "math_compare_numbers":     5,
    }

    # Through 3rd grade (grade_id 4) every question must be multiple choice —
    # these children cannot yet write their answers.
    EARLY_MAX_GRADE_ID = 4

    @staticmethod
    def _fn_name(fn) -> str:
        return getattr(fn, "__func__", fn).__name__

    @classmethod
    def _eligible(cls, fns: list, grade_id: int) -> list:
        """Generators allowed at this grade, never an empty list.

        If nothing in the subject reaches down this far (e.g. tangshi at TK),
        fall back to that subject's gentlest generators — NOT to math, which is
        what made space and art worksheets serve arithmetic.
        """
        ok = [f for f in fns
              if cls.MIN_GRADE_ID.get(cls._fn_name(f), 0) <= grade_id
              <= cls.MAX_GRADE_ID.get(cls._fn_name(f), 7)]
        if ok:
            return ok

        # Capped out of everything (phonics above 4th before the upper-grade
        # generators existed). Take the ones whose band ENDS nearest this grade
        # rather than returning nothing — a stale skill beats a blank screen.
        above = [f for f in fns if cls.MIN_GRADE_ID.get(cls._fn_name(f), 0) <= grade_id]
        if above:
            best = max(cls.MAX_GRADE_ID.get(cls._fn_name(f), 7) for f in above)
            return [f for f in above if cls.MAX_GRADE_ID.get(cls._fn_name(f), 7) == best]
        floor = min(cls.MIN_GRADE_ID.get(cls._fn_name(f), 0) for f in fns)
        return [f for f in fns if cls.MIN_GRADE_ID.get(cls._fn_name(f), 0) == floor]

    @classmethod
    def generate(cls, subject_slug: str, grade_id: int, n: int = 1,
                 theme: str = "", skill: str = "") -> list:
        """Generate `n` questions for a subject at a grade.

        `grade_id` is the dbo.Grades key (0=TK … 7=6th). The individual
        generators and dbo.usp_GenerateMathQuestion both reason in school
        years (K=0, 1st=1 … 6th=6), so convert once here rather than letting
        each caller guess. TK shares K's easiest band.

        `theme` is a dbo.Worksheets.interest_tag (animals, ocean, space …).
        It steers the wording so a worksheet titled "Ocean Math" actually
        counts seashells. An unknown theme is ignored, never an error.
        """
        fns = cls.GENERATORS.get(subject_slug, cls.GENERATORS["math"])
        grade_id = max(0, min(int(grade_id), 7))
        level = max(0, grade_id - 1)
        pool = cls._eligible(fns, grade_id)
        theme = cls._theme(theme)

        # A named skill wins outright when its generator is allowed at this
        # grade. Falling back silently is what let "Skip Counting by 2s, 5s,
        # 10s" serve unrelated arithmetic.
        want = cls.SKILL_GENERATORS.get((skill or "").strip().lower())
        if want:
            # A skill can name more than one generator — "geometry" is shapes at
            # 1st grade and area/perimeter at 3rd. Keep whichever is eligible.
            names = [want] if isinstance(want, str) else list(want)
            preferred = [f for f in pool if cls._fn_name(f) in names]
            if preferred:
                pool = preferred

        results = []
        for _ in range(n):
            fn = random.choice(pool)
            raw = fn.__func__ if hasattr(fn, "__func__") else fn
            q = raw(cls, level, theme)
            q.setdefault("options", None)
            q.setdefault("hint", None)
            if grade_id <= cls.EARLY_MAX_GRADE_ID and not q["options"]:
                q["options"] = cls._choices_from_answer(q["answer"])
            results.append(q)
        return results

    # ── Helper ────────────────────────────────────────────────────────────────

    @classmethod
    def _choices_from_answer(cls, answer) -> list:
        """Last-resort multiple choice for an early-grade question that somehow
        arrived without options. Every generator supplies its own options now,
        so this only guards against a future generator forgetting — a young
        child must never be shown a blank box to type into."""
        text = str(answer)
        if text.lstrip("-").isdigit():
            return cls._wrong_opts(int(text), 3)
        return None

    @staticmethod
    def _wrong_opts(correct: int, n: int, step: int = 1) -> list:
        deltas = random.sample([-3*step, -2*step, -step, step, 2*step, 3*step], n)
        opts   = [str(correct)] + [str(max(0, correct + d)) for d in deltas]
        unique = list(dict.fromkeys(opts))[:n+1]
        random.shuffle(unique)
        return unique
