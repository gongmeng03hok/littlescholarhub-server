# -*- coding: utf-8 -*-
"""
Generates lsh.database/69_outdoor_games_household_content.sql — extends
the existing 'Outdoor Games' category (added in 68_outdoor_games_content.sql)
with 7 more games per grade (14 -> 21 per grade, 56 new games total), all
using paper, household items, natural materials, or basic stuff most
families already have at home — no purchased sports equipment required.
Many are playable indoors as well as outdoors (noted per game).

Appends to the SAME PacketCategories row per grade (looked up by
grade_id + category_name, not re-created) with sort_order continuing from
15-21. target_count stays at 7 (unchanged) — the larger 21-game pool just
gives more weekly variety, same mechanism as every other category.

Run with: python gen_migration_69.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🍽️ Paper Plate Toss",
        "objective": "Practice tossing and aiming using paper plates as flying discs. Works indoors or outdoors.",
        "materials": ["2-3 paper plates", "A laundry basket or box as a target"],
        "steps": [
            "Set a basket or box a few steps away.",
            "Hold a paper plate flat and gently toss it like a mini frisbee toward the basket.",
            "Try to land the plate inside!",
            "Take turns tossing all the plates, then collect and try again.",
        ],
        "safety_line": "Toss gently — paper plates can flip in the wind, so stay clear of anyone's face.",
        "image_prompt": "A simple indoor/outdoor illustration showing a laundry basket a few steps away, with a paper plate shown mid-flight flying toward it like a small frisbee, a dotted arc trajectory line from a child's hand who just released it. Bright, cheerful flat children's-book illustration style, no text.",
    },
    {
        "name": "🧦 Sock Ball Basket",
        "objective": "Practice tossing a soft rolled-up sock into a basket target.",
        "materials": ["2-3 pairs of socks rolled into balls", "A laundry basket or bucket"],
        "steps": [
            "Roll socks into soft little balls.",
            "Set a basket a few steps away.",
            "Take turns tossing the sock balls, trying to land them in the basket.",
            "Count how many you get in — then try again from a bit farther!",
        ],
        "safety_line": "Sock balls are soft and safe for indoor play, but toss gently near others.",
        "image_prompt": "A cozy indoor scene showing a laundry basket on a rug, with a rolled-up gray sock ball mid-air arcing toward it, and a child in the foreground mid-throw motion, smiling. Warm home interior background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🍂 Leaf & Stick Sorting",
        "objective": "Collect and sort natural items by size, color, or shape.",
        "materials": ["Leaves and sticks found outside", "2-3 sorting bins or hoops (optional)"],
        "steps": [
            "Go outside and collect a handful of leaves and sticks.",
            "Lay them out and sort them into groups — big vs. small, or by color.",
            "Talk about why you put each one in its group.",
            "Mix them up and try sorting a different way!",
        ],
        "safety_line": "Only pick up leaves and sticks a grown-up says are safe to touch.",
        "image_prompt": "An outdoor illustration showing a child crouched on grass, sorting a small pile of leaves and sticks into two clear groups on the ground — one pile of big leaves, one pile of small leaves — with a curious, focused expression. Bright natural garden background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛏️ Pillow Path Walk",
        "objective": "Practice balance and big steps by walking across a path of pillows.",
        "materials": ["4-5 pillows or couch cushions"],
        "steps": [
            "Lay pillows in a line on the floor, like stepping stones.",
            "Walk across, stepping only on the pillows.",
            "Try not to touch the 'floor is lava' space in between!",
            "Rearrange the pillows and try a new path.",
        ],
        "safety_line": "Clear the area of hard furniture edges before playing indoors.",
        "image_prompt": "A cozy living room illustration showing 5 colorful pillows laid out as stepping stones across a rug, with a child mid-step balancing on one pillow with arms out, big careful expression. Warm home interior background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥄 Spoon and Cotton Ball Walk",
        "objective": "Practice balance and steady hands by carrying a cotton ball on a spoon.",
        "materials": ["1 spoon per player", "1 cotton ball (or pom-pom) per player"],
        "steps": [
            "Balance a cotton ball on a spoon.",
            "Walk from one spot to another without dropping it.",
            "If it falls, pick it back up and keep going from where you are.",
            "Try walking faster once you've got the hang of it!",
        ],
        "safety_line": "Walk carefully — this is about steady hands, not speed.",
        "image_prompt": "A simple indoor illustration of a child walking slowly across a room, holding a spoon out in front with a fluffy white cotton ball balanced on top, eyes focused downward in concentration, one arm out for balance. Bright cozy home background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "✈️ Paper Airplane Fly-Off",
        "objective": "Make a simple paper airplane and practice throwing it.",
        "materials": ["1 sheet of paper per player"],
        "steps": [
            "With a grown-up's help, fold a simple paper airplane.",
            "Stand behind a starting line.",
            "Throw your airplane and see how far it flies!",
            "Try again and see if you can beat your own distance.",
        ],
        "safety_line": "Only throw your airplane forward, away from other people's faces.",
        "image_prompt": "A bright indoor or outdoor illustration showing a simple white paper airplane mid-flight with a dotted trajectory line, launched by a child standing behind a chalk or tape starting line, arm extended after the throw, excited expression. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔍 Nature Texture Hunt",
        "objective": "Explore outside and find things that feel different — smooth, rough, soft, bumpy.",
        "materials": ["None — just curious hands and open outdoor space"],
        "steps": [
            "Walk around outside with a grown-up.",
            "Touch different things gently — a smooth rock, rough bark, soft grass, bumpy pinecone.",
            "Talk about how each one feels.",
            "See who can find the softest thing, or the bumpiest thing!",
        ],
        "safety_line": "Only touch things a grown-up says are safe, and wash hands afterward.",
        "image_prompt": "An outdoor illustration of a child gently touching the rough bark of a tree trunk with one hand, with small texture-detail close-up icons nearby showing a smooth rock, soft grass blades, and a bumpy pinecone. Bright natural garden background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[1] = [
    {
        "name": "📰 Newspaper Stomp Ball",
        "objective": "Make a ball out of scrap paper and practice kicking it into a goal.",
        "materials": ["Old newspaper or scrap paper", "Tape", "2 chairs or shoes as goal markers"],
        "steps": [
            "Scrunch newspaper into a ball shape and wrap it with tape.",
            "Set two chairs or shoes a few steps apart as a goal.",
            "Take turns kicking the paper ball toward the goal.",
            "Count how many goals you can score!",
        ],
        "safety_line": "Kick gently along the ground — the ball is soft but keep kicks low.",
        "image_prompt": "A cozy indoor illustration showing a homemade paper ball (crumpled newspaper wrapped in tape) rolling toward a small goal marked by two shoes on the floor, with a child mid-kick nearby. Warm home interior background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🥤 Cup Stack Race",
        "objective": "Practice fine motor skills and speed by stacking and unstacking cups.",
        "materials": ["6-10 plastic cups per player"],
        "steps": [
            "Give each player a stack of cups.",
            "On 'go,' build a pyramid stack as fast as you can.",
            "Then knock it down and stack it again in a single tower!",
            "See who finishes both builds first.",
        ],
        "safety_line": "Use lightweight plastic cups so nothing gets hurt if they tip over.",
        "image_prompt": "An indoor table-top illustration showing a child mid-motion stacking plastic cups into a pyramid shape, with a second smaller single-tower stack already built beside it, focused excited expression. Bright home kitchen or living room background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎨 Rock Painting Match",
        "objective": "Paint or color rocks with matching patterns, then find their pairs.",
        "materials": ["6-8 smooth rocks (collected outside)", "Washable paint or markers"],
        "steps": [
            "Collect smooth rocks from outside.",
            "Paint or color pairs of rocks with matching patterns or colors.",
            "Let them dry, then mix them up face-down.",
            "Flip two at a time trying to find matching pairs, like a memory game!",
        ],
        "safety_line": "Use washable, non-toxic paint and wear old clothes or an apron.",
        "image_prompt": "A bright craft-table illustration showing several smooth rocks painted with colorful matching patterns (dots, stripes, stars) laid out face-up, with a child's hand flipping one rock over to check for a match. Cheerful, artistic flat children's-book illustration style, no text.",
    },
    {
        "name": "⛺ Blanket Fort Builder",
        "objective": "Work together to design and build a cozy fort using blankets and furniture.",
        "materials": ["2-3 blankets or sheets", "Chairs, couch cushions, or a table"],
        "steps": [
            "Gather blankets and find furniture to build around (chairs, a table, a couch).",
            "Drape the blankets to create a fort roof and walls.",
            "Add cushions inside to make it cozy.",
            "Enjoy your fort — read a book or tell stories inside!",
        ],
        "safety_line": "Ask a grown-up before draping blankets over lamps or anything that gets hot.",
        "image_prompt": "A warm, inviting indoor illustration showing a blanket fort built between two chairs and a couch, with a striped blanket draped as a roof, soft cushions visible inside, and a child peeking out happily from the fort entrance. Cozy living room background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🧷 Clothespin Drop",
        "objective": "Practice hand-eye coordination by dropping clothespins into a target container.",
        "materials": ["5-6 clothespins", "1 jar or narrow container"],
        "steps": [
            "Stand up and hold a clothespin at waist height, right above the jar.",
            "Drop the clothespin, trying to get it into the jar.",
            "Count how many out of 5 make it in!",
            "Try holding a little higher for a harder challenge.",
        ],
        "safety_line": "Only drop clothespins straight down into the jar, not toward anyone.",
        "image_prompt": "A simple indoor illustration of a child standing and holding a wooden clothespin above a glass jar on the floor, mid-drop with a dotted line showing the clothespin falling straight down toward the jar opening. Bright home background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "⛵ Paper Boat Race",
        "objective": "Fold a simple paper boat and race it in water.",
        "materials": ["1 sheet of paper per player", "A tub, sink, or shallow puddle of water"],
        "steps": [
            "With a grown-up's help, fold a simple paper boat.",
            "Set your boat in the water at a starting line.",
            "Gently blow on your boat to make it move across the water.",
            "First boat to reach the other side wins!",
        ],
        "safety_line": "Only play near water with a grown-up watching closely.",
        "image_prompt": "A cheerful illustration showing a small folded paper boat floating in a water-filled tub or basin, with a child leaning close and blowing gently to push it forward, small ripple lines showing movement across the water. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "🌿 Stick Balance Walk",
        "objective": "Practice balance and focus by walking along a stick or rope laid on the ground.",
        "materials": ["A long stick, rope, or string laid straight on the ground"],
        "steps": [
            "Lay a long stick or rope in a straight (or gently curving) line on the ground.",
            "Walk along it heel-to-toe, one foot in front of the other.",
            "Try walking backward once you've done it forward!",
            "Make the line curvier for a bigger challenge.",
        ],
        "safety_line": "Walk slowly with arms out for balance — take your time.",
        "image_prompt": "An outdoor illustration of a long stick laid in a gently curving line on grass, with a child walking along it heel-to-toe, arms stretched out for balance, focused expression. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[2] = [
    {
        "name": "✈️ Paper Airplane Distance Challenge",
        "objective": "Fold, test, and improve a paper airplane design to fly as far as possible.",
        "materials": ["2-3 sheets of paper per player", "A measuring tape or long string"],
        "steps": [
            "Fold a paper airplane.",
            "Throw it from a starting line and mark where it lands.",
            "Measure the distance, or compare landing spots.",
            "Try folding it a different way and see if it flies farther!",
        ],
        "safety_line": "Only throw airplanes forward, away from other people.",
        "image_prompt": "An indoor or outdoor illustration showing a paper airplane mid-flight with a dotted trajectory line, a measuring tape laid on the ground from a starting line to the landing spot, and a child recording the distance on a small notepad. Bright, clear flat children's-book illustration style, no text.",
    },
    {
        "name": "🧦 Sock Ball Target Toss",
        "objective": "Practice aiming by tossing rolled socks at numbered targets for points.",
        "materials": ["4-5 rolled-up sock balls", "Chalk or tape to mark 3 target zones with point values"],
        "steps": [
            "Mark 3 target zones on the ground or wall (with chalk or tape), worth 1, 2, and 3 points.",
            "Stand behind a throwing line.",
            "Take turns tossing sock balls at the targets, adding up your score.",
            "Play 3 rounds and see who scores the most!",
        ],
        "safety_line": "Only toss toward the targets, never at people or breakable objects.",
        "image_prompt": "An indoor illustration showing 3 chalk or tape target zones on the floor labeled '1', '2', '3' with increasing distance, and a rolled sock ball mid-air flying toward the '3' zone with a dotted arc line, thrown by a child at a marked line. Bright, clear scoring-diagram flat illustration style.",
    },
    {
        "name": "🥄 Spoon and Ball Relay",
        "objective": "Balance a small ball on a spoon while racing to a finish line and back.",
        "materials": ["1 spoon per team", "1 small ball (or bouncy ball) per team", "2 markers"],
        "steps": [
            "Split into teams; each player balances a ball on a spoon.",
            "Walk quickly to the far marker and back without dropping it.",
            "If it drops, stop, pick it up, and continue from there.",
            "Hand the spoon to the next teammate — fastest team wins!",
        ],
        "safety_line": "Walk, don't run, to keep the ball balanced and stay safe.",
        "image_prompt": "An indoor or outdoor illustration of a child walking carefully with a spoon held out, balancing a small orange ball on top, heading toward a distant marker, teammates waiting in line at the start. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "📦 Cardboard Box Maze",
        "objective": "Build and navigate a simple maze using cardboard boxes.",
        "materials": ["4-6 cardboard boxes (open on both ends, or just used as walls)"],
        "steps": [
            "Arrange cardboard boxes to form maze walls and turns.",
            "Take turns crawling or walking through the maze from start to finish.",
            "Time each other, or just enjoy exploring the path!",
            "Rearrange the boxes to build a trickier maze.",
        ],
        "safety_line": "Make sure boxes are sturdy and won't collapse or have sharp edges.",
        "image_prompt": "A playful indoor illustration showing a maze built from open cardboard boxes arranged in a winding path on the floor, with a child crawling through one section, a dotted line showing the path to the maze's exit. Bright, fun flat children's-book illustration style, no text.",
    },
    {
        "name": "🌲 Pinecone Toss Game",
        "objective": "Practice tossing pinecones (or rocks) into targets for points.",
        "materials": ["4-5 pinecones (or small rocks)", "A bucket or hula hoop target"],
        "steps": [
            "Collect a few pinecones from outside.",
            "Set a bucket or hoop a few steps away as the target.",
            "Take turns tossing pinecones, trying to land them inside.",
            "Move the target farther away as you improve!",
        ],
        "safety_line": "Only toss toward the target, and check the area is clear first.",
        "image_prompt": "An outdoor illustration of a bucket sitting on grass with a pinecone mid-air arcing toward it, thrown by a child standing a few steps away, dotted trajectory line showing the toss. Bright natural background with a pine tree nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🕸️ String Web Walk",
        "objective": "Navigate through a string 'spider web' without touching the strings.",
        "materials": ["A ball of string or yarn", "Two chairs or door frames to tie it between"],
        "steps": [
            "Tie string back and forth between two chairs or a doorway to make a 'web.'",
            "Try to climb through the gaps without touching any string.",
            "If you touch a string, gently start that section again.",
            "Time yourself, or race a friend through a second web!",
        ],
        "safety_line": "Move slowly and carefully — this is about control, not speed.",
        "image_prompt": "A playful indoor illustration showing string crisscrossed between two chairs to form a spider-web pattern of gaps, with a child carefully stepping through one gap, arms tucked in to avoid touching the strings, focused expression. Bright, fun flat children's-book illustration style, no text.",
    },
    {
        "name": "🎳 Rolled-Sock Bowling",
        "objective": "Set up homemade bowling pins and practice rolling a ball to knock them down.",
        "materials": ["6 empty plastic bottles or rolled-sock 'pins'", "1 ball (soft ball or rolled sock)"],
        "steps": [
            "Set up 6 bottles or rolled socks in a triangle shape, like bowling pins.",
            "Stand behind a line a few steps back.",
            "Roll the ball, trying to knock down as many pins as possible.",
            "Reset the pins and take turns — count your total knocked down after 3 rolls!",
        ],
        "safety_line": "Roll the ball along the ground — no throwing it in the air.",
        "image_prompt": "An indoor illustration showing 6 plastic bottles arranged in a triangle 'bowling pin' formation on the floor, with a ball mid-roll toward them, motion lines trailing behind it, and a child in a rolling-release pose at a starting line. Bright, fun flat children's-book illustration style, no text.",
    },
]


GAMES[3] = [
    {
        "name": "📰 Newspaper Ball Toss Battle",
        "objective": "Work in teams to toss paper balls across a line, keeping your own side clear.",
        "materials": ["10-15 balls of crumpled scrap paper", "A rope or tape line to divide the area"],
        "steps": [
            "Split into 2 teams on either side of a dividing line.",
            "Each team gets half the paper balls.",
            "On 'go,' toss the balls to the other side as fast as you can for 30 seconds.",
            "When time's up, whichever side has fewer balls on their floor wins!",
        ],
        "safety_line": "Toss gently — paper balls are soft, but aim below head height.",
        "image_prompt": "A lively indoor illustration showing a room divided by a tape line on the floor, with crumpled paper balls flying across it in both directions, two children on each side mid-toss with excited expressions. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🥤 Cup Tower Relay",
        "objective": "Race in teams to build the tallest cup tower before time runs out.",
        "materials": ["15-20 plastic cups per team"],
        "steps": [
            "Split into teams, each with a pile of cups.",
            "On 'go,' work together to build the tallest tower you can.",
            "You have 60 seconds — stop building when time is called.",
            "Measure each team's tower — tallest standing tower wins!",
        ],
        "safety_line": "Build carefully — if a tower wobbles, stop adding and steady it.",
        "image_prompt": "An indoor illustration showing two teams of children each building a tall tower of stacked plastic cups, one team's tower slightly taller and more stable than the other's, with a small ruler or measuring tape icon nearby. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🌳 Nature Scavenger Bingo",
        "objective": "Find and check off a bingo card of natural outdoor items.",
        "materials": ["A simple 3x3 bingo card with nature items drawn or listed (leaf, rock, flower, bird, cloud, etc.)"],
        "steps": [
            "Give each player a bingo card with 9 nature items.",
            "Search outside for each item, checking it off when found.",
            "Get 3 in a row (across, down, or diagonal) to call 'Bingo!'",
            "Keep playing to fill the whole card!",
        ],
        "safety_line": "Only touch or collect items a grown-up says are safe.",
        "image_prompt": "An outdoor illustration showing a child holding a 3x3 bingo card with simple nature icons (leaf, rock, flower, bird, cloud, stick, etc.), 4 squares already checked off, standing in a garden pointing excitedly at a flower matching one of the squares. Bright, natural, colorful flat illustration style.",
    },
    {
        "name": "🦸 Blanket Cape Obstacle Dash",
        "objective": "Wear a blanket cape and complete a simple obstacle course as a superhero.",
        "materials": ["1 small blanket or towel per player (as a cape)", "Household items for obstacles (pillows, chairs, boxes)"],
        "steps": [
            "Tie a blanket or towel around your shoulders as a cape.",
            "Set up a simple obstacle course using pillows, chairs, and boxes.",
            "Race through the course as a 'superhero,' completing each obstacle.",
            "Take turns and time each other!",
        ],
        "safety_line": "Make sure the cape is tied loosely and won't catch on anything.",
        "image_prompt": "A fun indoor illustration of a child wearing a blanket tied around their shoulders like a superhero cape, mid-jump over a pillow obstacle, with a chair to weave around and a box to crawl through further along the course. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "🥏 Paper Plate Frisbee Golf",
        "objective": "Toss a paper plate 'disc' toward a series of household targets in as few throws as possible.",
        "materials": ["1-2 paper plates", "3-4 household 'holes' (a laundry basket, a chair, a doorway, a box)"],
        "steps": [
            "Set up 3-4 targets around the house or yard (a basket, a chair leg, a doorway).",
            "Throw your paper plate toward the first target, counting your throws.",
            "Pick it up from where it landed and throw again until you hit the target.",
            "Move to the next target — fewest total throws across all targets wins!",
        ],
        "safety_line": "Check the throwing path is clear of people and breakable items.",
        "image_prompt": "An indoor course-map illustration showing 4 numbered household targets (a laundry basket, a chair, a doorway, a box) connected by a dotted throwing path, with a paper plate mid-flight toward the basket and a small scorecard showing throw counts. Clear, playful course-map style flat illustration.",
    },
    {
        "name": "🧷 Clothespin Clip Relay",
        "objective": "Race to clip clothespins onto your clothing, then race to remove them.",
        "materials": ["10-15 clothespins per team", "2 cones or markers"],
        "steps": [
            "Split into teams, lined up at the start.",
            "First player runs to the pile of clothespins and clips as many as they can onto their clothes in 10 seconds.",
            "Run back and tag the next teammate, who removes the clips and adds their own.",
            "Team with the most clips successfully passed through wins!",
        ],
        "safety_line": "Clip pins onto loose clothing only, gently, never onto skin.",
        "image_prompt": "A fun indoor illustration showing a child covered in colorful clothespins clipped onto their sleeves and shirt, running toward a teammate, with a pile of extra clothespins on a table in the background. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🎣 Stick and String Fishing Game",
        "objective": "Make a simple fishing pole and practice 'catching' paper fish with a magnet or hook.",
        "materials": ["1 stick", "String", "A magnet or paperclip", "Paper fish cutouts with paperclips attached"],
        "steps": [
            "Tie string to a stick, with a magnet or paperclip hook on the end.",
            "Cut out paper fish shapes and attach a paperclip to each.",
            "Spread the fish on the floor or ground.",
            "'Fish' by dangling your hook near a fish until it attaches, then reel it in!",
        ],
        "safety_line": "Keep the stick pointed down and away from faces while fishing.",
        "image_prompt": "A playful illustration showing a homemade fishing pole (a stick with string and a small magnet tied to the end) dangling over a scattering of paper fish cutouts on the floor, each fish with a small paperclip attached, with a child holding the pole and reeling one in with a delighted expression. Bright, whimsical flat children's-book illustration style, no text.",
    },
]


GAMES[4] = [
    {
        "name": "✈️ Paper Airplane Target Challenge",
        "objective": "Design a paper airplane and practice landing it accurately inside target zones.",
        "materials": ["2-3 sheets of paper per player", "Chalk or tape to mark 3 target zones on the ground"],
        "steps": [
            "Fold a paper airplane and mark 3 target zones on the ground worth 1, 2, and 3 points.",
            "Throw from a starting line, aiming for the highest-value zone.",
            "Score points based on where it lands.",
            "Play 5 rounds and total your score!",
        ],
        "safety_line": "Only throw airplanes toward the targets, never at people.",
        "image_prompt": "An indoor or outdoor course-diagram illustration showing 3 target zones marked with chalk labeled '1', '2', '3' points, with a paper airplane mid-flight heading toward the '3' zone, thrown from a marked starting line. Clear, scoring-diagram-style flat illustration.",
    },
    {
        "name": "🎳 Household Item Bowling",
        "objective": "Set up a bowling lane using household items and practice rolling for accuracy.",
        "materials": ["6-10 plastic bottles or cups as pins", "A ball (soft ball or rolled-up socks taped together)"],
        "steps": [
            "Set up bottles or cups in a triangle formation.",
            "Mark a rolling line a few steps back.",
            "Roll the ball to knock down as many pins as possible.",
            "Track your score across 5 rounds — most pins knocked down wins!",
        ],
        "safety_line": "Roll along the ground only, and reset pins carefully.",
        "image_prompt": "An indoor bowling-lane illustration showing 10 plastic bottles arranged in a triangle at one end, with a ball mid-roll toward them along a marked lane, a child in a bowling release pose at the starting line. Clear, fun sports-diagram flat illustration style.",
    },
    {
        "name": "🧺 Nature Weaving Craft Race",
        "objective": "Collect natural materials and weave them into a simple pattern as fast as possible.",
        "materials": ["Long grass, thin sticks, or vines collected outside", "A simple frame (a paper plate with slits cut in, or a stick frame)"],
        "steps": [
            "Collect long grass, thin sticks, or vines outside.",
            "Weave them in and out of a simple frame (like a paper plate with cut slits).",
            "See how much of the frame you can cover in 5 minutes.",
            "Compare your woven patterns with a friend's!",
        ],
        "safety_line": "Only collect natural materials a grown-up says are safe to touch.",
        "image_prompt": "An outdoor craft illustration showing a child weaving thin grass strands and small sticks in and out of the slits of a paper plate frame, creating a woven pattern, with natural materials scattered nearby on the grass. Bright, creative flat children's-book illustration style, no text.",
    },
    {
        "name": "📦 Cardboard Slide and Ramp Challenge",
        "objective": "Build a ramp from cardboard and test which household objects roll or slide the farthest.",
        "materials": ["A large piece of cardboard", "Books or a chair to prop it up", "Small household objects to test (a ball, a toy car, a bottle cap)"],
        "steps": [
            "Prop a cardboard sheet against books or a chair to make a ramp.",
            "Choose several small objects to test.",
            "Release each one from the top and mark how far it travels after reaching the bottom.",
            "Compare distances — which object rolled the farthest?",
        ],
        "safety_line": "Make sure the ramp is stable and won't tip over during testing.",
        "image_prompt": "A side-view illustration of a cardboard ramp propped up against a stack of books, with a small toy car mid-slide down the ramp and a dotted line showing its path continuing across the floor to a marked distance point. Clear, experiment-diagram style flat illustration.",
    },
    {
        "name": "🧦 Sock Ball Dodge",
        "objective": "Practice dodging and throwing accuracy in a gentle sock-ball dodgeball game.",
        "materials": ["6-8 rolled-up sock balls", "A center line (rope or tape)"],
        "steps": [
            "Split into 2 teams on either side of a center line.",
            "Toss sock balls across the line, trying to gently tag opposing players.",
            "If tagged, sit out for one round, then rejoin.",
            "Play until time runs out — team with the most players still in wins!",
        ],
        "safety_line": "Aim below the shoulders, and remember the socks are soft — play gently.",
        "image_prompt": "An indoor illustration showing two teams of children on either side of a tape line, tossing soft rolled sock balls across at each other, with a few motion-blur trails showing balls in flight. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🪨 Rock Stacking Challenge",
        "objective": "Practice patience and balance by stacking rocks into the tallest stable tower.",
        "materials": ["5-8 rocks of different sizes (collected outside)"],
        "steps": [
            "Collect a handful of rocks of different sizes.",
            "Try stacking them into the tallest tower you can, balancing carefully.",
            "If it falls, that's okay — try again!",
            "See how many rocks you can balance at once.",
        ],
        "safety_line": "Stack rocks low to the ground so nothing falls on toes.",
        "image_prompt": "An outdoor illustration showing a small tower of 5 different-sized rocks stacked carefully on top of each other on the ground, with a child crouched nearby, hands hovering carefully as they place the top rock, focused expression. Bright natural background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "📰 Newspaper Tower Build",
        "objective": "Work in teams to build the tallest free-standing tower using only newspaper and tape.",
        "materials": ["A stack of newspaper or scrap paper per team", "1 roll of tape per team"],
        "steps": [
            "Split into teams, each with paper and tape.",
            "In 10 minutes, build the tallest tower that can stand on its own.",
            "No other materials allowed — just paper and tape!",
            "Measure each team's tower at the end — tallest standing tower wins!",
        ],
        "safety_line": "Build on a stable, flat surface away from foot traffic.",
        "image_prompt": "An indoor illustration showing two teams of children building tall towers out of rolled and taped newspaper, one tower noticeably taller and more stable, with a measuring tape shown alongside comparing the heights. Bright, energetic, engineering-themed flat illustration style, no text.",
    },
]


GAMES[5] = [
    {
        "name": "🥄 Paper Catapult Challenge",
        "objective": "Build a simple catapult from household items and test its launch distance.",
        "materials": ["1 spoon", "A rubber band", "A small stack of books or a block for a pivot", "Small paper balls or pom-poms to launch"],
        "steps": [
            "Build a simple catapult: rest a spoon on a pivot block, secured with a rubber band.",
            "Load a small paper ball onto the spoon.",
            "Press down and release to launch it toward a target.",
            "Measure your launch distances and try adjusting your design for more power!",
        ],
        "safety_line": "Only launch soft paper balls, never anything hard, and aim away from faces.",
        "image_prompt": "A detailed illustration of a simple homemade catapult made from a spoon balanced on a small wooden block, secured with a rubber band, with a paper ball mid-launch arcing through the air toward a target marked on the floor with a dotted trajectory line. Clear, engineering-diagram style flat illustration.",
    },
    {
        "name": "♻️ Recycling Relay Sort",
        "objective": "Race in teams to correctly sort recyclable household items into the right bins.",
        "materials": ["A mixed pile of clean recyclables (paper, plastic, cardboard)", "3 labeled boxes or bins"],
        "steps": [
            "Set up 3 bins labeled paper, plastic, and cardboard.",
            "Pile mixed clean recyclables at a starting point.",
            "Teams race to carry items one at a time to the correct bin.",
            "Fastest team to correctly sort everything wins — double-check for mistakes!",
        ],
        "safety_line": "Use only clean, safe items — no sharp edges or broken glass.",
        "image_prompt": "An indoor illustration showing 3 labeled bins (paper, plastic, cardboard) with a child running an item from a central pile toward the correct bin, motion lines showing speed, teammates waiting to go next. Bright, clear, educational flat illustration style with visible bin labels.",
    },
    {
        "name": "🍁 Nature Land Art Challenge",
        "objective": "Use only natural materials found outside to create a piece of art on the ground.",
        "materials": ["Leaves, sticks, rocks, flowers, and other natural items found outside"],
        "steps": [
            "Collect natural materials from around the yard or park.",
            "Arrange them into a picture or pattern on the ground (a face, a shape, a design).",
            "Take a photo of your finished land art (or just admire it together)!",
            "Try a new design with different materials.",
        ],
        "safety_line": "Only use materials already on the ground — don't pick living plants without permission.",
        "image_prompt": "An overhead illustration of a beautiful land-art design created on grass using natural materials — leaves arranged as a sun, small rocks as a border, sticks forming rays — with a child kneeling nearby admiring their creation. Bright, artistic, natural flat illustration style, no text.",
    },
    {
        "name": "🛏️ Blanket Tug and Balance",
        "objective": "Combine balance and gentle team pulling using a folded blanket.",
        "materials": ["1 sturdy blanket or towel"],
        "steps": [
            "Two players each hold one end of a folded blanket while standing on one foot.",
            "Gently pull and try to make the other person lose balance and put their foot down.",
            "Whoever stays balanced longest wins the round!",
            "Switch partners and try again.",
        ],
        "safety_line": "Pull gently and stop immediately if anyone feels unsteady or unsafe.",
        "image_prompt": "An indoor or outdoor illustration showing two children standing on one leg each, both gripping opposite ends of a folded blanket, leaning slightly and pulling gently, focused balanced expressions. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "🥤 Cup Stack Speed Challenge",
        "objective": "Practice speed and precision using the competitive cup-stacking technique.",
        "materials": ["12 plastic cups per player"],
        "steps": [
            "Learn a simple stacking pattern: build a pyramid of cups, then collapse it back into a single stack.",
            "Time yourself doing the full pattern.",
            "Practice a few times to get faster.",
            "Challenge a friend to a head-to-head speed race!",
        ],
        "safety_line": "Practice on a flat, stable surface with room for cups to fall safely.",
        "image_prompt": "A dynamic close-up illustration of a child's hands mid-motion rapidly stacking plastic cups into a pyramid shape, motion-blur lines showing speed, a stopwatch icon in the corner showing elapsed time. Bright, energetic flat illustration style, no text.",
    },
    {
        "name": "🧭 String and Stick Compass Walk",
        "objective": "Use a simple sun-shadow method with a stick to estimate direction, then walk a course.",
        "materials": ["1 stick", "String", "A sunny outdoor spot"],
        "steps": [
            "Push a stick upright into the ground in a sunny spot; mark where its shadow tip falls.",
            "Wait 10-15 minutes, then mark the new shadow tip position — the first mark is roughly west, the second roughly east.",
            "Use string to lay out a simple direction line based on your marks.",
            "Walk a short course using your estimated directions (e.g., '10 steps toward your west mark')!",
        ],
        "safety_line": "Never look directly at the sun — only watch the shadow on the ground.",
        "image_prompt": "An outdoor illustration showing a stick planted upright in the ground with its shadow cast on the dirt, two small marker stones placed at the shadow's first and second positions, and a string laid between them showing an east-west line. A child observes from a safe distance, watching only the shadow, not the sun. Clear, educational flat illustration style.",
    },
    {
        "name": "🏠 Household Obstacle Ninja Course",
        "objective": "Design and complete an obstacle course using only furniture and household items.",
        "materials": ["Pillows, chairs, tape, boxes, and other safe household items"],
        "steps": [
            "Design a course: crawl under a table, jump over a pillow line, weave through chairs, balance-walk a taped line.",
            "Test your course yourself first for safety.",
            "Race friends or family through the course, timing each run.",
            "Redesign a station if it's too easy or too hard!",
        ],
        "safety_line": "Check for sharp corners or unstable furniture before anyone runs the course.",
        "image_prompt": "A detailed indoor illustration showing a household obstacle course with a table to crawl under, pillows lined up to jump over, chairs arranged to weave through, and a taped balance line on the floor, all connected with a dotted path, a child mid-crawl under the table. Bright, clear, energetic flat illustration style, no text.",
    },
]


GAMES[6] = [
    {
        "name": "🌉 Paper Bridge Engineering Challenge",
        "objective": "Design and test a paper bridge that can hold as much weight as possible.",
        "materials": ["Several sheets of paper", "Tape", "2 books or blocks (bridge supports)", "Small weights (coins, small toys)"],
        "steps": [
            "Build a bridge out of paper and tape, spanning the gap between two books.",
            "Test how much weight it can hold before collapsing (add coins or small toys one at a time).",
            "Record how much weight it held.",
            "Redesign your bridge (try folding the paper, adding supports) and test again — did it hold more?",
        ],
        "safety_line": "Test with small, safe weights only, and keep fingers clear as it collapses.",
        "image_prompt": "A detailed engineering-diagram illustration showing a folded paper bridge spanning the gap between two stacked books, with small coin weights being carefully added one at a time on top, a small scale or tally showing the total weight held so far. Clear, educational, engineering-style flat illustration.",
    },
    {
        "name": "🏠 Household Item Olympics",
        "objective": "Compete across multiple mini-events using only everyday household items.",
        "materials": ["Cups, socks, spoons, paper, string — whatever's on hand"],
        "steps": [
            "Set up 3-4 mini 'Olympic' events: sock-ball shot put, paper airplane javelin, spoon-and-ball balance walk, cup-stack speed build.",
            "Compete in each event, scoring points for placement.",
            "Add up total points across all events.",
            "Crown the household Olympics champion!",
        ],
        "safety_line": "Check each event's setup for safety before competing.",
        "image_prompt": "A festive illustration showing 4 different household-Olympics event stations happening at once: a sock ball being thrown, a paper airplane being launched, a spoon-and-ball balance walk, and a cup-stack tower — with a small medal/podium icon nearby. Bright, energetic, Olympic-themed flat illustration style.",
    },
    {
        "name": "🏕️ Natural Materials Shelter Build",
        "objective": "Design and build a small shelter or structure using only materials found outside.",
        "materials": ["Sticks, leaves, and other natural materials found outside", "String (optional, for lashing sticks together)"],
        "steps": [
            "Collect sticks, leaves, and other natural materials.",
            "Design and build a small shelter structure (big enough for a stuffed animal or small object, not a person).",
            "Test if it stays standing, and if it could shed rain (pour a little water on it, if allowed).",
            "Improve your design based on what you learned!",
        ],
        "safety_line": "Only use materials already on the ground, and build somewhere it won't be a tripping hazard.",
        "image_prompt": "An outdoor illustration of a small lean-to shelter built from sticks leaned against each other and covered with leaves, sized for a small stuffed animal sitting inside it, with a child kneeling nearby adjusting a stick. Bright, natural, educational flat illustration style, no text.",
    },
    {
        "name": "📦 Cardboard Box Derby",
        "objective": "Design and race simple cardboard vehicles down a ramp, testing speed and distance.",
        "materials": ["Small cardboard boxes or cardboard scraps", "Tape", "Bottle caps or small wheels (optional)", "A ramp (a board or cardboard sheet propped up)"],
        "steps": [
            "Build a simple cardboard 'vehicle,' adding wheels if you have bottle caps or similar round objects.",
            "Set up a ramp using a board or propped cardboard.",
            "Release your vehicle from the top and measure how far it travels.",
            "Redesign and test again — what made it go farther or straighter?",
        ],
        "safety_line": "Keep the ramp stable and test area clear of people and pets.",
        "image_prompt": "A side-view illustration of a small cardboard vehicle with bottle-cap wheels racing down a propped-up cardboard ramp, a dotted line showing its path continuing across the floor to a measured distance marker. Clear, engineering-diagram style flat illustration.",
    },
    {
        "name": "🎯 Sock and Spoon Trebuchet",
        "objective": "Build a simple lever-based launcher and test its accuracy and distance.",
        "materials": ["1 spoon", "A rubber band", "A pivot point (a block or stack of books)", "Sock balls to launch"],
        "steps": [
            "Build a simple lever launcher: a spoon balanced on a pivot, secured with a rubber band.",
            "Load a sock ball onto the spoon end.",
            "Press and release to launch toward a target.",
            "Adjust your pivot point or launch angle and test again — what changes the distance?",
        ],
        "safety_line": "Only launch soft sock balls, and keep the launch path clear of people.",
        "image_prompt": "A detailed illustration of a simple lever-launcher device (a spoon on a pivot block secured with a rubber band) launching a sock ball in an arc toward a target zone marked on the ground, with a dotted trajectory line and a small scorecard showing distance. Clear, engineering-diagram style flat illustration.",
    },
    {
        "name": "⚖️ Rock Balancing Art Challenge",
        "objective": "Use patience, precision, and an understanding of balance to stack rocks into artistic sculptures.",
        "materials": ["8-10 rocks of varying sizes and shapes"],
        "steps": [
            "Collect rocks of different sizes and shapes.",
            "Experiment with balancing them into a tall or creative sculpture, using each rock's natural balance points.",
            "Once stable, step back and admire (or photograph) your creation.",
            "Challenge a friend to build something even more impressive!",
        ],
        "safety_line": "Stack low to the ground and away from where anyone might bump into it.",
        "image_prompt": "An artistic outdoor illustration showing an impressive balanced rock sculpture — several irregularly-shaped rocks stacked in a seemingly gravity-defying tower — with a child stepping back to admire their careful work, focused satisfied expression. Bright, artistic, natural flat illustration style, no text.",
    },
    {
        "name": "📰 Newspaper Fashion Design Race",
        "objective": "Work in teams to design and 'construct' a wearable outfit from newspaper as fast as possible.",
        "materials": ["A stack of newspaper per team", "Tape", "Scissors (with grown-up supervision)"],
        "steps": [
            "Split into teams; one person is the 'model.'",
            "In 15 minutes, design and tape/fold a newspaper outfit onto your model.",
            "Hold a mini fashion show, walking each design across the room.",
            "Vote together on the most creative design!",
        ],
        "safety_line": "Use scissors carefully with a grown-up's help, and keep the outfit loose and comfortable.",
        "image_prompt": "A fun, creative illustration showing a child standing as a 'model' wearing a costume made entirely of taped and folded newspaper (a skirt, a sash, a hat), with teammates around them still working on adding finishing touches, scissors and tape nearby. Bright, playful, fashion-show-themed flat illustration style, no text.",
    },
]


GAMES[7] = [
    {
        "name": "🗼 Paper Tower Engineering Challenge",
        "objective": "Design and build the tallest free-standing paper tower that can support a weight on top.",
        "materials": ["A stack of paper", "Tape", "A small weight (like a small book or apple) to place on top"],
        "steps": [
            "Using only paper and tape, build a tower as tall as you can.",
            "Your tower must stand on its own and hold a small weight on top for 10 seconds.",
            "Measure your tower's height once it successfully holds the weight.",
            "Redesign and try to beat your own height record!",
        ],
        "safety_line": "Build on a stable surface and keep the weight small and safe.",
        "image_prompt": "A detailed engineering illustration showing a tall, rolled-paper tower structure standing on a table with a small book balanced carefully on top, a measuring tape alongside showing the height, and a child observing with a clipboard nearby. Clear, professional, engineering-diagram style flat illustration.",
    },
    {
        "name": "🏆 Household Item Triathlon",
        "objective": "Compete across three different skill-based mini-events using everyday items.",
        "materials": ["A ball or sock ball, a spoon, cups, and other household items"],
        "steps": [
            "Set up 3 events: a sock-ball accuracy toss, a spoon-and-object balance sprint, and a cup-stacking speed challenge.",
            "Compete in all 3 events, recording your placement or time in each.",
            "Combine your results into an overall triathlon score.",
            "Compare scores with friends or family — who's the household triathlon champion?",
        ],
        "safety_line": "Warm up briefly before the sprint event, and check each station for safety first.",
        "image_prompt": "A festive triathlon-themed illustration showing 3 event stations in sequence: a sock-ball toss target, a spoon-balance sprint lane, and a cup-stacking table, with a scoreboard nearby tracking combined results across all three. Bright, energetic, competitive flat illustration style.",
    },
    {
        "name": "🧭 Nature Survival Skills Challenge",
        "objective": "Practice basic outdoor skills like shelter-building, direction-finding, and identifying materials.",
        "materials": ["Sticks, leaves, and natural materials found outside", "A simple compass (optional)"],
        "steps": [
            "In small teams, build a small emergency shelter frame using sticks and leaves.",
            "Use the sun-shadow method (or a compass) to estimate which direction is north.",
            "Identify 3 natural materials that could be useful in a real outdoor situation (e.g., soft moss, sturdy sticks).",
            "Present your shelter and findings to the group!",
        ],
        "safety_line": "Stay within sight of a grown-up and only use materials already on the ground.",
        "image_prompt": "An outdoor illustration showing a team of students building a small lean-to shelter frame from sticks, with one student checking a compass and another examining natural materials nearby (moss, sturdy branches). Bright, educational, adventurous flat illustration style, no text.",
    },
    {
        "name": "⛵ Cardboard Boat Regatta",
        "objective": "Design and test a small cardboard/foil boat for how much weight it can float before sinking.",
        "materials": ["Cardboard scraps or aluminum foil", "Tape", "A tub or basin of water", "Small weights (coins)"],
        "steps": [
            "Build a small boat from cardboard or foil, shaped to float.",
            "Set it in a tub of water and add coins one at a time to test how much weight it holds.",
            "Record how many coins it held before sinking or taking on water.",
            "Redesign your boat's shape and test again — did it hold more weight?",
        ],
        "safety_line": "Only play near water with a grown-up watching, and dry hands/surfaces afterward.",
        "image_prompt": "A detailed illustration showing a small foil or cardboard boat floating in a water-filled basin, with coins being carefully placed inside one at a time, a tally mark counter nearby showing how many coins it has held so far. Clear, engineering-diagram style flat illustration.",
    },
    {
        "name": "🌉 String and Stick Bridge Challenge",
        "objective": "Design a small bridge using sticks and string, then test its strength.",
        "materials": ["Several sticks", "String or yarn", "Two supports (books or blocks)", "Small weights to test with"],
        "steps": [
            "Lash sticks together with string to build a small bridge spanning two supports.",
            "Test how much weight it holds before bending or breaking.",
            "Record your results.",
            "Try a new design (like a triangle truss pattern) and test if it holds more!",
        ],
        "safety_line": "Test with small, safe weights, and keep fingers clear as the structure is tested.",
        "image_prompt": "A detailed engineering illustration showing a small bridge made of sticks lashed together with string, spanning the gap between two stacked books, with small weights being placed on top to test its strength, a tally showing weight held. Clear, professional engineering-diagram style flat illustration.",
    },
    {
        "name": "💡 Recycled Materials Invention Fair",
        "objective": "Design and build a useful invention using only recycled household materials.",
        "materials": ["Clean recyclables (cardboard, bottles, paper, caps)", "Tape or glue"],
        "steps": [
            "Brainstorm a simple problem to solve (like organizing pencils, or a mini catapult).",
            "Build your invention using only recycled materials.",
            "Test whether your invention actually works.",
            "Present your invention to others, explaining the problem it solves!",
        ],
        "safety_line": "Use only clean materials, and ask before using scissors or sharp tools.",
        "image_prompt": "A creative illustration showing a student proudly presenting a homemade invention built from recycled cardboard and bottle caps (like a small pencil organizer or simple mechanical device) to a small audience, with recycling materials scattered on a work table nearby. Bright, inventive, educational flat illustration style, no text.",
    },
    {
        "name": "🕐 Natural Compass and Shadow Clock Challenge",
        "objective": "Build a simple shadow clock using a stick and track how shadows change over time.",
        "materials": ["1 stick", "Small stones or markers", "A sunny outdoor spot", "A watch or phone clock (for reference only)"],
        "steps": [
            "Push a stick upright into the ground in a sunny spot.",
            "Mark the tip of its shadow with a small stone every 30 minutes, noting the time on each marker.",
            "After a few markers, observe the pattern the shadow makes as the sun moves.",
            "Explain what your 'shadow clock' shows about the sun's movement across the sky!",
        ],
        "safety_line": "Never look directly at the sun — only observe the shadow it casts on the ground.",
        "image_prompt": "An outdoor illustration showing a stick planted upright in the ground with several small stone markers placed around it at different shadow positions, each labeled with a time (e.g., '10:00', '10:30', '11:00'), showing the shadow's path curving over the course of the morning. A student observes from a safe distance, sketching the pattern in a notebook. Clear, educational, scientific-diagram flat illustration style.",
    },
]


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
    out.append("-- 69_outdoor_games_household_content.sql")
    out.append("-- Extends the existing 'Outdoor Games' category (see")
    out.append("-- 68_outdoor_games_content.sql) with 7 more games per grade (14 -> 21),")
    out.append("-- all built from paper, household items, natural materials, or basic stuff")
    out.append("-- most families already have — no purchased sports equipment needed. Many")
    out.append("-- work indoors as well as outdoors (noted per game's objective text).")
    out.append("--")
    out.append("-- Appends to the SAME per-grade PacketCategories row (looked up, not")
    out.append("-- re-created) with sort_order continuing from 15. target_count stays at 7")
    out.append("-- (unchanged) — a bigger 21-game pool just means more weekly variety, same")
    out.append("-- NEWID()-sampling mechanism as every other category.")
    out.append("-- See gen_69_outdoor_games_household_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (")
    out.append("    SELECT 1 FROM dbo.PacketQuestions q")
    out.append("    JOIN dbo.PacketCategories c ON c.category_id = q.category_id")
    out.append("    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 15")
    out.append(")")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 7, f"grade {grade_id} has {len(games)} games, expected 7"
        var = f"@cat_ext_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    SELECT {var} = category_id FROM dbo.PacketCategories "
            f"WHERE grade_id = {grade_id} AND category_name = 'Outdoor Games';"
        )
        for i, game in enumerate(games):
            sort_order = 15 + i
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


def check_completeness():
    ok = True
    for grade_id in GRADE_IDS:
        n = len(GAMES[grade_id])
        if n != 7:
            print(f"INCOMPLETE: grade {GRADE_LABELS[grade_id]} has {n} games, expected 7")
            ok = False
        for game in GAMES[grade_id]:
            for key in ("name", "objective", "materials", "steps", "safety_line", "image_prompt"):
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
    with open(r"D:\Project\www\littlescholarhub\lsh.database\69_outdoor_games_household_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 69_outdoor_games_household_content.sql", file=sys.stderr)
