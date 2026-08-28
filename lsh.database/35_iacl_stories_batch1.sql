-- 35_iacl_stories_batch1.sql
-- First batch of Stories content adapted from classic public-domain tales
-- found in Archive.org's IACL (Internet Archive Children's Library)
-- collection. Body text below is an ORIGINAL kid-level retelling, not a
-- copy of any scanned book's text (IACL's raw OCR text is messy 19th/early
-- 20th-century scan output, not appropriate to paste directly into a TK-6
-- read-aloud product) -- source_url links back to the real archive.org item
-- for attribution / for families who want the original.
-- audio_url is populated separately via POST /admin/stories/<id>/generate-audio
-- (gTTS-based read-aloud narration) after this migration runs.

INSERT INTO dbo.Stories (grade_id, language_id, title, body_text, read_min, theme_tag, thumbnail_url, source_url, source_attribution, is_published)
VALUES
(0, 1, N'The Tortoise and the Hare', N'Once there was a speedy hare who loved to brag about how fast he was. One day, a slow tortoise said, "Let''s race!" The hare laughed and laughed. "You? Race me? Silly tortoise!"

The race began. The hare zoomed ahead so fast that he decided to take a nap under a tree. "I have plenty of time," he said, and closed his eyes.

The tortoise kept walking. Step... step... step. He never stopped, not even once.

When the hare woke up, the tortoise was almost at the finish line! The hare ran as fast as he could, but it was too late. The tortoise crossed the finish line first.

Slow and steady wins the race!', 2, N'fable', 'https://archive.org/services/img/fablesofaesopoth00aesoiala', 'https://archive.org/details/fablesofaesopoth00aesoiala', N'Adapted from a public-domain classic in the Internet Archive Children''s Library', 1),
(1, 1, N'The Ant and the Grasshopper', N'All summer long, a hardworking ant carried food back to her home, one crumb at a time. The sun was hot and the work was hard, but she didn''t stop.

Nearby, a grasshopper fiddled and sang and danced in the tall green grass. "Why work so hard?" he laughed. "Come play with me instead!"

"I''m storing food for winter," said the ant. "You should do the same."

The grasshopper just shrugged and kept on singing.

Then winter came. Snow covered the ground, and the grasshopper had nothing to eat. Shivering, he knocked on the ant''s door.

The ant looked at her shelves, full of food she had gathered all summer. She shared her food with the hungry grasshopper — and from that day on, he learned the value of a little hard work.

It''s wise to prepare today for what tomorrow may bring.', 2, N'fable', 'https://archive.org/services/img/fablesofaesopoth00aesoiala', 'https://archive.org/details/fablesofaesopoth00aesoiala', N'Adapted from a public-domain classic in the Internet Archive Children''s Library', 1),
(2, 1, N'The Boy Who Cried Wolf', N'A shepherd boy watched his sheep on a hill outside the village every day. It was quiet work, and sometimes he felt bored.

One afternoon, just for fun, he ran down the hill shouting, "Wolf! Wolf! A wolf is chasing the sheep!"

The villagers dropped what they were doing and rushed up the hill to help — but when they arrived, there was no wolf at all. The boy laughed and laughed. "I fooled you!" he said.

A few days later, the boy played the same trick again. "Wolf! Wolf!" he cried. Once more, the villagers came running, and once more, they found nothing.

Then one evening, a real wolf crept out of the woods and began chasing the sheep! The boy was terrified. "Wolf! Wolf!" he screamed, as loud as he could. "A wolf is really here this time!"

But the villagers had heard him cry wolf twice before. "He''s just playing tricks again," they said, and no one came.

The wolf scattered the flock, and the boy learned a hard lesson that day: no one believes a liar, even when they''re finally telling the truth.', 3, N'fable', 'https://archive.org/services/img/fablesofaesopoth00aesoiala', 'https://archive.org/details/fablesofaesopoth00aesoiala', N'Adapted from a public-domain classic in the Internet Archive Children''s Library', 1),
(3, 1, N'The Lion and the Mouse', N'A mighty lion was sleeping in the shade when a little mouse, running along in a hurry, accidentally scurried right across his paw. The lion woke up with a roar and grabbed the mouse in one huge paw.

"Please don''t eat me!" squeaked the mouse. "Let me go, and someday I might help you!"

The lion laughed so hard his whiskers shook. "You? Help me? A tiny thing like you could never help a lion!" But he was amused enough that he opened his paw and let the mouse scamper away.

Weeks later, the lion was walking through the jungle when he stepped into a hunter''s net. He roared and struggled, but the ropes only pulled tighter. The more he fought, the more stuck he became.

The little mouse heard the lion''s roars from far away and came running. "Hold still," said the mouse. "I''ll help you, just like I promised!"

The mouse gnawed and gnawed at the ropes with his sharp little teeth until, at last, they snapped apart. The lion stood up, free again.

"I''m sorry I laughed at you," said the lion. "You were small, but you saved my life."

Even the smallest friend can turn out to be the greatest help of all.', 3, N'fable', 'https://archive.org/services/img/fablesofaesopoth00aesoiala', 'https://archive.org/details/fablesofaesopoth00aesoiala', N'Adapted from a public-domain classic in the Internet Archive Children''s Library', 1),
(4, 1, N'Cinderella', N'Once there lived a kind girl named Cinderella, who lived with her stepmother and two stepsisters. They treated her unkindly, making her cook and clean all day while they wore fine dresses and did as they pleased.

One day, an invitation arrived: the prince was holding a grand ball, and every young lady in the kingdom was invited. Cinderella''s stepsisters spent hours choosing gowns and jewels. Cinderella only wished, quietly, that she could go too — but she had no fine dress to wear, and her chores kept her busy until the sisters left for the palace.

As she sat alone by the fireplace, a soft light filled the room. A fairy godmother appeared! With a wave of her wand, Cinderella''s ragged dress transformed into a shimmering gown, and a pumpkin in the garden became a golden carriage.

"Enjoy the ball," said the fairy godmother, "but you must return before midnight, or the magic will disappear."

At the ball, Cinderella danced with the prince all evening, and he was captivated by her kindness and grace. But when the clock began to strike twelve, she remembered her promise and dashed down the palace steps — losing one glass slipper along the way.

The prince searched the whole kingdom, having every young lady try on the slipper, until at last he reached Cinderella''s house. The slipper fit her perfectly.

The prince recognized her at once, and they were married soon after, living happily together for the rest of their days.

Kindness and patience are rewarded in the end.', 4, N'fairy_tale', 'https://archive.org/services/img/adventuresofcind00londiala', 'https://archive.org/details/adventuresofcind00londiala', N'Adapted from a public-domain classic in the Internet Archive Children''s Library', 1),
(5, 1, N'Little Red Riding Hood', N'Once there was a sweet little girl who always wore a red hooded cloak, so everyone called her Little Red Riding Hood. One morning, her mother asked her to bring a basket of bread and fruit to her grandmother, who lived deep in the forest and wasn''t feeling well.

"Go straight to Grandmother''s house," her mother warned, "and don''t wander off the path or talk to strangers."

Little Red Riding Hood promised, and set off through the trees. But partway through the forest, she met a wolf. The wolf was cunning, and he spoke in a friendly voice.

"Where are you headed on this fine morning?" he asked.

"To my grandmother''s house," she answered. "She lives just past the old mill."

The wolf raced ahead on a shortcut, arrived at the grandmother''s cottage first, and hid her away. Then he put on her nightcap and climbed into her bed, waiting for Little Red Riding Hood to arrive.

When she reached the cottage, something seemed strange about her grandmother.

"Grandmother, what big ears you have!" she said.

"All the better to hear you with," the wolf replied.

"Grandmother, what big eyes you have!"

"All the better to see you with!"

"Grandmother, what big teeth you have!"

"All the better to greet you with!" the wolf said, and he leapt from the bed.

Little Red Riding Hood screamed for help. A woodsman working nearby heard her cries and rushed in, chasing the wolf away and rescuing both Little Red Riding Hood and her grandmother, who had been hiding safely in the pantry all along.

From then on, Little Red Riding Hood always remembered to stay on the path — and never to trust a stranger''s friendly voice.', 4, N'fairy_tale', 'https://archive.org/services/img/redridinghood00veryiala', 'https://archive.org/details/redridinghood00veryiala', N'Adapted from a public-domain classic in the Internet Archive Children''s Library', 1),
(6, 1, N'The Town Mouse and the Country Mouse', N'A country mouse once invited his old friend, a town mouse, to visit his home in the fields. The town mouse arrived, brushing dust from his fine coat, and looked around at the simple burrow with its plain meal of barley and roots.

"Is this really all you eat?" the town mouse asked, wrinkling his nose. "You must come visit ME in the city. I''ll show you what a proper meal looks like."

The country mouse, curious, agreed to go. That evening, the two mice scurried into a grand house and found their way to the dining room table, where a feast had been left out: cheeses, cakes, and jellies of every kind. The country mouse had never seen so much food in his life.

"This is wonderful!" he exclaimed, nibbling at a piece of cake. But just then, the door swung open, and a huge dog came bounding in, barking loudly! The two mice scrambled for their lives, diving behind the curtains just in time.

Once the danger passed, they crept back to the table — but no sooner had they taken another bite than a cat crept silently along the shelf, eyeing them hungrily. Again, they fled, hearts pounding, hiding inside a crack in the wall until the cat wandered off.

The country mouse, trembling, turned to his friend. "I don''t understand how you live like this every day," he said. "Your food is grand, but I can hardly enjoy a single bite with all this danger around!"

"You get used to it," said the town mouse, though even he looked a little pale.

"I think I''ll go home," said the country mouse. "I''d rather eat simple barley in peace than feast like a king in constant fear."

And so the country mouse said goodbye to his friend and returned to his quiet burrow in the fields, where he lived out his days content with simple meals — and no dogs or cats to worry about.

It''s better to live simply and safely than richly and afraid.', 5, N'fable', 'https://archive.org/services/img/fablesofaesopoth00aesoiala', 'https://archive.org/details/fablesofaesopoth00aesoiala', N'Adapted from a public-domain classic in the Internet Archive Children''s Library', 1),
(7, 1, N'The Golden Goose', N'There once was a man with three sons. The youngest was often teased and called "Simpleton" by his brothers, who thought themselves far cleverer than he was.

One day, the eldest son set off into the forest to cut wood, and his mother packed him a fine cake and a bottle of wine for lunch. On his way, he met a little old grey man who asked for a bite of his cake, but the eldest son refused rudely. Moments later, his axe slipped and cut his arm, forcing him to return home.

The second son set out the next day with the same fine lunch, met the same old man, and refused him just as unkindly. He, too, injured himself in the woods and had to turn back.

Finally, Simpleton asked if he might try his luck as well. His father, doubting him, gave him only a plain biscuit and a flask of sour beer — but Simpleton didn''t mind. When he met the little grey man in the forest and was asked to share his meal, he happily agreed. To his amazement, his plain biscuit had turned into a rich cake, and his sour beer into fine wine!

Grateful, the old man told Simpleton where to find a special tree. "Cut it down," he said, "and you''ll find something wonderful in its roots."

Simpleton chopped down the tree and discovered a goose sitting among the roots — with feathers of pure gold! He tucked the goose under his arm and set off to find an inn for the night.

At the inn, the innkeeper''s three daughters each snuck in, hoping to pluck a golden feather for themselves. But the moment each girl touched the goose, her hand stuck fast to it! By morning, all three daughters were stuck in a line behind Simpleton and his goose, unable to let go, and had to follow wherever he walked, much to everyone''s astonishment.

As Simpleton traveled on with his strange parade, a gloomy princess who had never once laughed in her life saw the ridiculous sight of the three girls stuck to the goose — and burst out laughing for the very first time.

The king, delighted that someone had finally made his daughter laugh, kept his promise: Simpleton would marry the princess. And so the boy once called "Simpleton" became a prince after all — proof that kindness is worth more than cleverness.', 5, N'fairy_tale', 'https://archive.org/services/img/householdstories00grim', 'https://archive.org/details/householdstories00grim', N'Adapted from a public-domain classic in the Internet Archive Children''s Library', 1);
GO
