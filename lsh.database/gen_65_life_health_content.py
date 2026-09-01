# -*- coding: utf-8 -*-
"""
Generates lsh.database/65_life_health_content.sql — Whole-Child Curriculum
expansion, batch 2: 'life_skills' (Digital Literacy, Financial Literacy,
Time Management, Organization) and 'health' (Anatomy, Food & Healthy
Eating, Exercise & Fitness, Physical Game Instruction). Same pattern as
gen_64_sel_cognitive_content.py — see that file for the helper docstrings.
Run with: python gen_migration_65.py
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
# LIFE SKILLS 1/4: Digital Literacy & Online Safety
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "digital", "subject_area": "life_skills", "category_name": "Digital Literacy & Online Safety", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("How much screen time is a good amount each day?", ["A little bit, with a grown-up's okay", "As much as you want", "All day long"], "A little bit, with a grown-up's okay"),
                q_mc("Before using a screen, you should...", ["Ask a grown-up first", "Just start using it", "Hide it from grown-ups"], "Ask a grown-up first"),
                q_short("Draw or tell: what is your favorite thing to do on a screen?", "Answers will vary."),
                q_mc("If a screen shows something scary, what should you do?", ["Tell a grown-up right away", "Keep watching alone", "Hide it"], "Tell a grown-up right away"),
                q_short("Name one rule your family has about screens.", "Answers will vary."),
                q_mc("Screens are a tool that should be used...", ["With grown-up help and limits", "Without any rules", "Only at night"], "With grown-up help and limits"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("If something online confuses or worries you, who should you ask?", ["A grown-up you trust", "A stranger online", "No one"], "A grown-up you trust"),
                q_mc("It's safe to click on any colorful button online.", ["False — always check with a grown-up first", "True — colorful buttons are always safe", "It doesn't matter"], "False — always check with a grown-up first"),
                q_short("Color or describe a safety poster reminding kids to 'ask a grown-up' before going online.", "Answers will vary."),
                q_mc("If a pop-up says you WON a prize, you should...", ["Close it and tell a grown-up", "Click it right away", "Enter all your information"], "Close it and tell a grown-up"),
                q_short("Why is it important to ask a grown-up before downloading a game or app?", "Grown-ups can check that it's safe and appropriate."),
                q_mc("A trusted grown-up online is someone who...", ["You also know and trust in real life", "Just says they're nice", "You met only through a game"], "You also know and trust in real life"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Sort each website or app example as SAFE or UNSAFE for kids.",
            "questions": [
                q_match("Sort each example.",
                        ["A learning game your teacher assigned", "A site asking for your home address", "An app your parent downloaded for you", "A pop-up asking you to 'chat' with a stranger"],
                        ["Safe", "Unsafe", "Safe", "Unsafe"], [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("A safe website for kids is usually one that...", ["A trusted adult approved or set up for you", "Has a fun-looking cartoon on it", "Doesn't ask you to type anything"], "A trusted adult approved or set up for you"),
                q_short("What is one warning sign that a website might not be safe?", "Answers will vary (e.g., asking for personal info, strangers messaging you)."),
                q_short("Why should you never share your home address online?", "Strangers could find out where you live, which isn't safe."),
                q_mc("If a website asks for your last name and address to 'play a game,' you should...", ["Not enter it and tell a grown-up", "Enter it so you can play", "Make up a fake one"], "Not enter it and tell a grown-up"),
                q_short("Name one website or app you use that you think is safe, and explain why.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn how to keep passwords and personal information safe.",
            "questions": [
                q_mc("A strong password should...", ["Mix letters, numbers, and be hard to guess", "Be your name spelled backward", "Be 'password123'"], "Mix letters, numbers, and be hard to guess"),
                q_mc("You should share your password with...", ["Only a parent/guardian, if needed", "All your friends", "Anyone who asks nicely"], "Only a parent/guardian, if needed"),
                q_short("List 3 pieces of personal information you should NEVER share online without a grown-up's help.", "Answers will vary (e.g., full name, address, school name, phone number)."),
                q_mc("Why shouldn't you use the same password for everything?", ["If one account gets hacked, others could be at risk too", "It's more convenient and has no downside", "Passwords don't actually matter"], "If one account gets hacked, others could be at risk too"),
                q_short("Why might it be tempting to share personal info to 'win a prize' online, and why is that risky?", "It feels exciting, but real companies rarely ask for personal info that way — it's often a scam."),
                q_mc("If a game asks for your parent's credit card number, you should...", ["Stop and ask a grown-up first", "Enter it to keep playing", "Guess a random number"], "Stop and ask a grown-up first"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Learn to spot the warning signs of a scam or phishing email.",
            "questions": [
                q_short("Example email: 'You've WON $1,000! Click here NOW and enter your bank info to claim it!' What makes this look like a scam?", "Urgency, promises of free money, and asking for bank info are classic scam signs."),
                q_mc("A phishing email often tries to make you feel...", ["Rushed or excited so you don't think carefully", "Calm and unhurried", "Bored"], "Rushed or excited so you don't think carefully"),
                q_short("List 3 warning signs of a scam or phishing message.", "Answers will vary (e.g., urgent language, asking for personal info, too-good-to-be-true offers, weird sender address)."),
                q_mc("If you get a suspicious email, the safest first step is to...", ["Not click any links and tell a trusted adult", "Reply asking if it's real", "Click the link to investigate"], "Not click any links and tell a trusted adult"),
                q_short("Why do scammers often pretend to be someone official, like a bank or a prize company?", "People are more likely to trust and respond to messages that seem official."),
                q_mc("A real company asking for your password by email is a...", ["Red flag — real companies rarely ask this way", "Normal, safe request", "Required legal process"], "Red flag — real companies rarely ask this way"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Reflect on your digital footprint — what your online activity says about you.",
            "questions": [
                q_short("What is a 'digital footprint'? Explain in your own words.", "The trail of information about you left behind by your online activity."),
                q_short("Name one thing you've posted or shared online (or would want to) — is it something you'd be okay with a future teacher or employer seeing?", "Answers will vary."),
                q_mc("Which is TRUE about digital footprints?", ["Things posted online can be hard to fully delete later", "Everything posted online disappears after a day", "Digital footprints don't matter for kids"], "Things posted online can be hard to fully delete later"),
                q_short("Why might it matter what you post online, even years from now?", "Future schools, employers, or others might see old posts, so it's worth being thoughtful."),
                q_mc("A helpful rule of thumb before posting something is to ask...", ["'Would I be okay with anyone seeing this?'", "'Will this get the most likes?'", "'Can I delete this in 5 seconds if I want?'"], "'Would I be okay with anyone seeing this?'"),
                q_short("What's one change you could make to keep your digital footprint more positive?", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Practice evaluating whether a website is credible (trustworthy).",
            "questions": [
                q_short("List 3 things you'd check to decide if a website is credible.", "Answers will vary (e.g., author/source listed, recent date, matches other trusted sources, not full of ads/errors)."),
                q_mc("A credible website usually...", ["Clearly states its author or organization and sources", "Has no information about who wrote it", "Uses only ALL CAPS and exclamation points"], "Clearly states its author or organization and sources"),
                q_short("Why is it risky to trust a claim from just ONE website without checking elsewhere?", "That one source could be biased, outdated, or simply wrong."),
                q_mc("Which is a red flag for a website's credibility?", ["No sources, extreme claims, or a strange web address", "A clearly listed publish date", "Links to other reputable sources"], "No sources, extreme claims, or a strange web address"),
                q_short("Pick a topic you're curious about. What would you check before trusting a website's claim about it?", "Answers will vary."),
                q_mc("Checking a website's credibility is most important when...", ["Using the information for something important, like a report or a decision", "Just glancing at a meme", "Never — credibility doesn't matter"], "Using the information for something important, like a report or a decision"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Identify and respond to a cyberbullying scenario.",
            "questions": [
                q_short("Scenario: someone keeps sending a classmate mean messages in a group chat. Is this cyberbullying? Explain.", "Yes — repeated, intentional mean messages online is cyberbullying."),
                q_short("What should the classmate being targeted do first?", "Save evidence, don't respond with more meanness, and tell a trusted adult."),
                q_mc("If you SEE cyberbullying happening to someone else, a helpful response is to...", ["Support the person being targeted and tell a trusted adult", "Join in so you're not the target", "Ignore it completely, it's not your problem"], "Support the person being targeted and tell a trusted adult"),
                q_short("Why might someone cyberbully others online more than they would in person?", "Answers will vary (e.g., feeling anonymous or less accountable behind a screen)."),
                q_mc("Which is the BEST first step if you're being cyberbullied?", ["Don't respond, save the evidence, and tell a trusted adult", "Respond with an even meaner message", "Delete the app and never mention it"], "Don't respond, save the evidence, and tell a trusted adult"),
                q_short("What's one way schools or families could help prevent cyberbullying?", "Answers will vary (e.g., clear rules, open communication, teaching empathy online)."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# LIFE SKILLS 2/4: Financial Literacy
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "finance", "subject_area": "life_skills", "category_name": "Financial Literacy", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Which coin is the penny?", ["1 cent", "5 cents", "10 cents"], "1 cent"),
                q_mc("Which coin is the nickel?", ["5 cents", "1 cent", "25 cents"], "5 cents"),
                q_mc("Which coin is the dime?", ["10 cents", "5 cents", "25 cents"], "10 cents"),
                q_mc("Which coin is the quarter?", ["25 cents", "10 cents", "1 cent"], "25 cents"),
                q_match("Match the coin name to its value.", ["Penny", "Nickel", "Dime", "Quarter"], ["1¢", "5¢", "10¢", "25¢"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_short("Sort some real or pretend coins from smallest value to largest.", "Penny, nickel, dime, quarter."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Sort each item as a NEED or a WANT.",
            "questions": [
                q_match("Sort each item.", ["Food", "A new toy", "A warm coat", "Video games"], ["Need", "Want", "Need", "Want"], [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("A NEED is something...", ["You must have to live and be healthy", "That's just fun to have", "You always get for free"], "You must have to live and be healthy"),
                q_mc("A WANT is something...", ["Nice to have but not required", "You must have to survive", "The same thing as a need"], "Nice to have but not required"),
                q_short("Name one need and one want from your own life.", "Answers will vary."),
                q_mc("Why is it useful to know the difference between needs and wants?", ["It helps you make good choices about money and priorities", "It doesn't matter at all", "Wants are always more important"], "It helps you make good choices about money and priorities"),
                q_short("Draw or describe a want you're saving up for.", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Set a simple saving goal and track it in a jar.",
            "questions": [
                q_short("What is something you'd like to save up for? How much does it cost (a guess is fine)?", "Answers will vary."),
                q_short("If you save $1 a week, how many weeks would it take to save $5?", "5 weeks."),
                q_mc("Saving money means...", ["Putting money aside instead of spending it right away", "Spending all your money immediately", "Giving your money away"], "Putting money aside instead of spending it right away"),
                q_short("Draw a saving jar and mark how full it would be if you've saved half of your goal.", "Answers will vary — should show the jar about half full."),
                q_mc("Why might saving a little at a time be easier than saving it all at once?", ["Small amounts add up over time and are easier to manage", "It's actually harder to save a little at a time", "Saving slowly never works"], "Small amounts add up over time and are easier to manage"),
                q_short("What would you do if you really wanted to spend your savings before reaching your goal?", "Answers will vary (e.g., remind yourself of the goal, wait a few days before deciding)."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice making change for small purchases.",
            "questions": [
                q_fill("You pay with a $1 bill for a $0.75 item. How much change do you get?", "$0.25 (25 cents)"),
                q_fill("You pay with a $5 bill for a $3.50 item. How much change do you get?", "$1.50"),
                q_fill("An item costs $0.60. You pay with 3 quarters. How much change do you get?", "$0.15 (15 cents)"),
                q_short("Explain, in your own words, how you figure out how much change to give back.", "Subtract the price from the amount paid."),
                q_mc("Why is it important for a cashier to make change correctly?", ["So the customer pays the right, fair amount", "Change doesn't actually matter", "To make the register look full"], "So the customer pays the right, fair amount"),
                q_fill("You pay with a $10 bill for a $7.25 item. How much change do you get?", "$2.75"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Build a basic budget for a weekly allowance.",
            "questions": [
                q_short("If you get $5 allowance a week, write a simple budget: how much would you save, spend, and maybe give?", "Answers will vary (e.g., $2 save, $2 spend, $1 give)."),
                q_mc("A budget is...", ["A plan for how you'll use your money", "A list of things you want to buy", "The total amount of money you have"], "A plan for how you'll use your money"),
                q_short("Why might it be smart to plan your budget BEFORE you get your allowance, not after you've already spent it?", "Planning ahead helps you make thoughtful choices instead of spending impulsively."),
                q_mc("If you spend your whole allowance right away every week, what might happen?", ["You won't have money saved for bigger goals later", "Nothing — spending it all is always fine", "You'll automatically get more money"], "You won't have money saved for bigger goals later"),
                q_short("What's one thing you'd want to save toward using part of your allowance each week?", "Answers will vary."),
                q_mc("A good budget usually balances...", ["Saving, spending, and maybe giving", "Spending on only one single thing", "Ignoring how much money you actually have"], "Saving, spending, and maybe giving"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Plan how you'd spend money on wants vs. needs across a month.",
            "questions": [
                q_short("List 3 needs and 3 wants you (or a family) might spend money on in a month.", "Answers will vary."),
                q_short("If you had $50 for the month, how would you split it between needs, wants, and savings? Explain your choices.", "Answers will vary."),
                q_mc("A spending plan mainly helps you...", ["Make sure needs are covered before spending on wants", "Spend as much as possible on wants first", "Avoid ever thinking about money"], "Make sure needs are covered before spending on wants"),
                q_short("What would you do if an unexpected need (like a broken shoe) came up mid-month?", "Answers will vary (e.g., adjust the plan, use savings)."),
                q_mc("Why might someone choose to delay a want in favor of a need?", ["Needs are essential, so they usually come first", "Wants are always more urgent than needs", "It doesn't matter which comes first"], "Needs are essential, so they usually come first"),
                q_short("Reflect: is there a want you've bought before that you later wished you'd saved for something else instead?", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a simple business plan for a lemonade-stand style venture.",
            "questions": [
                q_short("What would your stand sell, and at what price per item?", "Answers will vary."),
                q_short("List your estimated costs (ingredients, cups, sign) and how you'd make sure you earn more than you spend.", "Answers will vary."),
                q_mc("Profit is...", ["The money left after subtracting costs from what you earned", "The total amount of money you took in", "The same thing as your costs"], "The money left after subtracting costs from what you earned"),
                q_short("If your costs are $10 and you sell $25 worth of lemonade, what is your profit?", "$15."),
                q_mc("Why might a business owner track their costs carefully?", ["To make sure they're actually making a profit, not losing money", "Costs don't matter as long as sales happen", "Tracking costs is only for big companies"], "To make sure they're actually making a profit, not losing money"),
                q_short("What would you do with the profit from your stand — save it, spend it, or split it? Explain.", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare saving vs. spending scenarios, and get an intro to simple interest.",
            "questions": [
                q_short("Scenario A: spend $100 today. Scenario B: save $100 in an account earning interest. Explain the trade-off between the two.", "Spending gives immediate benefit; saving grows over time but delays the benefit."),
                q_fill("If you save $100 at 5% simple interest for 1 year, how much interest do you earn?", "$5 (100 x 0.05)"),
                q_mc("Simple interest means...", ["You earn a percentage of your saved amount over time", "Your money never grows in a savings account", "You lose money by saving instead of spending"], "You earn a percentage of your saved amount over time"),
                q_short("Why might a bank pay you interest for keeping your money saved with them?", "They use saved money for other things and pay you for letting them use it."),
                q_mc("Which grows your money over time?", ["Saving in an account that earns interest", "Keeping cash in a piggy bank with no interest", "Both grow money exactly the same amount"], "Saving in an account that earns interest"),
                q_short("Would you rather spend $100 now or save it and have more later? Explain your reasoning.", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# LIFE SKILLS 3/4: Time Management
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "timemgmt", "subject_area": "life_skills", "category_name": "Time Management", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("What do you do first in the morning?", ["Wake up and get dressed", "Go to bed", "Eat dinner"], "Wake up and get dressed"),
                q_mc("What happens right before bedtime?", ["Brushing teeth and pajamas", "Eating breakfast", "Going to school"], "Brushing teeth and pajamas"),
                q_seq("Put a morning routine in order.", ["Wake up", "Get dressed", "Eat breakfast", "Brush teeth"], "Wake up, dress, eat, brush teeth."),
                q_seq("Put a nighttime routine in order.", ["Take a bath", "Put on pajamas", "Brush teeth", "Go to bed"], "Bath, pajamas, brush teeth, bed."),
                q_short("Draw your own morning routine in pictures.", "Answers will vary."),
                q_mc("A routine is...", ["Things you do in the same order each day", "Something you only do once", "A type of food"], "Things you do in the same order each day"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Fill in a simple visual schedule for your day.",
            "questions": [
                q_short("Write or draw 4 things you do on a typical school day, in order.", "Answers will vary."),
                q_mc("A schedule helps you...", ["Know what to do and when", "Forget about time completely", "Do everything all at once"], "Know what to do and when"),
                q_short("What time do you usually wake up, and what time do you usually go to bed?", "Answers will vary."),
                q_mc("If your schedule says 'reading time' after dinner, what should you do then?", ["Read a book", "Watch TV", "Go outside to play"], "Read a book"),
                q_short("Why might having a visual schedule help someone who doesn't read well yet?", "Pictures can show the plan without needing to read words."),
                q_mc("What could you do if something unexpected changes your schedule?", ["Adjust the plan calmly", "Get upset and refuse to do anything", "Ignore the rest of the day completely"], "Adjust the plan calmly"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Fill in a weekly routine chart with school, chores, and play.",
            "questions": [
                q_short("List one activity you do every single day of the week.", "Answers will vary (e.g., homework, brushing teeth)."),
                q_short("List one activity you only do on weekends.", "Answers will vary."),
                q_mc("A weekly routine chart is useful because...", ["It shows the whole week's plan at a glance", "It only shows one single day", "It replaces the need for any planning"], "It shows the whole week's plan at a glance"),
                q_short("What's a day of your week that feels the busiest? What's on it?", "Answers will vary."),
                q_mc("If your chart shows 'chores' every day but you keep forgetting, what could help?", ["Put the chart somewhere you'll see it often", "Stop making a chart at all", "Do chores only when you remember by chance"], "Put the chart somewhere you'll see it often"),
                q_short("Fill in your own simple weekly routine chart with at least 3 activities for 3 different days.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Estimate how long a task will take, then compare to how long it actually took.",
            "questions": [
                q_short("Pick a task (like cleaning your room). Estimate how long you think it will take.", "Answers will vary."),
                q_short("After actually doing the task, write how long it ACTUALLY took.", "Answers will vary."),
                q_mc("If your estimate was way off from the actual time, that means...", ["You've learned something useful for estimating next time", "You did something wrong", "Estimating doesn't matter at all"], "You've learned something useful for estimating next time"),
                q_short("Why is it useful to practice estimating how long tasks take?", "It helps you plan your day more realistically and avoid running out of time."),
                q_mc("People often UNDERESTIMATE how long tasks take. Why might that happen?", ["They forget about small interruptions or extra steps", "Tasks always take exactly as long as expected", "Estimating too low never causes problems"], "They forget about small interruptions or extra steps"),
                q_short("Pick a NEW task and estimate its time. Try it and compare — were you closer this time?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Build a schedule balancing homework, chores, and play.",
            "questions": [
                q_short("List your homework, chores, and play activities for one day, then arrange them into a schedule.", "Answers will vary."),
                q_mc("A balanced schedule usually includes...", ["Time for responsibilities AND time for fun/rest", "Only schoolwork, nothing else", "Only free time, no responsibilities"], "Time for responsibilities AND time for fun/rest"),
                q_short("What would you do if homework took longer than you planned and cut into your play time?", "Answers will vary (e.g., adjust remaining tasks, prioritize what's most important)."),
                q_mc("Why put chores BEFORE play in a schedule, for many people?", ["Finishing responsibilities first can make play time feel more relaxed", "Chores should always come last", "The order never matters"], "Finishing responsibilities first can make play time feel more relaxed"),
                q_short("Design a realistic schedule for a Saturday that includes at least one chore, one homework/study block, and one fun activity.", "Answers will vary."),
                q_mc("A good schedule should be...", ["Realistic — something you can actually follow", "As packed as possible with no breaks", "Exactly the same every single day forever"], "Realistic — something you can actually follow"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Sort tasks using a priority matrix: urgent vs. important.",
            "questions": [
                q_match("Sort each task by urgency/importance category.",
                        ["A test tomorrow you haven't studied for", "Organizing your bookshelf someday", "A permission slip due today", "Learning a new hobby, no deadline"],
                        ["Urgent & important", "Not urgent, less important", "Urgent & important", "Not urgent, less important"],
                        [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("'Urgent' means...", ["It needs attention very soon", "It's not very important", "It can wait forever"], "It needs attention very soon"),
                q_mc("'Important' means...", ["It really matters for your goals or responsibilities", "It has a strict deadline", "It's something fun to do"], "It really matters for your goals or responsibilities"),
                q_short("List one task that's urgent AND important, and one that's neither, from your own life.", "Answers will vary."),
                q_mc("Which should usually get done FIRST?", ["Tasks that are both urgent and important", "Tasks that are neither urgent nor important", "Whatever task is most fun"], "Tasks that are both urgent and important"),
                q_short("Why might people waste time on 'not urgent, not important' tasks instead of important ones?", "Answers will vary (e.g., they're easier or more fun in the moment)."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Build a weekly planner that tracks deadlines across several classes or activities.",
            "questions": [
                q_short("List 3 upcoming deadlines (real or made up) across different subjects or activities.", "Answers will vary."),
                q_short("Arrange those 3 deadlines into a weekly planner, working backward to figure out when to start each one.", "Answers will vary."),
                q_mc("Working backward from a deadline helps you...", ["Figure out when you actually need to start", "Wait until the last minute automatically", "Ignore the deadline until it's too late"], "Figure out when you actually need to start"),
                q_short("What would you do if two big deadlines landed on the exact same day?", "Answers will vary (e.g., start both earlier, prioritize by importance)."),
                q_mc("A weekly planner with deadlines is most useful when it's...", ["Checked and updated regularly, not just made once", "Made once and never looked at again", "Only for very important people"], "Checked and updated regularly, not just made once"),
                q_short("What's one strategy you use (or could use) to avoid procrastinating on a deadline?", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a multi-project time-blocking planner.",
            "questions": [
                q_short("List 3 different projects or responsibilities you're juggling (real or made up).", "Answers will vary."),
                q_short("Time-block a single day, assigning specific blocks of time to each project.", "Answers will vary."),
                q_mc("Time-blocking means...", ["Assigning specific chunks of time to specific tasks", "Working on everything at once, unplanned", "Avoiding a schedule entirely"], "Assigning specific chunks of time to specific tasks"),
                q_short("Why might switching between many tasks without blocks of focus actually slow you down?", "Constant switching can make it harder to focus deeply on any one task."),
                q_mc("If one time block runs over, what's a good response?", ["Adjust the rest of the day's blocks realistically", "Panic and abandon the whole schedule", "Pretend the overrun didn't happen"], "Adjust the rest of the day's blocks realistically"),
                q_short("How would you build in buffer time for unexpected interruptions in a time-blocked schedule?", "Answers will vary (e.g., leave small gaps between blocks)."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# LIFE SKILLS 4/4: Organization
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "organize", "subject_area": "life_skills", "category_name": "Organization", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_match("Match each item to its 'home'.", ["Backpack", "Lunchbox", "Jacket", "Shoes"], ["Cubby hook", "Lunch shelf", "Coat hook", "Shoe bin"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("Where should your backpack go when you get home?", ["Its usual spot, like a hook or shelf", "Anywhere on the floor", "In the kitchen sink"], "Its usual spot, like a hook or shelf"),
                q_short("Why is it helpful for things to have their own special spot?", "It's easier to find them later."),
                q_mc("If you can't find your shoes, what probably happened?", ["They weren't put back in their spot", "Shoes disappear on their own", "It doesn't matter, just wear different ones"], "They weren't put back in their spot"),
                q_short("Draw a picture of where 3 of your things belong at home.", "Answers will vary."),
                q_mc("Putting things back where they belong is called...", ["Being organized", "Being messy", "Being tired"], "Being organized"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Make a checklist to help you pack your backpack.",
            "questions": [
                q_short("List 4 things that should go in your backpack for school.", "Answers will vary (e.g., homework, pencil case, lunch, water bottle)."),
                q_mc("A checklist helps you...", ["Remember everything without forgetting something", "Take longer to get ready", "Skip important steps"], "Remember everything without forgetting something"),
                q_short("What could happen if you forget your homework at home?", "You might not be able to turn it in on time."),
                q_mc("When is the best time to check your packing checklist?", ["The night before or morning of, before leaving", "After you've already left home", "Only once a month"], "The night before or morning of, before leaving"),
                q_short("Make your own simple backpack checklist with checkboxes.", "Answers will vary."),
                q_mc("If you always forget the same item, what could help?", ["Put it at the top of your checklist as a reminder", "Just accept you'll always forget it", "Stop using a checklist"], "Put it at the top of your checklist as a reminder"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Use an assignment tracker to check off homework as you finish it.",
            "questions": [
                q_short("List 3 assignments (real or made up) you have this week.", "Answers will vary."),
                q_mc("An assignment tracker mainly helps you...", ["See what's done and what's still left to do", "Do your assignments for you", "Forget about your assignments"], "See what's done and what's still left to do"),
                q_short("Why is it satisfying to check off a finished assignment on a tracker?", "It shows real progress and helps you see what's left."),
                q_mc("When should you update your assignment tracker?", ["Right after finishing each assignment", "Only at the very end of the week", "Never — just remember it in your head"], "Right after finishing each assignment"),
                q_short("Draw or make your own simple assignment tracker with boxes to check off.", "Answers will vary."),
                q_mc("If your tracker shows 2 assignments still unchecked, what should you do?", ["Finish them soon so nothing is missed", "Ignore the tracker", "Erase them from the list without doing them"], "Finish them soon so nothing is missed"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Build a checklist for keeping your weekly folder/binder organized.",
            "questions": [
                q_short("List 3 things that should be organized in a school binder or folder.", "Answers will vary (e.g., homework, graded papers, notes)."),
                q_mc("How often should you clean out and organize your folder?", ["Regularly, like once a week", "Only at the end of the school year", "Never"], "Regularly, like once a week"),
                q_short("What problem can happen if papers just get shoved into a folder without any order?", "Important papers (like homework due tomorrow) can get lost or hard to find."),
                q_mc("A good way to organize a binder is to...", ["Use labeled sections or dividers for different subjects", "Put everything in one big pile", "Never take anything out, ever"], "Use labeled sections or dividers for different subjects"),
                q_short("Design a simple weekly checklist to keep your binder/folder tidy.", "Answers will vary."),
                q_mc("Why might a messy folder make homework take longer?", ["You'd waste time searching for the right paper", "Mess never affects how long things take", "Messy folders are actually faster to use"], "You'd waste time searching for the right paper"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Use an assignment planner to track due dates.",
            "questions": [
                q_short("List 3 assignments (real or made up) with their due dates.", "Answers will vary."),
                q_mc("An assignment planner mainly helps you...", ["Keep track of what's due and when", "Do your assignments for you", "Forget about deadlines completely"], "Keep track of what's due and when"),
                q_short("How would you decide which assignment to work on FIRST if you had 3 due this week?", "Answers will vary (e.g., whichever is due soonest, or takes longest)."),
                q_mc("What should you do right after receiving a new assignment?", ["Write it in your planner with its due date", "Forget about it until the day it's due", "Only remember it if a friend reminds you"], "Write it in your planner with its due date"),
                q_short("Design your own simple assignment planner page for one week.", "Answers will vary."),
                q_mc("Checking your planner regularly (not just once) helps you...", ["Notice upcoming deadlines with enough time to prepare", "Waste time for no reason", "Nothing — checking once is always enough"], "Notice upcoming deadlines with enough time to prepare"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design an organized study space.",
            "questions": [
                q_short("Describe (or draw) your ideal study space. What's in it?", "Answers will vary."),
                q_mc("A good study space usually has...", ["Good lighting, minimal distractions, and needed supplies nearby", "As many distractions as possible", "No supplies at all, just a chair"], "Good lighting, minimal distractions, and needed supplies nearby"),
                q_short("What's one distraction in your current study space, and how could you reduce it?", "Answers will vary."),
                q_mc("Why might having supplies (pencils, paper) already organized nearby help you study?", ["You won't waste time getting up to search for them", "Supplies don't actually matter for studying", "It's better to search for supplies mid-task"], "You won't waste time getting up to search for them"),
                q_short("Design a simple plan to reorganize your current study space, listing 3 changes you'd make.", "Answers will vary."),
                q_mc("A consistent study space (used regularly) can help because...", ["Your brain starts to associate that space with focus", "Location never affects focus", "It's better to study in a different random place every time"], "Your brain starts to associate that space with focus"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Track a long-term project using steps and deadlines.",
            "questions": [
                q_short("Pick a long-term project (real school project or made up). Break it into at least 4 steps.", "Answers will vary."),
                q_short("Assign a rough deadline to each of your 4 steps, working backward from the final due date.", "Answers will vary."),
                q_mc("Breaking a big project into steps with deadlines mainly helps you...", ["Avoid cramming everything at the very end", "Finish faster with no real planning", "Make the project take longer overall"], "Avoid cramming everything at the very end"),
                q_short("What would you do if you fell behind on one of your project's steps?", "Answers will vary (e.g., adjust the remaining timeline, focus extra effort)."),
                q_mc("A long-term project tracker is most useful when...", ["You check and update it regularly as you go", "You make it once and never look at it again", "The project has no real deadline"], "You check and update it regularly as you go"),
                q_short("Design a simple tracker table with columns for step, deadline, and done/not done.", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design your own personal organization system: planner plus digital calendar.",
            "questions": [
                q_short("Describe your ideal organization system. What would go in a paper planner vs. a digital calendar?", "Answers will vary."),
                q_short("Why might using BOTH a paper planner and a digital calendar work well for some people?", "Answers will vary (e.g., paper for quick notes, digital for reminders/alerts)."),
                q_mc("A personal organization system should be...", ["Something you'll actually keep using consistently", "As complicated as possible", "Copied exactly from someone else with no changes"], "Something you'll actually keep using consistently"),
                q_short("What's one habit (like a nightly 5-minute check-in) that could help you stick to your system?", "Answers will vary."),
                q_mc("If a system is too complicated to maintain, what usually happens?", ["People stop using it", "It automatically becomes more effective", "Complexity never causes problems"], "People stop using it"),
                q_short("Design your personal system: list the 2-3 tools you'd use and how each one fits into your routine.", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# HEALTH 1/4: Anatomy & the Human Body
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "anatomy", "subject_area": "health", "category_name": "Anatomy & the Human Body", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Which body part do you see with?", ["Eyes", "Ears", "Feet"], "Eyes"),
                q_mc("Which body part do you hear with?", ["Ears", "Eyes", "Hands"], "Ears"),
                q_mc("Which body part do you walk with?", ["Legs", "Arms", "Head"], "Legs"),
                q_mc("Which body part do you hold things with?", ["Hands", "Feet", "Ears"], "Hands"),
                q_match("Match the body part to its picture location.", ["Head", "Arms", "Legs", "Tummy"], ["Top of body", "Sides of body", "Bottom of body", "Middle of body"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_short("Point to and name 3 body parts on yourself.", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Match each of your five senses to the body part that does it.",
            "questions": [
                q_match("Match each sense to its body part.", ["See", "Hear", "Smell", "Taste", "Touch"], ["Eyes", "Ears", "Nose", "Tongue", "Skin"], [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]]),
                q_mc("How many senses do people have?", ["5", "3", "10"], "5"),
                q_short("Which sense do you use to smell fresh cookies baking?", "Smell (nose)."),
                q_mc("Which sense helps you know if water is hot or cold?", ["Touch", "Taste", "Hearing"], "Touch"),
                q_short("Name your favorite thing to look at, listen to, and taste.", "Answers will vary."),
                q_mc("Why are our five senses important?", ["They help us understand and stay safe in the world around us", "They're just for fun, not useful", "We only really need one sense"], "They help us understand and stay safe in the world around us"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn what different body parts do — their 'jobs.'",
            "questions": [
                q_match("Match the body part to its job.", ["Eyes", "Ears", "Nose", "Mouth", "Legs"], ["See", "Hear", "Smell", "Talk and eat", "Walk and run"], [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]]),
                q_short("What is the job of your lungs?", "They help you breathe."),
                q_mc("What is the job of your heart?", ["Pump blood through your body", "Help you see", "Help you smell"], "Pump blood through your body"),
                q_short("Why does your body need many different parts each doing a different job?", "Each part has a special task, and together they help your whole body work."),
                q_mc("What is the job of your brain?", ["Control your whole body and help you think", "Only help you breathe", "Only help you walk"], "Control your whole body and help you think"),
                q_short("Pick one body part and describe its job in your own words.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn about bones and muscles working together.",
            "questions": [
                q_mc("Bones give your body its...", ["Shape and support", "Ability to smell", "Sense of taste"], "Shape and support"),
                q_mc("Muscles help your body...", ["Move", "Digest food", "See colors"], "Move"),
                q_short("Why do bones and muscles need to work TOGETHER for you to move?", "Muscles pull on bones to create movement — neither could move you alone."),
                q_mc("The skeleton is made up of...", ["All the bones in your body", "All the muscles in your body", "Only the bones in your arms"], "All the bones in your body"),
                q_short("Name one activity that uses a lot of your muscles.", "Answers will vary (e.g., running, climbing)."),
                q_mc("Why is it important to protect your bones (like wearing a helmet)?", ["Bones can break, and protecting them helps keep your body safe", "Bones can't ever be hurt", "Bones aren't actually important"], "Bones can break, and protecting them helps keep your body safe"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn about major organs and what they do.",
            "questions": [
                q_match("Match the organ to its job.", ["Heart", "Lungs", "Stomach", "Brain"], ["Pumps blood", "Helps you breathe", "Digests food", "Controls the body"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_short("What happens to food after you swallow it and it reaches your stomach?", "Your stomach breaks the food down so your body can use its nutrients."),
                q_mc("Which organ pumps blood through your whole body?", ["Heart", "Stomach", "Lungs"], "Heart"),
                q_short("Why do you need your lungs to breathe?", "They take in oxygen from the air and remove carbon dioxide from your blood."),
                q_mc("Organs are...", ["Body parts that each do an important job to keep you alive", "Just for decoration inside the body", "Only found in adults, not kids"], "Body parts that each do an important job to keep you alive"),
                q_short("Pick one major organ and describe why it's important.", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Follow food's journey through the digestive system.",
            "questions": [
                q_seq("Put the steps of digestion in order.", ["Food enters your mouth and gets chewed", "Food travels down your esophagus to your stomach", "Your stomach breaks the food down further", "Your intestines absorb nutrients from the food", "Leftover waste leaves your body"], "Mouth, esophagus, stomach, intestines, waste."),
                q_short("Why does your mouth start the digestion process by chewing?", "Chewing breaks food into smaller pieces that are easier to digest."),
                q_mc("The esophagus is the tube that...", ["Carries food from your mouth to your stomach", "Pumps blood through your body", "Helps you see"], "Carries food from your mouth to your stomach"),
                q_short("What do your intestines do with the nutrients from digested food?", "They absorb the nutrients into your bloodstream so your body can use them."),
                q_mc("Why does the body need to remove waste after digestion?", ["The body only keeps what it can use and gets rid of the rest", "Waste is actually more useful than the nutrients", "The body never removes anything"], "The body only keeps what it can use and gets rid of the rest"),
                q_short("Draw or describe food's full journey through the digestive system, from mouth to the end.", "Answers will vary — should follow the correct sequence."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Match human body systems to what they do.",
            "questions": [
                q_match("Match each body system to its main job.", ["Circulatory system", "Respiratory system", "Skeletal system", "Digestive system"], ["Moves blood around the body", "Handles breathing", "Provides structure and support", "Breaks down food"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_short("Which system includes your heart and blood vessels?", "The circulatory system."),
                q_mc("Which system includes your lungs?", ["Respiratory system", "Skeletal system", "Digestive system"], "Respiratory system"),
                q_short("How do the circulatory and respiratory systems work together?", "The respiratory system brings in oxygen, and the circulatory system carries it through the body in the blood."),
                q_mc("Why is it useful to think of the body as a set of 'systems'?", ["It helps organize how different parts work together for a shared purpose", "Systems have nothing to do with each other", "The body doesn't really have systems"], "It helps organize how different parts work together for a shared purpose"),
                q_short("Pick one body system and list 2 organs that are part of it.", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Research and write a mini-report on one body system.",
            "questions": [
                q_short("Pick a body system to research (circulatory, respiratory, skeletal, digestive, muscular, or nervous).", "Answers will vary."),
                q_short("List 3 facts you learned about your chosen system.", "Answers will vary."),
                q_short("What is the MAIN function of your chosen system?", "Answers will vary depending on chosen system."),
                q_mc("A good mini-report should include...", ["Accurate facts organized clearly", "Only your own opinions with no facts", "Random unrelated information"], "Accurate facts organized clearly"),
                q_short("How does your chosen system connect or work with at least one other body system?", "Answers will vary (e.g., circulatory and respiratory systems work together to deliver oxygen)."),
                q_short("Write a short conclusion: why is your chosen system important for staying healthy?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# HEALTH 2/4: Food & Healthy Eating Awareness
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "nutrition", "subject_area": "health", "category_name": "Food & Healthy Eating Awareness", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_match("Sort each food as HEALTHY or TREAT.", ["Apple", "Candy", "Carrot", "Cookie"], ["Healthy", "Treat", "Healthy", "Treat"], [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("Which is a healthy snack?", ["An apple", "A candy bar", "A soda"], "An apple"),
                q_mc("Treats should be eaten...", ["Sometimes, not every meal", "For every meal", "Instead of healthy food"], "Sometimes, not every meal"),
                q_short("Name one healthy food you like to eat.", "Answers will vary."),
                q_short("Name one treat food you enjoy sometimes.", "Answers will vary."),
                q_mc("Eating healthy foods helps your body...", ["Grow strong and stay healthy", "Feel worse", "Do nothing at all"], "Grow strong and stay healthy"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn about MyPlate: fruits, veggies, grains, and protein.",
            "questions": [
                q_mc("MyPlate shows food in groups. Name one group.", ["Fruits", "Candy", "Soda"], "Fruits"),
                q_mc("Which food is a grain?", ["Bread", "Apple", "Chicken"], "Bread"),
                q_mc("Which food is a protein?", ["Chicken", "Bread", "Apple"], "Chicken"),
                q_short("Color a plate showing fruits, veggies, grains, and protein in different sections.", "Answers will vary."),
                q_mc("Which food is a vegetable?", ["Carrot", "Cheese", "Bread"], "Carrot"),
                q_short("Why might a plate with only ONE food group not be very healthy?", "Your body needs different nutrients that come from different food groups."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Build a balanced plate with foods from every group.",
            "questions": [
                q_short("Design a balanced meal with a fruit, a vegetable, a grain, and a protein.", "Answers will vary."),
                q_mc("A balanced plate includes...", ["A mix of different food groups", "Only one food group", "Only treats and dessert"], "A mix of different food groups"),
                q_short("Why might it be unhealthy to eat only protein and no vegetables at every meal?", "Your body needs nutrients from many food groups, not just one."),
                q_mc("Which meal is MORE balanced?", ["Chicken, rice, and broccoli", "Only candy and soda", "Only chips"], "Chicken, rice, and broccoli"),
                q_short("Look at a meal you ate recently. Which food groups were included, and which were missing?", "Answers will vary."),
                q_mc("Building a balanced plate helps your body...", ["Get a variety of nutrients it needs", "Get bored of the same food", "Only taste sweet things"], "Get a variety of nutrients it needs"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Sort foods into groups and practice 'eating the rainbow.'",
            "questions": [
                q_match("Sort each food into its food group.", ["Broccoli", "Rice", "Chicken", "Milk"], ["Vegetable", "Grain", "Protein", "Dairy"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_short("'Eating the rainbow' means eating fruits and veggies of different colors. Name 3 different-colored foods.", "Answers will vary (e.g., red strawberries, orange carrots, green spinach)."),
                q_mc("Why might different-colored fruits and veggies have different nutrients?", ["Different colors often come from different vitamins and nutrients", "Color has nothing to do with nutrients", "All fruits and veggies have identical nutrients"], "Different colors often come from different vitamins and nutrients"),
                q_short("Plan a meal that includes at least 3 different food-group colors.", "Answers will vary."),
                q_mc("Sorting foods into groups mainly helps you...", ["Notice if your diet is missing a whole group", "Make food taste different", "Nothing useful"], "Notice if your diet is missing a whole group"),
                q_short("What's a colorful fruit or vegetable you haven't tried before that you'd like to try?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Read a simple nutrition label.",
            "questions": [
                q_short("On a nutrition label, what does 'serving size' tell you?", "How much of the food counts as one serving — all the other numbers are based on that amount."),
                q_mc("If a label shows 20g of sugar per serving, that number tells you...", ["How much sugar is in one serving of the food", "How many calories are in the food", "How much the food costs"], "How much sugar is in one serving of the food"),
                q_short("Why might comparing nutrition labels of two similar snacks help you make a healthier choice?", "It lets you see which one has more sugar, fewer nutrients, etc., so you can compare."),
                q_mc("Nutrition labels usually list ingredients in order of...", ["Amount — most first, least last", "Alphabetical order", "Random order"], "Amount — most first, least last"),
                q_short("Look at a food label at home (or imagine one). What's one thing it tells you about the food?", "Answers will vary."),
                q_mc("Why is it useful to check nutrition labels before buying packaged food?", ["It helps you know what's really in the food", "Labels never have useful information", "Only adults need to read labels"], "It helps you know what's really in the food"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Plan a healthy lunch using food groups.",
            "questions": [
                q_short("Plan a full healthy lunch, listing one item from each major food group.", "Answers will vary."),
                q_mc("A healthy lunch plan should balance...", ["Variety and portion size across food groups", "Only your favorite foods, regardless of group", "As much sugar as possible"], "Variety and portion size across food groups"),
                q_short("Why might planning your lunch ahead of time lead to healthier choices than deciding last-minute?", "Planning ahead avoids grabbing whatever's fastest or least healthy in the moment."),
                q_mc("Which is a healthier lunch swap?", ["Water instead of soda", "More candy instead of fruit", "Chips instead of any vegetable"], "Water instead of soda"),
                q_short("What's one small change you could make to your typical lunch to make it more balanced?", "Answers will vary."),
                q_mc("Why include protein in a lunch plan?", ["It helps keep you full and gives your body important nutrients", "Protein has no real benefit", "Only dinner needs protein"], "It helps keep you full and gives your body important nutrients"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare packaged foods to whole foods.",
            "questions": [
                q_short("Compare a packaged snack (like chips) to a whole food (like an apple). What's different about their ingredients?", "Whole foods usually have one simple ingredient; packaged foods often have many added ones."),
                q_mc("A 'whole food' is...", ["Food in its natural, unprocessed form", "Food that comes in a big package", "Any food with added sugar"], "Food in its natural, unprocessed form"),
                q_short("Why might a packaged food have a very long ingredient list compared to a whole food?", "Processing often adds preservatives, flavors, and other ingredients."),
                q_mc("Which is generally closer to a whole food?", ["A fresh orange", "Orange-flavored candy", "Orange soda"], "A fresh orange"),
                q_short("Does eating packaged foods sometimes mean you're eating unhealthy? Explain your reasoning.", "Not always — some packaged foods are healthy, but it's worth checking labels and considering whole-food options too."),
                q_mc("Why might a mix of whole foods AND some packaged convenience foods be realistic for most people?", ["Whole foods are ideal, but convenience and variety matter too in real life", "Only 100% whole foods should ever be eaten", "Packaged foods are always better"], "Whole foods are ideal, but convenience and variety matter too in real life"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a full week of balanced meals with label-reading.",
            "questions": [
                q_short("Plan breakfast, lunch, and dinner for one day, including at least one food from each major group at each meal.", "Answers will vary."),
                q_short("Pick one packaged food you'd include in your week's plan. What would you check on its nutrition label?", "Answers will vary (e.g., sugar content, serving size, ingredient list)."),
                q_mc("Planning a full week of meals in advance mainly helps you...", ["Make sure your diet stays balanced over time, not just one meal", "Guarantee every single meal is perfect", "Avoid ever needing to think about food again"], "Make sure your diet stays balanced over time, not just one meal"),
                q_short("Why might planning meals for a whole WEEK (not just one day) reveal patterns a single day wouldn't show?", "You might notice you're repeating unhealthy choices, or missing a food group across several days."),
                q_mc("A realistic weekly meal plan should include...", ["Mostly balanced meals, with room for occasional treats", "Only treats, no balanced meals at all", "The exact same meal every single day"], "Mostly balanced meals, with room for occasional treats"),
                q_short("Reflect: what's one healthy habit from this project you'd actually like to try in real life?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# HEALTH 3/4: Exercise & Fitness
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "exercise", "subject_area": "health", "category_name": "Exercise & Fitness", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("How does a bunny move?", ["Hop", "Slither", "Fly"], "Hop"),
                q_mc("How does a bird move?", ["Fly", "Hop", "Swim"], "Fly"),
                q_mc("How does a fish move?", ["Swim", "Hop", "Fly"], "Swim"),
                q_short("Show or describe how you would move like your favorite animal.", "Answers will vary."),
                q_mc("Moving your body like an animal is a fun way to...", ["Exercise and be active", "Stay completely still", "Fall asleep"], "Exercise and be active"),
                q_short("Name one way you like to move your body and have fun.", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice a simple stretching routine.",
            "questions": [
                q_mc("Stretching before exercise helps your body...", ["Get ready to move safely", "Get more tired", "Fall asleep"], "Get ready to move safely"),
                q_short("Name one stretch you can do (like touching your toes).", "Answers will vary."),
                q_mc("You should stretch...", ["Slowly and gently", "As fast as possible", "By jumping hard"], "Slowly and gently"),
                q_short("Draw or describe 3 stretches in a simple stretching routine.", "Answers will vary."),
                q_mc("If a stretch hurts, what should you do?", ["Stop and ease off", "Push harder through the pain", "Ignore it"], "Stop and ease off"),
                q_short("Why is stretching a helpful habit before playing sports or running?", "It helps warm up your muscles and can help prevent injury."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Keep a daily movement log tracking how you move each day.",
            "questions": [
                q_short("Log 3 ways you moved your body today (jump, run, dance, walk, etc.).", "Answers will vary."),
                q_mc("A movement log helps you...", ["Notice how active you are each day", "Forget about being active", "Track what you eat"], "Notice how active you are each day"),
                q_short("What's your favorite way to move and be active?", "Answers will vary."),
                q_mc("Which counts as 'movement' for your log?", ["Dancing, jumping, running, or walking", "Only formal sports practice", "Sitting still"], "Dancing, jumping, running, or walking"),
                q_short("Why might it be good to move your body in different ways, not just one activity?", "Different movements use different muscles and keep exercise fun and varied."),
                q_mc("How often should kids try to be physically active?", ["Most days, in fun ways", "Once a year", "Never — rest is always better"], "Most days, in fun ways"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Check your heart rate before and after exercise.",
            "questions": [
                q_short("Feel your pulse (or place a hand on your chest) while resting. Describe what you notice.", "Answers will vary (e.g., a slow, steady beat)."),
                q_mc("After exercising, your heart rate usually...", ["Goes up (beats faster)", "Goes down (beats slower)", "Stays exactly the same"], "Goes up (beats faster)"),
                q_short("Why does your heart beat faster when you exercise?", "Your muscles need more oxygen, so your heart pumps faster to deliver it."),
                q_mc("A faster heart rate during exercise means...", ["Your heart is working harder to help your body move", "Something is wrong with you", "Exercise isn't working"], "Your heart is working harder to help your body move"),
                q_short("Do some jumping jacks, then check your heart rate again. How did it change?", "Answers will vary — should show an increase after exercise."),
                q_mc("Why is it healthy to raise your heart rate through exercise regularly?", ["It helps strengthen your heart over time", "It's always bad for your heart", "It has no effect on your body"], "It helps strengthen your heart over time"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Build your own warm-up routine before exercise.",
            "questions": [
                q_seq("Put a warm-up routine in a sensible order.", ["Light movement (like marching in place)", "Dynamic stretches (like arm circles)", "A few practice moves of the activity you're about to do"], "Light movement, dynamic stretches, practice moves."),
                q_mc("A warm-up routine's main purpose is to...", ["Prepare your muscles and heart for exercise", "Make you more tired before exercising", "Replace the need to exercise at all"], "Prepare your muscles and heart for exercise"),
                q_short("Design your own 3-step warm-up routine for before a run or game.", "Answers will vary."),
                q_short("Why might skipping a warm-up increase the risk of getting hurt during exercise?", "Cold muscles are more likely to strain or get injured than warmed-up ones."),
                q_mc("A good warm-up gradually...", ["Increases your heart rate and loosens your muscles", "Exhausts you completely", "Has nothing to do with the activity you're about to do"], "Increases your heart rate and loosens your muscles"),
                q_short("How long do you think a warm-up should realistically take before a game or workout?", "Answers will vary (e.g., 5-10 minutes)."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Match muscle groups to exercises that work them.",
            "questions": [
                q_match("Match the muscle group to an exercise that works it.", ["Legs", "Arms", "Core (stomach)", "Back"], ["Squats", "Push-ups", "Sit-ups", "Rows"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_short("Name one exercise that works your legs.", "Answers will vary (e.g., squats, lunges, running)."),
                q_mc("Working different muscle groups on different days is called...", ["Balanced training", "Overtraining", "Skipping exercise"], "Balanced training"),
                q_short("Why might it be helpful to work different muscle groups instead of only one, over and over?", "It builds overall strength evenly and gives some muscles time to rest."),
                q_mc("Push-ups mainly strengthen your...", ["Arms and chest", "Legs", "Ears"], "Arms and chest"),
                q_short("Design a simple exercise plan that includes one move for each major muscle group.", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Track a weekly fitness goal.",
            "questions": [
                q_short("Set a realistic weekly fitness goal (e.g., 'move for 30 minutes, 4 days this week').", "Answers will vary."),
                q_mc("A good fitness goal should be...", ["Specific and realistic for you", "Vague, like 'get fitter someday'", "Impossible to actually measure"], "Specific and realistic for you"),
                q_short("How will you track your progress toward your goal each day?", "Answers will vary (e.g., a checklist or log)."),
                q_mc("If you miss a day of your fitness goal, what's the best response?", ["Keep going the next day, don't give up entirely", "Quit the whole goal immediately", "Pretend the goal never existed"], "Keep going the next day, don't give up entirely"),
                q_short("What would make your fitness goal enjoyable, not just a chore?", "Answers will vary (e.g., picking activities you actually like)."),
                q_mc("Tracking a fitness goal over a WEEK (not just one day) helps you...", ["See a pattern of consistency, not just a single effort", "Nothing useful, tracking doesn't matter", "Guarantee instant results"], "See a pattern of consistency, not just a single effort"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a personal fitness plan covering strength, cardio, and flexibility.",
            "questions": [
                q_short("List one activity for each: strength, cardio (heart-pumping), and flexibility.", "Answers will vary (e.g., push-ups, running, stretching)."),
                q_mc("A well-rounded fitness plan includes...", ["Strength, cardio, AND flexibility work", "Only cardio, nothing else", "Only stretching, nothing else"], "Strength, cardio, AND flexibility work"),
                q_short("Why might focusing on ONLY one type of fitness (like just strength) leave gaps in your overall health?", "Different types of fitness support different parts of health — cardio, strength, and flexibility all matter."),
                q_mc("Cardio exercise mainly benefits your...", ["Heart and lungs", "Only your fingernails", "Nothing important"], "Heart and lungs"),
                q_short("Design a full week's fitness plan, spreading strength, cardio, and flexibility across different days.", "Answers will vary."),
                q_mc("Why include rest days in a fitness plan?", ["Muscles need time to recover and rebuild", "Rest days have no purpose", "You should never rest at all"], "Muscles need time to recover and rebuild"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# HEALTH 4/4: Physical Game Instruction
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "gamerules", "subject_area": "health", "category_name": "Physical Game Instruction", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("In Duck Duck Goose, what do you do when you're picked as 'Goose'?", ["Get up and chase the other player", "Sit down and hide", "Leave the game"], "Get up and chase the other player"),
                q_mc("In Freeze Dance, what do you do when the music stops?", ["Freeze completely still", "Keep dancing", "Sit down"], "Freeze completely still"),
                q_short("Name a game you like to play with rules.", "Answers will vary."),
                q_mc("Why do games have rules?", ["So everyone knows how to play fairly", "Rules don't matter in games", "To make the game boring"], "So everyone knows how to play fairly"),
                q_short("Draw a picture of yourself playing your favorite game.", "Answers will vary."),
                q_mc("If you don't know a game's rules, what should you do?", ["Ask someone to explain them", "Just guess and hope", "Refuse to play"], "Ask someone to explain them"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Follow the rules for a simple playground game.",
            "questions": [
                q_short("Pick a playground game you know. Write one rule of that game.", "Answers will vary."),
                q_mc("Following rules during a game helps make sure...", ["The game is fair for everyone playing", "One person always wins", "The game has no point"], "The game is fair for everyone playing"),
                q_short("What might happen if one player doesn't follow the rules?", "The game could become unfair or confusing for everyone else."),
                q_mc("If you disagree with a rule during a game, what's a good response?", ["Talk it out calmly with the other players", "Yell and quit the game", "Ignore the rule and do what you want"], "Talk it out calmly with the other players"),
                q_short("List the rules of a simple game you'd teach to a younger kid.", "Answers will vary."),
                q_mc("Why is it important to follow rules even when you're losing?", ["Rules apply to everyone, not just when it's convenient", "Rules only matter when you're winning", "You should change the rules to help yourself"], "Rules apply to everyone, not just when it's convenient"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Sequence the steps of a tag or relay game.",
            "questions": [
                q_seq("Put the steps of a simple relay race in order.", ["Line up teams at the starting line", "First racer runs to the marker and back", "Tag the next teammate", "Repeat until every teammate has gone"], "Line up, run and back, tag, repeat."),
                q_short("In a game of tag, what happens when you get tagged?", "Answers will vary depending on the version of tag being played (e.g., you become 'it')."),
                q_mc("Sequencing the steps of a game helps players...", ["Understand the correct order to play it", "Play the game in a random, confusing order", "Skip steps without noticing"], "Understand the correct order to play it"),
                q_short("Write the steps for your own version of a tag or relay game.", "Answers will vary."),
                q_mc("Why does a relay race need clear steps for handing off to the next player?", ["Without clear handoff rules, the race could become unfair or confusing", "Handoffs don't matter in relay races", "Every player should just run at the same time"], "Without clear handoff rules, the race could become unfair or confusing"),
                q_short("What could go wrong if the steps of a relay race weren't followed in order?", "Answers will vary (e.g., unfair advantage, confusion about whose turn it is)."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Write simple rules for a game you invent.",
            "questions": [
                q_short("Invent a simple physical game. What is the GOAL of your game?", "Answers will vary."),
                q_short("Write 3 rules for your invented game.", "Answers will vary."),
                q_mc("Good game rules should be...", ["Clear enough that anyone can understand and follow them", "Confusing on purpose", "Only known by the game's inventor"], "Clear enough that anyone can understand and follow them"),
                q_short("How would someone WIN your invented game?", "Answers will vary."),
                q_mc("Why is it important to think through your rules BEFORE playing, not during?", ["Unclear rules can cause arguments once the game starts", "Rules can always be made up on the spot with no issue", "Thinking ahead doesn't matter for games"], "Unclear rules can cause arguments once the game starts"),
                q_short("What equipment (if any) would your invented game need?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Practice writing clear instructions for a partner game.",
            "questions": [
                q_short("Pick a partner game. Write clear, step-by-step instructions someone could follow without seeing you play.", "Answers will vary."),
                q_mc("Clear instructions should avoid...", ["Vague or confusing wording", "Numbered steps", "Explaining the goal of the game"], "Vague or confusing wording"),
                q_short("Read your instructions out loud. Is there any part that might confuse someone who's never played?", "Answers will vary."),
                q_mc("Why is explaining a game's GOAL an important part of instructions?", ["Players need to know what they're trying to achieve to play well", "The goal doesn't matter, only the rules do", "Goals should always be kept secret"], "Players need to know what they're trying to achieve to play well"),
                q_short("Revise your instructions to fix any confusing parts you noticed.", "Answers will vary."),
                q_mc("The BEST way to check if your instructions are clear is to...", ["Have someone else try to follow them", "Assume they're clear because you understand them", "Never test them at all"], "Have someone else try to follow them"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn the basics of a team sport: positions and simple rules.",
            "questions": [
                q_short("Pick a team sport. Name 2 different positions and what each one does.", "Answers will vary."),
                q_mc("Positions in a team sport exist to...", ["Give each player a specific role that helps the team", "Confuse the players", "Make everyone do the exact same thing"], "Give each player a specific role that helps the team"),
                q_short("Why might a team struggle if everyone tried to play the SAME position at once?", "Important roles (like defense or offense) would be left uncovered."),
                q_mc("Learning the basic rules of a sport before playing helps you...", ["Play fairly and understand what's happening", "Guess randomly during the game", "Avoid needing to pay attention"], "Play fairly and understand what's happening"),
                q_short("Write 2 basic rules of your chosen team sport.", "Answers will vary."),
                q_mc("Why do team sports usually require players to understand BOTH their own position and the overall rules?", ["Good teamwork needs both individual roles and shared understanding of the game", "Only knowing your own position matters, rules don't", "Only knowing the rules matters, positions don't"], "Good teamwork needs both individual roles and shared understanding of the game"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design an original playground game and write its full rules.",
            "questions": [
                q_short("Design an original playground game. Describe the goal and basic setup.", "Answers will vary."),
                q_short("Write the complete rules for your game, including how to win and any special moves.", "Answers will vary."),
                q_mc("A well-designed original game should be...", ["Fun, fair, and clear enough for others to play", "Impossible to actually understand", "Designed to only benefit the inventor"], "Fun, fair, and clear enough for others to play"),
                q_short("How many players does your game need, and how would you handle an uneven number?", "Answers will vary."),
                q_mc("Testing your game with real players before finalizing the rules helps you...", ["Catch confusing or unfair parts you missed", "Nothing — the first draft is always perfect", "Make the game more confusing on purpose"], "Catch confusing or unfair parts you missed"),
                q_short("What would you do if playtesting showed a rule in your game was unfair?", "Answers will vary (e.g., revise the rule)."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Plan a lead-a-game project: write and teach instructions to younger kids.",
            "questions": [
                q_short("Pick a game to teach to younger kids. List the rules in simple, age-appropriate language.", "Answers will vary."),
                q_short("How would you explain the rules differently to a 5-year-old than you would to someone your own age?", "Answers will vary (e.g., simpler words, more demonstration, shorter rules)."),
                q_mc("Teaching a game to younger kids requires...", ["Patience and clear, simple explanations", "Using exactly the same explanation as for older kids", "Assuming they already understand everything"], "Patience and clear, simple explanations"),
                q_short("Plan how you'd demonstrate the game (not just explain it) to make sure younger kids understand.", "Answers will vary."),
                q_mc("Why might demonstrating a game, not just describing it, help younger kids learn faster?", ["Seeing an example often makes rules click faster than words alone", "Demonstrating never helps, only words matter", "Younger kids don't benefit from demonstrations"], "Seeing an example often makes rules click faster than words alone"),
                q_short("What would you do if the younger kids got confused partway through the game?", "Answers will vary (e.g., pause, re-explain, simplify further)."),
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
    out.append("-- 65_life_health_content.sql")
    out.append("-- Whole-Child Curriculum expansion, batch 2: content for the 'life_skills'")
    out.append("-- (Digital Literacy, Financial Literacy, Time Management, Organization) and")
    out.append("-- 'health' (Anatomy, Food & Healthy Eating, Exercise & Fitness, Physical Game")
    out.append("-- Instruction) subject_area groups, hand-crafted across all 8 grades from the")
    out.append("-- curriculum matrix the site owner provided. Requires 63_whole_child_rotation.sql")
    out.append("-- (schema/rotation) to already be applied. See gen_65_life_health_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'life_skills')")
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


if __name__ == "__main__":
    import sys
    total_q = sum(len(gc["questions"]) for cat in CATEGORIES for gc in cat["grades"].values())
    total_cat = sum(len(cat["grades"]) for cat in CATEGORIES)
    print(f"Categories: {total_cat}, Questions: {total_q}", file=sys.stderr)
    with open(r"D:\Project\www\littlescholarhub\lsh.database\65_life_health_content.sql", "w", encoding="utf-8") as f:
        f.write(emit())
    print("Wrote 65_life_health_content.sql", file=sys.stderr)
