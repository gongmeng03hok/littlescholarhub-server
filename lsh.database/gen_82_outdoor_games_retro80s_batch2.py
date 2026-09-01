# -*- coding: utf-8 -*-
"""
Generates lsh.database/82_outdoor_games_retro80s_batch2.sql -- extends the
existing 'Outdoor Games' category (see 68/69/70/71) with 7 MORE games per
grade (35 -> 42 per grade, 56 new games), continuing the 1980s-retro theme
from batch 71 but with a fresh set of classic, traditional (public-domain)
playground and field-day game mechanics not already covered by any of the
280 existing Outdoor Games entries: Red Rover, Mother May I, Steal the
Bacon, Sack Race, Egg and Spoon Race, Three-Legged/Wheelbarrow Race, plus
one "special" per grade (London Bridge, Tetherball, Roller Skating Relay,
Ghost in the Graveyard). No branded/copyrighted games -- traditional
public-domain mechanics only, scaled by grade, with a safety-conscious
framing on the physically rougher ones (Red Rover, Steal the Bacon).

Same structural fields as batch 71 (name, inspiration, objective,
materials, steps, safety_line, image_prompt) and the same prompt format
(build_prompt), appended to the same per-grade Outdoor Games category row.

Also emits outdoor_games_retro80s_batch2_image_prompts.md (reference doc
only, not stored in the DB).

Run with: python gen_82_outdoor_games_retro80s_batch2.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🙌 Red Rover Wave Hello",
        "objective": "Practice walking confidently across an open space while friends cheer you on.",
        "inspiration": "A gentle, safety-first take on the classic Red Rover call-and-cross game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Two lines of kids stand facing each other, holding hands loosely with a grown-up nearby.",
            "One line calls a friend's name from the other side: 'Red Rover, Red Rover, send [name] right over!'",
            "That friend walks (not runs) across to the other line.",
            "They join hands at the end of the new line, then it's someone else's turn.",
        ],
        "safety_line": "Walk, don't run, and hold hands gently -- this is a friendly walk-over, not a crash.",
        "image_prompt": "A bright, friendly illustration of two short lines of young children facing each other on grass, holding hands loosely, with one child walking calmly between the lines while both sides smile and clap. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👑 Mother May I Baby Steps",
        "objective": "Practice listening carefully and following simple step directions.",
        "inspiration": "A simplified version of the classic permission-asking playground game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "One grown-up or child is 'Mother' and stands at the finish line.",
            "Everyone else lines up far away and takes turns asking, 'Mother, may I take 2 baby steps?'",
            "Mother says 'Yes, you may!' before that player moves.",
            "First player to reach Mother wins, then picks the next Mother!",
        ],
        "safety_line": "Only move after Mother says yes -- and always take small, careful steps.",
        "image_prompt": "A cheerful playground illustration of one adult standing at a finish line while three small children in a row take tiny exaggerated steps toward them, big smiles, sunny grassy background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥓 Steal the Bacon Gentle Start",
        "objective": "Practice quick walking and grabbing a soft object placed in the middle.",
        "inspiration": "A slowed-down, walk-only version of the classic team retrieval game.",
        "materials": ["1 soft object (a rolled sock or beanbag)"],
        "steps": [
            "Two small teams line up facing each other, with the object placed exactly in the middle.",
            "A grown-up calls one player's number from each team.",
            "Both players walk quickly to the middle and try to grab the object first.",
            "Whoever grabs it walks it back to their team without being gently tagged.",
        ],
        "safety_line": "Walk quickly instead of running, and tag gently with an open hand.",
        "image_prompt": "A simple bird's-eye illustration of two small groups of children facing each other with a beanbag placed exactly between them, one child from each side walking toward the middle. Bright flat children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Hop Starter",
        "objective": "Practice hopping while holding onto a soft sack or pillowcase.",
        "inspiration": "A short, simple version of the classic field-day potato sack race.",
        "materials": ["1 soft pillowcase or cloth sack per child"],
        "steps": [
            "Step into the sack and hold the top edge with both hands.",
            "Line up at a starting line a few big steps from the finish.",
            "Hop forward slowly, one small hop at a time.",
            "Reach the finish line, then try again a little faster!",
        ],
        "safety_line": "Hop slowly and stay balanced -- it's okay to take tiny hops.",
        "image_prompt": "A joyful illustration of a young child standing inside a soft pillowcase-style sack up to their waist, mid-hop on a short grassy path with a finish-line ribbon just ahead, big happy expression. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Egg and Spoon Wobble Walk",
        "objective": "Practice balancing a soft ball on a spoon while walking carefully.",
        "inspiration": "A gentle version of the classic field-day egg-and-spoon race, using a soft ball instead of a real egg.",
        "materials": ["1 large spoon per child", "1 small soft ball or pom-pom per child"],
        "steps": [
            "Place the soft ball on the spoon and hold the spoon handle flat.",
            "Walk slowly from the start line to the finish line.",
            "If the ball falls off, stop and put it back on before continuing.",
            "See how many times you can cross without dropping it!",
        ],
        "safety_line": "Walk slowly and watch your feet -- this game is about balance, not speed.",
        "image_prompt": "A cheerful illustration of a young child walking carefully across grass while holding a large spoon flat with a small soft colorful pom-pom balanced on top, look of concentration, sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤝 Buddy Steps Partner Walk",
        "objective": "Practice walking in sync with a partner, side by side.",
        "inspiration": "A safe warm-up version of the classic three-legged race, using linked arms instead of tied legs.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Stand side by side with a partner and link arms or hold hands.",
            "Practice saying 'left, right, left, right' together before moving.",
            "Walk forward slowly, stepping with the same foot at the same time.",
            "Try to reach a nearby marker together without letting go!",
        ],
        "safety_line": "Walk slowly and stay close together so neither friend trips.",
        "image_prompt": "A sweet illustration of two young children standing side by side with arms linked, both stepping forward with matching feet, laughing, on a grassy lawn. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🌉 London Bridge Sing-Along",
        "objective": "Practice moving through a bridge shape made by two friends' raised arms, in time with a song.",
        "inspiration": "A classic traditional singing-and-movement circle game passed down for generations.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Two children face each other and raise joined hands to make a 'bridge.'",
            "Everyone else walks in a line underneath the bridge, one at a time.",
            "The two bridge-makers gently lower their arms to 'catch' whoever is underneath at the end of the song.",
            "The caught friend picks the next song verse or becomes part of the bridge!",
        ],
        "safety_line": "Lower your arms gently -- this is a soft, playful catch, not a grab.",
        "image_prompt": "A whimsical illustration of two children forming an arch with raised joined hands while a line of smaller children walks underneath, all smiling, on a sunny playground. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[1] = [
    {
        "name": "🙌 Red Rover Gentle Version",
        "objective": "Practice jogging lightly across an open space and gently letting go of hands.",
        "inspiration": "A safety-first take on the classic Red Rover call-and-cross game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Two lines of kids stand facing each other, holding hands with a grown-up supervising.",
            "One line calls a friend's name: 'Red Rover, Red Rover, send [name] right over!'",
            "That friend jogs lightly across and gently tries to pass through a pair of joined hands.",
            "If hands separate, that friend joins the new line; if not, they go back to their own team.",
        ],
        "safety_line": "Jog lightly, never crash into arms -- gently touch and let go, no rough contact.",
        "image_prompt": "A friendly playground illustration of two lines of children holding hands facing each other on grass, with one child jogging gently between a pair of joined hands. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👑 Mother May I Basics",
        "objective": "Practice asking politely and following different types of movement steps.",
        "inspiration": "The classic permission-asking playground game, with a few different step types.",
        "materials": ["None -- just open space!"],
        "steps": [
            "One player is 'Mother' and stands at the finish line; everyone else lines up far away.",
            "Take turns asking, 'Mother, may I take 3 giant steps?' or '2 bunny hops?'",
            "Mother says 'Yes, you may!' before you move -- if you forget to ask, you go back to start.",
            "First player to reach Mother wins and becomes the next Mother!",
        ],
        "safety_line": "Only move after hearing 'yes,' and keep steps under control.",
        "image_prompt": "A lively illustration of one child standing at a finish line while several others take exaggerated giant steps and bunny hops toward them across grass, playful expressions. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥓 Steal the Bacon Basics",
        "objective": "Practice quick reactions, running, and gentle tagging in a team retrieval game.",
        "inspiration": "The classic team game where a called player races to grab an object first.",
        "materials": ["1 soft object (a rolled sock or beanbag)"],
        "steps": [
            "Two teams line up facing each other with the object placed in the middle.",
            "A grown-up calls a matching number from each team to run to the middle.",
            "Whoever grabs the object first tries to run it back to their own line.",
            "The other player tries to gently tag them before they get back -- a tag before home means a point for the tagger's team!",
        ],
        "safety_line": "Tag gently with an open hand, and always run with your eyes up.",
        "image_prompt": "A dynamic playground illustration of two children running toward a beanbag placed between two lines of teammates, energetic poses, sunny grassy field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Race Basics",
        "objective": "Practice hopping steadily in a sack over a short race distance.",
        "inspiration": "The classic field-day potato sack race.",
        "materials": ["1 soft pillowcase or cloth sack per child"],
        "steps": [
            "Step into the sack and hold the top edge firmly with both hands.",
            "Line up at the start line, a short distance from the finish.",
            "On 'go,' hop forward toward the finish line as steadily as you can.",
            "First to cross the finish line without falling wins!",
        ],
        "safety_line": "If you feel wobbly, take smaller hops -- staying upright matters more than speed.",
        "image_prompt": "An energetic illustration of several children mid-hop inside colorful cloth sacks racing across a grassy field toward a ribbon finish line, cheering families in the background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Egg and Spoon Basics",
        "objective": "Practice balancing a soft ball on a spoon while walking briskly.",
        "inspiration": "The classic field-day egg-and-spoon race, using a soft ball for safety.",
        "materials": ["1 large spoon per child", "1 small soft ball or pom-pom per child"],
        "steps": [
            "Balance the soft ball on the spoon and hold the handle steady.",
            "Line up at the start, a short distance from the finish.",
            "Walk briskly to the finish line without letting the ball fall.",
            "If it falls, pick it back up and keep going -- first to finish wins!",
        ],
        "safety_line": "Walking beats running here -- go at a pace where you can still balance.",
        "image_prompt": "A charming illustration of several children walking briskly in a row, each holding a spoon with a small colorful pom-pom balanced on top, determined expressions, grassy race lane. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦵 Three-Legged Race Basics",
        "objective": "Practice walking in sync with a partner whose ankle is gently tied to yours.",
        "inspiration": "The classic field-day three-legged race.",
        "materials": ["1 soft scarf or strip of cloth per pair"],
        "steps": [
            "Stand side by side with a partner and loosely tie your inside ankles together with the soft cloth.",
            "Put your arms around each other's shoulders or hold hands for balance.",
            "Practice saying 'left, right, left, right' together, then walk slowly toward a nearby marker.",
            "Once you're steady, try picking up the pace a little!",
        ],
        "safety_line": "Tie the cloth loosely (never tight), and always start slow before speeding up.",
        "image_prompt": "A cheerful illustration of two children standing side by side with their inner ankles gently tied together with a soft cloth, arms around each other's shoulders, mid-step on grass, laughing. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛼 Roller Skate Wobble Walk",
        "objective": "Practice basic balance and small steps while wearing roller skates.",
        "inspiration": "A gentle introduction to the roller-skating relays that were everywhere on 1980s playgrounds.",
        "materials": ["Roller skates (with a grown-up spotting)", "A smooth, flat surface"],
        "steps": [
            "Put on roller skates and stand still first, getting used to the feel.",
            "Hold a grown-up's hand or a railing for the first few steps.",
            "Take small, careful rolling steps forward, one foot at a time.",
            "Once you feel steady, try letting go for just a few seconds!",
        ],
        "safety_line": "Always skate with a grown-up nearby, and wear a helmet if you have one.",
        "image_prompt": "A sweet illustration of a young child wearing colorful roller skates, holding an adult's hand for balance while taking a careful step forward on a smooth sidewalk, big concentrated smile. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[2] = [
    {
        "name": "🙌 Red Rover Warm-Up",
        "objective": "Practice jogging with control and breaking through joined hands safely.",
        "inspiration": "The classic call-and-cross team game, played with a safety-first mindset.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Two teams form lines facing each other, holding hands.",
            "One team calls a player from the other side by name.",
            "That player jogs across and tries to gently break through a pair of joined hands.",
            "If they break through, they pick a player to bring back to their team; if not, they join the new line.",
        ],
        "safety_line": "Jog under control -- no full sprinting or slamming into arms.",
        "image_prompt": "An energetic but safe-looking illustration of two lines of children holding hands facing each other, with one child jogging toward a pair of joined hands, determined expression, grassy field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👑 Mother May I Challenge",
        "objective": "Practice strategic step choices while following clear directions.",
        "inspiration": "The classic permission-asking game, with a wider variety of step types.",
        "materials": ["None -- just open space!"],
        "steps": [
            "One player is Mother; everyone else lines up at the start.",
            "Ask for different step types: giant steps, baby steps, scissor steps, or spins.",
            "Mother approves or denies the request -- if denied, try a different step.",
            "First to tag Mother wins and takes over as the next Mother!",
        ],
        "safety_line": "Keep steps controlled, especially spins -- stay aware of your neighbors.",
        "image_prompt": "A lively playground illustration of several children using different exaggerated movements (giant step, scissor step, spin) as they approach one child standing as 'Mother,' bright sunny field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥓 Steal the Bacon Relay",
        "objective": "Practice quick decision-making and teamwork in a relay-style retrieval game.",
        "inspiration": "The classic team game, adapted so every player gets a turn in order.",
        "materials": ["1 soft object (a rolled sock or beanbag)"],
        "steps": [
            "Two teams line up in order, facing each other, with the object in the middle.",
            "The first player from each team runs to grab the object when a grown-up says 'go.'",
            "Whoever grabs it races it back to their team's line before being tagged.",
            "Next pair of players goes, continuing until every player has had a turn.",
        ],
        "safety_line": "Tag with an open hand only, and keep your head up while running.",
        "image_prompt": "A dynamic illustration of two lines of children waiting their turn while two players race toward a beanbag in the middle, cheering teammates on both sides. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Race Challenge",
        "objective": "Practice steady hopping over a longer race distance with a turnaround.",
        "inspiration": "The classic field-day potato sack race, with an added turn for more challenge.",
        "materials": ["1 soft pillowcase or cloth sack per child", "1 cone or marker"],
        "steps": [
            "Step into the sack and line up at the start, with a cone placed partway to the finish.",
            "Hop to the cone, go around it, then hop back to the start.",
            "Stay balanced the whole way -- falling means starting that lap again.",
            "First one back to the start line wins!",
        ],
        "safety_line": "Slow down around the turn so you don't tip over.",
        "image_prompt": "An energetic illustration of children mid-hop in sacks rounding a bright orange cone on a grassy course, determination on their faces. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Egg and Spoon Challenge",
        "objective": "Practice balancing while walking around an obstacle.",
        "inspiration": "The classic field-day egg-and-spoon race, with an added turn for more challenge.",
        "materials": ["1 large spoon per child", "1 small soft ball or pom-pom per child", "1 cone or marker"],
        "steps": [
            "Balance the ball on the spoon and walk toward a cone placed partway to the finish.",
            "Carefully go around the cone without dropping the ball.",
            "Walk back to the start line, keeping your balance the whole way.",
            "If the ball falls, stop, pick it up, and keep going!",
        ],
        "safety_line": "Slow way down for the turn -- that's when most balls fall.",
        "image_prompt": "A charming illustration of a child carefully walking around an orange cone while balancing a small colorful ball on a spoon, focused expression, grassy course. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦵 Three-Legged Race Challenge",
        "objective": "Practice coordinated walking with a partner over a longer race distance.",
        "inspiration": "The classic field-day three-legged race, stepped up with a full race course.",
        "materials": ["1 soft scarf or strip of cloth per pair"],
        "steps": [
            "Loosely tie inside ankles together with your partner and get into a starting stance.",
            "Count '1, 2, 1, 2' out loud together as you take your first few steps.",
            "Race toward the finish line, staying in sync with your partner.",
            "First pair to cross the finish line together wins!",
        ],
        "safety_line": "If you start to stumble, slow down together rather than one person speeding up.",
        "image_prompt": "A fun illustration of two children with ankles gently tied together racing across a grassy field toward a finish line, big smiles, arms around each other for balance. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏓 Tetherball Intro",
        "objective": "Practice hitting a ball on a rope around a pole with a partner.",
        "inspiration": "The classic playground tetherball game, found on nearly every 1980s schoolyard.",
        "materials": ["A tetherball pole and ball (or improvised rope-and-ball setup)"],
        "steps": [
            "Stand on opposite sides of the pole from your partner.",
            "Take turns hitting the ball with an open hand or fist to wind the rope around the pole in your direction.",
            "Your partner tries to hit it back the other way to unwind it.",
            "The first player to fully wind the rope around the pole (in their direction) wins the round!",
        ],
        "safety_line": "Hit the ball, not your partner's hands -- keep a safe distance apart.",
        "image_prompt": "A cheerful illustration of two children on opposite sides of a tetherball pole, one mid-swing hitting a yellow ball attached to a rope wound partway around the pole. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[3] = [
    {
        "name": "🙌 Red Rover Championship",
        "objective": "Practice teamwork strategy in choosing which player to call across.",
        "inspiration": "The classic call-and-cross team game, played with strategic team calling.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Two teams form lines facing each other, holding hands firmly but gently.",
            "Teams huddle briefly to decide strategically which opposing player to call.",
            "The called player jogs across and tries to break through a pair of joined hands.",
            "Winners of each round bring a player back to their team; play multiple rounds to see which team grows biggest!",
        ],
        "safety_line": "Jog with control, and always break through with an open, gentle push -- never a shoulder charge.",
        "image_prompt": "A spirited illustration of two teams of children in lines holding hands, huddling to strategize, with one child confidently jogging toward the opposing line. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👑 Mother May I Teams",
        "objective": "Practice teamwork by taking turns asking permission as a relay team.",
        "inspiration": "A team relay twist on the classic Mother May I game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Split into small teams lined up behind a starting line, with one team's turn at a time.",
            "One player per team asks Mother for a type of step and, if approved, moves.",
            "Then it's the next player's turn on that team, and so on.",
            "First team to get every player to Mother wins!",
        ],
        "safety_line": "Wait your turn patiently, and keep steps under control near your teammates.",
        "image_prompt": "A busy but organized illustration of two small teams of children lined up, taking turns asking a player standing as 'Mother' for movement steps, sunny field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥓 Steal the Bacon Teams",
        "objective": "Practice quick teamwork calls and multi-player retrieval strategy.",
        "inspiration": "A team-based expansion of the classic Steal the Bacon game.",
        "materials": ["1-2 soft objects (rolled socks or beanbags)"],
        "steps": [
            "Two teams line up facing each other with one or two objects placed in the middle.",
            "A grown-up calls TWO numbers from each team at once, so pairs race together.",
            "Partners can work together to grab an object and protect each other from being tagged.",
            "Whichever team scores the most successful retrievals after several rounds wins!",
        ],
        "safety_line": "Tag gently with an open hand, and never grab a teammate's clothing to pull them.",
        "image_prompt": "An energetic illustration of two pairs of children racing toward two beanbags placed in the middle of a field, teammates cheering from their lines on either side. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Race Relay",
        "objective": "Practice teamwork by passing the sack to the next teammate in a relay.",
        "inspiration": "A relay-team version of the classic potato sack race.",
        "materials": ["1-2 soft pillowcases or cloth sacks", "1 cone or marker per lane"],
        "steps": [
            "Split into teams lined up behind a starting line, with a cone placed down the lane.",
            "The first player hops in the sack to the cone, back, then hands the sack to the next teammate.",
            "Continue until every player on the team has had a turn.",
            "First team to finish wins the relay!",
        ],
        "safety_line": "Hand off the sack carefully -- don't throw it -- and wait for a clear tag before starting.",
        "image_prompt": "A lively illustration of a line of children cheering as one teammate hops in a sack toward a cone, with the next player ready and waiting to take the sack. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Egg and Spoon Relay",
        "objective": "Practice teamwork by handing off a balanced spoon to the next teammate.",
        "inspiration": "A relay-team version of the classic egg-and-spoon race.",
        "materials": ["1-2 large spoons", "1-2 small soft balls or pom-poms", "1 cone or marker per lane"],
        "steps": [
            "Split into teams; the first player balances the ball on the spoon and walks to a cone and back.",
            "Carefully hand the spoon (with the ball still balanced) to the next teammate.",
            "If the ball falls during a hand-off, pick it back up and try again.",
            "First team to get every player through the relay wins!",
        ],
        "safety_line": "Hand off slowly and carefully so the ball doesn't fall during the pass.",
        "image_prompt": "A charming illustration of one child carefully passing a spoon with a balanced ball to a teammate, both concentrating closely, cone marker visible in the background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦵 Three-Legged Race Relay",
        "objective": "Practice coordinated team racing with multiple tied pairs taking turns.",
        "inspiration": "A relay-team version of the classic three-legged race.",
        "materials": ["Soft scarves or strips of cloth, one per pair", "1 cone or marker per lane"],
        "steps": [
            "Split into teams of paired-up partners, tied loosely at the ankle.",
            "The first pair races to a cone and back, then unties and tags the next pair.",
            "Continue until every pair on the team has raced.",
            "First team to finish wins!",
        ],
        "safety_line": "Untie ankles fully before the next pair starts, so nobody trips over loose cloth.",
        "image_prompt": "An energetic illustration of one tied pair of children racing back from a cone toward their cheering teammates, with the next pair ready to go. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛼 Roller Skating Relay",
        "objective": "Practice balanced skating over a short distance as part of a team relay.",
        "inspiration": "The classic roller-skating relays that were a staple of 1980s neighborhood playgrounds.",
        "materials": ["Roller skates", "A smooth, flat surface", "1 cone or marker per lane"],
        "steps": [
            "Split into teams; the first skater rolls carefully to a cone and back.",
            "Tag the next teammate's hand to pass the turn.",
            "Continue until every teammate has skated their turn.",
            "First team to finish wins -- balance matters more than speed!",
        ],
        "safety_line": "Skate on a flat, open surface away from traffic, and wear a helmet and pads if you have them.",
        "image_prompt": "A fun illustration of a child on roller skates rolling toward an orange cone on a smooth path, with teammates waiting their turn nearby, sunny day. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[4] = [
    {
        "name": "🙌 Red Rover Advanced Strategy",
        "objective": "Practice reading the other team's line to choose the weakest link to call.",
        "inspiration": "The classic call-and-cross team game, with real strategic thinking.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Two teams form lines facing each other, holding hands.",
            "Before calling, scan the other line for a spot where two smaller hands might be easier to break through.",
            "Call that player's name; they jog across and try to break through.",
            "Track how many players each team gains over several rounds to see who wins overall.",
        ],
        "safety_line": "Strategy is about WHERE you break through, not how hard -- always stay in control.",
        "image_prompt": "A strategic-looking illustration of a team of children studying the opposing line before calling a name, thoughtful expressions, sunny field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👑 Mother May I Strategy",
        "objective": "Practice choosing the most efficient step type to reach the finish fastest.",
        "inspiration": "A strategy-focused twist on the classic Mother May I game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Estimate the distance to Mother and think about which step type covers it fastest.",
            "Ask for that step type -- but Mother might approve a smaller step instead as a twist!",
            "Adjust your strategy each turn based on what's approved.",
            "First to reach Mother wins and becomes the next Mother!",
        ],
        "safety_line": "Even 'giant steps' should stay controlled -- no leaping into a neighbor's space.",
        "image_prompt": "A thoughtful illustration of a child sizing up the distance to a finish line before choosing a step type, playground scene, other kids also strategizing nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥓 Steal the Bacon Strategy",
        "objective": "Practice reading an opponent's movement to decide when to grab and when to fake.",
        "inspiration": "A strategy-focused twist on the classic Steal the Bacon game.",
        "materials": ["1 soft object (a rolled sock or beanbag)"],
        "steps": [
            "Two teams line up with the object in the middle; a number is called from each side.",
            "Try faking a grab to see how your opponent reacts before actually going for it.",
            "Whoever actually grabs it runs it home while the other tries to tag them.",
            "Keep score over several rounds -- whoever reads their opponent best usually wins!",
        ],
        "safety_line": "Fakes are for footwork, not physical contact -- keep hands to yourself until it's a real grab.",
        "image_prompt": "A tense, exciting illustration of two children facing off near a beanbag, one leaning in as if to fake a grab, the other watching closely. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Race Obstacle Course",
        "objective": "Practice hopping steadily through a short course with multiple obstacles.",
        "inspiration": "A leveled-up version of the classic potato sack race with an obstacle course twist.",
        "materials": ["Soft pillowcases or cloth sacks", "3-4 cones or markers"],
        "steps": [
            "Set up 3-4 cones in a winding path from start to finish.",
            "Step into the sack and hop the winding path around each cone.",
            "Stay balanced through each turn -- falling means going back to the last cone you passed.",
            "First to complete the whole course wins!",
        ],
        "safety_line": "Slow down at each turn -- a wide course beats a fast fall.",
        "image_prompt": "A dynamic illustration of a child hopping in a sack through a winding path of orange cones on grass, focused and determined. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Egg and Spoon Obstacle Dash",
        "objective": "Practice balancing through a short obstacle course without dropping the ball.",
        "inspiration": "A leveled-up version of the classic egg-and-spoon race with obstacles added.",
        "materials": ["Large spoons", "Small soft balls or pom-poms", "3-4 cones or markers"],
        "steps": [
            "Set up 3-4 cones in a winding path from start to finish.",
            "Balance the ball on the spoon and walk the winding path around each cone.",
            "If the ball falls, stop, pick it up right where it fell, and continue.",
            "First to complete the course without too many drops wins!",
        ],
        "safety_line": "Go slowly on turns -- most drops happen when you turn too fast.",
        "image_prompt": "A charming illustration of a child carefully navigating a winding cone course while balancing a small ball on a spoon, look of intense focus. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦵 Wheelbarrow Race Basics",
        "objective": "Practice teamwork balance with one partner walking on hands while the other holds their legs.",
        "inspiration": "The classic field-day wheelbarrow race, a favorite of 1980s school field days.",
        "materials": ["A soft grassy or padded surface"],
        "steps": [
            "One partner gets on hands and knees, then lifts into a plank position on their hands.",
            "The other partner gently holds their ankles, just above the ground, like wheelbarrow handles.",
            "The 'wheelbarrow' partner walks forward on their hands while the other walks behind holding on.",
            "Race to a marker and back, then switch roles!",
        ],
        "safety_line": "Only attempt this on soft ground, and hold ankles gently -- stop right away if arms get tired.",
        "image_prompt": "A fun illustration of two children playing wheelbarrow race on a grassy field, one walking on hands with a big smile while the other gently holds their ankles behind them. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👻 Ghost in the Graveyard",
        "objective": "Practice quiet movement and quick reactions in a classic dusk hide-and-seek game.",
        "inspiration": "A beloved neighborhood evening game from countless 1980s summer nights.",
        "materials": ["None -- just open space with hiding spots", "A grown-up to supervise"],
        "steps": [
            "One player is the 'Ghost' and hides while everyone else counts to 20 at a home base with eyes closed.",
            "Everyone spreads out to search for the Ghost, staying within the agreed-upon play area.",
            "Whoever spots the Ghost shouts 'Ghost in the graveyard!' and everyone races back to home base.",
            "The Ghost tries to tag someone before they reach base -- whoever is tagged becomes the next Ghost!",
        ],
        "safety_line": "Play in a well-lit, agreed-upon area with a grown-up nearby, and always know the boundary lines.",
        "image_prompt": "An atmospheric but friendly illustration of children running excitedly back toward a lit porch 'home base' at dusk, one child peeking out from behind a tree as the Ghost, warm twilight sky. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[5] = [
    {
        "name": "🙌 Red Rover Team Tactics",
        "objective": "Practice full-team strategy across multiple rounds of calling and defending.",
        "inspiration": "The classic call-and-cross team game, played with real tactical planning.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Two teams form lines, holding hands, and appoint a quick team captain.",
            "Before each call, the captain gathers input on who to call based on the other team's line.",
            "The called player jogs across and tries to break through strategically.",
            "Track total players gained across many rounds to determine the winning team.",
        ],
        "safety_line": "Fast play still means controlled play -- no shoulder-first charges, ever.",
        "image_prompt": "A dynamic illustration of a team captain huddled with teammates strategizing between rounds of Red Rover, opposing team visible in the background holding hands. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥓 Steal the Bacon Championship",
        "objective": "Practice competitive, multi-round retrieval strategy tracked for an overall winner.",
        "inspiration": "A championship-format version of the classic Steal the Bacon game.",
        "materials": ["1-2 soft objects (rolled socks or beanbags)"],
        "steps": [
            "Set up a full tournament bracket of numbered rounds between two or more teams.",
            "Play each round with the standard call-and-retrieve rules.",
            "Keep a running score across all rounds on a simple scoreboard.",
            "The team with the most successful retrievals at the end is the champion!",
        ],
        "safety_line": "Championship energy still means gentle, open-hand tags only.",
        "image_prompt": "An exciting illustration of a small chalkboard scoreboard next to a field where two teams face off in Steal the Bacon, colorful and competitive but friendly atmosphere. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Race Championship",
        "objective": "Practice consistent, fast hopping across a full multi-round tournament.",
        "inspiration": "A championship-format version of the classic potato sack race.",
        "materials": ["Soft pillowcases or cloth sacks", "Cones for a marked lane"],
        "steps": [
            "Set up heats of 3-4 racers at a time, with winners advancing to the next round.",
            "Race each heat over the same marked distance.",
            "Continue advancing winners until a final race determines the champion.",
            "Celebrate every racer's effort, not just the winner!",
        ],
        "safety_line": "Staying upright still beats winning fast -- pace yourself to avoid falling.",
        "image_prompt": "An exciting tournament-style illustration of multiple children racing in sacks side by side down marked lanes, cheering crowd of classmates on the sidelines. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Egg and Spoon Championship",
        "objective": "Practice consistent balance skill across a full multi-round tournament.",
        "inspiration": "A championship-format version of the classic egg-and-spoon race.",
        "materials": ["Large spoons", "Small soft balls or pom-poms", "Cones for a marked lane"],
        "steps": [
            "Set up heats of 3-4 racers at a time, each balancing a ball on a spoon.",
            "Race each heat over the same marked distance -- fastest without dropping advances.",
            "Continue advancing winners until a final race determines the champion.",
            "A dropped ball means a quick pause to pick it up, not disqualification!",
        ],
        "safety_line": "A slow, steady walk beats a fast run that drops the ball -- balance first.",
        "image_prompt": "A lively tournament-style illustration of several children walking briskly with spoons and balanced balls, cheering onlookers, marked race lanes on grass. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦵 Wheelbarrow Race Championship",
        "objective": "Practice sustained partner-balance strength across a full competitive race.",
        "inspiration": "A championship-format version of the classic field-day wheelbarrow race.",
        "materials": ["A soft grassy or padded surface", "Cones for a marked lane"],
        "steps": [
            "Pairs line up with one partner in wheelbarrow position, hands on the ground.",
            "Race the full marked lane to the finish and back if the course allows.",
            "The back partner gently guides by the ankles the whole way -- no letting go mid-race.",
            "Fastest pair to complete the course without stopping wins the championship!",
        ],
        "safety_line": "If the 'wheelbarrow' partner's arms get tired, stop immediately and switch or rest.",
        "image_prompt": "An energetic championship-style illustration of two pairs racing in wheelbarrow position across a grassy lane, cheering teammates on the sidelines. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👑 Mother May I Championship",
        "objective": "Practice competitive strategic step choices across a multi-round tournament.",
        "inspiration": "A championship-format version of the classic Mother May I game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Play several rounds with a rotating 'Mother' role, keeping score of who wins each round.",
            "Vary the step types allowed each round to keep strategy fresh.",
            "Track total round wins across the whole game.",
            "The player with the most round wins at the end is the Mother May I champion!",
        ],
        "safety_line": "Bigger steps still need control -- especially spins and leaps near other players.",
        "image_prompt": "A fun tournament-style illustration of several children lined up taking varied exaggerated steps toward a 'Mother' player, small scoreboard visible nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏓 Tetherball Championship",
        "objective": "Practice sustained tetherball skill across a full head-to-head tournament.",
        "inspiration": "A championship-format version of the classic playground tetherball game.",
        "materials": ["A tetherball pole and ball (or improvised rope-and-ball setup)"],
        "steps": [
            "Set up a bracket of head-to-head matches between players.",
            "Play each match to a full wind of the rope as the win condition.",
            "Track match winners advancing through the bracket.",
            "The final match winner is the Tetherball Champion!",
        ],
        "safety_line": "Watch your hands near the pole and rope, and always hit the ball, never a person.",
        "image_prompt": "An exciting illustration of two children in an intense tetherball match, rope wound partway around the pole, small crowd of classmates watching and cheering. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[6] = [
    {
        "name": "🙌 Red Rover Grand League",
        "objective": "Practice team leadership and strategy across a multi-team league format.",
        "inspiration": "A league-format version of the classic Red Rover team game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Split into 3-4 smaller teams and rotate matchups so every team plays every other team once.",
            "Each match follows standard Red Rover rules, tracking players gained per team.",
            "After all matches, total up each team's overall performance across the league.",
            "The team with the best overall record is the league champion!",
        ],
        "safety_line": "Bigger league, same rule: control over speed, every single round.",
        "image_prompt": "A large-scale, spirited illustration of multiple small teams of children scattered across a field playing simultaneous rounds of Red Rover, a simple league standings chart nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥓 Steal the Bacon Grand Tournament",
        "objective": "Practice advanced retrieval strategy across a full bracket tournament with multiple teams.",
        "inspiration": "A grand-tournament version of the classic Steal the Bacon game.",
        "materials": ["1-2 soft objects (rolled socks or beanbags)"],
        "steps": [
            "Set up a bracket with 4 or more teams competing in elimination rounds.",
            "Play each round with standard rules, with the losing team eliminated each round.",
            "Continue until two teams remain for a final round.",
            "The winner of the final round is the Grand Tournament Champion!",
        ],
        "safety_line": "Bigger stakes, same care -- gentle open-hand tags, every round.",
        "image_prompt": "An exciting bracket-style illustration showing four teams of children competing across a field in a Steal the Bacon tournament, a simple bracket chart drawn on a whiteboard nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Race Grand Championship",
        "objective": "Practice consistent racing performance across a full field-day-style championship.",
        "inspiration": "A grand-championship version of the classic field-day potato sack race.",
        "materials": ["Soft pillowcases or cloth sacks", "Cones for marked lanes"],
        "steps": [
            "Run a full field-day format: qualifying heats, semifinals, and a final race.",
            "Every racer gets at least one heat to qualify for the next round.",
            "Track times or finishing order at each stage.",
            "The winner of the final heat is crowned Sack Race Grand Champion!",
        ],
        "safety_line": "Championship nerves are normal -- remind everyone that staying upright wins over rushing.",
        "image_prompt": "A grand field-day illustration of a sack race final with several children hopping toward a ribbon finish line, a cheering crowd and a small trophy visible nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Egg and Spoon Masters",
        "objective": "Practice mastering balance under pressure across a full elimination tournament.",
        "inspiration": "A masters-level version of the classic egg-and-spoon race.",
        "materials": ["Large spoons", "Small soft balls or pom-poms", "Cones for marked lanes"],
        "steps": [
            "Run heats where any dropped ball eliminates that attempt for the round.",
            "Racers who complete the course without dropping advance to the next round.",
            "Continue until a final head-to-head heat determines the winner.",
            "The Egg and Spoon Master is whoever balances best under pressure!",
        ],
        "safety_line": "Precision beats speed here -- a slow, steady finish always beats a fast fall.",
        "image_prompt": "A tense but joyful illustration of two finalists walking carefully with balanced spoons toward a finish line, a small trophy waiting, cheering crowd nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦵 Wheelbarrow Race Grand Finals",
        "objective": "Practice sustained teamwork and strength across a full elimination bracket.",
        "inspiration": "A grand-finals version of the classic field-day wheelbarrow race.",
        "materials": ["A soft grassy or padded surface", "Cones for marked lanes"],
        "steps": [
            "Run bracket-style head-to-head races between pairs, with losers eliminated.",
            "Each pair races the full marked lane, switching who is in wheelbarrow position between rounds if they like.",
            "Continue until two pairs remain for the grand final race.",
            "The winning pair of the grand final is the Wheelbarrow Race Champion team!",
        ],
        "safety_line": "If any arm or wrist feels sore, sit out a round rather than push through pain.",
        "image_prompt": "A dramatic grand-finals illustration of two pairs racing head-to-head in wheelbarrow position toward a finish line, an excited crowd of classmates cheering. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👑 Mother May I Leader Rotation",
        "objective": "Practice leadership by taking turns creating fair, creative step challenges for the group.",
        "inspiration": "An advanced version of the classic Mother May I game with rotating leadership.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Everyone takes a turn being 'Mother' for one full round, inventing a new step type each time.",
            "The group votes on whether each invented step is fair and fun before playing it.",
            "Play a full round with each invented step type.",
            "At the end, vote on which invented step type was the most fun overall!",
        ],
        "safety_line": "Invented steps still need to be safe -- no leaping, spinning too fast, or contact.",
        "image_prompt": "A creative illustration of a group of children voting by raised hands on a newly invented movement step, one child standing confidently as the current 'Mother.' Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👻 Ghost in the Graveyard Championship",
        "objective": "Practice advanced stealth, teamwork, and quick sprinting in a large-group version of the classic game.",
        "inspiration": "A bigger, more strategic version of the classic 1980s dusk hide-and-seek game.",
        "materials": ["None -- just open space with hiding spots", "A grown-up to supervise"],
        "steps": [
            "With a larger group, choose 2 Ghosts who hide together while everyone else counts at home base.",
            "Searchers move in pairs for safety and to cover more ground spotting the Ghosts.",
            "Whoever spots a Ghost shouts the signal and everyone races back to base.",
            "Both Ghosts try to tag runners before they reach base; anyone tagged becomes a Ghost for the next round!",
        ],
        "safety_line": "Stick to a clearly marked, well-lit boundary, and always play with a grown-up supervising nearby.",
        "image_prompt": "An exciting dusk illustration of a large group of children sprinting back toward a lit home base while two 'Ghosts' emerge from behind bushes to chase, warm twilight colors. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[7] = [
    {
        "name": "🙌 Red Rover Legends Cup",
        "objective": "Practice top-level team strategy and communication across a full multi-team cup format.",
        "inspiration": "The most advanced format of the classic Red Rover team game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Split into several teams and run a round-robin cup where every team faces every other team.",
            "Each match uses standard rules, with a scorekeeper tracking players gained per team.",
            "After all matches, rank teams by total players gained across the whole cup.",
            "The top-ranked team lifts the Red Rover Legends Cup!",
        ],
        "safety_line": "The bigger the event, the more it matters to stay controlled -- no shoulder charges, ever.",
        "image_prompt": "A grand, celebratory illustration of several teams of children lined up across a large field for a Red Rover tournament, a simple handmade 'cup' trophy displayed nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👑 Mother May I Grandmaster Round",
        "objective": "Practice inventing and negotiating fair, creative step challenges at an advanced level.",
        "inspiration": "The most advanced format of the classic Mother May I game.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Each player gets one turn as Mother, allowed to invent one brand-new step type.",
            "Before playing each invented step, the group briefly discusses if it's fair and safe.",
            "Play a full round with each invented step type, keeping score of who wins each round.",
            "The player with the most round wins across the whole session is the Grandmaster!",
        ],
        "safety_line": "New step ideas still need grown-up approval if they involve running or spinning.",
        "image_prompt": "A creative and lively illustration of a group of children discussing a newly invented movement step together before playing it, one child standing confidently as 'Mother.' Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥓 Steal the Bacon World Series",
        "objective": "Practice elite-level retrieval strategy across a best-of-several-rounds series between two top teams.",
        "inspiration": "The most advanced format of the classic Steal the Bacon game.",
        "materials": ["1-2 soft objects (rolled socks or beanbags)"],
        "steps": [
            "The two strongest teams from earlier rounds face off in a best-of-5 series.",
            "Play each round with standard rules, tracking wins for each team.",
            "First team to win 3 rounds takes the series.",
            "Celebrate great plays from BOTH teams, not just the winners!",
        ],
        "safety_line": "High-stakes rounds still mean gentle, open-hand tags only -- no exceptions.",
        "image_prompt": "A dramatic 'championship series' illustration of two teams facing off across a field for Steal the Bacon, a simple series scoreboard (3 games to win) drawn on a whiteboard nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Race Ultimate Finals",
        "objective": "Practice peak hopping consistency in a single ultimate final race.",
        "inspiration": "The final, ultimate round of the classic field-day potato sack race.",
        "materials": ["Soft pillowcases or cloth sacks", "Cones for a marked lane"],
        "steps": [
            "Gather the fastest racer from each earlier heat for one ultimate final race.",
            "Line up together at the start line for a single deciding race.",
            "Hop the full marked distance, staying balanced the whole way.",
            "The winner of the ultimate final is crowned the season's Sack Race champion!",
        ],
        "safety_line": "Finals nerves are normal -- remind everyone that a steady finish always beats a fast fall.",
        "image_prompt": "A dramatic finals-day illustration of several children hopping in sacks side by side toward a ribbon finish line, an excited crowd cheering from the sidelines. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Egg and Spoon Grand Masters Cup",
        "objective": "Practice mastering precision balance under the pressure of a final head-to-head cup match.",
        "inspiration": "The final, ultimate round of the classic field-day egg-and-spoon race.",
        "materials": ["Large spoons", "Small soft balls or pom-poms", "Cones for a marked lane"],
        "steps": [
            "Gather the two most consistent balancers from earlier rounds for a final cup match.",
            "Both walk the full marked distance at the same time, side by side.",
            "A dropped ball means a quick pause to pick it up and continue -- no disqualification.",
            "Whoever finishes first without too many drops lifts the Grand Masters Cup!",
        ],
        "safety_line": "A calm, steady walk beats a fast run that drops the ball -- balance always comes first.",
        "image_prompt": "A celebratory illustration of two finalists walking side by side with balanced spoons toward a finish line, a small handmade trophy waiting, cheering crowd of classmates. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦵 Wheelbarrow Race Legends League",
        "objective": "Practice sustained partner strength and trust across a full multi-pair league format.",
        "inspiration": "The most advanced format of the classic field-day wheelbarrow race.",
        "materials": ["A soft grassy or padded surface", "Cones for marked lanes"],
        "steps": [
            "Split into several pairs and run a round-robin league where every pair races every other pair once.",
            "Each race follows standard wheelbarrow rules over the same marked distance.",
            "Track wins for each pair across the whole league.",
            "The pair with the most wins across the league are the Wheelbarrow Race Legends!",
        ],
        "safety_line": "If any arm or wrist feels sore during the league, sit out a round rather than push through it.",
        "image_prompt": "A grand league-day illustration of several pairs of children racing in wheelbarrow position across parallel grassy lanes, a simple league standings chart nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎪 80s Field Day Showdown",
        "objective": "Practice a wide range of retro field-day skills across several linked mini-stations in one big event.",
        "inspiration": "A capstone celebration combining several classic 1980s field-day games into one big showdown.",
        "materials": ["Soft pillowcases or cloth sacks", "Large spoons and small soft balls", "Soft cloth ties for partner races", "Cones or markers for each station"],
        "steps": [
            "Set up 4 stations around the field: sack hop, egg-and-spoon walk, three-legged/wheelbarrow dash, and Mother May I steps.",
            "Split into small groups and rotate through every station, completing each one fully.",
            "Add up each group's combined results (or just how many stations they completed) across all 4 stations.",
            "Celebrate every group's effort at the end with a group cheer -- everyone who finishes all 4 stations is a Field Day Champion!",
        ],
        "safety_line": "Complete each station fully and safely before moving to the next -- this is about finishing, not rushing.",
        "image_prompt": "A festive, colorful illustration of a playground with four different retro-game stations happening at once -- a sack race, an egg-and-spoon walk, a three-legged race, and a Mother May I line -- with a big handmade 'Field Day' banner overhead. Flat colorful children's-book illustration style, no text.",
    },
]

GRADE_TARGET_COUNT = 7


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"80s Inspiration: {game['inspiration']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 82_outdoor_games_retro80s_batch2.sql")
    out.append("-- Extends the existing 'Outdoor Games' category (see 68/69/70/71) with 7")
    out.append("-- more games per grade (35 -> 42), continuing the 1980s-retro theme from")
    out.append("-- batch 71 with a fresh set of classic playground/field-day mechanics not")
    out.append("-- already covered: Red Rover, Mother May I, Steal the Bacon, Sack Race, Egg")
    out.append("-- and Spoon Race, Three-Legged/Wheelbarrow Race, plus one special per grade")
    out.append("-- (London Bridge, Tetherball, Roller Skating Relay, Ghost in the Graveyard).")
    out.append("--")
    out.append("-- Appends to the SAME per-grade PacketCategories row with sort_order")
    out.append("-- continuing from 36. target_count stays at 7 per batch (14 retro-80s")
    out.append("-- games total per grade after this migration).")
    out.append("-- See gen_82_outdoor_games_retro80s_batch2.py.")
    out.append("")
    out.append("IF NOT EXISTS (")
    out.append("    SELECT 1 FROM dbo.PacketQuestions q")
    out.append("    JOIN dbo.PacketCategories c ON c.category_id = q.category_id")
    out.append("    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 36")
    out.append(")")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == GRADE_TARGET_COUNT, f"grade {grade_id} has {len(games)} games, expected {GRADE_TARGET_COUNT}"
        var = f"@cat_80s2_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    SELECT {var} = category_id FROM dbo.PacketCategories "
            f"WHERE grade_id = {grade_id} AND category_name = 'Outdoor Games';"
        )
        for i, game in enumerate(games):
            sort_order = 36 + i
            prompt = build_prompt(game)
            diagram_data = {"steps": game["steps"]}
            cols = ["category_id", "question_type", "prompt", "choices_json", "answer_text", "sort_order", "diagram_type", "diagram_data"]
            vals = [var, esc("short_response"), esc(prompt), "NULL", esc(game["safety_line"]), str(sort_order),
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


def emit_image_prompts_doc():
    out = []
    out.append("# Outdoor Games -- 1980s Retro Batch 2 -- Illustrator / AI Image Prompts")
    out.append("")
    out.append("Reference doc only -- not stored in the app database. One detailed prompt")
    out.append("per game, organized by grade, for a future illustration pass.")
    out.append("")
    for grade_id in GRADE_IDS:
        out.append(f"## {GRADE_LABELS[grade_id]}")
        out.append("")
        for game in GAMES[grade_id]:
            out.append(f"### {game['name']}")
            out.append("")
            out.append(f"*80s Inspiration: {game['inspiration']}*")
            out.append("")
            out.append(game["image_prompt"])
            out.append("")
    return "\n".join(out)


def check_completeness():
    ok = True
    all_names = []
    for grade_id in GRADE_IDS:
        n = len(GAMES[grade_id])
        if n != GRADE_TARGET_COUNT:
            print(f"INCOMPLETE: grade {GRADE_LABELS[grade_id]} has {n} games, expected {GRADE_TARGET_COUNT}")
            ok = False
        names = [g["name"] for g in GAMES[grade_id]]
        if len(names) != len(set(names)):
            print(f"DUPLICATE within grade {GRADE_LABELS[grade_id]}: {[n for n in names if names.count(n) > 1]}")
            ok = False
        all_names.extend(names)
        for game in GAMES[grade_id]:
            for key in ("name", "inspiration", "objective", "materials", "steps", "safety_line", "image_prompt"):
                if key not in game or not game[key]:
                    print(f"MISSING '{key}' in grade {GRADE_LABELS[grade_id]} game {game.get('name')}")
                    ok = False
    if len(all_names) != len(set(all_names)):
        dupes = [n for n in all_names if all_names.count(n) > 1]
        print(f"DUPLICATE across grades: {set(dupes)}")
        ok = False
    return ok


if __name__ == "__main__":
    import sys
    if not check_completeness():
        sys.exit(1)
    total_games = sum(len(v) for v in GAMES.values())
    print(f"Grades: {len(GAMES)}, Total new games: {total_games}", file=sys.stderr)
    with open(r"D:\Project\www\littlescholarhub\lsh.database\82_outdoor_games_retro80s_batch2.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    with open(r"D:\Project\www\littlescholarhub\scratch_tmp\outdoor_games_retro80s_batch2_image_prompts.md", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_image_prompts_doc())
    print("Wrote 82_outdoor_games_retro80s_batch2.sql and image-prompts doc", file=sys.stderr)
