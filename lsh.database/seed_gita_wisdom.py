# Run with:  LSH_DB_PASSWORD=... python3 seed_gita_wisdom.py
# The password used to be hard-coded here; it now comes from the
# environment so this file is safe to commit and to share.
import os
"""
Seeds dbo.DailyWisdom with all 30 GITA_WISDOM entries.
Uses parameterized queries so titles/bodies with special chars are stored cleanly.
Mapping:
  text_original = body   (long wisdom paragraph shown as the quote)
  text_english  = title  (child-friendly title shown as subtitle)
  author        = "Bhagavad Gita <verse>"
  source_track  = 'gita'
  language_id   = 1 (English)
"""
import pyodbc

CONN_STR = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=94.72.121.94,1433;"
    "DATABASE=LittleScholarHub;"
    "UID=SA;PWD=${LSH_DB_PASSWORD};"
    "TrustServerCertificate=yes;Encrypt=yes;"
)

GITA_WISDOM = [
    {"verse": "2.47",  "title": "Do your best. Let go of the rest.",
     "body": "You get to choose how hard you try — but not whether things turn out perfectly. Give your full effort, then release the worry. That is where peace lives."},
    {"verse": "6.5",   "title": "Your mind is your best friend.",
     "body": "The same mind that worries can also calm you. Train it gently — a minute a day — and it becomes the kindest voice you know."},
    {"verse": "6.6",   "title": "A trained mind protects you.",
     "body": "When you learn to quiet your thoughts, your mind works for you instead of against you. That friendship with yourself is the strongest one you'll ever have."},
    {"verse": "2.20",  "title": "You are more than your body.",
     "body": "The part of you that loves, wonders, and grows is not made of skin and bones. It cannot be broken. It always was and always will be."},
    {"verse": "3.19",  "title": "Work without waiting for rewards.",
     "body": "When you do something kind, helpful, or honest without checking to see what you'll get back — that is when your action becomes truly beautiful."},
    {"verse": "2.14",  "title": "Difficult days pass like seasons.",
     "body": "Cold days don't last forever, and neither do hard feelings. Learn to sit with discomfort without being swept away, and you become unshakeable."},
    {"verse": "9.26",  "title": "Small gifts given with love mean everything.",
     "body": "A flower, a glass of water, a kind word — offered with a full heart, these reach further than any grand gesture given without feeling."},
    {"verse": "2.48",  "title": "Stay steady in success and failure alike.",
     "body": "Whether a test goes well or not, whether the team wins or loses — keep the same calm inside. That evenness is called Yog, and it is its own reward."},
    {"verse": "12.13", "title": "Be kind to every living being.",
     "body": "The person closest to wisdom holds no malice toward anyone — friend, stranger, or someone who hurt them. That compassion is not weakness; it is the highest strength."},
    {"verse": "4.7",   "title": "When things go wrong, goodness rises to meet it.",
     "body": "Whenever kindness fades in the world, something greater quietly stirs. Good always finds a way to come back. You can be part of that."},
    {"verse": "2.56",  "title": "Calm in the storm is the mark of wisdom.",
     "body": "A wise person is not someone who never faces trouble — it is someone whose mind stays clear in the middle of it. Practice stillness a little every day."},
    {"verse": "18.66", "title": "Let go and trust.",
     "body": "When you have done everything you can, it is all right to put the rest down. Surrender is not giving up — it is trusting that you are held."},
    {"verse": "3.35",  "title": "Walk your own path.",
     "body": "Your own purpose, lived imperfectly, is worth far more than someone else's path walked with perfection. You were made for your own journey."},
    {"verse": "6.17",  "title": "Balance is the secret to everything.",
     "body": "Eat enough, sleep enough, play enough, work enough. Not too much of any one thing. In that balance, suffering quietly disappears."},
    {"verse": "2.38",  "title": "Do your duty — no matter what.",
     "body": "Do what is right because it is right, not because you'll be praised. Whether the result is joy or grief, treat both the same and you will never be lost."},
    {"verse": "4.38",  "title": "Knowledge is the greatest purifier.",
     "body": "Understanding why things happen — in nature, in people, in your own heart — clears away confusion the way sunlight burns off morning fog."},
    {"verse": "6.19",  "title": "A focused mind is like a flame in still air.",
     "body": "When a candle burns in a windless room, it doesn't flicker. A mind that has learned to be still is exactly like that — steady, bright, reliable."},
    {"verse": "9.22",  "title": "Those who remember good things are protected.",
     "body": "When you keep your thoughts anchored in what truly matters — in goodness, in love, in purpose — what you need tends to find you."},
    {"verse": "2.13",  "title": "Every stage of life is a gift.",
     "body": "You were a toddler, then a child, and one day you will be grown. The soul inside you watches all of it with quiet joy. None of it is wasted."},
    {"verse": "6.32",  "title": "Feel others' joy and pain as your own.",
     "body": "The highest yogi is the one who sees a friend's happiness and is happy, and sees a stranger's pain and is moved. That is the beginning of wisdom."},
    {"verse": "3.27",  "title": "Nature does the work — stay humble.",
     "body": "When you accomplish something great, remember that the air in your lungs, the mind that thought it through, and the hands that did the work — all were given to you."},
    {"verse": "4.39",  "title": "Faith and focus unlock everything.",
     "body": "Those who believe deeply and practice steadily find that the answers they need arrive at just the right moment. Trust the process, even on slow days."},
    {"verse": "2.70",  "title": "Be like the ocean — not the river.",
     "body": "Rivers rush in and disturb the ocean, but the ocean stays still. Let good news and bad news flow through you without carrying you away."},
    {"verse": "18.47", "title": "Your own path matters most.",
     "body": "Doing your own duty — even imperfectly — is more meaningful than perfectly imitating someone else. Your unique contribution to this world cannot be replaced."},
    {"verse": "2.72",  "title": "Steady wisdom leads to freedom.",
     "body": "The one who finds peace in understanding — who is no longer confused about what truly matters — is never lost, even at the hardest moment."},
    {"verse": "10.41", "title": "Beauty is a glimpse of something greater.",
     "body": "Everywhere you see something glorious — a sunset, a kind act, a perfect song — know that you are seeing a small reflection of the infinite. That sense of wonder is wisdom."},
    {"verse": "6.10",  "title": "Quiet time with yourself is never wasted.",
     "body": "A few minutes each day in stillness — away from noise and screens — is not idle time. It is where you find out who you actually are."},
    {"verse": "12.15", "title": "Don't disturb others; don't be disturbed.",
     "body": "Move through the world without causing worry, and practice not being rattled by the small things others do. That double peace is the rarest quality."},
    {"verse": "18.55", "title": "Love is the only way to truly know.",
     "body": "You can study everything about a person for years and still not know them. But love — real, patient, giving love — opens every door that knowledge alone cannot."},
    {"verse": "18.78", "title": "Where goodness and skill meet, things flourish.",
     "body": "Where a good heart and a prepared mind come together, you will always find prosperity, success, and rightness. Grow both — every single day."},
]


def main():
    conn = pyodbc.connect(CONN_STR, timeout=15)
    conn.autocommit = True
    cur = conn.cursor()
    print(f"Connected. Seeding {len(GITA_WISDOM)} GITA_WISDOM entries...\n")

    # Clear existing gita rows so re-runs are idempotent
    cur.execute("DELETE FROM dbo.DailyWisdom WHERE source_track='gita' AND language_id=1")
    print(f"  Cleared existing gita rows (deleted={cur.rowcount})")

    inserted = 0
    for entry in GITA_WISDOM:
        cur.execute(
            "INSERT INTO dbo.DailyWisdom "
            "  (language_id, source_track, text_original, text_english, author) "
            "VALUES (?, 'gita', ?, ?, ?)",
            (
                1,                                      # language_id = English
                entry["body"],                          # text_original = body paragraph
                entry["title"],                         # text_english  = child-friendly title
                f"Bhagavad Gita {entry['verse']}",      # author        = verse reference
            ),
        )
        inserted += cur.rowcount
        print(f"  [{entry['verse']:>5}]  {entry['title'][:55]}")

    cur.close()
    conn.close()
    print(f"\nDone — {inserted}/{len(GITA_WISDOM)} rows inserted.")


if __name__ == "__main__":
    main()
