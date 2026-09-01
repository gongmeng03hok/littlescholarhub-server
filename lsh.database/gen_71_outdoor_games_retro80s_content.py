# -*- coding: utf-8 -*-
"""
Generates lsh.database/71_outdoor_games_retro80s_content.sql — extends the
existing 'Outdoor Games' category with 7 more games per grade (28 -> 35
per grade, 56 new games), each inspired by a classic, traditional (public-
domain) 1980s-era playground game mechanic: hopscotch, kick the can, four
square, jump rope/double dutch, wall ball, jacks, and chalk pavement
games. No branded/copyrighted games, songs, or specific franchise IP —
just the traditional game mechanics themselves, scaled by grade.

New structural field vs. batches 68-70: each game now also carries an
"80s Inspiration" one-liner. Embedded into the same `prompt` text (a new
labeled section between Name and Objective) so it's visible wherever the
game already renders, and parsed out by the admin API the same way
Objective/Materials already are.

Also emits outdoor_games_retro80s_image_prompts.md — the companion
illustrator/AI-image-prompt reference doc (still not stored in the DB —
nothing in the app renders images).

Run with: python gen_migration_71.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🦶 Toe-Tap Hopscotch",
        "objective": "Practice hopping and balance on a simple 4-square chalk hopscotch course.",
        "inspiration": "A simplified version of the classic hopscotch grid kids have chalked onto sidewalks for generations.",
        "materials": ["Playground chalk"],
        "steps": [
            "Draw 4 big squares in a row with chalk, numbered 1 to 4.",
            "Hop into square 1 on one foot, then square 2, and so on.",
            "Hop all the way to 4, then turn around and hop back.",
            "Try again, hopping a little faster each time!",
        ],
        "safety_line": "Hop carefully to keep your balance — it's not a race.",
        "image_prompt": "A bird's-eye view illustration of 4 large chalk squares drawn in a straight row on gray pavement, numbered 1 through 4 in bold chalk numerals, with a young child mid-hop landing on one foot inside square 2, arms out for balance. Bright, simple, colorful flat children's-book illustration style.",
    },
    {
        "name": "🥊 Freeze Tag Throwback",
        "objective": "Practice quick running and freezing completely still when tagged, just like retro playground tag.",
        "inspiration": "A classic schoolyard tag variant that's been played on playgrounds for decades.",
        "materials": ["None — just open space!"],
        "steps": [
            "One player is 'It' and gently tags others.",
            "Tagged players freeze in place like a statue.",
            "Un-frozen players can tag a frozen friend to set them free.",
            "Play until everyone is frozen, then pick a new 'It'!",
        ],
        "safety_line": "Tag gently with an open hand, and freeze safely wherever you are.",
        "image_prompt": "A playful playground illustration showing one child reaching out to tag another, who freezes mid-run with arms out like a statue, while a third un-frozen child runs over to tap the frozen player free. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪢 Big Rope Jump-In",
        "objective": "Practice timing and jumping by hopping into a gently-swinging long rope.",
        "inspiration": "A gentle version of the long jump-rope games where two turners swing a rope for others to jump in.",
        "materials": ["1 long jump rope"],
        "steps": [
            "Two grown-ups or big kids hold each end of a long rope and swing it low and slow along the ground.",
            "Watch the rope swing back and forth.",
            "Time your jump to hop over the rope as it swings near your feet.",
            "Take turns jumping in!",
        ],
        "safety_line": "Turners should swing slowly and low to the ground for little jumpers.",
        "image_prompt": "A cheerful illustration showing two children gently swinging a long jump rope low along the ground in a wide arc, while a third child watches closely, timing a small hop over the rope as it passes near their feet. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🧮 Bean Bag Toss Classic",
        "objective": "Practice tossing and aiming beanbags at a chalk-drawn target.",
        "inspiration": "A simple version of the beanbag toss games common on 1980s playgrounds and school fairs.",
        "materials": ["3-4 beanbags", "Playground chalk"],
        "steps": [
            "Draw a big circle target on the ground with chalk.",
            "Stand a few steps back behind a chalk line.",
            "Take turns tossing beanbags, trying to land them inside the circle.",
            "Count how many you get in!",
        ],
        "safety_line": "Only toss beanbags toward the target, never at people.",
        "image_prompt": "A top-down illustration of a large chalk circle target drawn on pavement, with a beanbag mid-air arcing toward it and one beanbag already inside, thrown by a child standing behind a chalk starting line a few steps away. Bright, clear flat children's-book illustration style, no text.",
    },
    {
        "name": "🖍️ Chalk Path Walk",
        "objective": "Practice balance and following a path by walking along a winding chalk line.",
        "inspiration": "Inspired by the winding chalk paths and hopscotch trails kids used to draw across playgrounds.",
        "materials": ["Playground chalk"],
        "steps": [
            "Draw a long, winding line on the pavement with chalk.",
            "Walk along the line, trying to stay on it the whole way.",
            "Try walking backward once you reach the end!",
            "Draw a new, curvier path and try again.",
        ],
        "safety_line": "Walk slowly and carefully to keep your balance.",
        "image_prompt": "A bird's-eye view illustration of a long, curvy chalk line winding across pavement, with a child walking carefully along it, arms out for balance, one foot placed exactly on the line. Bright, colorful chalk against gray pavement. Flat children's-book illustration style, no text.",
    },
    {
        "name": "🪑 Musical Chairs Throwback",
        "objective": "Practice quick reactions by finding a chair before the music stops.",
        "inspiration": "The classic musical chairs game that's been a party and playground favorite since long before the 1980s.",
        "materials": ["Chairs (one fewer than the number of players)", "Music (clapping or humming works too!)"],
        "steps": [
            "Set up chairs in a circle, facing outward, one fewer chair than players.",
            "Walk around the chairs while music plays (or while everyone claps a beat).",
            "When the music stops, sit in the nearest chair!",
            "Remove one chair each round — whoever doesn't get a seat cheers on the rest.",
        ],
        "safety_line": "Sit down carefully — no pushing to grab a chair.",
        "image_prompt": "A lively illustration showing 4 chairs arranged in a circle facing outward, with children walking around them, one child mid-sit-down landing in a chair with a happy surprised expression as the others react to the music stopping. Bright playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤫 Statue Freeze Retro",
        "objective": "Practice freezing in a funny pose and holding perfectly still.",
        "inspiration": "A simple version of retro 'statues' games where kids freeze in silly poses and try not to move.",
        "materials": ["None — just kids and open space!"],
        "steps": [
            "Everyone spins around once, then freezes in a silly pose.",
            "Hold your pose as still as you can.",
            "A grown-up gently checks — anyone who wiggles or giggles too much starts over.",
            "See who can hold the silliest pose the longest!",
        ],
        "safety_line": "Choose a pose you can hold safely without losing your balance.",
        "image_prompt": "A playful illustration showing 3 children frozen in silly statue poses on a playground — one with arms out like a scarecrow, one balanced on one foot, one mid-funny-face — all holding very still. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[1] = [
    {
        "name": "🦶 Classic Hopscotch Ladder",
        "objective": "Practice hopping in a pattern of single and double squares along a chalk hopscotch ladder.",
        "inspiration": "The full classic hopscotch grid — single squares hopped on one foot, side-by-side squares landed on with both feet.",
        "materials": ["Playground chalk", "A small stone or beanbag marker"],
        "steps": [
            "Draw a hopscotch ladder with chalk: squares 1-8, with 2-3 and 6-7 drawn side by side.",
            "Toss your marker onto square 1.",
            "Hop through the ladder on one foot for single squares, both feet for side-by-side squares, skipping the marker's square.",
            "Pick up your marker on the way back, then toss it to the next number!",
        ],
        "safety_line": "Hop carefully to keep your balance on each square.",
        "image_prompt": "A bird's-eye view illustration of a classic hopscotch grid drawn in colorful chalk on pavement, numbered 1 through 8, with squares 2-3 and 6-7 drawn as side-by-side pairs for two-footed landings. A small beanbag marker sits in square 4, and a child hops on one foot in square 3, arms out for balance. Clear, colorful diagram-style flat illustration.",
    },
    {
        "name": "🥤 Kick the Can Lite",
        "objective": "Practice hiding, sneaking, and quick running in a gentle version of the classic can-kicking game.",
        "inspiration": "A simplified version of Kick the Can, a beloved dusk-till-dark neighborhood game for generations of kids.",
        "materials": ["1 empty plastic bottle or bucket (standing in for the 'can')"],
        "steps": [
            "Set the 'can' (bottle) in the middle of the play area.",
            "One player is 'It' and guards the can while everyone else hides nearby.",
            "Hiding players try to sneak up and gently tip the can over before being tagged.",
            "If someone kicks the can, everyone who was caught gets a fresh chance to hide!",
        ],
        "safety_line": "Hide only in spots a grown-up allows, and tip the can gently — no kicking it hard.",
        "image_prompt": "A playful illustration showing a plastic bottle standing in the middle of a play area, with a child sneaking up carefully to tip it over while another child (guarding, 'It') watches nearby, and other children peeking from hiding spots behind bushes. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪢 Long Rope Jump-In",
        "objective": "Practice timing your jump into a swinging long rope and jumping a few times before hopping out.",
        "inspiration": "The classic long jump-rope game where two turners swing a rope for others to run in and jump.",
        "materials": ["1 long jump rope"],
        "steps": [
            "Two players turn a long rope in a steady, even swing.",
            "Watch the rope and time your run-in as it swings up and away from you.",
            "Jump 3-5 times, then run back out.",
            "Take turns jumping in and turning the rope!",
        ],
        "safety_line": "Turn the rope at a steady, gentle pace for beginners.",
        "image_prompt": "A dynamic illustration of two children turning a long jump rope in a wide swinging arc, while a third child jumps in the middle mid-jump, feet off the ground, focused timing expression. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Beanbag Board Toss",
        "objective": "Practice aiming beanbags at numbered chalk zones to score points.",
        "inspiration": "A pavement version of the classic beanbag toss boards found at school carnivals and playgrounds.",
        "materials": ["3-4 beanbags", "Playground chalk"],
        "steps": [
            "Draw 3 chalk circles, one inside the other, labeled 1, 2, and 3 points from outside in.",
            "Stand behind a chalk line a few steps back.",
            "Toss beanbags, adding up your points based on where they land.",
            "Play 3 rounds and total your score!",
        ],
        "safety_line": "Only toss toward the target, never at people.",
        "image_prompt": "A top-down illustration of 3 concentric chalk circles on pavement labeled '1', '2', '3' from outer to inner, with a beanbag mid-air flying toward the center ring, thrown from a chalk line a few steps away. Bright, clear scoring-diagram-style flat illustration.",
    },
    {
        "name": "🏃 TV Tag Retro",
        "objective": "Practice quick thinking and running by naming something to become briefly safe from tag.",
        "inspiration": "A playground twist on tag where calling out a word (like a TV show name) makes you safe for a few seconds.",
        "materials": ["None — just open space!"],
        "steps": [
            "One player is 'It' and chases the others.",
            "If about to be tagged, a player can crouch down and shout out any word (an animal, a color, a food) to be briefly safe.",
            "You can't use the same word twice in a row — think fast!",
            "Once safe, count to 3 before standing back up to keep playing.",
        ],
        "safety_line": "Tag gently, and give a crouching player a moment to think of their word.",
        "image_prompt": "An energetic playground illustration showing a child crouched down with a speech bubble containing a simple word icon (like a star), safe from a nearby chaser who is reaching out but stopping short, respecting the safe zone. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🖍️ Four-Square Warm-Up",
        "objective": "Practice the basic bounce-and-hit rules of four square in a simplified starter version.",
        "inspiration": "An easier version of Four Square, the classic ball-bouncing playground game played in a chalk-divided court.",
        "materials": ["1 bouncy ball", "Playground chalk"],
        "steps": [
            "Draw a big square divided into 4 smaller squares, numbered 1-4.",
            "One player stands in each square.",
            "The player in square 1 bounces the ball into another square.",
            "Keep bouncing the ball between squares — if it bounces twice in your square, you're out and a new player rotates in!",
        ],
        "safety_line": "Hit the ball gently with an open hand, not a hard punch.",
        "image_prompt": "A bird's-eye view illustration of a chalk-drawn court divided into 4 equal squares numbered 1 through 4, each with a child standing inside. A bouncy ball is shown mid-bounce inside square 3, arriving from square 1 with a dotted arc line. Bright pavement background. Flat colorful children's-book illustration style, clear diagram feel.",
    },
    {
        "name": "🪑 Musical Spots Throwback",
        "objective": "Practice quick reactions by finding an empty chalk spot before the music stops.",
        "inspiration": "A no-chairs playground version of musical chairs, using chalk circles instead.",
        "materials": ["Playground chalk", "Music (clapping or humming works too!)"],
        "steps": [
            "Draw chalk circles on the ground, one fewer than the number of players.",
            "Walk around the circles while music plays (or everyone claps a beat).",
            "When the music stops, jump into the nearest empty circle!",
            "Erase one circle each round — last player standing wins!",
        ],
        "safety_line": "Step (don't dive) into circles to avoid bumping heads with a friend.",
        "image_prompt": "A bird's-eye view illustration of several chalk circles scattered on pavement, with children walking around them, one child mid-jump landing inside a circle, arms out, as the music stops. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[2] = [
    {
        "name": "🦶 Hopscotch Challenge",
        "objective": "Practice hopping through a full 1-10 hopscotch course with speed and balance.",
        "inspiration": "The classic full-length hopscotch course, a sidewalk-chalk staple for generations.",
        "materials": ["Playground chalk", "A small stone or beanbag marker"],
        "steps": [
            "Draw a hopscotch course numbered 1 to 10, with paired squares for two-footed landings.",
            "Toss your marker onto square 1 and hop through the course, skipping that square.",
            "Turn around at 10, hop back, and pick up your marker on the way.",
            "Toss to the next number and keep going — see who finishes the whole course first!",
        ],
        "safety_line": "Hop carefully — balance matters more than speed.",
        "image_prompt": "A bird's-eye view illustration of a full chalk hopscotch course numbered 1 through 10 on pavement, with paired squares for two-footed landings drawn at intervals, a beanbag marker in square 6, and a child hopping through on one foot with focused balance. Clear, colorful diagram-style flat illustration.",
    },
    {
        "name": "🥤 Kick the Can Classic",
        "objective": "Combine hiding, sneaking, and running strategy in the classic can-guarding game.",
        "inspiration": "Kick the Can, a beloved neighborhood evening game that mixes hide-and-seek with a race to free everyone caught.",
        "materials": ["1 empty plastic bottle or bucket (the 'can')"],
        "steps": [
            "Place the can in the center; one player guards it while everyone else hides.",
            "The guard tags hiders they spot, sending them to a 'jail' near the can.",
            "Other hiders can sneak up and kick the can to free everyone in jail.",
            "If the guard tags everyone before the can is kicked, they win — otherwise, pick a new guard and play again!",
        ],
        "safety_line": "Hide only in approved spots, and kick the can gently — a light tap is enough.",
        "image_prompt": "A dynamic playground illustration showing a plastic bottle in the center with two children standing nearby in a marked 'jail' zone, while another child sneaks up to gently kick the can, and the guard (mid-turn, noticing) reaches to tag a different hider nearby. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔲 Four Square Basics",
        "objective": "Learn and apply the basic rules of Four Square: serving, bouncing, and elimination.",
        "inspiration": "Four Square, one of the most iconic 1980s blacktop games, played in a chalk-divided court with a bouncy ball.",
        "materials": ["1 bouncy ball", "Playground chalk"],
        "steps": [
            "Draw a court divided into 4 squares, numbered 1-4, with square 4 as the 'server.'",
            "The server bounces the ball into another player's square.",
            "That player must hit it into someone else's square before it bounces twice.",
            "Miss, or hit out of bounds, and you're out — the next waiting player rotates in!",
        ],
        "safety_line": "Hit the ball with an open hand only — no punching or kicking.",
        "image_prompt": "A bird's-eye diagram of a chalk four-square court with squares numbered 1 to 4, each occupied by a child, and the ball mid-bounce traveling from square 4 to square 2 with a dotted arc line. Bright, clear diagram-style flat illustration.",
    },
    {
        "name": "🪢 Jump Rope Rhyme Time",
        "objective": "Practice steady jump-rope rhythm while chanting an original counting rhyme.",
        "inspiration": "Classic jump-rope games where turners chant a rhyme while a jumper keeps time with their feet.",
        "materials": ["1 jump rope"],
        "steps": [
            "Two players turn the rope while everyone chants together: 'Jump so high, touch the sky, count along as the seconds fly — 1, 2, 3...'",
            "The jumper keeps jumping and counting along with the chant.",
            "See how high you can count before missing a jump!",
            "Take turns being the jumper and the turners.",
        ],
        "safety_line": "Turn the rope at a steady pace the jumper can keep up with.",
        "image_prompt": "A cheerful illustration of two children turning a jump rope in a steady arc, with a third child jumping in the middle, small floating number icons (1, 2, 3) above them showing their count, all with joyful rhythmic expressions. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "⚾ Wall Ball Retro",
        "objective": "Practice throwing and catching a ball off a wall using simple rules.",
        "materials": ["1 rubber ball", "A flat outdoor wall"],
        "inspiration": "Wall Ball, a simple throw-and-catch game that's been a recess favorite against any handy wall for decades.",
        "steps": [
            "Stand a few steps back from a flat wall.",
            "Throw the ball against the wall and catch it after one bounce.",
            "Take turns, trying different throws — underhand, overhand, bounce first.",
            "If you drop it, it's the next player's turn!",
        ],
        "safety_line": "Throw at a wall with no windows nearby, and watch for others waiting their turn.",
        "image_prompt": "A simple illustration showing a child throwing a rubber ball at a blank brick wall, with a dotted line showing the ball's path bouncing back toward them, ready to catch it. Bright playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🐌 Sidewalk Snail Spiral",
        "objective": "Practice hopping through a spiral-shaped hopscotch course from the outside in.",
        "inspiration": "A spiral variation of hopscotch, sometimes called a 'snail,' popular on playgrounds as an alternative to the standard ladder shape.",
        "materials": ["Playground chalk"],
        "steps": [
            "Draw a spiral of connected squares, starting big on the outside and curling into the center.",
            "Number the squares in order from the outside in.",
            "Hop from square 1 all the way to the center, then hop back out.",
            "Try hopping on one foot the whole way for an extra challenge!",
        ],
        "safety_line": "Hop carefully — the spiral gets tighter near the center, so slow down.",
        "image_prompt": "A bird's-eye view illustration of a spiral-shaped hopscotch course drawn in chalk, starting with large numbered squares on the outside and curling inward to a small numbered square at the center, with a child hopping partway through the spiral. Bright, colorful diagram-style flat illustration.",
    },
    {
        "name": "🏃 Freeze Tag Tournament Retro",
        "objective": "Compete to be the last player still moving in a bracket-style freeze tag showdown.",
        "inspiration": "A tournament twist on the classic playground freeze tag game.",
        "materials": ["None — just open space!"],
        "steps": [
            "Pick 2 players to be 'It' for this round.",
            "Everyone else runs to avoid being tagged; tagged players freeze in place.",
            "Frozen players stay frozen — no unfreezing this round!",
            "Last player still moving becomes an 'It' for the next round!",
        ],
        "safety_line": "Tag gently, and freeze safely wherever you are when tagged.",
        "image_prompt": "A playground illustration showing two children as 'It' chasing others across an open field, with two frozen statue-pose children already tagged in the background, and one player still dodging and weaving to avoid being caught. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[3] = [
    {
        "name": "🦶 Hopscotch Relay Retro",
        "objective": "Combine team relay racing with the classic hopscotch hopping pattern.",
        "inspiration": "Turns the traditional solo hopscotch course into a team relay race.",
        "materials": ["Playground chalk", "2 beanbag markers"],
        "steps": [
            "Draw two identical hopscotch courses (1-10) side by side, one per team.",
            "Split into 2 teams, lined up at each course.",
            "First player hops the full course and back, then tags the next teammate.",
            "First team to have everyone finish wins!",
        ],
        "safety_line": "Hop carefully — a fall slows your team down more than a careful hop.",
        "image_prompt": "A top-down illustration of two identical chalk hopscotch courses side by side on pavement, each numbered 1-10, with a child mid-hop on each course and teammates lined up waiting behind each one. Bright, energetic sports-day style flat illustration, no text.",
    },
    {
        "name": "🥤 Kick the Can Teams",
        "objective": "Apply team strategy to guarding the can and freeing teammates from jail.",
        "inspiration": "A team-based version of the classic Kick the Can game, adding cooperative strategy.",
        "materials": ["1 empty plastic bottle or bucket (the 'can')"],
        "steps": [
            "Split into 2 teams; one team guards the can while the other hides and tries to kick it.",
            "Guards tag hiders and send them to a jail zone near the can.",
            "Hiders sneak up to kick the can and free everyone in jail.",
            "Switch team roles after a set time and see who freed more teammates!",
        ],
        "safety_line": "Hide only in approved spots, and kick the can gently.",
        "image_prompt": "A team-strategy illustration showing a plastic bottle guarded by 2 children, with a jail zone nearby holding 2 caught hiders, while another hider sneaks from behind a tree, ready to dash in and kick the can free. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔲 Four Square Rally",
        "objective": "Practice sustained rallies in four square, keeping the ball in play as long as possible.",
        "inspiration": "A rally-focused twist on the classic 1980s blacktop favorite, Four Square.",
        "materials": ["1 bouncy ball", "Playground chalk"],
        "steps": [
            "Draw a court divided into 4 squares, numbered 1-4.",
            "Play normal four square rules, but count out loud how many hits happen in a row without a miss.",
            "Try to beat your group's best rally count!",
            "If someone's out, a new player rotates in and the rally count keeps going.",
        ],
        "safety_line": "Hit with an open hand only, keeping hits controlled.",
        "image_prompt": "A bird's-eye diagram of a chalk four-square court with squares numbered 1-4, a ball mid-bounce between squares, and a small floating rally-count number ('12!') shown above the court to represent the ongoing streak. Clear, colorful diagram-style flat illustration.",
    },
    {
        "name": "🪢 Double Dutch Intro",
        "objective": "Learn the basics of jumping between two ropes turning in opposite directions.",
        "inspiration": "Double Dutch, the iconic two-rope jump style that became hugely popular on playgrounds through the 1980s.",
        "materials": ["2 jump ropes"],
        "steps": [
            "Two turners hold two ropes, turning them in opposite, alternating directions.",
            "Watch the rhythm of the ropes before jumping in.",
            "Time your jump to enter between the ropes and jump a few times.",
            "Practice slowly at first — speed comes with practice!",
        ],
        "safety_line": "Start with slow, gentle turns until the jumper gets the timing down.",
        "image_prompt": "A dynamic illustration of two children turning two jump ropes in opposite alternating arcs, with a third child jumping carefully between them, focused timing expression, feet lifted mid-jump. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "⚾ Wall Ball Challenge",
        "objective": "Practice more advanced wall-ball throws and catches with added challenge rules.",
        "materials": ["1 rubber ball", "A flat outdoor wall", "Playground chalk (optional, for a throwing line)"],
        "inspiration": "A leveled-up version of the classic recess wall-ball game, adding challenge moves.",
        "steps": [
            "Draw a throwing line a few steps from the wall.",
            "Take turns throwing and catching, adding a challenge each round (clap once before catching, spin around, catch behind your back).",
            "If you miss a challenge catch, you're out for that round.",
            "Last player still completing challenges wins!",
        ],
        "safety_line": "Only attempt challenges you feel confident and safe doing.",
        "image_prompt": "An illustration of a child clapping once before catching a rubber ball bouncing back from a wall, with a chalk throwing line a few steps away and a small dotted line showing the ball's path. Bright playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🖍️ Chalk Spot Shuffle",
        "objective": "Practice following called-out directions to move hands and feet onto different colored chalk spots.",
        "inspiration": "A pavement chalk game inspired by classic hand-and-foot placement party games from the 80s.",
        "materials": ["Playground chalk (multiple colors)"],
        "steps": [
            "Draw a grid of colored chalk spots in front of each player.",
            "A caller shouts directions like 'left hand on blue!' or 'right foot on red!'",
            "Move your hands and feet to match, without falling over.",
            "Keep adding directions until someone loses their balance!",
        ],
        "safety_line": "Play on a soft or flat surface in case someone tips over.",
        "image_prompt": "A colorful illustration of a grid of chalk spots in different colors (red, blue, yellow, green) on pavement, with a child stretched into a funny pose, one hand on a blue spot and one foot on a red spot, balancing carefully. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "❌ Sidewalk Tic-Tac-Toe Toss",
        "objective": "Combine beanbag-tossing accuracy with the classic 3-in-a-row strategy game.",
        "inspiration": "Merges a chalk-drawn tic-tac-toe grid with the classic beanbag-toss accuracy games of the era.",
        "materials": ["Playground chalk", "2 sets of different-colored beanbags (or rocks)"],
        "steps": [
            "Draw a large tic-tac-toe grid on the ground with chalk.",
            "Two players take turns tossing their colored beanbag into a grid square from a throwing line.",
            "The beanbag stays wherever it lands, claiming that square.",
            "First player to get 3 in a row wins!",
        ],
        "safety_line": "Toss beanbags gently, never at people.",
        "image_prompt": "A bird's-eye view illustration of a large chalk tic-tac-toe grid on pavement, with 2 different-colored beanbags already placed in squares forming a partial line, and a third beanbag mid-air flying toward an empty square. Bright, clear game-diagram style flat illustration.",
    },
]


GAMES[4] = [
    {
        "name": "🦶 Hopscotch Speed Round",
        "objective": "Race against the clock to complete a hopscotch course as fast as possible without mistakes.",
        "inspiration": "Adds a speed-challenge twist to the traditional hopscotch course.",
        "materials": ["Playground chalk", "A beanbag marker", "A stopwatch or phone timer"],
        "steps": [
            "Draw a 1-10 hopscotch course with chalk.",
            "Time yourself hopping the full course and back, tossing the marker as usual.",
            "If you step on a line or miss a square, add 2 seconds as a penalty.",
            "Try to beat your own best time across several rounds!",
        ],
        "safety_line": "Go fast, but not so fast you lose your balance and fall.",
        "image_prompt": "A dynamic bird's-eye illustration of a full chalk hopscotch course numbered 1-10, with a child mid-hop showing motion-blur speed lines, and a stopwatch icon in the corner showing elapsed time. Clear, energetic diagram-style flat illustration.",
    },
    {
        "name": "🥤 Kick the Can Strategy",
        "objective": "Apply advanced hiding and timing strategy to outsmart the can's guard.",
        "inspiration": "A more strategic version of the classic Kick the Can game, emphasizing planning over just running.",
        "materials": ["1 empty plastic bottle or bucket (the 'can')"],
        "steps": [
            "One player guards the can; everyone else plans hiding spots that allow a fast sneak-up.",
            "Guards must balance watching for hiders and watching the can itself.",
            "Hiders coordinate — one might distract the guard while another sneaks in to kick the can.",
            "Discuss strategy afterward: what worked, what didn't?",
        ],
        "safety_line": "Hide only in approved spots, and kick the can gently.",
        "image_prompt": "A strategic playground illustration showing one child distracting the can's guard from one side while another child sneaks in from the opposite direction to kick the can, with a dotted arrow showing the sneaking path. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔲 Four Square Tournament Retro",
        "objective": "Compete in a bracket-style four square tournament applying full classic rules.",
        "inspiration": "A full-fledged tournament format built around the classic 1980s blacktop favorite, Four Square.",
        "materials": ["1 bouncy ball", "Playground chalk", "A simple bracket sheet"],
        "steps": [
            "Draw a four square court and set up a rotation line for waiting challengers.",
            "Play standard rules — miss or hit out, go to the back of the line, next player rotates in.",
            "Track how many rounds each player survives as 'king/queen' of square 4.",
            "Crown the player with the most total rounds won as tournament champion!",
        ],
        "safety_line": "Hit the ball with an open hand only, keeping hits controlled.",
        "image_prompt": "A bird's-eye diagram of a chalk four-square court with a line of waiting challengers off to the side, and a simple tournament bracket sheet nearby with small crown icons next to leading players. Clear, colorful diagram-style flat illustration.",
    },
    {
        "name": "🪢 Double Dutch Jump Challenge",
        "objective": "Practice sustained double dutch jumping and counting consecutive jumps.",
        "inspiration": "Builds on the classic Double Dutch two-rope jumping tradition with an endurance challenge.",
        "materials": ["2 jump ropes"],
        "steps": [
            "Two turners swing two ropes in opposite alternating arcs at a steady pace.",
            "The jumper enters and jumps continuously, counting out loud.",
            "See how many jumps in a row you can do before missing.",
            "Switch roles and try to beat the group's best count!",
        ],
        "safety_line": "Turn the ropes at a pace the jumper can safely keep up with.",
        "image_prompt": "A dynamic illustration of two children turning two jump ropes in opposite arcs, with a jumper mid-air between them and a floating jump-count number above ('24!'), showing an ongoing streak. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "⚾ Wall Ball Ace",
        "objective": "Practice precision throwing to hit specific chalk-marked zones on a wall.",
        "inspiration": "A precision-focused version of the classic recess wall-ball game.",
        "materials": ["1 rubber ball", "A flat outdoor wall", "Playground chalk"],
        "steps": [
            "Draw 3 target zones on the wall (low, middle, high) with chalk, worth different points.",
            "Stand behind a throwing line and call out which zone you're aiming for.",
            "Score points if you hit your called zone and catch the rebound.",
            "Play 5 rounds and total your score!",
        ],
        "safety_line": "Choose a wall with no windows nearby, and throw at a safe height.",
        "image_prompt": "An illustration showing a flat outdoor wall with 3 chalk-marked target zones labeled low, middle, and high with point values, a rubber ball mid-flight toward the middle zone, thrown from a chalk line a few steps away. Clear, scoring-diagram-style flat illustration.",
    },
    {
        "name": "⚪ Marbles Ring Toss",
        "objective": "Practice aiming and flicking marbles to knock others out of a chalk-drawn ring.",
        "inspiration": "A gentle version of the classic marbles ring game, one of the most popular pocket games of the era.",
        "materials": ["A handful of marbles (large, supervised — or use small rocks/bottle caps)", "Playground chalk"],
        "steps": [
            "Draw a circle on the ground and place several marbles inside it.",
            "Take turns flicking your own marble from outside the circle, trying to knock others out.",
            "Any marble knocked out of the circle is collected by whoever knocked it out.",
            "Keep playing until all marbles are out — whoever collected the most wins!",
        ],
        "safety_line": "Use marbles only with grown-up supervision, and keep them out of your mouth.",
        "image_prompt": "A top-down illustration of a chalk circle on pavement with several small marbles scattered inside, and a child crouched down flicking one marble from outside the ring toward the cluster, dotted line showing its path. Clear, focused game-diagram style flat illustration.",
    },
    {
        "name": "🪢 Elastics Jump Challenge",
        "objective": "Practice jumping footwork patterns using a big loop of elastic held between two players' ankles.",
        "inspiration": "Elastics (also called Chinese jump rope), where a big loop of elastic is stretched between two players' legs while a third jumps a set pattern of footwork.",
        "materials": ["1 long loop of elastic (or a few rubber bands tied together, or a soft rope loop)"],
        "steps": [
            "Two players stand facing each other with the elastic loop stretched around both their ankles.",
            "A third player jumps a pattern: in, out, on top of both strands, side to side.",
            "If you complete the pattern without a mistake, the elastic moves up to knee height for a harder round!",
            "Take turns being a 'post' and the jumper.",
        ],
        "safety_line": "Keep the elastic loose enough that it won't trip anyone, and stop if it gets too tight.",
        "image_prompt": "An illustration showing two children standing facing each other with a loop of elastic stretched around their ankles forming two parallel lines, while a third child jumps between and around the strands mid-pattern, focused footwork expression. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[5] = [
    {
        "name": "🦶 Hopscotch Master Challenge",
        "objective": "Design and complete a custom advanced hopscotch course with mixed hopping patterns.",
        "inspiration": "Takes the classic hopscotch ladder and lets players design their own advanced layout.",
        "materials": ["Playground chalk", "A beanbag marker"],
        "steps": [
            "Design your own hopscotch course — mix single squares, side-by-side squares, and a few extra-large 'jump' squares.",
            "Test your own course first.",
            "Challenge a friend to complete your course, then try theirs.",
            "Compare which course was trickiest and why!",
        ],
        "safety_line": "Test your own course before challenging a friend, checking for safe spacing.",
        "image_prompt": "A bird's-eye view illustration of a creative, non-standard hopscotch course with a mix of single squares, paired squares, and one extra-wide 'jump' square, numbered in a custom order, with a child mid-hop navigating the unusual layout. Clear, colorful diagram-style flat illustration.",
    },
    {
        "name": "🥤 Kick the Can Championship",
        "objective": "Apply full team strategy across multiple rounds of the classic can-guarding game.",
        "inspiration": "A championship format built around the enduring neighborhood classic, Kick the Can.",
        "materials": ["1 empty plastic bottle or bucket (the 'can')"],
        "steps": [
            "Play several rounds, rotating who guards the can.",
            "Track how many times each guard successfully catches everyone versus how many times the can gets kicked.",
            "Discuss strategy adjustments between rounds.",
            "Crown the champion guard (fewest cans kicked) and champion sneaker (most cans kicked)!",
        ],
        "safety_line": "Hide only in approved spots, and kick the can gently.",
        "image_prompt": "A championship-themed illustration showing a plastic bottle in the center of a play area with a scoreboard nearby tracking 'Cans kicked: 3, Guard catches: 5', and children mid-action sneaking and guarding around the can. Bright sunny background. Flat colorful children's-book illustration style, no text besides the scoreboard numbers.",
    },
    {
        "name": "🔲 Four Square King/Queen League",
        "objective": "Compete in an ongoing four square league, tracking who holds the top square the longest.",
        "inspiration": "Builds a league format around the blacktop classic Four Square, tracking long-term standings.",
        "materials": ["1 bouncy ball", "Playground chalk", "A league standings sheet"],
        "steps": [
            "Draw a four square court and establish a rotation line for challengers.",
            "Play using standard rules, with a special 'king/queen' rule for the square 4 player.",
            "Track each player's total time spent as king/queen across multiple play sessions.",
            "Keep a running league standings sheet — top scorer at the end of the week wins!",
        ],
        "safety_line": "Hit with an open hand only, and keep the game friendly and fair.",
        "image_prompt": "A detailed bird's-eye four-square court diagram with a league standings clipboard nearby showing player names and total 'king/queen' time, a ball mid-bounce in the court. Clear, competitive, professional diagram-style flat illustration.",
    },
    {
        "name": "🪢 Double Dutch Relay",
        "objective": "Combine team relay racing with double dutch jump-rope skills.",
        "inspiration": "Turns the classic Double Dutch jump style into a team relay event.",
        "materials": ["2 jump ropes per team"],
        "steps": [
            "Split into teams; two turners per team swing double dutch ropes.",
            "Each teammate takes a turn jumping in, completing 5 jumps, then jumping out.",
            "The next teammate jumps in immediately after.",
            "First team to have everyone complete their jumps wins!",
        ],
        "safety_line": "Keep turning steady, and give each jumper a clear signal to jump in.",
        "image_prompt": "A team-relay illustration showing two double dutch stations side by side, each with turners swinging ropes and a jumper mid-air completing their turn, with teammates lined up waiting at each station. Bright, energetic sports-day style flat illustration, no text.",
    },
    {
        "name": "⚾ Wall Ball World Cup",
        "objective": "Compete in a bracket-style wall ball tournament applying skill challenges.",
        "inspiration": "A tournament format built around the classic recess wall-ball game.",
        "materials": ["1 rubber ball", "A flat outdoor wall", "A bracket sheet"],
        "steps": [
            "Set up a bracket tournament; players face off in head-to-head wall ball matches.",
            "Each match, players alternate throws, adding challenge moves (spin, clap, catch behind back).",
            "Whoever completes the most successful catches in a set number of rounds advances.",
            "Play through the bracket to crown a World Cup champion!",
        ],
        "safety_line": "Only attempt challenge catches you feel confident doing safely.",
        "image_prompt": "A tournament-themed illustration showing two children facing off in a wall-ball match against a flat wall, with a bracket board nearby tracking match results and a small trophy icon next to the leading player. Bright playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Jacks Retro Challenge",
        "objective": "Practice hand-eye coordination and quick reflexes with the classic game of jacks.",
        "inspiration": "Jacks, a tiny-but-mighty pavement game played with a small ball and metal or plastic pieces, hugely popular through the 1980s.",
        "materials": ["A set of jacks (or small stones/bottle caps)", "1 small bouncy ball"],
        "steps": [
            "Scatter the jacks on a flat surface.",
            "Toss the ball up, and before it bounces twice, pick up 1 jack and catch the ball.",
            "Repeat, picking up 2 jacks at a time, then 3, and so on, each round.",
            "If you miss the ball or knock other jacks out of place, it's the next player's turn!",
        ],
        "safety_line": "Play on a flat, clean surface, and keep small pieces away from younger siblings who might put them in their mouths.",
        "image_prompt": "A close-up illustration of small jacks scattered on pavement, with a child's hand reaching to grab 2 jacks while a small rubber ball is shown mid-bounce above, about to be caught. Clear, focused game-diagram style flat illustration.",
    },
    {
        "name": "👏 Hand-Clap Rhythm Challenge",
        "objective": "Practice memory and rhythm by learning and repeating an original hand-clapping pattern with a partner.",
        "inspiration": "Inspired by the hand-clapping games that were a playground staple, where partners clap out a rhythm together.",
        "materials": ["None — just hands and a partner!"],
        "steps": [
            "Face a partner and learn a simple clap pattern: clap your own hands, then clap both of your partner's hands, then clap your own again.",
            "Practice the pattern slowly until it feels smooth.",
            "Add a chant to keep the beat: 'Clap, clap, together, clap!'",
            "Once you've mastered it, try speeding up together!",
        ],
        "safety_line": "Clap palms gently — this is about rhythm, not force.",
        "image_prompt": "A rhythmic illustration of two children facing each other mid hand-clap, palms touching in the air between them, both with focused joyful expressions, small musical note icons floating nearby to show the beat. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[6] = [
    {
        "name": "🦶 Hopscotch Trick Course",
        "objective": "Master advanced hopping tricks layered onto a standard hopscotch course.",
        "inspiration": "Adds trick-hopping challenges (spins, backward hops) onto the traditional hopscotch course.",
        "materials": ["Playground chalk", "A beanbag marker"],
        "steps": [
            "Draw a standard 1-10 hopscotch course.",
            "Add a 'trick' to specific squares (spin 180° in square 4, hop backward from 7 to 6).",
            "Complete the course including all tricks without falling.",
            "Add your own new trick and challenge a friend to try it!",
        ],
        "safety_line": "Only attempt tricks you can do safely without losing balance.",
        "image_prompt": "A bird's-eye illustration of a chalk hopscotch course numbered 1-10, with small trick icons marked on certain squares (a spin arrow on square 4, a backward arrow between 6 and 7), and a child mid-spin on square 4. Clear, colorful diagram-style flat illustration.",
    },
    {
        "name": "🥤 Kick the Can Advanced Strategy",
        "objective": "Apply layered team strategy, including decoys and timed sneaks, to outsmart the guard.",
        "inspiration": "A more advanced strategic layer added onto the classic Kick the Can game.",
        "materials": ["1 empty plastic bottle or bucket (the 'can')"],
        "steps": [
            "As a team, plan roles before starting: a decoy, a scout, and a sneaker.",
            "The decoy draws the guard's attention on one side of the play area.",
            "The scout signals when the guard is distracted.",
            "The sneaker uses that window to dash in and kick the can — discuss what worked afterward!",
        ],
        "safety_line": "Hide only in approved spots, and kick the can gently.",
        "image_prompt": "A strategic illustration showing 3 students in different roles: one waving to distract the guard on the left, one signaling with a hand gesture from a hidden spot, and one sprinting toward the can from the right side, dotted arrows showing each player's path. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔲 Four Square Pro Rules",
        "objective": "Apply advanced four square rules, including special serves and challenge moves.",
        "inspiration": "Adds advanced 'pro' rule variations to the classic Four Square blacktop game.",
        "materials": ["1 bouncy ball", "Playground chalk"],
        "steps": [
            "Draw a four square court; agree on advanced rules beforehand (allow lobs, spins, or 'around the world' where the ball must bounce in every square in a row).",
            "Play using these pro rules, tracking who holds square 4 the longest.",
            "Rotate in new challengers as players are eliminated.",
            "Discuss which pro rule made the game most exciting!",
        ],
        "safety_line": "Hit with an open hand only, and keep advanced moves controlled and safe.",
        "image_prompt": "A bird's-eye diagram of a four-square court showing an 'around the world' ball path bouncing through all 4 squares in sequence with small numbered arrows (1→2→3→4). Clear, detailed diagram-style flat illustration.",
    },
    {
        "name": "🪢 Double Dutch Freestyle",
        "objective": "Create and perform an original freestyle double dutch routine with tricks.",
        "inspiration": "Freestyle Double Dutch routines were a showcase skill on playgrounds throughout the 1980s.",
        "materials": ["2 jump ropes"],
        "steps": [
            "Two turners swing double dutch ropes at a steady pace.",
            "The jumper enters and adds tricks: a spin, a high knee, jumping on one foot.",
            "Perform your freestyle routine for the group.",
            "Take turns and vote on the most creative routine!",
        ],
        "safety_line": "Only attempt tricks you're confident you can land safely.",
        "image_prompt": "A dynamic illustration of a jumper performing a trick (one knee raised high) between two swinging double dutch ropes, turners on either side, small motion lines showing the athletic movement. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "⚾ Wall Ball Tournament",
        "objective": "Compete in a full bracket tournament applying advanced wall ball rules and scoring.",
        "inspiration": "A full tournament structure built around the enduring recess classic, wall ball.",
        "materials": ["1 rubber ball", "A flat outdoor wall", "A bracket sheet"],
        "steps": [
            "Set up a bracket; players face off in timed wall ball matches.",
            "Score points for successful catches, lose points for drops.",
            "Winners advance through the bracket.",
            "Crown the tournament champion after the final match!",
        ],
        "safety_line": "Choose a wall with no windows nearby, and play at a controlled pace.",
        "image_prompt": "A tournament-themed illustration showing a bracket board with match results, and two students facing off in an active wall-ball match against a flat outdoor wall, ball mid-flight between them. Bright playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Jacks Championship",
        "objective": "Compete through the full progression of jacks levels, from onesies to tensies.",
        "inspiration": "The classic game of jacks, played through its traditional leveled progression of picking up increasing numbers of pieces per toss.",
        "materials": ["A set of jacks (or small stones/bottle caps)", "1 small bouncy ball"],
        "steps": [
            "Scatter the jacks and start at 'onesies' — pick up 1 jack per bounce.",
            "If successful, move up to 'twosies' — pick up 2 at a time, then 'threesies,' and so on.",
            "Whoever reaches the highest level without missing wins that round.",
            "Play multiple rounds and track your personal best level!",
        ],
        "safety_line": "Play on a flat, clean surface, and keep pieces away from anyone who might put them in their mouth.",
        "image_prompt": "A close-up illustration of scattered jacks on pavement with a small ball mid-bounce above, and a child's hand mid-motion sweeping up 3 jacks at once, focused concentrated expression. Clear game-diagram style flat illustration.",
    },
    {
        "name": "🖍️ Chalk Relay Obstacle",
        "objective": "Combine hopscotch hopping and tic-tac-toe tossing into one multi-station chalk relay.",
        "inspiration": "Blends several classic 1980s chalk pavement games into a single relay challenge.",
        "materials": ["Playground chalk", "Beanbags"],
        "steps": [
            "Set up 2 chalk stations: a hopscotch course and a tic-tac-toe toss grid.",
            "Split into teams; each runner hops the hopscotch course, then tosses a beanbag to claim a tic-tac-toe square.",
            "Tag the next teammate to go.",
            "First team to complete both stations for everyone (or get 3 in a row on the tic-tac-toe grid) wins!",
        ],
        "safety_line": "Complete each station fully and carefully before moving to the next.",
        "image_prompt": "A top-down illustration showing two chalk stations connected by a dotted path: a numbered hopscotch course and a tic-tac-toe grid with a few beanbags already placed, with a runner mid-hop at the first station and teammates waiting at the start. Bright, colorful diagram-style flat illustration.",
    },
]


GAMES[7] = [
    {
        "name": "🦶 Hopscotch Innovator Challenge",
        "objective": "Design a completely original hopscotch course layout, then teach others to play it.",
        "inspiration": "Takes creative ownership of the traditional hopscotch format, inviting players to reinvent it.",
        "materials": ["Playground chalk", "A beanbag marker"],
        "steps": [
            "Design your own hopscotch course with a unique shape (a zigzag, a star, a double-track).",
            "Write simple rules for your version.",
            "Teach your course to a partner and watch them try it.",
            "Trade courses with another pair and see whose design is the most fun!",
        ],
        "safety_line": "Test your own course design first to check it's safe to hop.",
        "image_prompt": "A bird's-eye view illustration of a creative, non-traditional hopscotch course shaped like a zigzag with numbered squares, drawn in chalk, with a student demonstrating the course to a partner watching nearby. Clear, inventive, colorful diagram-style flat illustration.",
    },
    {
        "name": "🥤 Kick the Can Strategy League",
        "objective": "Compete across multiple structured rounds, refining team strategy each time.",
        "inspiration": "A league format that treats the classic Kick the Can game as an ongoing strategic competition.",
        "materials": ["1 empty plastic bottle or bucket (the 'can')"],
        "steps": [
            "Play several rounds across a session, rotating guard duty.",
            "After each round, huddle briefly to adjust your team's strategy.",
            "Track results across rounds — which strategies worked best?",
            "Present your team's winning strategy to the group at the end!",
        ],
        "safety_line": "Hide only in approved spots, and kick the can gently.",
        "image_prompt": "A strategic illustration showing a small team huddled together mid-discussion near the play area, with a whiteboard-style thought bubble showing simple strategy icons (a decoy path, a sneak path), the can visible in the background. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔲 Four Square Masters Retro League",
        "objective": "Compete in a season-long four square league, tracking standings across multiple matches.",
        "inspiration": "A full league season built around the enduring blacktop classic, Four Square.",
        "materials": ["1 bouncy ball", "Playground chalk", "A league standings sheet"],
        "steps": [
            "Draw a four square court and set up a challenger rotation line.",
            "Play using agreed-upon advanced rules across multiple sessions.",
            "Track total wins and time spent as king/queen on a running standings sheet.",
            "Crown a season champion at the end of the week!",
        ],
        "safety_line": "Hit with an open hand only, and keep matches friendly and fair.",
        "image_prompt": "A detailed illustration of a chalk four-square court with a league standings clipboard showing multiple players' names and win totals, a ball mid-bounce in play. Clear, competitive, professional diagram-style flat illustration.",
    },
    {
        "name": "🪢 Double Dutch Performance Challenge",
        "objective": "Choreograph and perform a synchronized double dutch routine with multiple jumpers.",
        "inspiration": "Reflects the competitive Double Dutch performance teams that became a genuine sport through the 1980s.",
        "materials": ["2 jump ropes"],
        "steps": [
            "In a small group, choreograph a routine with 2 jumpers taking turns or jumping together.",
            "Practice the timing until the routine feels smooth.",
            "Perform your routine for the rest of the group.",
            "Watch other groups' routines and discuss what made each one impressive!",
        ],
        "safety_line": "Practice each part slowly before performing at full speed.",
        "image_prompt": "A performance-style illustration of two jumpers moving in sync between two swinging double dutch ropes, turners on either side maintaining a steady rhythm, small audience of students watching and clapping nearby. Bright sunny playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "⚾ Wall Ball Grand Championship",
        "objective": "Compete in a full tournament with escalating skill challenges to determine an overall champion.",
        "inspiration": "The ultimate tournament format for the classic recess wall-ball game.",
        "materials": ["1 rubber ball", "A flat outdoor wall", "A bracket sheet"],
        "steps": [
            "Run a full bracket tournament with increasingly harder challenge rounds (basic catch, one-clap catch, spin catch).",
            "Players are eliminated after a set number of misses per round.",
            "Track results through each round of the bracket.",
            "Crown the Grand Champion after the final round!",
        ],
        "safety_line": "Only attempt challenge catches you feel confident doing safely.",
        "image_prompt": "A grand tournament illustration showing a full bracket board with several rounds of results, and two finalists facing off in an intense wall-ball match against a flat wall, small trophy icon nearby. Bright playground background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Jacks Speed Championship",
        "objective": "Race through the full jacks progression as fast as possible while maintaining accuracy.",
        "inspiration": "Adds a speed-run challenge to the traditional leveled game of jacks.",
        "materials": ["A set of jacks (or small stones/bottle caps)", "1 small bouncy ball", "A stopwatch or phone timer"],
        "steps": [
            "Time yourself going through onesies, twosies, threesies, up through as high as you can.",
            "If you miss a catch or bump other jacks, restart that level.",
            "Compare your total time to a friend's.",
            "Try again and see if you can beat your own record!",
        ],
        "safety_line": "Play on a flat, clean surface, and keep pieces away from anyone who might put them in their mouth.",
        "image_prompt": "A close-up dynamic illustration of a student's hand rapidly sweeping up jacks with motion-blur lines showing speed, a small ball mid-bounce above, and a stopwatch icon showing elapsed time in the corner. Clear, energetic game-diagram style flat illustration.",
    },
    {
        "name": "🏆 Retro Playground Pentathlon",
        "objective": "Compete across five classic playground events to determine an all-around champion.",
        "inspiration": "Combines five different 1980s playground classics into one multi-event competition, like a track-and-field pentathlon.",
        "materials": ["Playground chalk", "A jump rope", "A bouncy ball", "Beanbags", "A set of jacks"],
        "steps": [
            "Set up 5 stations: hopscotch speed run, jump rope count, wall ball catches, beanbag toss accuracy, and jacks level reached.",
            "Rotate through all 5 stations, recording your result at each.",
            "Combine your results into an overall pentathlon score.",
            "Compare scores as a group — who's the Retro Playground Champion?",
        ],
        "safety_line": "Complete each event fully and safely before moving to the next station.",
        "image_prompt": "A festive illustration showing 5 different retro-game stations happening at once across a playground: a hopscotch course, a jump rope station, a wall-ball wall, a beanbag toss target, and a jacks station, with a scoreboard nearby tracking combined results. Bright, energetic, competitive flat illustration style.",
    },
]


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
    out.append("-- 71_outdoor_games_retro80s_content.sql")
    out.append("-- Extends the existing 'Outdoor Games' category (see 68/69/70) with 7 more")
    out.append("-- games per grade (28 -> 35), each inspired by a classic, traditional 1980s")
    out.append("-- playground game mechanic (hopscotch, kick the can, four square, jump rope/")
    out.append("-- double dutch, wall ball, jacks, chalk pavement games) — no branded or")
    out.append("-- copyrighted games/songs, just the traditional public-domain mechanics.")
    out.append("--")
    out.append("-- New vs. 68/69/70: each game's prompt now also includes an '80s")
    out.append("-- Inspiration' line (parsed by the admin API the same way as Objective/")
    out.append("-- Materials — see routes/content.py's outdoor_games_library()).")
    out.append("--")
    out.append("-- Appends to the SAME per-grade PacketCategories row with sort_order")
    out.append("-- continuing from 29. target_count stays at 7.")
    out.append("-- See gen_71_outdoor_games_retro80s_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (")
    out.append("    SELECT 1 FROM dbo.PacketQuestions q")
    out.append("    JOIN dbo.PacketCategories c ON c.category_id = q.category_id")
    out.append("    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 29")
    out.append(")")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 7, f"grade {grade_id} has {len(games)} games, expected 7"
        var = f"@cat_80s_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    SELECT {var} = category_id FROM dbo.PacketCategories "
            f"WHERE grade_id = {grade_id} AND category_name = 'Outdoor Games';"
        )
        for i, game in enumerate(games):
            sort_order = 29 + i
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
    out.append("# Outdoor Games — 1980s Retro Batch — Illustrator / AI Image Prompts")
    out.append("")
    out.append("Reference doc only — not stored in the app database. One detailed prompt")
    out.append("per game, organized by grade, for a future illustration pass. Each prompt")
    out.append("explicitly describes chalk lines, boundary markers, and player positioning")
    out.append("per the requested spec.")
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
    for grade_id in GRADE_IDS:
        n = len(GAMES[grade_id])
        if n != 7:
            print(f"INCOMPLETE: grade {GRADE_LABELS[grade_id]} has {n} games, expected 7")
            ok = False
        names = [g["name"] for g in GAMES[grade_id]]
        if len(names) != len(set(names)):
            print(f"DUPLICATE within grade {GRADE_LABELS[grade_id]}: {[n for n in names if names.count(n) > 1]}")
            ok = False
        for game in GAMES[grade_id]:
            for key in ("name", "inspiration", "objective", "materials", "steps", "safety_line", "image_prompt"):
                if key not in game or not game[key]:
                    print(f"MISSING '{key}' in grade {GRADE_LABELS[grade_id]} game {game.get('name')}")
                    ok = False
    return ok


if __name__ == "__main__":
    import sys
    if not check_completeness():
        sys.exit(1)
    total_games = sum(len(v) for v in GAMES.values())
    print(f"Grades: {len(GAMES)}, Total new games: {total_games}", file=sys.stderr)
    with open(r"D:\Project\www\littlescholarhub\lsh.database\71_outdoor_games_retro80s_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    with open(r"D:\Project\www\littlescholarhub\scratch_tmp\outdoor_games_retro80s_image_prompts.md", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_image_prompts_doc())
    print("Wrote 71_outdoor_games_retro80s_content.sql and image-prompts doc", file=sys.stderr)
