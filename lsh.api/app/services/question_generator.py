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
        ("咏鹅",   "骆宾王", "鹅鹅鹅，曲项向天歌。白毛浮绿水，红掌拨清波。",
         "Goose, goose, goose - it bends its neck and sings to the sky."),
        ("悯农",   "李绅",   "锄禾日当午，汗滴禾下土。谁知盘中餐，粒粒皆辛苦。",
         "Hoeing the grain under the noon sun, sweat drips into the soil below."),
        ("相思",   "王维",   "红豆生南国，春来发几枝。愿君多采撷，此物最相思。",
         "Red beans grow in the southern land; in spring they put out new branches."),
        ("江雪",   "柳宗元", "千山鸟飞绝，万径人踪灭。孤舟蓑笠翁，独钓寒江雪。",
         "A thousand hills, and no bird flies; ten thousand paths, and no footprint."),
        ("早发白帝城","李白", "朝辞白帝彩云间，千里江陵一日还。两岸猿声啼不住，轻舟已过万重山。",
         "At dawn I left Baidi among the coloured clouds, and reached Jiangling in a day."),
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
        ("patience",    "Your little brother keeps asking the same question. Patience means:",
         "Answering kindly one more time"),
        ("self-control", "You are furious and want to shout. Self-control means:",
         "Waiting until you are calm to speak"),
        ("effort",      "You practise every day but see no progress yet. Effort means:",
         "Doing the work without demanding the reward"),
        ("humility",    "You win a prize in front of everyone. Humility means:",
         "Thanking the people who helped you"),
        ("fairness",    "You are dividing sweets among friends. Fairness means:",
         "Giving each person their proper share"),
        ("gratitude",   "Someone cooked a meal you did not much like. Gratitude means:",
         "Thanking them for the trouble they took"),
        ("focus",       "Your phone buzzes while you are studying. Focus means:",
         "Finishing the task before you look"),
        ("forgiveness", "A friend apologises for something unkind. Forgiveness means:",
         "Letting the anger go rather than storing it"),
        ("truthfulness", "Telling the truth would get you into trouble. Truthfulness means:",
         "Saying what happened anyway"),
        ("service",     "Nobody notices the classroom needs tidying. Service means:",
         "Doing it without being asked"),
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
        # Banded. The early passages ask what the text says; the later ones ask
        # what it means and why the writer said it that way, which is the
        # actual comprehension ladder.
        early = [
            ("The sun rises in the east every morning. It gives us light and warmth.",
             "What does the sun give us?", "Light and warmth"),
            ("Bears hibernate in winter. They sleep to save energy when food is scarce.",
             "Why do bears hibernate?", "To save energy when food is scarce"),
            ("The water cycle has three steps: evaporation, condensation, and precipitation.",
             "What are the three steps of the water cycle?",
             "Evaporation, condensation, and precipitation"),
            ("Bees carry pollen from flower to flower. This helps new plants grow.",
             "How do bees help plants?", "They carry pollen between flowers"),
            ("Owls hunt at night. Their large eyes let in as much light as possible.",
             "Why do owls have large eyes?", "To see in the dark"),
            ("Ice is water that has frozen solid. It melts back into water when it warms.",
             "What happens to ice when it warms?", "It melts back into water"),
        ]
        middle = [
            ("Deserts get very little rain, but they are far from empty. Cactus plants store "
             "water in thick stems, and many animals come out only after dark.",
             "Why do desert animals come out at night?",
             "It is cooler and they lose less water"),
            ("Paper was invented in China around two thousand years ago. Before that, people "
             "wrote on silk, which was costly, or on strips of bamboo, which were heavy.",
             "Why was paper an improvement on bamboo?",
             "It was much lighter to carry"),
            ("A volcano erupts when melted rock beneath the surface finds a weak point and "
             "pushes upward. The rock is called magma below ground and lava above it.",
             "What is magma called once it reaches the surface?", "Lava"),
            ("Migrating birds often fly in a V shape. Each bird catches the moving air from "
             "the one ahead, so the whole flock uses less energy than any bird flying alone.",
             "Why do birds fly in a V?", "The shape saves the flock energy"),
        ]
        upper = [
            ("The library was quiet except for the radiator, which knocked twice and then "
             "gave up. Maya read the same paragraph four times and understood none of it.",
             "What does this suggest about Maya?", "She is distracted, not that the text is hard"),
            ("Some argue that homework builds discipline. Others reply that it mostly measures "
             "how much help a child can get at home, which is not the same as effort.",
             "What is the second argument really objecting to?",
             "That homework may measure advantage rather than effort"),
            ("The glacier has retreated four kilometres since the first survey in 1912. The "
             "valley it left behind is now colonised by grasses and, lately, by young birch.",
             "What does the passage suggest about the valley?",
             "Life moves in once the ice withdraws"),
            ("The advertisement showed a family laughing over a bowl of cereal. It said nothing "
             "about sugar, and the smallest print carried the only number on the page.",
             "Why does the writer mention the smallest print?",
             "To suggest the advertisement hides unflattering facts"),
            ("Rivers rarely run straight. Water moving fastest on the outside of a bend wears "
             "the bank away, while the slower inside edge drops the sand it can no longer carry.",
             "Why does a bend in a river grow more curved over time?",
             "The outside erodes while the inside builds up"),
        ]
        if grade <= 2:
            passages = early
        elif grade <= 4:
            passages = early[:2] + middle
        else:
            passages = middle[:2] + upper
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
        # Banded: a TK child hears the four tones on one familiar syllable;
        # older children meet more finals and more contrast.
        early = [
            ("mā", "1st — flat/high"), ("má", "2nd — rising"),
            ("mǎ", "3rd — dip/low"),   ("mà", "4th — falling"),
            ("bā", "1st — flat/high"), ("bá", "2nd — rising"),
            ("bǎ", "3rd — dip/low"),   ("bà", "4th — falling"),
        ]
        later = [
            ("hāo", "1st — flat/high"), ("háo", "2nd — rising"),
            ("hǎo", "3rd — dip/low"),   ("hào", "4th — falling"),
            ("shū", "1st — flat/high"), ("shú", "2nd — rising"),
            ("shǔ", "3rd — dip/low"),  ("shù", "4th — falling"),
            ("qī", "1st — flat/high"), ("qí", "2nd — rising"),
            ("qǐ", "3rd — dip/low"),   ("qì", "4th — falling"),
            ("xiāng", "1st — flat/high"), ("xiáng", "2nd — rising"),
            ("xiǎng", "3rd — dip/low"),   ("xiàng", "4th — falling"),
        ]
        syllables = early if grade <= 1 else early + later
        syl, ans = random.choice(syllables)
        opts = list({ans} | {s[1] for s in random.sample(syllables, 3)})
        random.shuffle(opts)
        return {"question": f"What tone is the syllable '{syl}'?",
                "answer": ans, "options": opts[:4], "hint": "Count: flat, rise, dip, fall."}

    @classmethod
    def hanzi_meaning(cls, grade: int, theme: str = "") -> dict:
        # Banded roughly the way a Chinese primary reader introduces them:
        # numbers and pictographs first, then position and family, then verbs
        # and colours, then two-character words.
        early = [
            ("一","one"),("二","two"),("三","three"),("四","four"),("五","five"),
            ("六","six"),("七","seven"),("八","eight"),("九","nine"),("十","ten"),
            ("山","mountain"),("水","water"),("火","fire"),("木","wood"),("日","sun"),
            ("月","moon"),("人","person"),("口","mouth"),("手","hand"),("大","big"),
            ("小","small"),
        ]
        mid = [
            ("上","up"),("下","down"),("中","middle"),("天","sky"),("女","woman"),
            ("子","child"),("目","eye"),("心","heart"),("田","field"),("石","stone"),
            ("白","white"),("红","red"),("黄","yellow"),("蓝","blue"),("绿","green"),
            ("黑","black"),
        ]
        upper = [
            ("看","to look"),("听","to listen"),("说","to speak"),("走","to walk"),
            ("吃","to eat"),("喝","to drink"),("学","to study"),("写","to write"),
            ("朋友","friend"),("老师","teacher"),("学校","school"),("今天","today"),
            ("明天","tomorrow"),("谢谢","thank you"),("你好","hello"),
        ]
        chars = early if grade <= 1 else (early + mid if grade <= 3 else early + mid + upper)
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
        extra_mid = [
            ("la escuela","the school"),("el maestro","the teacher"),
            ("el amigo","the friend"),("la familia","the family"),
            ("el agua","the water"),("el pan","the bread"),
            ("la leche","the milk"),("la manzana","the apple"),
            ("el perro","the dog"),("el gato","the cat"),
            ("la casa","the house"),("el libro","the book"),
        ]
        extra_upper = [
            ("aprender","to learn"),("escribir","to write"),("leer","to read"),
            ("caminar","to walk"),("escuchar","to listen"),("ayudar","to help"),
            ("siempre","always"),("nunca","never"),("porque","because"),
            ("aunque","although"),("entonces","then"),("todavía","still"),
        ]
        bank = list(cls.SPANISH_VOCABULARY)
        if grade >= 2:
            bank += extra_mid
        if grade >= 4:
            bank += extra_upper
        word, meaning = random.choice(bank)
        distractors = random.sample([m for _, m in bank if m != meaning], 3)
        opts = [meaning] + distractors
        random.shuffle(opts)
        return {"question": f"What does the Spanish word '{word}' mean in English?",
                "answer": meaning, "options": opts, "hint": None}

    @classmethod
    def hispanic_festival(cls, grade: int, theme: str = "") -> dict:
        festivals = [
            ("Día de los Muertos", "November 1-2",  "honour ancestors who have died"),
            ("Las Posadas",        "December 16-24", "re-enact Mary and Joseph's journey"),
            ("Cinco de Mayo",      "May 5",          "remember the Battle of Puebla"),
            ("Three Kings Day",    "January 6",      "celebrate the Three Wise Men"),
            ("Día de la Independencia", "September 16", "mark Mexico's independence"),
            ("Carnaval",           "the week before Lent", "parade in costume before Lent"),
            ("Semana Santa",       "the week before Easter", "walk in Holy Week processions"),
            ("Las Fallas",         "March 15-19",    "burn giant sculptures in Valencia"),
            ("La Tomatina",        "last Wednesday in August", "throw tomatoes in Buñol"),
            ("Inti Raymi",         "June 24",        "greet the Inca sun festival in Cusco"),
            ("Feria de Abril",     "April",          "dance sevillanas in Seville"),
            ("Nochevieja",         "December 31",    "eat twelve grapes at midnight"),
            ("Quinceañera",        "a girl's 15th birthday", "mark growing up at fifteen"),
            ("Día del Niño",       "April 30",       "celebrate children"),
        ]
        # Younger children get the handful they are most likely to have met.
        if grade <= 1:
            festivals = festivals[:6]
        fest, date_, meaning = random.choice(festivals)
        return {"question": f"What is the purpose of '{fest}'?",
                "answer": f"To {meaning}",
                "options": [f"To {f[2]}" for f in
                            [(fest, date_, meaning)] + random.sample(
                                [x for x in festivals if x[0] != fest], 3)],
                "hint": f"'{fest}' is celebrated on {date_}."}


    # ── Social-emotional banks, banded by age ───────────────────────────────
    #: (scenario, feeling, place_ok)
    FEELINGS_EARLY = [
        ("Your best friend moves to another city. How do you feel?", "sad", True),
        ("You get to open a present. How do you feel?", "excited", True),
        ("A big dog barks loudly right next to you. How do you feel?", "scared", True),
        ("You finish a puzzle all by yourself. How do you feel?", "proud", True),
        ("Someone takes your toy without asking. How do you feel?", "angry", True),
        ("You cannot find your shoes and you are late. How do you feel?", "worried", True),
        ("Your grandma gives you a big hug. How do you feel?", "loved", True),
        ("It rains and you cannot go outside to play. How do you feel?", "disappointed", True),
        ("You are the last one picked for a team. How do you feel?", "left out", True),
        ("You wake up on your birthday. How do you feel?", "happy", True),
        ("You spill juice all over the floor. How do you feel?", "embarrassed", True),
        ("You have nothing to do for a long time. How do you feel?", "bored", True),
    ]

    FEELINGS_MID = [
        ("You studied hard but still got a question wrong. How do you feel?", "frustrated", True),
        ("Your friend is chosen for something you wanted. How do you feel?", "jealous", True),
        ("You told a small lie and nobody found out. How do you feel?", "guilty", True),
        ("You are about to read out loud to the whole class. How do you feel?", "nervous", True),
        ("You helped someone who was struggling. How do you feel?", "proud", True),
        ("Your friend did not invite you to their party. How do you feel?", "hurt", True),
        ("You finally learn something that was hard for weeks. How do you feel?", "relieved", True),
        ("Someone breaks a promise they made to you. How do you feel?", "let down", True),
        ("You are meeting a whole class of new people. How do you feel?", "shy", True),
        ("You see someone being treated unfairly. How do you feel?", "angry", True),
    ]

    FEELINGS_UPPER = [
        ("You are happy to move to a new school but sad to leave your friends. What is that called?",
         "mixed feelings", True),
        ("Your friend snaps at you, then says they had a terrible day. What were they probably feeling?",
         "overwhelmed", True),
        ("You keep checking your work over and over before handing it in. What are you feeling?",
         "anxious", True),
        ("You did well but your friend did not, so you keep your good news quiet. What is that?",
         "being considerate", True),
        ("You feel low for days and cannot say why. What is the useful next step?",
         "tell someone you trust", True),
        ("A friend keeps interrupting you. Instead of shouting, what helps most?",
         "say calmly how it makes you feel", True),
        ("You are furious. What can you do BEFORE you speak?",
         "take a breath and wait", True),
        ("Someone apologises properly and means it. What can you choose to do?",
         "forgive them", True),
    ]

    FEELING_WORDS = [
        "sad", "excited", "scared", "proud", "angry", "worried", "loved",
        "disappointed", "left out", "happy", "embarrassed", "bored",
        "frustrated", "jealous", "guilty", "nervous", "hurt", "relieved",
        "let down", "shy", "mixed feelings", "overwhelmed", "anxious",
    ]

    #: (scenario, right answer, three wrong answers, place_ok)
    MANNERS_EARLY = [
        ("Someone sneezes near you. What do you say?", "Bless you!",
         ["Nothing at all", "That was loud", "Go away"], True),
        ("You want the bread at the table. What do you say?", "Please pass the bread",
         ["Give me that", "I want bread now", "Grab it yourself"], False),
        ("You finish eating dinner. What do you say to the cook?", "Thank you for the meal",
         ["I am still hungry", "That took ages", "Nothing"], False),
        ("You bump into someone by accident. What do you say?", "I'm sorry, excuse me",
         ["Watch where you go", "Nothing", "That was your fault"], True),
        ("Someone gives you a present you already own. What do you say?", "Thank you so much",
         ["I have this already", "I wanted something else", "Nothing"], True),
        ("You want to get past someone in a doorway. What do you say?", "Excuse me, please",
         ["Move!", "Push past quietly", "Nothing"], True),
        ("A visitor arrives at your home. What do you do?", "Say hello and welcome them",
         ["Keep watching your show", "Hide in your room", "Ask them to leave"], True),
        ("Your friend shows you their drawing. What is kind to say?", "I like the colours you chose",
         ["Mine is better", "That looks wrong", "Nothing"], True),
        ("You need to cough. What do you do?", "Cover your mouth with your elbow",
         ["Cough on your friend", "Cough on the food", "Nothing"], True),
        ("Someone holds a door open for you. What do you say?", "Thank you",
         ["Nothing", "About time", "Move faster"], True),
    ]

    MANNERS_MID = [
        ("You want to interrupt someone talking. What should you do?",
         "Wait for a pause and say 'Excuse me'",
         ["Talk over them", "Tap them until they stop", "Walk away"], True),
        ("A new child is standing alone at break. What do you do?",
         "Invite them to join in",
         ["Ignore them", "Point at them", "Tell others to stay away"], True),
        ("You are a guest and are served food you dislike. What do you do?",
         "Try a little and say thank you",
         ["Say it looks horrible", "Push the plate away", "Leave the table"], False),
        ("Your friend is telling a long story. What shows you are listening?",
         "Look at them and ask a question",
         ["Check your watch", "Finish their sentences", "Start your own story"], True),
        ("You borrowed something and broke it. What do you do?",
         "Tell them honestly and offer to replace it",
         ["Return it quietly", "Blame someone else", "Keep it"], True),
        ("You disagree with a friend's idea. How do you say so?",
         "I see it differently, can I explain?",
         ["That's stupid", "You're wrong", "Say nothing and sulk"], True),
        ("You are on a bus and an elderly person is standing. What do you do?",
         "Offer them your seat",
         ["Pretend not to notice", "Move to another seat", "Look at your phone"], True),
        ("You win a game against a friend. What do you say?",
         "Good game, that was close",
         ["I always win", "You are terrible", "Again, and I'll win again"], True),
        ("You lose a game. What do you say?",
         "Well played, congratulations",
         ["You cheated", "That game is unfair", "I wasn't trying"], True),
    ]

    MANNERS_UPPER = [
        ("A classmate is being teased in a group chat. What is the right thing to do?",
         "Speak up or tell an adult you trust",
         ["Join in so you fit in", "Screenshot it and share", "Say nothing and scroll on"], True),
        ("You said something that hurt someone. What is a real apology?",
         "Name what you did and change it",
         ["Say 'sorry you feel that way'", "Explain why they overreacted", "Wait for it to blow over"], True),
        ("You are given credit for work a classmate did. What do you do?",
         "Say clearly that it was their work",
         ["Accept the praise", "Say nothing", "Offer to share next time"], True),
        ("Someone holds an opinion you strongly disagree with. What is respectful?",
         "Ask why they think that, then explain your view",
         ["Mock the idea", "Repeat yourself louder", "Refuse to talk to them"], True),
        ("You are running late to meet someone. What is the courteous thing?",
         "Message them as soon as you know",
         ["Arrive and explain later", "Say nothing", "Blame the traffic afterwards"], True),
        ("A friend tells you something private. What do you do?",
         "Keep it to yourself",
         ["Tell one other person", "Hint about it publicly", "Ask if you can share it later"], True),
        ("You are eating with a family whose customs differ from yours. What do you do?",
         "Watch, follow their lead, and ask politely",
         ["Do it your own way", "Say their way is strange", "Refuse to eat"], True),
        ("Someone thanks you for something small. What is a gracious reply?",
         "You're welcome, happy to help",
         ["It was nothing, obviously", "You owe me", "Finally"], True),
    ]

    @classmethod
    def _sel_band(cls, grade, early, mid, upper):
        """grade here is a school year (K=0, 1st=1 .. 6th=6)."""
        if grade <= 1:
            return early
        if grade <= 3:
            return early[:4] + mid
        return mid[:3] + upper

    # ── Social-Emotional ─────────────────────────────────────────────────────

    @classmethod
    def feelings_recognition(cls, grade: int, theme: str = "") -> dict:
        th = cls._theme(theme)
        bank = cls._sel_band(grade, cls.FEELINGS_EARLY, cls.FEELINGS_MID, cls.FEELINGS_UPPER)
        pool = [f for f in bank if f[2]] if th else bank
        scenario, ans, _ok = random.choice(pool or bank)
        if th:
            scenario = "%s, %s" % (cls.THEME_PLACE[th].capitalize(),
                                   scenario[0].lower() + scenario[1:])
        distract = [w for w in cls.FEELING_WORDS if w != ans]
        opts = [ans] + random.sample(distract, 3)
        random.shuffle(opts)
        return {"question": scenario, "answer": ans, "options": opts,
                "hint": "How would YOU feel in this situation?"}

    @classmethod
    def feelings_response(cls, grade: int, theme: str = "") -> dict:
        """Naming a feeling is the first half; knowing what helps is the rest."""
        bank = cls._sel_band(grade, cls.FEELINGS_EARLY, cls.FEELINGS_MID, cls.FEELINGS_UPPER)
        scenario, feeling, _ok = random.choice(bank)
        helps = [
            ("tell someone you trust how you feel", True),
            ("take a few slow breaths first", True),
            ("ask for help", True),
            ("keep it to yourself and say nothing", False),
            ("pretend you do not care", False),
            ("shout until someone listens", False),
            ("blame someone else", False),
        ]
        good = random.choice([h for h in helps if h[1]])[0]
        bad = random.sample([h[0] for h in helps if not h[1]], 3)
        opts = [good] + bad
        random.shuffle(opts)
        return {
            "question": "%s  What could HELP?" % scenario,
            "answer": good, "options": opts,
            "hint": "Feelings get smaller when they are shared, not hidden.",
        }

    @classmethod
    def manners_scenario(cls, grade: int, theme: str = "") -> dict:
        """What do you say / do. Scenarios are banded by age: 'bless you' for a
        TK child, group-chat bystanding for a 6th grader.

        place_ok marks a scenario that still makes sense once a setting is
        prefixed. "You finish eating dinner ... the cook" does not - prefixing
        every scenario produced "At the aquarium, you finish eating dinner".
        """
        th = cls._theme(theme)
        bank = cls._sel_band(grade, cls.MANNERS_EARLY, cls.MANNERS_MID, cls.MANNERS_UPPER)
        pool = [x for x in bank if x[3]] if th else bank
        scenario, ans, wrong, _ok = random.choice(pool or bank)
        if th:
            scenario = "%s, %s" % (cls.THEME_PLACE[th].capitalize(),
                                   scenario[0].lower() + scenario[1:])
        opts = [ans] + list(wrong[:3])
        random.shuffle(opts)
        return {"question": scenario, "answer": ans, "options": opts,
                "hint": "Think about how the other person would feel."}

    @classmethod
    def manners_reason(cls, grade: int, theme: str = "") -> dict:
        """Why it is the kind thing - moves from doing to understanding."""
        bank = cls._sel_band(grade, cls.MANNERS_EARLY, cls.MANNERS_MID, cls.MANNERS_UPPER)
        scenario, ans, wrong, _ok = random.choice(bank)
        opts = [ans] + list(wrong[:3])
        random.shuffle(opts)
        return {
            "question": "%s  Which choice is the kind one?" % scenario,
            "answer": ans, "options": opts,
            "hint": "The kind choice is usually the one that considers the other person first.",
        }


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
        ("a lake", "a river", "it is fresh water",
         "it stays in one place", "it flows towards the sea"),
        ("a diary", "a newspaper", "it is written down and dated",
         "it records one person's private thoughts", "it reports events for many readers"),
        ("a seed", "an egg", "a new living thing grows from it",
         "it grows into a plant", "it grows into an animal"),
        ("a camel", "a polar bear", "it survives an extreme climate",
         "it stores fat in a hump for the desert", "it has thick fur for the cold"),
        ("a map", "a photograph", "it shows you a place",
         "it uses symbols and a scale", "it captures one moment as it looked"),
        ("a democracy", "a monarchy", "it is a way of governing a country",
         "leaders are chosen by voting", "a ruler inherits the position"),
        ("a fact", "an opinion", "it can appear in a piece of writing",
         "it can be checked and proved", "it expresses what someone believes"),
        ("a spider", "an insect", "it is a small animal with many legs",
         "it has eight legs and no antennae", "it has six legs and antennae"),
        ("thunder", "lightning", "it happens during a storm",
         "it is the sound you hear", "it is the flash you see"),
        ("a novel", "a biography", "it is a long book about a person's life",
         "the person and events are invented", "the person really lived"),
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


    # ── Puzzles ─────────────────────────────────────────────────────────────
    @staticmethod
    def _sudoku_grid(rows: int, cols: int):
        """A valid completed sudoku for boxes of `rows` x `cols`.

        Built from the standard pattern and then shuffled in ways that preserve
        validity: rows within a band, whole bands, columns within a stack,
        whole stacks, and a relabelling of the digits.
        """
        n = rows * cols

        def pattern(r, c):
            return (cols * (r % rows) + r // rows + c) % n

        rand = random.sample
        row_order = [g * rows + r
                     for g in rand(range(cols), cols)
                     for r in rand(range(rows), rows)]
        col_order = [g * cols + c
                     for g in rand(range(rows), rows)
                     for c in rand(range(cols), cols)]
        nums = rand(range(1, n + 1), n)
        return [[nums[pattern(r, c)] for c in col_order] for r in row_order]

    @staticmethod
    def _sudoku_valid(grid, rows: int, cols: int) -> bool:
        n = rows * cols
        full = set(range(1, n + 1))
        if any(set(row) != full for row in grid):
            return False
        if any({grid[r][c] for r in range(n)} != full for c in range(n)):
            return False
        for br in range(0, n, rows):
            for bc in range(0, n, cols):
                box = {grid[br + r][bc + c] for r in range(rows) for c in range(cols)}
                if box != full:
                    return False
        return True

    @classmethod
    def sudoku_cell(cls, grade: int, theme: str = "") -> dict:
        """Which number belongs in the marked square.

        A whole grid cannot be typed into a multiple-choice box, so the puzzle
        is shown complete except for one cell - which is still genuine sudoku
        reasoning: the answer is forced by its row, column and box.
        """
        rows, cols = (2, 2) if grade <= 2 else (2, 3)      # 4x4 for the younger ones
        n = rows * cols
        for _ in range(12):
            grid = cls._sudoku_grid(rows, cols)
            if cls._sudoku_valid(grid, rows, cols):
                break
        else:
            grid = cls._sudoku_grid(rows, cols)

        hr, hc = random.randrange(n), random.randrange(n)
        answer = grid[hr][hc]

        lines = []
        for r in range(n):
            cells = []
            for c in range(n):
                cells.append(" ? " if (r, c) == (hr, hc) else " %d " % grid[r][c])
                if cols > 1 and c % cols == cols - 1 and c != n - 1:
                    cells.append("|")
            lines.append("".join(cells))
            if r % rows == rows - 1 and r != n - 1:
                lines.append("-" * len(lines[-1]))
        board = "\n".join(lines)

        opts = [str(answer)] + [str(x) for x in random.sample(
            [v for v in range(1, n + 1) if v != answer], 3)]
        random.shuffle(opts)
        return {
            "question": ("Sudoku %d\u00d7%d \u2014 every row, every column and every box "
                         "uses 1\u2013%d once.\n\n%s\n\nWhich number goes in the ?"
                         % (n, n, n, board)),
            "answer": str(answer), "options": opts,
            "hint": "Look along the row, down the column, then inside the box.",
        }

    #: (people, items, the word for the item kind)
    LOGIC_SETS = [
        (["Mei", "Arjun", "Sofia"], ["a cat", "a dog", "a rabbit"], "pet"),
        (["Ada", "Leo", "Priya"],   ["red", "blue", "green"],       "favourite colour"),
        (["Kai", "Nora", "Diego"],  ["a violin", "a drum", "a flute"], "instrument"),
        (["Yuki", "Omar", "Lena"],  ["apples", "pears", "plums"],   "favourite fruit"),
        (["Sam", "Hana", "Tomas"],  ["football", "swimming", "chess"], "hobby"),
    ]

    @classmethod
    def logic_grid(cls, grade: int, theme: str = "") -> dict:
        """A three-by-three deduction puzzle with clues that pin it down.

        The clues are brute-forced against all six permutations, and the puzzle
        is only used when exactly one assignment satisfies them - otherwise the
        child is asked to deduce something that is not deducible.
        """
        import itertools
        people, items, kind = random.choice(cls.LOGIC_SETS)

        for _ in range(40):
            truth = dict(zip(people, random.sample(items, 3)))
            # two negative clues and one positive is usually, but not always,
            # enough - which is why the result is checked rather than trusted.
            clues, texts = [], []
            a, b = random.sample(people, 2)
            wrong_a = random.choice([i for i in items if i != truth[a]])
            clues.append(lambda m, a=a, w=wrong_a: m[a] != w)
            texts.append("%s does not have %s." % (a, wrong_a))
            wrong_b = random.choice([i for i in items if i != truth[b]])
            clues.append(lambda m, b=b, w=wrong_b: m[b] != w)
            texts.append("%s does not have %s." % (b, wrong_b))
            c = random.choice(people)
            clues.append(lambda m, c=c, t=truth[c]: m[c] == t)
            texts.append("%s has %s." % (c, truth[c]))

            solutions = []
            for perm in itertools.permutations(items):
                cand = dict(zip(people, perm))
                if all(fn(cand) for fn in clues):
                    solutions.append(cand)
            if len(solutions) == 1:
                break
        else:
            truth = dict(zip(people, random.sample(items, 3)))
            texts = ["%s has %s." % (p, truth[p]) for p in people[:2]]

        # Never ask about the person a clue names outright - "Kai has a flute"
        # followed by "which instrument does Kai have?" is not deduction.
        givens = {t.split(" has ")[0] for t in texts if " has " in t}
        candidates = [p for p in people if p not in givens] or people
        asked = random.choice(candidates)
        answer = truth[asked]
        opts = list(items)
        random.shuffle(opts)
        return {
            "question": ("Logic grid \u2014 work out who has what.\n\n%s\n\nWhich %s does %s have?"
                         % ("\n".join("\u2022 " + t for t in texts), kind, asked)),
            "answer": answer, "options": opts,
            "hint": "Start with the clue that tells you something for certain.",
        }

    CIPHER_WORDS = ["CAT", "DOG", "SUN", "BOOK", "STAR", "TREE", "MOON", "FISH",
                    "BIRD", "RAIN", "LEAF", "SNOW", "CAKE", "SHIP", "GOLD"]

    @classmethod
    def cipher_decode(cls, grade: int, theme: str = "") -> dict:
        """A Caesar shift. Small shifts for younger children, and the alphabet
        wraps, which is the part that catches people out."""
        word = random.choice(cls.CIPHER_WORDS)
        shift = random.randint(1, 3) if grade <= 4 else random.randint(1, 7)
        abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        coded = "".join(abc[(abc.index(ch) + shift) % 26] for ch in word)
        wrong = random.sample([w for w in cls.CIPHER_WORDS if w != word], 3)
        opts = [word] + wrong
        random.shuffle(opts)
        return {
            "question": ("Code breaker \u2014 every letter was moved %d place%s forward in the "
                         "alphabet.\n\nDecode:  %s"
                         % (shift, "" if shift == 1 else "s", coded)),
            "answer": word, "options": opts,
            "hint": "Move each letter %d back. A comes after Z when you wrap around." % shift,
        }


    # ── Reading strategies ──────────────────────────────────────────────────
    #: (sentence with the target word, word, meaning, three wrong meanings)
    CONTEXT_CLUES = [
        ("The path was so narrow that we had to walk in single file.", "narrow",
         "not wide", ["very long", "muddy", "steep"]),
        ("After three days of rain the river was turbulent and dangerous.", "turbulent",
         "rough and churning", ["frozen solid", "shallow", "clear"]),
        ("She was reluctant to speak, and had to be asked twice.", "reluctant",
         "unwilling", ["excited", "loud", "confused"]),
        ("The ancient map was so fragile it tore at the corner.", "fragile",
         "easily broken", ["colourful", "enormous", "waterproof"]),
        ("He gave a brief answer and walked straight on.", "brief",
         "short", ["angry", "clever", "whispered"]),
        ("The cave was damp, and water ran down the walls.", "damp",
         "slightly wet", ["warm", "bright", "empty"]),
        ("Her argument was persuasive and everyone changed their mind.", "persuasive",
         "good at convincing people", ["written down", "very quiet", "extremely long"]),
    ]

    #: (statement, is_fact)
    FACT_OPINION = [
        ("Water freezes at zero degrees Celsius.", True),
        ("Winter is the best season of the year.", False),
        ("The Nile is a river in Africa.", True),
        ("Chocolate ice cream tastes better than vanilla.", False),
        ("A spider has eight legs.", True),
        ("Spiders are creepy and horrible.", False),
        ("Our school day starts at half past eight.", True),
        ("Homework should be banned completely.", False),
        ("The moon orbits the Earth.", True),
        ("Football is more exciting than swimming.", False),
    ]

    #: (cause, effect, three wrong effects)
    CAUSE_EFFECT = [
        ("It rained all afternoon,", "the match was cancelled.",
         ["the sun grew hotter", "the pitch was repainted", "everyone brought sunglasses"]),
        ("Ravi forgot to water the seedling,", "it wilted.",
         ["it grew twice as fast", "it turned into a tree", "it changed colour to blue"]),
        ("The power cut lasted all evening,", "we ate dinner by candlelight.",
         ["the television got louder", "the fridge froze over", "the clocks ran fast"]),
        ("Nobody had swept the leaves,", "the path became slippery.",
         ["the path grew wider", "the leaves turned green", "the wind stopped"]),
        ("She practised the piece every day,", "she played it perfectly at the concert.",
         ["she forgot how to play", "the piano broke", "the concert was cancelled"]),
    ]

    #: (short text, the writer's purpose, three wrong purposes)
    AUTHOR_PURPOSE = [
        ("Mix the flour and butter, then add the eggs one at a time.",
         "to instruct", ["to entertain", "to persuade", "to frighten"]),
        ("You should vote for our plan because it helps every family in the town.",
         "to persuade", ["to instruct", "to describe a process", "to tell a joke"]),
        ("The dragon sneezed, and the whole village turned bright purple.",
         "to entertain", ["to instruct", "to persuade", "to report facts"]),
        ("Antarctica is the coldest continent, with an average winter temperature near -60C.",
         "to inform", ["to entertain", "to persuade", "to give instructions"]),
        ("Buy now and you will never regret it - our offer ends on Friday!",
         "to persuade", ["to inform", "to entertain", "to instruct"]),
    ]

    #: (setup, most likely next event, three unlikely ones)
    PREDICTIONS = [
        ("Mei packed her swimming costume and a towel, and set off down the lane.",
         "She is going swimming.",
         ["She is going to bed.", "She is baking a cake.", "She is doing homework."]),
        ("Dark clouds gathered and the wind picked up. Ben looked at the washing line.",
         "He will bring the washing in.",
         ["He will plant seeds.", "He will paint the fence.", "He will wash the car."]),
        ("The candles were lit and everyone hid behind the sofa.",
         "Someone is about to have a surprise party.",
         ["Everyone is going to sleep.", "They are cleaning the house.", "A lesson is starting."]),
        ("Ada checked her ticket, then looked up at the departures board.",
         "She is waiting for a train or plane.",
         ["She is cooking dinner.", "She is at the dentist.", "She is feeding a cat."]),
    ]

    #: (feature, what it is for, three wrong purposes)
    TEXT_FEATURES = [
        ("a caption", "to explain a picture",
         ["to list the chapters", "to define a hard word", "to show the title"]),
        ("a glossary", "to explain what difficult words mean",
         ["to show where places are", "to list the author's other books", "to explain a picture"]),
        ("an index", "to show which page a topic is on",
         ["to explain a picture", "to summarise the story", "to name the illustrator"]),
        ("a heading", "to tell you what the section is about",
         ["to explain a photograph", "to define a word", "to number the pages"]),
        ("a diagram", "to show how something works or fits together",
         ["to list new words", "to give the author's opinion", "to number the chapters"]),
        ("a table of contents", "to show what is in the book and where",
         ["to explain hard words", "to describe the cover", "to thank the publisher"]),
    ]

    @classmethod
    def context_clues(cls, grade: int, theme: str = "") -> dict:
        sentence, word, meaning, wrong = random.choice(cls.CONTEXT_CLUES)
        opts = [meaning] + list(wrong[:3])
        random.shuffle(opts)
        return {
            "question": ("Read: \"%s\"\n\nWhat does \u201c%s\u201d most likely mean?"
                         % (sentence, word)),
            "answer": meaning, "options": opts,
            "hint": "The rest of the sentence tells you, even if you have never met the word.",
        }

    @classmethod
    def fact_or_opinion(cls, grade: int, theme: str = "") -> dict:
        statement, is_fact = random.choice(cls.FACT_OPINION)
        ans = "Fact" if is_fact else "Opinion"
        return {
            "question": "Is this a fact or an opinion?\n\n\u201c%s\u201d" % statement,
            "answer": ans, "options": ["Fact", "Opinion"],
            "hint": "A fact can be checked. An opinion is what somebody believes.",
        }

    @classmethod
    def cause_effect(cls, grade: int, theme: str = "") -> dict:
        cause, effect, wrong = random.choice(cls.CAUSE_EFFECT)
        opts = [effect] + list(wrong[:3])
        random.shuffle(opts)
        return {
            "question": "%s so what happened?" % cause,
            "answer": effect, "options": opts,
            "hint": "The cause comes first; the effect is what it made happen.",
        }

    @classmethod
    def author_purpose(cls, grade: int, theme: str = "") -> dict:
        text, purpose, wrong = random.choice(cls.AUTHOR_PURPOSE)
        opts = [purpose] + list(wrong[:3])
        random.shuffle(opts)
        return {
            "question": "Read: \"%s\"\n\nWhy did the writer write this?" % text,
            "answer": purpose, "options": opts,
            "hint": "Writers usually want to inform, persuade, instruct or entertain.",
        }

    @classmethod
    def predict_next(cls, grade: int, theme: str = "") -> dict:
        setup, likely, wrong = random.choice(cls.PREDICTIONS)
        opts = [likely] + list(wrong[:3])
        random.shuffle(opts)
        return {
            "question": "Read: \"%s\"\n\nWhat will most likely happen next?" % setup,
            "answer": likely, "options": opts,
            "hint": "Use the clues in the sentence, not just a guess.",
        }

    #: The parts of a book a very young child actually meets.
    BOOK_PARTS = [
        ("the cover", "it shows the title and a picture of what the book is about",
         ["it lists every word in the book", "it tells you the price", "it is always blank"]),
        ("the title", "it tells you the name of the book",
         ["it tells you the page number", "it shows who printed it", "it is the last page"]),
        ("the author", "it is the person who wrote the book",
         ["the person who sells the book", "the person who reads it aloud", "the shop it came from"]),
        ("the illustrator", "it is the person who drew the pictures",
         ["the person who wrote the words", "the person who sold the book", "the librarian"]),
        ("the spine", "it is the edge you see on a shelf",
         ["the first page", "the picture on the front", "the words at the back"]),
    ]

    @classmethod
    def text_features(cls, grade: int, theme: str = "") -> dict:
        """Parts of a book at TK-1st; non-fiction features from 2nd.

        A four-year-old learning "Parts of a Book" is learning cover, title and
        author - not what a glossary is for.
        """
        if grade <= 1:
            part, purpose, wrong = random.choice(cls.BOOK_PARTS)
            opts = [purpose] + list(wrong[:3])
            random.shuffle(opts)
            return {"question": "What is %s of a book?" % part,
                    "answer": purpose, "options": opts,
                    "hint": "Picture a book in your hands."}
        feature, purpose, wrong = random.choice(cls.TEXT_FEATURES)
        opts = [purpose] + list(wrong[:3])
        random.shuffle(opts)
        return {"question": "In a non-fiction book, what is %s for?" % feature,
                "answer": purpose, "options": opts,
                "hint": "Think about what it helps a reader do."}

    # ── Phonics: spelling patterns ──────────────────────────────────────────
    ENDING_SOUNDS = {
        "t": ["cat", "hat", "boat", "night"], "n": ["sun", "rain", "green", "moon"],
        "p": ["cup", "map", "sheep", "jump"], "g": ["dog", "bag", "frog", "pig"],
        "k": ["book", "duck", "milk", "rock"], "d": ["bed", "hand", "road", "bird"],
    }

    #: (short vowel word, magic-e word)
    SILENT_E = [("cap", "cape"), ("kit", "kite"), ("hop", "hope"), ("tub", "tube"),
                ("pin", "pine"), ("rat", "rate"), ("not", "note"), ("cub", "cube"),
                ("man", "mane"), ("rid", "ride")]

    #: (word, soft or hard, letter)
    SOFT_CG = [("city", "soft", "c"), ("cat", "hard", "c"), ("circle", "soft", "c"),
               ("cup", "hard", "c"), ("giant", "soft", "g"), ("goat", "hard", "g"),
               ("gentle", "soft", "g"), ("gate", "hard", "g"), ("cycle", "soft", "c"),
               ("gym", "soft", "g")]

    COMPOUNDS = [("sun", "flower", "sunflower"), ("rain", "bow", "rainbow"),
                 ("butter", "fly", "butterfly"), ("foot", "ball", "football"),
                 ("book", "shelf", "bookshelf"), ("snow", "man", "snowman"),
                 ("play", "ground", "playground"), ("tooth", "brush", "toothbrush"),
                 ("cup", "cake", "cupcake"), ("star", "fish", "starfish")]

    CONTRACTIONS = [("do not", "don't"), ("cannot", "can't"), ("it is", "it's"),
                    ("they are", "they're"), ("I have", "I've"), ("she will", "she'll"),
                    ("we are", "we're"), ("did not", "didn't"), ("you have", "you've"),
                    ("is not", "isn't")]

    SILENT_LETTERS = [("knee", "k"), ("write", "w"), ("lamb", "b"), ("island", "s"),
                      ("castle", "t"), ("sign", "g"), ("hour", "h"), ("comb", "b"),
                      ("knife", "k"), ("wrist", "w")]

    @classmethod
    def ending_sound(cls, grade: int, theme: str = "") -> dict:
        letter = random.choice(list(cls.ENDING_SOUNDS.keys()))
        target = random.choice(cls.ENDING_SOUNDS[letter])
        others = [w for k, ws in cls.ENDING_SOUNDS.items() if k != letter for w in ws]
        opts = [target] + random.sample(others, 3)
        random.shuffle(opts)
        return {"question": "Which word ENDS with the /%s/ sound?" % letter,
                "answer": target, "options": opts,
                "hint": "Say each word and listen to the very last sound."}

    @classmethod
    def silent_e(cls, grade: int, theme: str = "") -> dict:
        short, long_ = random.choice(cls.SILENT_E)
        others = [w for _, w in cls.SILENT_E if w != long_]
        opts = [long_] + random.sample(others, 3)
        random.shuffle(opts)
        return {
            "question": ("Magic e \u2014 adding a silent e changes the vowel sound.\n\n"
                         "What does \u201c%s\u201d become when you add a silent e?" % short),
            "answer": long_, "options": opts,
            "hint": "The e stays silent but makes the first vowel say its own name.",
        }

    @classmethod
    def soft_hard_cg(cls, grade: int, theme: str = "") -> dict:
        word, kind, letter = random.choice(cls.SOFT_CG)
        return {
            "question": ("In \u201c%s\u201d, is the letter %s soft or hard?" % (word, letter)),
            "answer": kind.capitalize(), "options": ["Soft", "Hard"],
            "hint": "C and g go soft before e, i and y \u2014 like city and giant.",
        }

    @classmethod
    def compound_word(cls, grade: int, theme: str = "") -> dict:
        a, b, whole = random.choice(cls.COMPOUNDS)
        others = [w for _, _, w in cls.COMPOUNDS if w != whole]
        opts = [whole] + random.sample(others, 3)
        random.shuffle(opts)
        return {"question": "Which compound word means \u201c%s\u201d + \u201c%s\u201d?" % (a, b),
                "answer": whole, "options": opts,
                "hint": "A compound word is two smaller words joined together."}

    @classmethod
    def contraction(cls, grade: int, theme: str = "") -> dict:
        full, short = random.choice(cls.CONTRACTIONS)
        others = [c for _, c in cls.CONTRACTIONS if c != short]
        opts = [short] + random.sample(others, 3)
        random.shuffle(opts)
        return {"question": "Which contraction means \u201c%s\u201d?" % full,
                "answer": short, "options": opts,
                "hint": "The apostrophe stands where the missing letters were."}

    @classmethod
    def silent_letter(cls, grade: int, theme: str = "") -> dict:
        word, letter = random.choice(cls.SILENT_LETTERS)
        others = [l for _, l in cls.SILENT_LETTERS if l != letter]
        opts = [letter] + random.sample(list(dict.fromkeys(others)), 3)
        random.shuffle(opts)
        return {"question": "Which letter is SILENT in \u201c%s\u201d?" % word,
                "answer": letter, "options": opts,
                "hint": "Say the word aloud - one letter is written but not heard."}


    # ── Logic and number sense ──────────────────────────────────────────────
    ORDINALS = ["1st", "2nd", "3rd", "4th", "5th", "6th"]
    RACERS = [["Mei", "Arjun", "Sofia", "Leo", "Ada"],
              ["Kai", "Nora", "Diego", "Yuki", "Omar"],
              ["Hana", "Tomas", "Priya", "Sam", "Lena"]]

    #: (rule, three that fit, three that do not)
    SORTING_RULES = [
        ("things you can eat", ["apple", "bread", "cheese"], ["hammer", "sock", "cloud"]),
        ("animals with four legs", ["dog", "horse", "cat"], ["bird", "fish", "snake"]),
        ("things that float", ["cork", "leaf", "boat"], ["stone", "coin", "hammer"]),
        ("things that are always cold", ["ice", "snow", "frost"], ["oven", "candle", "sun"]),
        ("things with wheels", ["bus", "bicycle", "skateboard"], ["boat", "kite", "ladder"]),
        ("things you write with", ["pencil", "pen", "chalk"], ["spoon", "brick", "shoe"]),
        ("things that grow", ["tree", "puppy", "seed"], ["rock", "chair", "spoon"]),
    ]

    #: (statement, is_true)
    TRUE_FALSE = [
        ("All squares have four sides.", True),
        ("All birds can fly.", False),
        ("Every triangle has three corners.", True),
        ("All animals that swim are fish.", False),
        ("Two plus two equals four.", True),
        ("All red things are apples.", False),
        ("Every month has at least 28 days.", True),
        ("All even numbers end in 2.", False),
    ]

    #: (rule, given fact, what follows, three that do not)
    IF_THEN = [
        ("If it rains, we stay inside.", "It is raining.", "We stay inside.",
         ["We go outside.", "It stops raining.", "We take an umbrella outside."]),
        ("If the light is green, the cars may go.", "The light is green.", "The cars may go.",
         ["The cars must stop.", "The light turns red.", "The cars turn around."]),
        ("If you finish your work, you may read.", "You finished your work.", "You may read.",
         ["You must start again.", "You may not read.", "The work disappears."]),
        ("If an animal is a mammal, it has a backbone.", "A whale is a mammal.",
         "A whale has a backbone.",
         ["A whale is a fish.", "A whale has no bones.", "All fish are mammals."]),
        ("If the shop is shut, we come back tomorrow.", "The shop is shut.",
         "We come back tomorrow.",
         ["We go in anyway.", "The shop opens.", "We never come back."]),
    ]

    #: (claim, is it true of ALL or only SOME)
    QUANTIFIERS = [
        ("Birds have feathers.", "All"), ("Birds can swim.", "Some"),
        ("Squares have four sides.", "All"), ("Rectangles are squares.", "Some"),
        ("Even numbers can be divided by two.", "All"),
        ("Numbers are bigger than ten.", "Some"),
        ("Mammals feed their young milk.", "All"), ("Mammals live in water.", "Some"),
    ]

    FALLACIES = [
        ("Everyone in my class has a phone, so phones must be good for you.",
         "Popular does not mean correct",
         ["The class is too small", "Phones are expensive", "Nobody asked the teacher"]),
        ("It rained after I washed the car, so washing the car causes rain.",
         "Two things happening in order does not mean one caused the other",
         ["Cars should not be washed", "Rain is unpredictable", "The car was already clean"]),
        ("You are wrong about the film because you are only eleven.",
         "Attacking the person instead of the argument",
         ["Eleven-year-olds dislike films", "The film was too long", "Age is hard to check"]),
        ("Either we cancel sports day entirely or we ignore the weather.",
         "Pretending there are only two choices",
         ["Sports day is unimportant", "Weather cannot be predicted", "Everyone likes sport"]),
    ]

    @classmethod
    def ordinal_numbers(cls, grade: int, theme: str = "") -> dict:
        names = random.choice(cls.RACERS)[:]
        random.shuffle(names)
        n = 4 if grade <= 1 else 5
        names = names[:n]
        pos = random.randrange(n)
        order = ",  ".join("%s %s" % (cls.ORDINALS[i], names[i]) for i in range(n))
        if random.random() < 0.5:
            opts = random.sample(names, min(4, n))
            if names[pos] not in opts:
                opts[0] = names[pos]
            random.shuffle(opts)
            return {"question": "The race finished:  %s\n\nWho came %s?" % (order, cls.ORDINALS[pos]),
                    "answer": names[pos], "options": opts,
                    "hint": "1st is the winner, then 2nd, then 3rd."}
        opts = cls.ORDINALS[:n]
        return {"question": "The race finished:  %s\n\nWhere did %s come?" % (order, names[pos]),
                "answer": cls.ORDINALS[pos], "options": opts[:4] if pos < 4 else opts[-4:],
                "hint": "Count along the finishing order."}

    @classmethod
    def sorting_rule(cls, grade: int, theme: str = "") -> dict:
        rule, fits, nots = random.choice(cls.SORTING_RULES)
        shown = random.sample(fits, 2)
        answer = [f for f in fits if f not in shown][0]
        opts = [answer] + random.sample(nots, 3)
        random.shuffle(opts)
        return {
            "question": ("These belong in the same group:  %s\n\nThe rule is \u201c%s\u201d. "
                         "Which one ALSO belongs?" % ("  \u2022  ".join(shown), rule)),
            "answer": answer, "options": opts,
            "hint": "Check each choice against the rule.",
        }

    @classmethod
    def true_false_logic(cls, grade: int, theme: str = "") -> dict:
        statement, is_true = random.choice(cls.TRUE_FALSE)
        return {"question": "True or false?\n\n\u201c%s\u201d" % statement,
                "answer": "True" if is_true else "False", "options": ["True", "False"],
                "hint": "One counter-example is enough to make an \u201call\u201d statement false."}

    @classmethod
    def if_then_logic(cls, grade: int, theme: str = "") -> dict:
        rule, given, follows, wrong = random.choice(cls.IF_THEN)
        opts = [follows] + list(wrong[:3])
        random.shuffle(opts)
        return {"question": "Rule:  %s\nFact:  %s\n\nWhat must be true?" % (rule, given),
                "answer": follows, "options": opts,
                "hint": "Apply the rule to the fact - do not add anything of your own."}

    @classmethod
    def quantifier_logic(cls, grade: int, theme: str = "") -> dict:
        claim, kind = random.choice(cls.QUANTIFIERS)
        return {"question": "Is this true of ALL of them, or only SOME?\n\n\u201c%s\u201d" % claim,
                "answer": kind, "options": ["All", "Some"],
                "hint": "If you can think of one that does not fit, it is only some."}

    @classmethod
    def logical_fallacy(cls, grade: int, theme: str = "") -> dict:
        claim, flaw, wrong = random.choice(cls.FALLACIES)
        opts = [flaw] + list(wrong[:3])
        random.shuffle(opts)
        return {"question": "What is wrong with this reasoning?\n\n\u201c%s\u201d" % claim,
                "answer": flaw, "options": opts,
                "hint": "Look at whether the reason actually supports the conclusion."}

    @classmethod
    def guess_number(cls, grade: int, theme: str = "") -> dict:
        hi = 20 if grade <= 2 else (50 if grade <= 4 else 100)
        for _ in range(60):
            n = random.randint(2, hi)
            clues = []
            clues.append(("It is an even number." if n % 2 == 0 else "It is an odd number.",
                          lambda v, n=n: v % 2 == n % 2))
            lo_b = max(1, n - random.randint(3, 8)); hi_b = n + random.randint(3, 8)
            clues.append(("It is between %d and %d." % (lo_b, hi_b),
                          lambda v, a=lo_b, b=hi_b: a < v < b))
            d = random.choice([3, 4, 5])
            if n % d == 0:
                clues.append(("You can divide it by %d exactly." % d,
                              lambda v, d=d: v % d == 0))
            cands = [v for v in range(1, hi + 1) if all(fn(v) for _, fn in clues)]
            if len(cands) == 1:
                break
        else:
            n = 12
            clues = [("It is an even number.", None),
                     ("It is between 10 and 14.", None)]
        wrong = random.sample([v for v in range(1, hi + 1) if v != n], 3)
        opts = [str(n)] + [str(w) for w in wrong]
        random.shuffle(opts)
        return {
            "question": ("Guess my number.\n\n%s\n\nWhat is it?"
                         % "\n".join("\u2022 " + c for c, _ in clues)),
            "answer": str(n), "options": opts,
            "hint": "Use every clue - together they leave only one answer.",
        }

    @classmethod
    def number_bonds(cls, grade: int, theme: str = "") -> dict:
        total = 10 if grade <= 1 else (20 if grade <= 3 else 100)
        part = random.randint(1, total - 1)
        other = total - part
        opts = list(dict.fromkeys([str(other), str(other + 1), str(max(0, other - 1)),
                                   str(min(total, other + 2))]))
        while len(opts) < 4:
            opts.append(str(int(opts[-1]) + 3))
        random.shuffle(opts)
        return {"question": "Number bond to %d.\n\n%d and ___ make %d." % (total, part, total),
                "answer": str(other), "options": opts[:4],
                "hint": "Count up from %d until you reach %d." % (part, total)}

    @classmethod
    def size_sorting(cls, grade: int, theme: str = "") -> dict:
        groups = [("an elephant", "a mouse"), ("a bus", "a bicycle"), ("a tree", "a flower"),
                  ("the sun", "a candle"), ("a whale", "a fish"), ("a mountain", "a stone")]
        big, small = random.choice(groups)
        if random.random() < 0.5:
            others = [s for b, s in groups if s != small]
            opts = [big] + random.sample([b for b, _ in groups if b != big], 2) + [small]
            random.shuffle(opts)
            return {"question": "Which is BIGGER?  %s or %s?" % (big, small),
                    "answer": big, "options": [big, small],
                    "hint": "Picture them side by side."}
        return {"question": "Which is SMALLER?  %s or %s?" % (big, small),
                "answer": small, "options": [big, small],
                "hint": "Picture them side by side."}

    @classmethod
    def prealgebra_variable(cls, grade: int, theme: str = "") -> dict:
        x = random.randint(2, 12)
        a = random.randint(2, 9)
        b = random.randint(1, 20)
        if random.random() < 0.5:
            total = a * x + b
            q = "Solve for x:   %dx + %d = %d" % (a, b, total)
        else:
            total = a * x
            q = "Solve for x:   %dx = %d" % (a, total)
        opts = list(dict.fromkeys([str(x), str(x + 1), str(max(1, x - 1)), str(x + 2)]))
        while len(opts) < 4:
            opts.append(str(int(opts[-1]) + 2))
        random.shuffle(opts)
        return {"question": q, "answer": str(x), "options": opts[:4],
                "hint": "Undo the addition first, then the multiplication."}

    @classmethod
    def ratio_bar_model(cls, grade: int, theme: str = "") -> dict:
        a, b = random.choice([(1, 2), (2, 3), (3, 4), (2, 5), (3, 5)])
        unit = random.randint(3, 12)
        total = (a + b) * unit
        items = random.choice([("red beads", "blue beads"), ("apples", "pears"),
                               ("boys", "girls"), ("stickers", "stamps")])
        ans = a * unit
        opts = list(dict.fromkeys([str(ans), str(b * unit), str(ans + unit), str(max(1, ans - unit))]))
        while len(opts) < 4:
            opts.append(str(int(opts[-1]) + unit))
        random.shuffle(opts)
        return {
            "question": ("The ratio of %s to %s is %d:%d.\nThere are %d altogether.\n\n"
                         "How many %s are there?" % (items[0], items[1], a, b, total, items[0])),
            "answer": str(ans), "options": opts[:4],
            "hint": "%d + %d = %d equal parts, so one part is %d \u00f7 %d."
                    % (a, b, a + b, total, a + b),
        }


    IE_EI = [("bel__ve", "ie", "believe"), ("rec__ve", "ei", "receive"),
             ("ach__ve", "ie", "achieve"), ("c__ling", "ei", "ceiling"),
             ("f__ld", "ie", "field"), ("d__ceive", "e", "deceive"),
             ("th__f", "ie", "thief"), ("w__ght", "ei", "weight"),
             ("p__ce", "ie", "piece"), ("n__ghbour", "ei", "neighbour")]

    @classmethod
    def ie_ei_rule(cls, grade: int, theme: str = "") -> dict:
        """i before e except after c - and the exceptions that break it."""
        blank, correct, whole = random.choice([x for x in cls.IE_EI if x[1] in ("ie", "ei")])
        opts = ["ie", "ei"]
        return {
            "question": ("Spelling rule - i before e, except after c.\n\n"
                         "Which goes in the gap?   %s" % blank),
            "answer": correct, "options": opts,
            "hint": "The word is “%s”. After a c, it is usually ei." % whole,
        }

    @classmethod
    def count_objects(cls, grade: int, theme: str = "") -> dict:
        """Counting a small set - the first number skill there is."""
        icons = {"apples": "🍎", "stars": "⭐", "balls": "⚽",
                 "flowers": "🌷", "fish": "🐟", "cats": "🐱"}
        name, icon = random.choice(list(icons.items()))
        n = random.randint(1, 5 if grade <= 0 else 10)
        opts = list(dict.fromkeys([str(n), str(n + 1), str(max(1, n - 1)), str(n + 2)]))
        while len(opts) < 4:
            opts.append(str(int(opts[-1]) + 1))
        random.shuffle(opts)
        return {"question": "How many %s?\n\n%s" % (name, " ".join([icon] * n)),
                "answer": str(n), "options": opts[:4],
                "hint": "Point to each one as you count."}

    # ── Dispatch table ────────────────────────────────────────────────────────

    GENERATORS = {
        "math":      [math_addition, math_subtraction, math_multiplication,
                      math_division, math_word_problem, math_fractions,
                      math_percentage, math_geometry,
                      # SQL-generated (dbo.usp_GenerateMathQuestion) — logic lives in the DB
                      math_place_value, math_rounding, math_compare_numbers,
                      math_money_count, math_decimal_add, math_order_of_operations,
                      math_factors_primes, math_elapsed_time, skip_counting,
                      shape_basics, number_bonds, size_sorting, count_objects,
                      prealgebra_variable, ratio_bar_model],
        "phonics":   [ie_ei_rule, phonics_fill_blank, sight_word, beginning_sound,
                      rhyming_words, syllable_count, digraph_id,
                      prefix_suffix, homophone_choice, root_word, synonym_antonym,
                      ending_sound, silent_e, soft_hard_cg, compound_word,
                      contraction, silent_letter],
        # sight_word carries the early grades — a TK child cannot read a passage.
        "reading":   [sight_word, reading_comprehension, story_sequence,
                      compare_contrast, listening_comprehension,
                      context_clues, fact_or_opinion, cause_effect,
                      author_purpose, predict_next, text_features],
        "logic":     [logic_sequence, logic_odd_one_out, logic_pattern_grid,
                      sudoku_cell, logic_grid, cipher_decode,
                      ordinal_numbers, sorting_rule, true_false_logic,
                      if_then_logic, quantifier_logic, logical_fallacy,
                      guess_number],
        "feelings":  [feelings_recognition, feelings_response],
        "manners":   [manners_scenario, manners_reason],
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
        "context_clues":     "context_clues",
        "fact_opinion":      "fact_or_opinion",
        "cause_effect":      "cause_effect",
        "author_purpose":    "author_purpose",
        "prediction":        "predict_next",
        "text_features":     "text_features",
        "ending_sounds":     "ending_sound",
        "silent_e":          "silent_e",
        "soft_cg":           "soft_hard_cg",
        "compound_words":    "compound_word",
        "contractions":      "contraction",
        "silent_letters":    "silent_letter",
        "sudoku":            "sudoku_cell",
        "pinyin_tone":       "pinyin_tone",
        "tang_poem":         "tang_poem_question",
        "spanish_vocab":     "spanish_vocab",
        "ordinals":          "ordinal_numbers",
        "ie_ei":             "ie_ei_rule",
        "counting":          "count_objects",
        "sorting":           "sorting_rule",
        "true_false":        "true_false_logic",
        "if_then":           "if_then_logic",
        "quantifiers":       "quantifier_logic",
        "fallacies":         "logical_fallacy",
        "guess_number":      "guess_number",
        "number_bonds":      "number_bonds",
        "size_sorting":      "size_sorting",
        "prealgebra":        "prealgebra_variable",
        "ratios":            "ratio_bar_model",
        "homophones":        "homophone_choice",
        "prefix_suffix":     "prefix_suffix",
        "root_word":         "root_word",
        "synonym_antonym":   "synonym_antonym",
        "logic_grid":        "logic_grid",
        "cipher":            "cipher_decode",
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
        "ending_sound":             0,   # TK, straight after beginning sounds
        "silent_e":                 2,   # 1st — magic e
        "soft_hard_cg":             3,   # 2nd
        "compound_word":            2,   # 1st
        "contraction":              3,   # 2nd
        "silent_letter":            4,   # 3rd
        "context_clues":            3,   # 2nd
        "fact_or_opinion":          3,   # 2nd
        "cause_effect":             2,   # 1st
        "author_purpose":           4,   # 3rd
        "predict_next":             0,   # K — prediction from pictures/text
        "text_features":            0,   # 2nd
        "skip_counting":            1,   # K — counting by 2s/5s/10s
        "shape_basics":             0,   # TK — naming shapes, counting sides
        "story_sequence":           0,   # TK — first/next/last, read aloud
        "listening_comprehension":  0,   # TK — listening, not reading
        "compare_contrast":         3,   # 2nd — holding two ideas at once
        "reading_comprehension":    2,   # 1st — a passage to read
        # logic
        "logic_pattern_grid":       0,   # shapes, no reading
        "logic_odd_one_out":        0,
        "logic_sequence":           2,   # number sequences
        "sudoku_cell":              2,   # 1st - 4x4 first, 6x6 from 2nd
        "ordinal_numbers":          0,   # TK - 1st, 2nd, 3rd
        "ie_ei_rule":               5,   # 4th - the rule and its exceptions
        "count_objects":            0,   # TK
        "sorting_rule":             1,   # K
        "true_false_logic":         1,   # K
        "if_then_logic":            2,   # 1st
        "quantifier_logic":         3,   # 2nd - all versus some
        "logical_fallacy":          6,   # 5th
        "guess_number":             3,   # 2nd
        "number_bonds":             1,   # K
        "size_sorting":             0,   # TK
        "prealgebra_variable":      7,   # 6th
        "ratio_bar_model":          6,   # 5th
        "logic_grid":               3,   # 2nd - holding three facts at once
        "cipher_decode":            3,   # 2nd - needs the alphabet secure
        # social-emotional & cultural
        "feelings_recognition":     0,
        "manners_scenario":         0,
        "manners_reason":           3,   # 2nd - why, not just what
        "feelings_response":        1,   # K - what helps, once feelings are named
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
        "ending_sound":             2,   # TK-1st, same as beginning sounds
        "predict_next":             4,   # TK-3rd; older readers infer instead
        "silent_e":                 4,
        "compound_word":            5,
        "rhyming_words":            2,   # TK-1st
        "listening_comprehension":  2,   # TK-1st; older children read for themselves
        "phonics_fill_blank":       4,   # TK-3rd; the patterns scale (CVC -> kn_ght)
        "sight_word":               3,   # TK-2nd
        "shape_basics":             3,   # naming shapes, counting sides
        "size_sorting":             1,   # TK-K only
        "count_objects":            1,   # TK-K only
        "ordinal_numbers":          3,   # TK-2nd
        "true_false_logic":         4,
        "sorting_rule":             4,
        "number_bonds":             4,
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

            if not preferred:
                # The generator exists but lives under a different subject.
                # "Greek & Latin Roots" is filed as reading while root_word is
                # a phonics generator; the title is the better signal, so look
                # across every pool rather than dropping the skill.
                everywhere = [f for fns_ in cls.GENERATORS.values() for f in fns_]
                seen, unique = set(), []
                for f in everywhere:
                    n = cls._fn_name(f)
                    if n not in seen:
                        seen.add(n)
                        unique.append(f)
                preferred = [f for f in cls._eligible(unique, grade_id)
                             if cls._fn_name(f) in names]

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
