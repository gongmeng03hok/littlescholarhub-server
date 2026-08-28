import sys
sys.path.insert(0, '/var/www/littlescholarhub/lsh.api/app')
from app import create_app
application = create_app()
