"""
seed_admin.py — Run once after migration to set the real admin password hash.
Usage:  python seed_admin.py
"""
import os, sys
from dotenv import load_dotenv
load_dotenv()

# Bootstrap Flask context for bcrypt
from werkzeug.security import generate_password_hash

def main():
    admin_email    = os.getenv("ADMIN_EMAIL",    "admin@littlescholarhub.com")
    admin_password = os.getenv("ADMIN_PASSWORD", "")
    if not admin_password:
        admin_password = input("Enter admin password (12+ chars): ").strip()
    if len(admin_password) < 12:
        print("ERROR: password must be 12+ characters"); sys.exit(1)

    import bcrypt
    hashed = bcrypt.hashpw(admin_password.encode(), bcrypt.gensalt()).decode()
    print(f"\n✅  bcrypt hash generated.")
    print(f"\nRun this SQL against your database:\n")
    print(f"UPDATE dbo.Families")
    print(f"SET password_hash = '{hashed}'")
    print(f"WHERE email = '{admin_email}' AND role = 'admin';")
    print(f"\nOr call:  POST /api/admin/set-password")
    print(f"  {{ \"email\": \"{admin_email}\", \"new_password\": \"<password>\" }}")
    print(f"  (requires an existing valid admin JWT)")

if __name__ == "__main__":
    main()
