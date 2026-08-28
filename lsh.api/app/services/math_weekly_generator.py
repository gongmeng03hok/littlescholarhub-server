"""
services/math_weekly_generator.py
══════════════════════════════════════════════════════════════════════
Weekly Math Worksheet Generator — inspired by mathworksheets.com
Generates full week packets (Mon–Fri) per grade with:
  • Daily warm-up (5 quick-fire problems)
  • Skill focus block (12 problems on the week's topic)
  • Spiral review (6 problems mixing prior topics)
  • Word problem set (3–5 contextual problems)
  • Friday challenge / assessment (10 mixed problems)
  • Timed drill sheet (30 facts for fluency)

Grades supported : TK (0) · K (1) · 1 (2) · 2 (3) · 3 (4) · 4 (5) · 5 (6) · 6 (7)
All methods return plain dicts — no ORM / DB dependency.
"""

import random
import math
from datetime import date, timedelta
from typing import List, Dict, Any, Optional


# ── helpers ────────────────────────────────────────────────────────────────────

def _opts(correct: int, n: int = 3, spread: int = None) -> List[str]:
    """Generate `n` unique wrong answers near `correct`, return shuffled list with correct."""
    if spread is None:
        spread = max(1, abs(correct) // 4 + 1)
    wrongs = set()
    attempts = 0
    while len(wrongs) < n and attempts < 50:
        delta = random.choice([-1, 1]) * random.randint(1, spread)
        w = correct + delta
        if w != correct and w >= 0:
            wrongs.add(w)
        attempts += 1
    choices = [str(correct)] + [str(w) for w in wrongs]
    random.shuffle(choices)
    return choices


def _q(text: str, answer, options=None, hint: str = None, work_space: int = 2) -> Dict:
    """Canonical question dict."""
    return {
        "question": text,
        "answer": str(answer),
        "options": options,
        "hint": hint,
        "work_space": work_space,   # lines of blank space for working
    }


# ══════════════════════════════════════════════════════════════════════════════
#  GRADE-BANDED TOPIC SEQUENCES  (52-week spiral)
#  Each entry: (week_number_in_year, topic_slug, topic_label)
# ══════════════════════════════════════════════════════════════════════════════

WEEKLY_TOPICS: Dict[int, List[tuple]] = {
    # grade_id → list of (week, slug, label)  — repeats after week 36
    0: [  # TK
        (1, "counting_1_5",     "Counting 1–5"),
        (2, "counting_6_10",    "Counting 6–10"),
        (3, "more_less",        "More and Less"),
        (4, "shapes_basic",     "Basic Shapes"),
        (5, "patterns_ab",      "AB Patterns"),
        (6, "number_order",     "Number Order"),
        (7, "counting_1_10",    "Counting 1–10 Review"),
        (8, "size_compare",     "Size Comparison"),
    ],
    1: [  # K
        (1,  "counting_20",     "Counting to 20"),
        (2,  "add_fluency_5",   "Addition within 5"),
        (3,  "sub_fluency_5",   "Subtraction within 5"),
        (4,  "add_fluency_10",  "Addition within 10"),
        (5,  "sub_fluency_10",  "Subtraction within 10"),
        (6,  "teen_numbers",    "Teen Numbers 11–19"),
        (7,  "shapes_2d",       "2-D Shapes"),
        (8,  "compare_nums",    "Comparing Numbers"),
        (9,  "number_bonds",    "Number Bonds"),
        (10, "ordinals",        "Ordinal Numbers"),
    ],
    2: [  # Grade 1
        (1,  "add_to_20",       "Addition to 20"),
        (2,  "sub_to_20",       "Subtraction to 20"),
        (3,  "add_doubles",     "Doubles Facts"),
        (4,  "add_near_doubles","Near Doubles"),
        (5,  "make_ten",        "Make-a-Ten Strategy"),
        (6,  "place_value_tens","Tens and Ones"),
        (7,  "add_2digit_no_r", "Add 2-Digit (no regroup)"),
        (8,  "sub_2digit_no_r", "Subtract 2-Digit (no regroup)"),
        (9,  "measurement_cm",  "Measuring in Centimetres"),
        (10, "time_hour",       "Telling Time to the Hour"),
        (11, "time_half",       "Time to the Half Hour"),
        (12, "shapes_3d",       "3-D Shapes"),
        (13, "even_odd",        "Even and Odd Numbers"),
        (14, "skip_count_2",    "Skip Counting by 2s"),
        (15, "skip_count_5",    "Skip Counting by 5s"),
        (16, "skip_count_10",   "Skip Counting by 10s"),
        (17, "word_prob_add",   "Word Problems — Add"),
        (18, "word_prob_sub",   "Word Problems — Subtract"),
    ],
    3: [  # Grade 2
        (1,  "add_3digit",      "Add 3-Digit Numbers"),
        (2,  "sub_3digit",      "Subtract 3-Digit Numbers"),
        (3,  "add_regroup",     "Addition with Regrouping"),
        (4,  "sub_regroup",     "Subtraction with Regrouping"),
        (5,  "intro_multiply",  "Intro to Multiplication"),
        (6,  "times_2_5",       "Times Tables 2 & 5"),
        (7,  "times_10",        "Times Table 10"),
        (8,  "place_value_100", "Place Value to 1 000"),
        (9,  "measurement_m",   "Measuring in Metres"),
        (10, "time_5min",       "Time to 5 Minutes"),
        (11, "money_coins",     "Counting Coins"),
        (12, "graphs_bar",      "Bar Graphs"),
        (13, "fractions_half",  "Halves and Quarters"),
        (14, "geometry_lines",  "Lines and Angles"),
        (15, "data_tally",      "Tally Charts"),
        (16, "estimation_100",  "Estimation to 100"),
        (17, "word_prob_2step", "Two-Step Word Problems"),
        (18, "arrays",          "Arrays and Multiplication"),
    ],
    4: [  # Grade 3
        (1,  "times_3_4",       "Times Tables 3 & 4"),
        (2,  "times_6_7",       "Times Tables 6 & 7"),
        (3,  "times_8_9",       "Times Tables 8 & 9"),
        (4,  "division_basic",  "Division Basics"),
        (5,  "division_facts",  "Division Facts"),
        (6,  "multiply_2digit", "Multiply 2-Digit × 1-Digit"),
        (7,  "fractions_third", "Thirds and Eighths"),
        (8,  "fractions_equiv", "Equivalent Fractions"),
        (9,  "fractions_order", "Ordering Fractions"),
        (10, "place_value_1000","Place Value to 10 000"),
        (11, "perimeter",       "Perimeter"),
        (12, "area_basic",      "Area — Counting Squares"),
        (13, "time_elapsed",    "Elapsed Time"),
        (14, "rounding_10",     "Rounding to Nearest 10"),
        (15, "rounding_100",    "Rounding to Nearest 100"),
        (16, "patterns_rule",   "Number Patterns & Rules"),
        (17, "word_prob_mult",  "Word Problems — Multiply"),
        (18, "word_prob_div",   "Word Problems — Divide"),
    ],
    5: [  # Grade 4
        (1,  "multiply_3digit", "Multiply 3-Digit × 1-Digit"),
        (2,  "multiply_2x2",    "Multiply 2-Digit × 2-Digit"),
        (3,  "long_division",   "Long Division (no remainder)"),
        (4,  "long_div_rem",    "Long Division with Remainder"),
        (5,  "fractions_add",   "Add & Subtract Fractions"),
        (6,  "mixed_numbers",   "Mixed Numbers"),
        (7,  "decimals_intro",  "Intro to Decimals"),
        (8,  "decimals_tenths", "Tenths and Hundredths"),
        (9,  "decimals_compare","Comparing Decimals"),
        (10, "angles",          "Types of Angles"),
        (11, "area_formula",    "Area of Rectangles"),
        (12, "symmetry",        "Lines of Symmetry"),
        (13, "factors_multip",  "Factors and Multiples"),
        (14, "prime_composite", "Prime and Composite Numbers"),
        (15, "measurement_conv","Unit Conversions"),
        (16, "line_graphs",     "Line Graphs"),
        (17, "word_prob_frac",  "Word Problems — Fractions"),
        (18, "word_prob_dec",   "Word Problems — Decimals"),
    ],
    6: [  # Grade 5
        (1,  "fractions_mult",  "Multiply Fractions"),
        (2,  "fractions_div",   "Divide Fractions"),
        (3,  "decimals_mult",   "Multiply Decimals"),
        (4,  "decimals_div",    "Divide Decimals"),
        (5,  "percentage_basic","Percentages Basics"),
        (6,  "percentage_calc", "Calculating Percentages"),
        (7,  "ratio_intro",     "Introduction to Ratios"),
        (8,  "volume_cuboid",   "Volume of Cuboids"),
        (9,  "coordinates",     "Coordinates (all 4 quadrants)"),
        (10, "integers_intro",  "Positive & Negative Integers"),
        (11, "order_operations","Order of Operations (BODMAS)"),
        (12, "algebra_basics",  "Introduction to Algebra"),
        (13, "mean_median",     "Mean, Median, Mode"),
        (14, "probability",     "Probability Basics"),
        (15, "long_mult_dec",   "Long Multiplication with Decimals"),
        (16, "word_prob_ratio", "Word Problems — Ratio"),
        (17, "word_prob_pct",   "Word Problems — Percentages"),
        (18, "data_charts",     "Reading Data Charts"),
    ],
    7: [  # Grade 6
        (1,  "integers_ops",    "Integer Operations"),
        (2,  "algebra_linear",  "Linear Equations (1-step)"),
        (3,  "algebra_2step",   "Linear Equations (2-step)"),
        (4,  "ratios_rates",    "Ratios and Rates"),
        (5,  "proportions",     "Proportions"),
        (6,  "percentage_adv",  "Advanced Percentages"),
        (7,  "geometry_area",   "Area of Triangles & Parallelograms"),
        (8,  "geometry_circles","Circumference & Area of Circles"),
        (9,  "surface_area",    "Surface Area"),
        (10, "volume_prism",    "Volume of Prisms"),
        (11, "statistics_adv",  "Statistics — Spread of Data"),
        (12, "probability_adv", "Compound Probability"),
        (13, "exponents",       "Exponents & Powers"),
        (14, "prime_factors",   "Prime Factorisation"),
        (15, "fractions_adv",   "Complex Fractions"),
        (16, "coordinate_geo",  "Coordinate Geometry"),
        (17, "word_prob_alg",   "Algebraic Word Problems"),
        (18, "mixed_review",    "Comprehensive Review"),
    ],
}


# ══════════════════════════════════════════════════════════════════════════════
#  TOPIC GENERATORS
#  Each returns List[dict] of question dicts
# ══════════════════════════════════════════════════════════════════════════════

class TopicGenerators:
    """All question generators. Called by slug via REGISTRY at bottom."""

    NAMES  = ["Aanya","Kai","Noah","Mei","Sofia","Arjun","Leo","Zara","Mia","Ravi","Sam","Priya"]
    ITEMS  = ["apples","cookies","stickers","books","stamps","marbles","crayons","balloons","stars","coins"]

    # ── Counting / Number Sense ──────────────────────────────────────────────

    @classmethod
    def counting_1_5(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            count = random.randint(1, 5)
            qs.append(_q(f"How many? {'⭐' * count}", count,
                         _opts(count, 3, 2), "Count each star."))
        return qs

    @classmethod
    def counting_1_10(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            count = random.randint(1, 10)
            qs.append(_q(f"How many dots? {'●' * count}", count,
                         _opts(count, 3, 3), "Count each dot."))
        return qs

    @classmethod
    def counting_20(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(1, 20)
            b = random.randint(1, 20)
            ops = [("comes after", a, a+1), ("comes before", b, b-1 if b > 1 else 1)]
            label, start, ans = random.choice(ops)
            qs.append(_q(f"What number {label} {start}?", ans, _opts(ans, 3, 2)))
        return qs

    @classmethod
    def more_less(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a, b = random.randint(1,10), random.randint(1,10)
            while a == b: b = random.randint(1,10)
            bigger = max(a,b)
            qs.append(_q(f"Which is more: {a} or {b}?", bigger, [str(a), str(b)],
                         "The bigger number is more."))
        return qs

    @classmethod
    def even_odd(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            num = random.randint(1, 50)
            ans = "Even" if num % 2 == 0 else "Odd"
            qs.append(_q(f"Is {num} even or odd?", ans, ["Even","Odd"],
                         "Even numbers end in 0,2,4,6,8. Odd numbers end in 1,3,5,7,9."))
        return qs

    @classmethod
    def skip_count_2(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            start = random.choice([0,2,4,6,8,10])
            seq = [start + i*2 for i in range(4)]
            ans = start + 4*2
            qs.append(_q(f"Count by 2s: {', '.join(map(str,seq))}, ___", ans,
                         _opts(ans,3,2), "Add 2 each time."))
        return qs

    @classmethod
    def skip_count_5(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            start = random.choice([0,5,10,15,20])
            seq = [start + i*5 for i in range(4)]
            ans = start + 4*5
            qs.append(_q(f"Count by 5s: {', '.join(map(str,seq))}, ___", ans,
                         _opts(ans,3,5), "Add 5 each time."))
        return qs

    @classmethod
    def skip_count_10(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            start = random.choice([0,10,20,30,40])
            seq = [start + i*10 for i in range(4)]
            ans = start + 4*10
            qs.append(_q(f"Count by 10s: {', '.join(map(str,seq))}, ___", ans,
                         _opts(ans,3,10), "Add 10 each time."))
        return qs

    @classmethod
    def ordinals(cls, n: int) -> List[Dict]:
        ords = {1:"1st",2:"2nd",3:"3rd",4:"4th",5:"5th",6:"6th",7:"7th",8:"8th",9:"9th",10:"10th"}
        qs = []
        for _ in range(n):
            pos = random.randint(1,10)
            items = random.choice(cls.ITEMS)
            color_items = ["red","blue","green","yellow","purple","orange"]
            color = random.choice(color_items)
            qs.append(_q(
                f"There are 10 {items} in a row. What position is the {color} one if it is {ords[pos]}?",
                pos, _opts(pos,3,3), f"{ords[pos]} means position {pos}."))
        return qs

    # ── Addition ─────────────────────────────────────────────────────────────

    @classmethod
    def add_fluency_5(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(0,5); b = random.randint(0, 5-a)
            qs.append(_q(f"{a} + {b} = ___", a+b, _opts(a+b,3,2)))
        return qs

    @classmethod
    def add_fluency_10(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(0,10); b = random.randint(0, 10-a)
            qs.append(_q(f"{a} + {b} = ___", a+b, _opts(a+b,3,2)))
        return qs

    @classmethod
    def add_to_20(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(1,19); b = random.randint(1, 20-a)
            qs.append(_q(f"{a} + {b} = ___", a+b, _opts(a+b,3,3)))
        return qs

    @classmethod
    def add_doubles(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(1,10)
            qs.append(_q(f"{a} + {a} = ___", a*2, _opts(a*2,3,2),
                         f"Double of {a} is {a*2}."))
        return qs

    @classmethod
    def add_near_doubles(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(2,9)
            b = a + random.choice([-1, 1])
            qs.append(_q(f"{a} + {b} = ___", a+b, _opts(a+b,3,2),
                         f"Near double: {a}+{a}={a*2}, then adjust by 1."))
        return qs

    @classmethod
    def make_ten(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(6,9)
            b = random.randint(1,9)
            qs.append(_q(
                f"Use make-a-ten: {a} + {b} = ___\n(Hint: {a} needs ___ to make 10)",
                a+b, _opts(a+b,3,3),
                f"{a} + {10-a} = 10, then add {b-(10-a)}."))
        return qs

    @classmethod
    def add_2digit_no_r(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a_tens = random.randint(1,4); a_ones = random.randint(0,4)
            b_tens = random.randint(1,4); b_ones = random.randint(0, 9-a_ones)
            a = a_tens*10+a_ones; b = b_tens*10+b_ones
            qs.append(_q(f"  {a}\n+ {b}\n─────", a+b, _opts(a+b,3,10),
                         "Add ones first, then tens.", work_space=3))
        return qs

    @classmethod
    def add_regroup(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(15,99); b = random.randint(15,99)
            qs.append(_q(f"  {a}\n+ {b}\n─────", a+b, _opts(a+b,3,10),
                         "If ones sum ≥ 10, carry 1 to tens.", work_space=3))
        return qs

    @classmethod
    def add_3digit(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(100,499); b = random.randint(100,499)
            qs.append(_q(f"  {a}\n+ {b}\n──────", a+b, _opts(a+b,3,50), work_space=4))
        return qs

    # ── Subtraction ──────────────────────────────────────────────────────────

    @classmethod
    def sub_fluency_5(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(0,5); b = random.randint(0,a)
            qs.append(_q(f"{a} − {b} = ___", a-b, _opts(a-b,3,2)))
        return qs

    @classmethod
    def sub_fluency_10(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(0,10); b = random.randint(0,a)
            qs.append(_q(f"{a} − {b} = ___", a-b, _opts(a-b,3,2)))
        return qs

    @classmethod
    def sub_to_20(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(5,20); b = random.randint(1,a)
            qs.append(_q(f"{a} − {b} = ___", a-b, _opts(a-b,3,3)))
        return qs

    @classmethod
    def sub_2digit_no_r(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            b_tens = random.randint(1,3); b_ones = random.randint(0,5)
            a_tens = random.randint(b_tens, b_tens+3); a_ones = random.randint(b_ones,9)
            a = a_tens*10+a_ones; b = b_tens*10+b_ones
            qs.append(_q(f"  {a}\n− {b}\n─────", a-b, _opts(a-b,3,10), work_space=3))
        return qs

    @classmethod
    def sub_regroup(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            b = random.randint(15,79); a = b + random.randint(10,79)
            qs.append(_q(f"  {a}\n− {b}\n─────", a-b, _opts(a-b,3,10),
                         "Borrow from tens if ones digit is too small.", work_space=3))
        return qs

    @classmethod
    def sub_3digit(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            b = random.randint(100,400); a = b + random.randint(50,400)
            qs.append(_q(f"  {a}\n− {b}\n──────", a-b, _opts(a-b,3,50), work_space=4))
        return qs

    # ── Multiplication ───────────────────────────────────────────────────────

    @classmethod
    def intro_multiply(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            groups = random.randint(2,5); each = random.randint(2,5)
            ans = groups * each
            qs.append(_q(
                f"There are {groups} groups with {each} in each group. How many in all?",
                ans, _opts(ans,3,max(2,ans//4)),
                f"{groups} × {each} = {ans}"))
        return qs

    @classmethod
    def times_2_5(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            t = random.choice([2,5]); a = random.randint(1,12)
            ans = t*a
            qs.append(_q(f"{t} × {a} = ___", ans, _opts(ans,3,t)))
        return qs

    @classmethod
    def times_10(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(1,12)
            ans = 10*a
            qs.append(_q(f"10 × {a} = ___", ans, _opts(ans,3,10),
                         "Multiply by 10: add a zero."))
        return qs

    @classmethod
    def times_3_4(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            t = random.choice([3,4]); a = random.randint(1,12)
            ans = t*a
            qs.append(_q(f"{t} × {a} = ___", ans, _opts(ans,3,t)))
        return qs

    @classmethod
    def times_6_7(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            t = random.choice([6,7]); a = random.randint(1,12)
            ans = t*a
            qs.append(_q(f"{t} × {a} = ___", ans, _opts(ans,3,t*2)))
        return qs

    @classmethod
    def times_8_9(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            t = random.choice([8,9]); a = random.randint(1,12)
            ans = t*a
            qs.append(_q(f"{t} × {a} = ___", ans, _opts(ans,3,t*2)))
        return qs

    @classmethod
    def multiply_2digit(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(10,49); b = random.randint(2,9)
            ans = a*b
            qs.append(_q(f"  {a}\n×  {b}\n─────", ans, _opts(ans,3,max(10,ans//10)),
                         "Multiply ones then tens.", work_space=4))
        return qs

    @classmethod
    def multiply_3digit(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(100,499); b = random.randint(2,9)
            ans = a*b
            qs.append(_q(f"  {a}\n×    {b}\n──────", ans, _opts(ans,3,max(50,ans//20)), work_space=5))
        return qs

    @classmethod
    def multiply_2x2(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(11,49); b = random.randint(11,49)
            ans = a*b
            qs.append(_q(f"  {a}\n× {b}\n─────", ans, _opts(ans,3,max(50,ans//10)), work_space=5))
        return qs

    # ── Division ─────────────────────────────────────────────────────────────

    @classmethod
    def division_basic(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            b = random.randint(2,5); ans = random.randint(2,10); a = b*ans
            qs.append(_q(f"{a} ÷ {b} = ___", ans, _opts(ans,3,2),
                         f"How many groups of {b} fit in {a}?"))
        return qs

    @classmethod
    def division_facts(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            b = random.randint(2,9); ans = random.randint(2,12); a = b*ans
            qs.append(_q(f"{a} ÷ {b} = ___", ans, _opts(ans,3,3)))
        return qs

    @classmethod
    def long_division(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            b = random.randint(2,9); ans = random.randint(10,99); a = b*ans
            qs.append(_q(f"{a} ÷ {b} = ___", ans, _opts(ans,3,max(5,ans//10)),
                         "Use long division: divide, multiply, subtract, bring down.",
                         work_space=5))
        return qs

    @classmethod
    def long_div_rem(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            b = random.randint(3,9); quot = random.randint(5,25)
            rem = random.randint(1, b-1); a = b*quot+rem
            ans = f"{quot} R{rem}"
            qs.append(_q(f"{a} ÷ {b} = ___ remainder ___", ans, None,
                         "Divide, then find what's left over.", work_space=5))
        return qs

    # ── Fractions ────────────────────────────────────────────────────────────

    @classmethod
    def fractions_half(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            total = random.choice([4,6,8,10,12])
            half = total//2
            qs.append(_q(
                f"What is half of {total}?",
                half, _opts(half,3,max(1,half//2)),
                f"Divide {total} by 2."))
        return qs

    @classmethod
    def fractions_third(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            d = random.choice([3,4,6,8])
            n_num = random.randint(1, d-1)
            qs.append(_q(
                f"What fraction of the shape is shaded if {n_num} out of {d} parts are shaded?",
                f"{n_num}/{d}", None,
                "Numerator = shaded parts, denominator = total parts."))
        return qs

    @classmethod
    def fractions_equiv(cls, n: int) -> List[Dict]:
        qs = []
        equiv_pairs = [("1/2","2/4"),("1/2","3/6"),("2/3","4/6"),
                       ("3/4","6/8"),("1/3","2/6"),("2/4","4/8")]
        for _ in range(n):
            a, b = random.choice(equiv_pairs)
            blank = b.split("/")
            qs.append(_q(
                f"Fill in the blank to make equivalent fractions: {a} = ___/{blank[1]}",
                blank[0], None,
                "Multiply numerator and denominator by the same number."))
        return qs

    @classmethod
    def fractions_add(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            d = random.choice([3,4,5,6,8,10])
            a = random.randint(1,d-1); b = random.randint(1,d-a)
            raw = a+b
            g = math.gcd(raw, d)
            ans = f"{raw//g}/{d//g}" if d//g > 1 else str(raw//g)
            qs.append(_q(
                f"{a}/{d} + {b}/{d} = ___",
                ans, None,
                f"Add numerators ({a}+{b}={raw}), keep denominator ({d}), simplify."))
        return qs

    @classmethod
    def fractions_mult(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a_n = random.randint(1,4); a_d = random.randint(2,6)
            b_n = random.randint(1,4); b_d = random.randint(2,6)
            raw_n = a_n*b_n; raw_d = a_d*b_d
            g = math.gcd(raw_n, raw_d)
            ans = f"{raw_n//g}/{raw_d//g}" if raw_d//g > 1 else str(raw_n//g)
            qs.append(_q(
                f"{a_n}/{a_d} × {b_n}/{b_d} = ___",
                ans, None,
                "Multiply numerators together, multiply denominators together, simplify."))
        return qs

    @classmethod
    def fractions_div(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a_n = random.randint(1,4); a_d = random.randint(2,6)
            b_n = random.randint(1,3); b_d = random.randint(2,5)
            # a/b ÷ c/d = a*d / b*c
            raw_n = a_n*b_d; raw_d = a_d*b_n
            g = math.gcd(raw_n, raw_d)
            ans = f"{raw_n//g}/{raw_d//g}" if raw_d//g > 1 else str(raw_n//g)
            qs.append(_q(
                f"{a_n}/{a_d} ÷ {b_n}/{b_d} = ___",
                ans, None,
                "Keep, Change, Flip (KCF): multiply by the reciprocal."))
        return qs

    @classmethod
    def mixed_numbers(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            whole = random.randint(1,5); d = random.choice([2,3,4])
            n_num = random.randint(1,d-1)
            # convert to improper
            ans = whole*d + n_num
            qs.append(_q(
                f"Convert {whole} and {n_num}/{d} to an improper fraction: ___/{d}",
                ans, _opts(ans,3,d),
                f"Multiply whole ({whole}) × denominator ({d}), add numerator ({n_num})."))
        return qs

    # ── Decimals ─────────────────────────────────────────────────────────────

    @classmethod
    def decimals_intro(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            whole = random.randint(0,9); tenth = random.randint(1,9)
            val = f"{whole}.{tenth}"
            choices = [val, f"{whole+1}.{tenth}", f"{whole}.{tenth+1}", f"{whole-1}.{tenth}"]
            random.shuffle(choices)
            qs.append(_q(
                f"Write {whole} and {tenth} tenths as a decimal.",
                val, choices[:4],
                f"Tenths go after the decimal point: {val}"))
        return qs

    @classmethod
    def decimals_mult(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = round(random.uniform(1.1, 9.9), 1)
            b = random.randint(2,9)
            ans = round(a*b, 1)
            qs.append(_q(f"{a} × {b} = ___", ans, None,
                         "Multiply as whole numbers, then place the decimal.", work_space=4))
        return qs

    @classmethod
    def decimals_div(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            b = random.randint(2,5)
            ans = round(random.uniform(1.1,9.9),1)
            a = round(ans*b, 1)
            qs.append(_q(f"{a} ÷ {b} = ___", ans, None,
                         "Divide as if whole numbers; place decimal in answer.", work_space=4))
        return qs

    # ── Percentages ──────────────────────────────────────────────────────────

    @classmethod
    def percentage_basic(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            pct = random.choice([10,20,25,50,75,100])
            total = random.choice([20,40,60,80,100,200])
            ans = total*pct//100
            qs.append(_q(f"What is {pct}% of {total}?", ans, _opts(ans,3,max(5,ans//5)),
                         f"Divide by 100 then multiply by {pct}."))
        return qs

    @classmethod
    def percentage_calc(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            pct = random.choice([5,10,15,20,30,40,50])
            total = random.choice([30,40,50,60,80,120,150,200])
            ans = total*pct//100
            qs.append(_q(
                f"A shop has {total} items. {pct}% are on sale. How many items are on sale?",
                ans, _opts(ans,3,max(5,ans//5))))
        return qs

    @classmethod
    def percentage_adv(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            orig = random.choice([80,100,120,150,200,250])
            pct = random.choice([5,10,15,20,25])
            disc = orig*pct//100
            sale = orig - disc
            qs.append(_q(
                f"A jacket costs ${orig}. It is {pct}% off. What is the sale price?",
                sale, _opts(sale,3,max(10,sale//5)),
                f"Discount = {orig} × {pct}% = {disc}. Sale price = {orig} − {disc}."))
        return qs

    # ── Place Value ───────────────────────────────────────────────────────────

    @classmethod
    def place_value_tens(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            tens = random.randint(1,9); ones = random.randint(0,9)
            num = tens*10+ones
            q_type = random.choice(["tens","ones","number"])
            if q_type == "tens":
                qs.append(_q(f"How many tens in {num}?", tens, _opts(tens,3,2)))
            elif q_type == "ones":
                qs.append(_q(f"How many ones in {num}?", ones, _opts(ones,3,2)))
            else:
                qs.append(_q(f"___ tens and ___ ones = what number?\n{tens} tens and {ones} ones",
                             num, _opts(num,3,10)))
        return qs

    @classmethod
    def place_value_100(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            h = random.randint(1,9); t = random.randint(0,9); o = random.randint(0,9)
            num = h*100+t*10+o
            qs.append(_q(f"What is the value of the digit {h} in {num}?", h*100,
                         _opts(h*100,3,100), f"The digit {h} is in the hundreds place."))
        return qs

    @classmethod
    def place_value_1000(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            th = random.randint(1,9); h = random.randint(0,9)
            t = random.randint(0,9); o = random.randint(0,9)
            num = th*1000+h*100+t*10+o
            choices = [
                (f"What is the thousands digit of {num}?", th),
                (f"What is the hundreds digit of {num}?", h),
                (f"Round {num} to the nearest thousand.", round(num,-3)),
            ]
            text, ans = random.choice(choices)
            qs.append(_q(text, ans, _opts(int(ans),3,max(1,int(ans)//5))))
        return qs

    # ── Rounding / Estimation ────────────────────────────────────────────────

    @classmethod
    def rounding_10(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            num = random.randint(11,99)
            ans = round(num, -1)
            qs.append(_q(f"Round {num} to the nearest 10.", ans, _opts(ans,3,10),
                         "Look at the ones digit. ≥5 → round up, <5 → round down."))
        return qs

    @classmethod
    def rounding_100(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            num = random.randint(101,999)
            ans = round(num, -2)
            qs.append(_q(f"Round {num} to the nearest 100.", ans, _opts(ans,3,100),
                         "Look at the tens digit."))
        return qs

    # ── Geometry ─────────────────────────────────────────────────────────────

    @classmethod
    def perimeter(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            shape = random.choice(["square","rectangle","triangle"])
            if shape == "square":
                s = random.randint(3,12); ans = 4*s
                qs.append(_q(f"Find the perimeter of a square with side = {s} cm.",
                             ans, _opts(ans,3,s), f"P = 4 × {s}"))
            elif shape == "rectangle":
                l = random.randint(4,15); w = random.randint(2,10)
                ans = 2*(l+w)
                qs.append(_q(f"Find the perimeter of a rectangle: length = {l} cm, width = {w} cm.",
                             ans, _opts(ans,3,max(l,w)), f"P = 2 × ({l} + {w})"))
            else:
                a,b,c = random.randint(3,10),random.randint(3,10),random.randint(3,10)
                ans = a+b+c
                qs.append(_q(f"Find the perimeter of a triangle with sides {a}, {b}, {c} cm.",
                             ans, _opts(ans,3,5), "Add all three sides."))
        return qs

    @classmethod
    def area_basic(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            rows = random.randint(2,8); cols = random.randint(2,8)
            ans = rows*cols
            qs.append(_q(f"A rectangle has {rows} rows and {cols} columns of squares.\nWhat is the area?",
                         ans, _opts(ans,3,max(4,ans//4)), f"Area = {rows} × {cols} = {ans} sq units"))
        return qs

    @classmethod
    def area_formula(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            shape = random.choice(["rectangle","triangle"])
            if shape == "rectangle":
                l = random.randint(4,20); w = random.randint(3,15)
                ans = l*w
                qs.append(_q(f"Area of a rectangle: length = {l} m, width = {w} m.",
                             ans, _opts(ans,3,max(10,ans//10)), f"A = l × w = {l} × {w}"))
            else:
                b = random.randint(4,16); h = random.randint(3,12)
                ans = b*h//2
                qs.append(_q(f"Area of a triangle: base = {b} cm, height = {h} cm.",
                             ans, _opts(ans,3,max(5,ans//5)), f"A = ½ × b × h = ½ × {b} × {h}"))
        return qs

    @classmethod
    def volume_cuboid(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            l = random.randint(2,10); w = random.randint(2,8); h = random.randint(2,8)
            ans = l*w*h
            qs.append(_q(f"Find the volume of a cuboid: length={l}, width={w}, height={h}.",
                         ans, _opts(ans,3,max(10,ans//8)), f"V = l × w × h = {l}×{w}×{h}"))
        return qs

    @classmethod
    def geometry_circles(cls, n: int) -> List[Dict]:
        qs = []
        PI = 3.14159
        for _ in range(n):
            r = random.randint(3,12)
            kind = random.choice(["circumference","area"])
            if kind == "circumference":
                ans = round(2*PI*r, 1)
                qs.append(_q(f"Find the circumference of a circle with radius = {r} cm. (Use π ≈ 3.14)",
                             ans, None, f"C = 2πr = 2 × 3.14 × {r}", work_space=3))
            else:
                ans = round(PI*r*r, 1)
                qs.append(_q(f"Find the area of a circle with radius = {r} cm. (Use π ≈ 3.14)",
                             ans, None, f"A = πr² = 3.14 × {r}²", work_space=3))
        return qs

    # ── Algebra ──────────────────────────────────────────────────────────────

    @classmethod
    def algebra_basics(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            x = random.randint(2,15)
            op = random.choice(["add","sub","mul"])
            if op == "add":
                c = random.randint(1,20); ans = x+c
                qs.append(_q(f"If x = {x}, what is x + {c}?", ans, _opts(ans,3,max(3,ans//5))))
            elif op == "sub":
                c = random.randint(1,x-1); ans = x-c
                qs.append(_q(f"If x = {x}, what is x − {c}?", ans, _opts(ans,3,3)))
            else:
                c = random.randint(2,9); ans = x*c
                qs.append(_q(f"If x = {x}, what is {c}x?", ans, _opts(ans,3,max(5,ans//8))))
        return qs

    @classmethod
    def algebra_linear(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            x = random.randint(2,20)
            op = random.choice(["add","sub","mul","div"])
            if op == "add":
                c = random.randint(1,30); total = x+c
                qs.append(_q(f"Solve: x + {c} = {total}", x, _opts(x,3,max(3,x//4)),
                             f"Subtract {c} from both sides."))
            elif op == "sub":
                c = random.randint(1,20); total = x-c
                qs.append(_q(f"Solve: x − {c} = {total}", x, _opts(x,3,max(3,x//4)),
                             f"Add {c} to both sides."))
            elif op == "mul":
                c = random.randint(2,9); total = x*c
                qs.append(_q(f"Solve: {c}x = {total}", x, _opts(x,3,max(2,x//3)),
                             f"Divide both sides by {c}."))
            else:
                c = random.randint(2,9); total = x//c if x%c==0 else None
                if total:
                    qs.append(_q(f"Solve: x ÷ {c} = {total}", x, _opts(x,3,max(2,x//5)),
                                 f"Multiply both sides by {c}."))
                else:
                    a = random.randint(2,15); qs.append(_q(f"Solve: x + 5 = {a+5}", a, _opts(a,3,3)))
        return qs

    @classmethod
    def algebra_2step(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            x = random.randint(2,15)
            a = random.randint(2,6); b = random.randint(1,20)
            total = a*x + b
            qs.append(_q(f"Solve: {a}x + {b} = {total}", x, _opts(x,3,max(2,x//3)),
                         f"Step 1: subtract {b}. Step 2: divide by {a}.", work_space=3))
        return qs

    # ── Integers ─────────────────────────────────────────────────────────────

    @classmethod
    def integers_intro(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(-10,10); b = random.randint(-10,10)
            op = random.choice(["+","-"])
            ans = a+b if op=="+" else a-b
            qs.append(_q(f"({a}) {op} ({b}) = ___", ans, _opts(ans,3,3),
                         "Use a number line if needed."))
        return qs

    @classmethod
    def integers_ops(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(-12,12); b = random.randint(-12,12)
            while b == 0: b = random.randint(-12,12)
            op = random.choice(["×","÷"])
            if op == "×":
                ans = a*b
                qs.append(_q(f"({a}) × ({b}) = ___", ans, _opts(ans,3,max(5,abs(ans)//5)),
                             "neg × neg = pos; neg × pos = neg"))
            else:
                ans_f = a/b
                if ans_f == int(ans_f):
                    ans = int(ans_f)
                    qs.append(_q(f"({a}) ÷ ({b}) = ___", ans, _opts(ans,3,max(2,abs(ans))),
                                 "Same signs → positive; different signs → negative"))
                else:
                    ans2 = a*b
                    qs.append(_q(f"({a}) × ({b}) = ___", ans2, _opts(ans2,3,max(5,abs(ans2)//5))))
        return qs

    # ── Order of Operations ──────────────────────────────────────────────────

    @classmethod
    def order_operations(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(2,9); b = random.randint(2,9)
            c = random.randint(1,9); d = random.randint(1,9)
            expr = random.choice([
                (f"{a} + {b} × {c}", a + b*c),
                (f"({a} + {b}) × {c}", (a+b)*c),
                (f"{a} × {b} + {c} × {d}", a*b + c*d),
                (f"{a} × ({b} + {c})", a*(b+c)),
            ])
            text, ans = expr
            qs.append(_q(f"Evaluate: {text}", ans, _opts(ans,3,max(5,abs(ans)//5)),
                         "Remember BODMAS: Brackets → Orders → Divide/Multiply → Add/Subtract"))
        return qs

    # ── Statistics ───────────────────────────────────────────────────────────

    @classmethod
    def mean_median(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            data = sorted([random.randint(1,20) for _ in range(5)])
            kind = random.choice(["mean","median","mode"])
            if kind == "mean":
                ans = sum(data)//len(data) if sum(data)%len(data)==0 else round(sum(data)/len(data),1)
                qs.append(_q(f"Find the mean of: {', '.join(map(str,data))}",
                             ans, None,
                             f"Mean = sum ÷ count = {sum(data)} ÷ {len(data)}"))
            elif kind == "median":
                ans = data[2]
                qs.append(_q(f"Find the median of: {', '.join(map(str,data))}",
                             ans, _opts(ans,3,3),
                             "Median = middle value when sorted."))
            else:
                # force a mode
                mode_val = random.choice(data)
                data.append(mode_val); data.sort()
                qs.append(_q(f"Find the mode of: {', '.join(map(str,data))}",
                             mode_val, _opts(mode_val,3,3),
                             "Mode = most frequent value."))
        return qs

    # ── Ratio / Proportion / Rate ────────────────────────────────────────────

    @classmethod
    def ratio_intro(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(2,8); b = random.randint(2,8)
            item1 = random.choice(["cats","apples","boys","red balls"])
            item2 = random.choice(["dogs","oranges","girls","blue balls"])
            qs.append(_q(
                f"There are {a} {item1} and {b} {item2}. Write the ratio of {item1} to {item2}.",
                f"{a}:{b}", None,
                f"Ratio of {item1} to {item2} = {a}:{b}"))
        return qs

    @classmethod
    def proportions(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            a = random.randint(2,8); b = random.randint(2,8)
            k = random.randint(2,5); ans = a*k
            qs.append(_q(
                f"If {a}/{b} = x/{b*k}, what is x?",
                ans, _opts(ans,3,max(2,ans//4)),
                f"Multiply both sides by {b*k}: x = {a} × {k}"))
        return qs

    # ── Patterns ─────────────────────────────────────────────────────────────

    @classmethod
    def patterns_rule(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            kind = random.choice(["add","mul","sub"])
            start = random.randint(2,20)
            if kind == "add":
                step = random.randint(3,12)
                seq = [start + i*step for i in range(5)]
                ans = start + 5*step
                rule = f"add {step}"
            elif kind == "mul":
                r = random.choice([2,3])
                seq = [start * r**i for i in range(5)]
                ans = start * r**5
                rule = f"multiply by {r}"
            else:
                step = random.randint(2,8)
                seq = [start + 40 - i*step for i in range(5)]
                ans = seq[-1] - step
                rule = f"subtract {step}"
            qs.append(_q(
                f"Find the rule and next number: {', '.join(map(str,seq))}, ___",
                ans, _opts(int(ans),3,max(step if kind!="mul" else start,5)),
                f"Rule: {rule}"))
        return qs

    # ── Prime / Factors ──────────────────────────────────────────────────────

    @classmethod
    def prime_composite(cls, n: int) -> List[Dict]:
        def is_prime(x):
            if x < 2: return False
            for i in range(2, int(x**0.5)+1):
                if x%i==0: return False
            return True
        qs = []
        for _ in range(n):
            num = random.randint(2,50)
            ans = "Prime" if is_prime(num) else "Composite"
            qs.append(_q(f"Is {num} prime or composite?", ans, ["Prime","Composite"],
                         "Prime: only divisible by 1 and itself. Composite: has other factors."))
        return qs

    @classmethod
    def factors_multip(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            kind = random.choice(["factors","multiples","lcm","gcf"])
            if kind == "factors":
                num = random.choice([12,18,24,36,48])
                factors = [i for i in range(1,num+1) if num%i==0]
                qs.append(_q(f"How many factors does {num} have?", len(factors),
                             _opts(len(factors),3,3), f"Factors of {num}: {factors}"))
            elif kind == "multiples":
                num = random.choice([3,4,6,7,8])
                ms = [num*i for i in range(1,7)]
                idx = random.randint(2,5)
                qs.append(_q(f"What is the {['','1st','2nd','3rd','4th','5th','6th'][idx]} multiple of {num}?",
                             ms[idx-1], _opts(ms[idx-1],3,num)))
            elif kind == "lcm":
                a,b = random.sample([2,3,4,5,6],2)
                ans = a*b//math.gcd(a,b)
                qs.append(_q(f"What is the LCM of {a} and {b}?", ans, _opts(ans,3,max(2,ans//3)),
                             "LCM = smallest number divisible by both."))
            else:
                a,b = random.sample([12,18,24,36,48],2)
                ans = math.gcd(a,b)
                qs.append(_q(f"What is the GCF of {a} and {b}?", ans, _opts(ans,3,max(2,ans//2)),
                             "GCF = largest number that divides both."))
        return qs

    @classmethod
    def prime_factors(cls, n: int) -> List[Dict]:
        nums = [12,18,20,24,30,36,40,42,48,60]
        qs = []
        for _ in range(n):
            num = random.choice(nums)
            # prime factorisation as string
            factors = []
            temp = num
            for p in [2,3,5,7,11]:
                while temp % p == 0:
                    factors.append(p); temp //= p
            ans = " × ".join(map(str, factors))
            qs.append(_q(f"Write the prime factorisation of {num}.",
                         ans, None, "Use a factor tree.", work_space=4))
        return qs

    # ── Coordinates / Probability ────────────────────────────────────────────

    @classmethod
    def coordinates(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            x = random.randint(-8,8); y = random.randint(-8,8)
            quadrant = ("I" if x>0 and y>0 else "II" if x<0 and y>0
                        else "III" if x<0 and y<0 else "IV" if x>0 and y<0 else "origin")
            qs.append(_q(f"Point P is at ({x}, {y}). Which quadrant is it in?",
                         quadrant, ["I","II","III","IV"],
                         "Quadrant I: (+,+)  II: (−,+)  III: (−,−)  IV: (+,−)"))
        return qs

    @classmethod
    def probability(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            total = random.choice([4,5,6,8,10,12])
            fav = random.randint(1, total-1)
            g = math.gcd(fav, total)
            ans = f"{fav//g}/{total//g}" if total//g > 1 else "1"
            qs.append(_q(
                f"A bag has {total} balls. {fav} are red. What is the probability of picking a red ball?",
                ans, None,
                f"P = favourable outcomes / total = {fav}/{total}"))
        return qs

    @classmethod
    def probability_adv(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            total_a = random.choice([4,5,6]); fav_a = random.randint(1,total_a-1)
            total_b = random.choice([4,5,6]); fav_b = random.randint(1,total_b-1)
            ans_n = fav_a * fav_b; ans_d = total_a * total_b
            g = math.gcd(ans_n, ans_d)
            ans = f"{ans_n//g}/{ans_d//g}"
            qs.append(_q(
                f"Spinner A has {fav_a} out of {total_a} chances. Spinner B has {fav_b} out of {total_b}.\n"
                f"What is the probability both land on the target?",
                ans, None,
                "Multiply the two probabilities: P(A and B) = P(A) × P(B)"))
        return qs

    # ── Exponents ────────────────────────────────────────────────────────────

    @classmethod
    def exponents(cls, n: int) -> List[Dict]:
        qs = []
        for _ in range(n):
            base = random.randint(2,10); exp = random.randint(2,4)
            ans = base**exp
            qs.append(_q(f"Evaluate: {base}^{exp}", ans, _opts(ans,3,max(10,ans//10)),
                         f"Multiply {base} by itself {exp} times."))
        return qs

    # ── Word Problems ────────────────────────────────────────────────────────

    @classmethod
    def _word_problem_pool(cls, grade_id: int, n: int) -> List[Dict]:
        """Grade-appropriate word problems."""
        problems = []
        name = lambda: random.choice(cls.NAMES)
        item = lambda: random.choice(cls.ITEMS)

        # Grade TK-1 (0-2)
        easy = [
            lambda: (f"{name()} has {(a:=random.randint(2,5))} {item()}. She gets {(b:=random.randint(1,4))} more. How many now?", a+b),
            lambda: (f"{name()} picks {(a:=random.randint(3,8))} flowers. He gives away {(b:=random.randint(1,a-1))}. How many left?", a-b),
            lambda: (f"There are {(a:=random.randint(2,5))} birds in a tree and {(b:=random.randint(1,4))} on the ground. How many birds in all?", a+b),
        ]
        # Grade 2-3 (3-4)
        medium = [
            lambda: (f"{name()} earns ${(a:=random.randint(10,50))} on Monday and ${(b:=random.randint(10,50))} on Tuesday. How much in total?", a+b),
            lambda: (f"A box has {(r:=random.randint(2,6))} rows of {(c:=random.randint(2,6))} {item()}. How many {item()} in all?", r*c),
            lambda: (f"{name()} runs {(a:=random.randint(1,5))} km each day for {(d:=random.randint(3,7))} days. How many km in total?", a*d),
            lambda: (f"There are {(t:=random.randint(20,50))} students. {(g:=random.randint(10,t-5))} are girls. How many are boys?", t-g),
        ]
        # Grade 4+ (5-7)
        hard = [
            lambda: (f"A rectangle has perimeter {(p:=random.choice([24,32,40,48]))} cm and length {(l:=random.randint(5,p//2-2))} cm. What is the width?", p//2-l),
            lambda: (f"{name()} spends {(pct:=random.choice([10,20,25,50]))}% of ${(total:=random.choice([80,100,120,200]))}. How much is that?", total*pct//100),
            lambda: (f"A train travels {(s:=random.choice([60,80,100]))} km/h for {(t:=random.randint(2,5))} hours. How far does it travel?", s*t),
            lambda: (f"Share {(total:=random.choice([84,96,120]))} equally among {(g:=random.choice([4,6,8]))} groups. How many each?", total//g),
        ]

        pool = easy if grade_id <= 2 else (medium if grade_id <= 4 else hard)

        for _ in range(n):
            fn = random.choice(pool)
            try:
                text, ans = fn()
                problems.append(_q(text, ans, _opts(int(ans),3,max(2,int(ans)//5))))
            except Exception:
                pass
        return problems

    # ── Timed Drill ──────────────────────────────────────────────────────────

    @classmethod
    def timed_drill(cls, grade_id: int, n: int = 30) -> List[Dict]:
        """30-fact fluency drill appropriate for grade."""
        qs = []
        if grade_id <= 1:
            for _ in range(n):
                a = random.randint(0,5); b = random.randint(0,5-a)
                op = random.choice(["+","-"])
                if op == "-": a,b = max(a,b), min(a,b)
                ans = a+b if op=="+" else a-b
                qs.append(_q(f"{a} {op} {b} = ___", ans))
        elif grade_id <= 3:
            for _ in range(n):
                a = random.randint(0,10); b = random.randint(0,10)
                op = random.choice(["+","-"])
                if op == "-": a = max(a,b)
                ans = a+b if op=="+" else a-b
                qs.append(_q(f"{a} {op} {b} = ___", ans))
        else:
            for _ in range(n):
                a = random.randint(2,12); b = random.randint(2,12)
                op = random.choice(["×","÷"])
                if op == "÷": a = a*b
                ans = a*b if op=="×" else a//b
                qs.append(_q(f"{a} {op} {b} = ___", ans))
        return qs


# ── topic slug → generator function mapping ────────────────────────────────

REGISTRY: Dict[str, Any] = {
    # Counting
    "counting_1_5":    TopicGenerators.counting_1_5,
    "counting_6_10":   TopicGenerators.counting_1_10,
    "counting_1_10":   TopicGenerators.counting_1_10,
    "counting_20":     TopicGenerators.counting_20,
    "more_less":       TopicGenerators.more_less,
    "even_odd":        TopicGenerators.even_odd,
    "ordinals":        TopicGenerators.ordinals,
    "skip_count_2":    TopicGenerators.skip_count_2,
    "skip_count_5":    TopicGenerators.skip_count_5,
    "skip_count_10":   TopicGenerators.skip_count_10,
    # Addition
    "add_fluency_5":   TopicGenerators.add_fluency_5,
    "add_fluency_10":  TopicGenerators.add_fluency_10,
    "add_to_20":       TopicGenerators.add_to_20,
    "add_doubles":     TopicGenerators.add_doubles,
    "add_near_doubles":TopicGenerators.add_near_doubles,
    "make_ten":        TopicGenerators.make_ten,
    "add_2digit_no_r": TopicGenerators.add_2digit_no_r,
    "add_regroup":     TopicGenerators.add_regroup,
    "add_3digit":      TopicGenerators.add_3digit,
    # Subtraction
    "sub_fluency_5":   TopicGenerators.sub_fluency_5,
    "sub_fluency_10":  TopicGenerators.sub_fluency_10,
    "sub_to_20":       TopicGenerators.sub_to_20,
    "sub_2digit_no_r": TopicGenerators.sub_2digit_no_r,
    "sub_regroup":     TopicGenerators.sub_regroup,
    "sub_3digit":      TopicGenerators.sub_3digit,
    # Multiplication
    "intro_multiply":  TopicGenerators.intro_multiply,
    "times_2_5":       TopicGenerators.times_2_5,
    "times_10":        TopicGenerators.times_10,
    "times_3_4":       TopicGenerators.times_3_4,
    "times_6_7":       TopicGenerators.times_6_7,
    "times_8_9":       TopicGenerators.times_8_9,
    "multiply_2digit": TopicGenerators.multiply_2digit,
    "multiply_3digit": TopicGenerators.multiply_3digit,
    "multiply_2x2":    TopicGenerators.multiply_2x2,
    "arrays":          TopicGenerators.intro_multiply,
    # Division
    "division_basic":  TopicGenerators.division_basic,
    "division_facts":  TopicGenerators.division_facts,
    "long_division":   TopicGenerators.long_division,
    "long_div_rem":    TopicGenerators.long_div_rem,
    # Fractions
    "fractions_half":  TopicGenerators.fractions_half,
    "fractions_third": TopicGenerators.fractions_third,
    "fractions_equiv": TopicGenerators.fractions_equiv,
    "fractions_add":   TopicGenerators.fractions_add,
    "fractions_mult":  TopicGenerators.fractions_mult,
    "fractions_div":   TopicGenerators.fractions_div,
    "fractions_order": TopicGenerators.fractions_equiv,
    "fractions_adv":   TopicGenerators.fractions_div,
    "mixed_numbers":   TopicGenerators.mixed_numbers,
    # Decimals
    "decimals_intro":  TopicGenerators.decimals_intro,
    "decimals_tenths": TopicGenerators.decimals_intro,
    "decimals_compare":TopicGenerators.decimals_intro,
    "decimals_mult":   TopicGenerators.decimals_mult,
    "decimals_div":    TopicGenerators.decimals_div,
    "long_mult_dec":   TopicGenerators.decimals_mult,
    # Percentages
    "percentage_basic":TopicGenerators.percentage_basic,
    "percentage_calc": TopicGenerators.percentage_calc,
    "percentage_adv":  TopicGenerators.percentage_adv,
    # Place Value
    "place_value_tens":TopicGenerators.place_value_tens,
    "place_value_100": TopicGenerators.place_value_100,
    "place_value_1000":TopicGenerators.place_value_1000,
    "teen_numbers":    TopicGenerators.counting_20,
    # Rounding
    "rounding_10":     TopicGenerators.rounding_10,
    "rounding_100":    TopicGenerators.rounding_100,
    "estimation_100":  TopicGenerators.rounding_100,
    # Geometry
    "perimeter":       TopicGenerators.perimeter,
    "area_basic":      TopicGenerators.area_basic,
    "area_formula":    TopicGenerators.area_formula,
    "volume_cuboid":   TopicGenerators.volume_cuboid,
    "geometry_circles":TopicGenerators.geometry_circles,
    "geometry_lines":  TopicGenerators.area_basic,
    "geometry_area":   TopicGenerators.area_formula,
    "surface_area":    TopicGenerators.volume_cuboid,
    "volume_prism":    TopicGenerators.volume_cuboid,
    "symmetry":        TopicGenerators.even_odd,
    "coordinate_geo":  TopicGenerators.coordinates,
    # Algebra
    "algebra_basics":  TopicGenerators.algebra_basics,
    "algebra_linear":  TopicGenerators.algebra_linear,
    "algebra_2step":   TopicGenerators.algebra_2step,
    "order_operations":TopicGenerators.order_operations,
    # Integers
    "integers_intro":  TopicGenerators.integers_intro,
    "integers_ops":    TopicGenerators.integers_ops,
    # Statistics
    "mean_median":     TopicGenerators.mean_median,
    "statistics_adv":  TopicGenerators.mean_median,
    "data_charts":     TopicGenerators.mean_median,
    # Ratio
    "ratio_intro":     TopicGenerators.ratio_intro,
    "ratios_rates":    TopicGenerators.ratio_intro,
    "proportions":     TopicGenerators.proportions,
    "ratio_intro":     TopicGenerators.ratio_intro,
    "word_prob_ratio": TopicGenerators.proportions,
    # Patterns
    "patterns_ab":     TopicGenerators.skip_count_2,
    "patterns_rule":   TopicGenerators.patterns_rule,
    "number_order":    TopicGenerators.counting_20,
    # Prime / Factors
    "prime_composite": TopicGenerators.prime_composite,
    "factors_multip":  TopicGenerators.factors_multip,
    "prime_factors":   TopicGenerators.prime_factors,
    "exponents":       TopicGenerators.exponents,
    # Probability
    "probability":     TopicGenerators.probability,
    "probability_adv": TopicGenerators.probability_adv,
    # Coordinates
    "coordinates":     TopicGenerators.coordinates,
    # Measurement / money / time (mapped to proxies)
    "measurement_cm":  TopicGenerators.perimeter,
    "measurement_m":   TopicGenerators.perimeter,
    "measurement_conv":TopicGenerators.rounding_10,
    "time_hour":       TopicGenerators.ordinals,
    "time_half":       TopicGenerators.ordinals,
    "time_5min":       TopicGenerators.ordinals,
    "time_elapsed":    TopicGenerators.algebra_basics,
    "money_coins":     TopicGenerators.add_fluency_10,
    "graphs_bar":      TopicGenerators.mean_median,
    "data_tally":      TopicGenerators.mean_median,
    "line_graphs":     TopicGenerators.mean_median,
    "number_bonds":    TopicGenerators.make_ten,
    "compare_nums":    TopicGenerators.more_less,
    "size_compare":    TopicGenerators.more_less,
    "shapes_basic":    TopicGenerators.even_odd,
    "shapes_2d":       TopicGenerators.even_odd,
    "shapes_3d":       TopicGenerators.even_odd,
    "angles":          TopicGenerators.even_odd,
    "angles":          TopicGenerators.even_odd,
    # Misc
    "mixed_review":    TopicGenerators.algebra_linear,
    "word_prob_add":   TopicGenerators.add_to_20,
    "word_prob_sub":   TopicGenerators.sub_to_20,
    "word_prob_mult":  TopicGenerators.multiply_2digit,
    "word_prob_div":   TopicGenerators.division_facts,
    "word_prob_2step": TopicGenerators.algebra_2step,
    "word_prob_frac":  TopicGenerators.fractions_add,
    "word_prob_dec":   TopicGenerators.decimals_mult,
    "word_prob_pct":   TopicGenerators.percentage_calc,
    "word_prob_alg":   TopicGenerators.algebra_2step,
}


# ══════════════════════════════════════════════════════════════════════════════
#  PUBLIC API
# ══════════════════════════════════════════════════════════════════════════════

def get_current_week_topic(grade_id: int, week_override: int = None) -> Dict:
    """Return topic meta for the current ISO week (or override)."""
    week = week_override or date.today().isocalendar()[1]
    topics = WEEKLY_TOPICS.get(grade_id, WEEKLY_TOPICS[2])
    idx = (week - 1) % len(topics)
    w, slug, label = topics[idx]
    return {"week": week, "week_in_cycle": w, "slug": slug, "label": label, "grade_id": grade_id}


def generate_daily_sheet(grade_id: int, day: str, topic_slug: str, topic_label: str,
                          week: int = None) -> Dict:
    """
    Generate one day's worksheet.
    day: 'Monday'|'Tuesday'|'Wednesday'|'Thursday'|'Friday'
    Returns dict with sections.
    """
    fn = REGISTRY.get(topic_slug, TopicGenerators.add_to_20)

    # Friday = challenge / assessment (harder, mixed)
    if day == "Friday":
        warm_up    = fn(5)
        skill      = fn(10)
        word_probs = TopicGenerators._word_problem_pool(grade_id, 5)
        return {
            "day": day,
            "week": week,
            "topic_slug": topic_slug,
            "topic_label": topic_label,
            "type": "friday_assessment",
            "sections": {
                "warm_up":         {"title": "⚡ Warm-Up (5 questions)", "questions": warm_up},
                "skill_focus":     {"title": f"📘 {topic_label} Challenge (10 questions)", "questions": skill},
                "word_problems":   {"title": "✏️ Word Problems", "questions": word_probs},
            }
        }

    # Mon-Thu structure
    warm_up    = fn(5)
    skill      = fn(12)
    spiral     = _spiral_review(grade_id, topic_slug, 6)
    word_probs = TopicGenerators._word_problem_pool(grade_id, 3)

    return {
        "day": day,
        "week": week,
        "topic_slug": topic_slug,
        "topic_label": topic_label,
        "type": "daily_worksheet",
        "sections": {
            "warm_up":       {"title": "⚡ Warm-Up (5 questions)", "questions": warm_up},
            "skill_focus":   {"title": f"📘 Skill Focus: {topic_label} (12 questions)", "questions": skill},
            "spiral_review": {"title": "🔄 Spiral Review (6 questions)", "questions": spiral},
            "word_problems": {"title": "✏️ Word Problems (3 questions)", "questions": word_probs},
        }
    }


def generate_timed_drill(grade_id: int) -> Dict:
    """30-problem timed drill for fluency practice."""
    questions = TopicGenerators.timed_drill(grade_id, 30)
    return {
        "type": "timed_drill",
        "grade_id": grade_id,
        "target_seconds": 180,
        "questions": questions,
    }


def generate_weekly_packet(grade_id: int, week_override: int = None) -> Dict:
    """
    Full Mon–Fri weekly math packet for a given grade.
    Returns dict with topic meta + all 5 daily sheets + timed drill.
    """
    topic = get_current_week_topic(grade_id, week_override)
    days  = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    sheets = {}
    for day in days:
        sheets[day] = generate_daily_sheet(
            grade_id, day, topic["slug"], topic["label"], topic["week"]
        )

    return {
        "grade_id":    grade_id,
        "week":        topic["week"],
        "topic_slug":  topic["slug"],
        "topic_label": topic["label"],
        "generated":   date.today().isoformat(),
        "days":        sheets,
        "timed_drill": generate_timed_drill(grade_id),
        "total_questions": sum(
            sum(len(s["questions"]) for s in d["sections"].values())
            for d in sheets.values()
        ),
    }


def _spiral_review(grade_id: int, exclude_slug: str, n: int) -> List[Dict]:
    """Mix of prior-week topics for review."""
    topics = WEEKLY_TOPICS.get(grade_id, WEEKLY_TOPICS[2])
    other_slugs = [t[1] for t in topics if t[1] != exclude_slug]
    if not other_slugs:
        other_slugs = ["add_to_20"]
    qs = []
    per = max(1, n // 3)
    for slug in random.sample(other_slugs, min(3, len(other_slugs))):
        fn = REGISTRY.get(slug, TopicGenerators.add_to_20)
        try:
            qs.extend(fn(per))
        except Exception:
            pass
    return qs[:n]
