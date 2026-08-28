-- 38_mini_stories_batch1.sql
-- First batch of original mini-storybooks for the parent Story Library.
-- All content below is original writing, not adapted from any external
-- source (unlike the earlier IACL-inspired batch) -- fresh characters and
-- plots written for this platform. audio_url is populated separately via
-- POST /admin/stories/<id>/generate-audio after this migration runs.

INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, is_published)
VALUES
(0, 1, N'Pip the Little Cloud', N'High above a dry, thirsty garden floated a tiny cloud named Pip. All the other clouds were big and gray and knew exactly how to make rain. Pip was small and white and wasn''t sure he could do anything at all.

"I''m too little to help," Pip sighed, watching the garden''s flowers droop in the sun.

An older cloud floated by. "Even a little cloud can make a little rain," she said kindly. "Try it and see."

Pip took a deep breath and squeezed as hard as he could. One drop fell. Then another. Then a soft little shower sprinkled down on the garden below.

The flowers lifted their heads. The thirsty roots drank happily. And Pip, the littlest cloud in the whole sky, floated on feeling proud — because even something small can make a big difference.', 2, N'original', 1),
(1, 1, N'The Brave Little Boat', N'Down at the harbor lived a small red boat named Buoy. Every day, the big ships sailed far out to sea, but Buoy always stayed close to the dock. "The waves out there are too big for me," Buoy would say.

One foggy morning, an old fisherman''s engine broke down far from shore, and none of the big ships could hear his whistle over the wind. But Buoy could.

Buoy''s little propeller shook. The waves did look big. But the fisherman needed help, and there was no one else close enough. So Buoy took a deep breath and puttered out across the choppy water.

Wave after wave rocked the little boat, but Buoy kept going, straight toward the fisherman''s whistle. At last, Buoy reached him and towed him safely home.

That evening, the harbor cheered for the smallest, bravest boat of all. Buoy learned that being scared and being brave can happen at the very same time.', 2, N'original', 1),
(2, 1, N'Zia and the Whispering Wind', N'Zia loved sitting on her porch in the evenings, listening to the wind rustle through the maple tree. One breezy day, she noticed something strange — if she listened very closely, the wind almost seemed to whisper words.

"Follow the leaves," it seemed to say.

Curious, Zia hopped off the porch and chased a swirl of leaves down the street, around the corner, and into the community garden she''d never visited before. There, an elderly neighbor named Mr. Alvarez was struggling to carry a heavy bag of seeds.

"Could you use some help?" Zia asked.

Mr. Alvarez smiled with relief. Together, they planted rows of sunflowers, and he told her stories about the garden''s forty years of history while they worked.

From that day on, Zia visited the garden every week. She never knew if the wind had truly spoken to her or if she''d simply been paying close attention — but either way, she''d learned that slowing down to listen can lead somewhere wonderful.', 3, N'original', 1),
(3, 1, N'The Mixed-Up Backpack', N'On the first day back from winter break, Sam grabbed his backpack and rushed to school — but when he unzipped it in class, nothing inside was his. There was a harmonica, a rock collection, a half-finished comic book, and a note that read "Property of Deja R."

Sam realized the backpacks must have gotten swapped at the bus stop. He could easily have kept the cool rock collection and said nothing. No one would have known.

But that didn''t feel right. At lunch, Sam asked around until he found Deja, looking worried without her things. "I think we grabbed each other''s bags by accident," he said, holding it out.

Deja''s face lit up. "Thank you! My grandpa gave me that harmonica." She handed back Sam''s actual backpack, math homework and all.

"I almost just kept the rocks," Sam admitted with a laugh.

"I''m really glad you didn''t," Deja said, and from then on, they sat together at lunch every day — proof that doing the honest thing, even when it''s easier not to, can turn a stranger into a friend.', 3, N'original', 1),
(4, 1, N'The Clockwork Cat', N'In a cluttered workshop at the edge of town lived an inventor named Odette and her strangest creation: a clockwork cat named Ticker, built from gears, springs, and a small brass heart. There was just one problem — Ticker refused to move.

Odette oiled every joint and wound every spring, but Ticker sat frozen on the workbench, eyes dim. She was about to give up when her little brother wandered in giggling about a joke he''d heard at school. To her amazement, Ticker''s ears twitched.

Odette gasped. She told a silly joke of her own. Ticker''s tail flicked once, twice — and then the little cat leapt clean off the table, purring like a tiny engine.

It took weeks of testing to understand it: Ticker''s brass heart didn''t run on oil or electricity at all. It ran on laughter. The more joy filled the room, the more alive Ticker became.

Word spread through town, and soon children visited the workshop just to make Ticker purr — trading jokes, riddles, and giggles with a cat who reminded everyone that joy isn''t just nice to have. Sometimes, it''s what keeps things running at all.', 4, N'original', 1),
(5, 1, N'Mira and the Library Door', N'Mira had read every book in her school library twice, so when she noticed a narrow door behind the reference shelf that she''d never seen before, she couldn''t resist trying the handle. It was locked — but a small brass plaque above it read: "Opens only for those who are still curious."

Mira frowned. "I''m curious," she said out loud, half expecting nothing to happen. The door clicked open.

Behind it stretched a library unlike any she''d imagined — shelves that curved upward into darkness, books that hummed faintly when she walked past, and a reading room where the ceiling shifted between painted skies.

An old librarian with ink-stained fingers looked up from her desk. "Most people walk past that door for years without noticing it," she said. "It only opens for readers who still ask ''what if?'' instead of just ''what happened?''"

Mira spent the whole afternoon exploring, and when she finally stepped back through the door into her ordinary school library, the narrow door was gone — seamless wall in its place.

She never found it again, no matter how she searched. But she never stopped asking ''what if,'' just in case.', 4, N'original', 1),
(6, 1, N'The Cartographer of Nowhere', N'Every mapmaker who attempted to chart Restless Island eventually gave up — the coastline shifted every time a ship left port, rearranging cliffs and coves like puzzle pieces shuffled by an invisible hand. The island had earned a nickname: Nowhere, since no map of it ever stayed true for long.

Twelve-year-old Wren, apprenticed to the harbor''s cartographer, was determined to be the one who finally mapped it. Her first three attempts were useless within days. Her teacher gently suggested she try an easier island instead.

Wren refused. Instead of trying to draw Nowhere as one fixed shape, she began sketching it differently each week, filling a thick notebook with dozens of versions — the eastern cliffs in spring, the vanished cove in autumn, the new sandbar that appeared after every storm.

It took her two full years. When she finally presented her work to the harbor council, it wasn''t a single map at all — it was an atlas, showing how Restless Island changed with the seasons and tides, and predicting where it would likely shift next.

"You didn''t map what the island is," her teacher said, studying the pages in wonder. "You mapped how it changes. That''s harder, and better."

Wren''s atlas became the only navigation guide sailors trusted near Nowhere ever again — a reminder that some problems can''t be solved by insisting they hold still. Sometimes the real solution is learning to work with what won''t.', 5, N'original', 1),
(7, 1, N'The Lighthouse Keeper''s Apprentice', N'Old Mr. Okafor had kept the lighthouse on Gull Point for forty-one years, and everyone in the fishing village trusted its steady beam to guide them home. When his knees finally gave him trouble climbing the spiral stairs, he reluctantly took on an apprentice: a restless fourteen-year-old named Theo who''d rather have been anywhere else.

"Wind the mechanism every four hours. Trim the wick. Log the weather. It''s not complicated," Mr. Okafor said on Theo''s first night, already half-asleep in his chair by the fire.

Theo found it deadly boring — until the night a real storm rolled in, faster and meaner than the forecast had promised. Rain hammered the windows sideways. Mr. Okafor''s knees, aching worse than usual in the cold, made the stairs impossible.

"The light has to stay lit," the old man said grimly. "There''s a fishing boat still out — the Marisol. If our light goes dark, they won''t find the channel through the rocks."

Theo climbed the stairs alone, hands shaking, wind screaming through every gap in the old stone tower. He wound the mechanism exactly as he''d been shown. He trimmed the wick with fingers numb from cold. He kept the light burning through four hours that felt like forty.

Near dawn, the Marisol limped into harbor, battered but safe, her captain waving up at the tower in thanks.

Mr. Okafor, watching from the window below, didn''t say much when Theo finally came down the stairs, soaked and exhausted. He just nodded once, the way one keeper nods to another. Theo understood — some jobs only look boring until the night they matter most, and someone has to be ready long before that night arrives.', 5, N'original', 1);
GO
