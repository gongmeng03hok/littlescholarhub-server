# lsh.api — Step-by-Step Deployment Guide
**Server:** Contabo VPS | **OS:** Ubuntu 24.04  
**Stack:** Flask 3.1 · pyodbc · SQL Server · Gunicorn · Nginx  
**URL:** https://www.littlescholarhub.com/api/

---

## Pre-flight checklist
- [ ] SSH access to Contabo server
- [ ] SQL Server (Docker) already running on port 1433
- [ ] Domain `littlescholarhub.com` DNS pointing to server IP (IONOS)
- [ ] `backend/` folder ready to upload

---

## STEP 1 — Upload the code to the server

Run this from your **local machine** (Windows PowerShell or terminal):

```bash
# Create the target folder on server first
ssh root@YOUR_CONTABO_IP "mkdir -p /var/www/littlescholarhub/lsh.api"

# Upload the backend folder
scp -r ./backend/* root@YOUR_CONTABO_IP:/var/www/littlescholarhub/lsh.api/
```

> If you're using WinSCP or FileZilla, copy the contents of `backend/`  
> into `/var/www/littlescholarhub/lsh.api/` on the server.

---

## STEP 2 — Install system dependencies

SSH into the server, then run:

```bash
ssh root@YOUR_CONTABO_IP
```

```bash
# Update packages
apt-get update && apt-get upgrade -y

# Python 3, pip, venv
apt-get install -y python3 python3-pip python3-venv

# ODBC Driver 18 for SQL Server (required by pyodbc)
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list \
     > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev

# Verify ODBC driver installed
odbcinst -q -d -n "ODBC Driver 18 for SQL Server" && echo "✓ ODBC Driver OK"
```

---

## STEP 3 — Create Python virtual environment

```bash
cd /var/www/littlescholarhub/lsh.api

# Create venv
python3 -m venv venv

# Activate it
source venv/bin/activate

# Upgrade pip
cd 

# Install all dependencies from requirements.txt
pip install -r requirements.txt
```

Expected output — all these packages install successfully:
- flask 3.1.3
- flask-cors 6.0.2
- pyodbc 5.3.0
- bcrypt 5.0.0
- PyJWT 2.12.1
- python-dotenv 1.2.2
- gunicorn 26.0.0
- reportlab 4.5.1

```bash
# Deactivate venv when done
deactivate
```

---

## STEP 4 — Configure the .env file

```bash
nano /var/www/littlescholarhub/lsh.api/.env
```

Set it to:

```env
# ── Database ──────────────────────────────────────────────
# SQL Server is on the SAME server → use localhost
DB_CONN=DRIVER={ODBC Driver 18 for SQL Server};SERVER=localhost,1433;DATABASE=LittleScholarsHub;UID=SA;PWD=YOUR_DB_PASSWORD;TrustServerCertificate=yes

# ── Security ──────────────────────────────────────────────
JWT_SECRET=YOUR_JWT_SECRET

# ── Email (optional — fill in when ready) ─────────────────
SMTP_HOST=smtp.sendgrid.net
SMTP_PORT=587
SMTP_USER=apikey
SMTP_PASSWORD=YOUR_SMTP_PASSWORD
FROM_EMAIL=noreply@littlescholarhub.com

# ── App ───────────────────────────────────────────────────
FLASK_ENV=production
PORT=5001
```

> ⚠️ **Important:** Change `SERVER=94.72.121.94,1433` → `SERVER=localhost,1433`  
> since the API and SQL Server are on the same machine.  
> Also note PORT is **5001** (not 5000) to avoid conflicts.

Save and exit: `Ctrl+O` → Enter → `Ctrl+X`

**Secure the file:**
```bash
chmod 640 /var/www/littlescholarhub/lsh.api/.env
```

---

## STEP 5 — Test the app manually

```bash
cd /var/www/littlescholarhub/lsh.api
source venv/bin/activate

# Quick smoke test — should import without errors
python3 -c "from app import create_app; app = create_app(); print('✓ App created OK')"
```

If you see `✓ App created OK` — proceed.  
If you see import errors — check that all files uploaded correctly in Step 1.

```bash
# Optional: run dev server briefly to test DB connection
python3 app.py
# Then in another terminal: curl http://localhost:5000/api/health
# Should return: {"status": "ok", "ts": "..."}
# Ctrl+C to stop

deactivate
```

---

## STEP 6 — Create the Gunicorn WSGI entry point

The app uses `create_app()` factory pattern, so Gunicorn needs a `wsgi.py`:

```bash
cat > /var/www/littlescholarhub/lsh.api/wsgi.py << 'EOF'
from app import create_app
application = create_app()
EOF
```

---

## STEP 7 — Install the systemd service

```bash
cat > /etc/systemd/system/lsh-api.service << 'EOF'
[Unit]
Description=Little Scholar Hub — Python API (Gunicorn)
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/var/www/littlescholarhub/lsh.api
EnvironmentFile=/var/www/littlescholarhub/lsh.api/.env

ExecStart=/var/www/littlescholarhub/lsh.api/venv/bin/gunicorn \
    --workers 3 \
    --bind 127.0.0.1:5001 \
    --timeout 120 \
    --access-logfile /var/log/lsh-api-access.log \
    --error-logfile /var/log/lsh-api-error.log \
    wsgi:application

ExecReload=/bin/kill -s HUP $MAINPID
KillMode=mixed
TimeoutStopSec=5
PrivateTmp=true
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

---

## STEP 8 — Set file permissions

```bash
# www-data must own the app files
chown -R www-data:www-data /var/www/littlescholarhub/lsh.api
chmod -R 755 /var/www/littlescholarhub/lsh.api

# .env stays readable only by owner
chmod 640 /var/www/littlescholarhub/lsh.api/.env

# Create log files with correct owner
touch /var/log/lsh-api-access.log /var/log/lsh-api-error.log
chown www-data:www-data /var/log/lsh-api-access.log /var/log/lsh-api-error.log
```

---

## STEP 9 — Enable and start the service

```bash
# Reload systemd to pick up new service file
systemctl daemon-reload

# Enable so it starts on server reboot
systemctl enable lsh-api

# Start the service
systemctl start lsh-api

# Wait 2 seconds and check status
sleep 2 && systemctl status lsh-api
```

You should see `Active: active (running)` in green.

---

## STEP 10 — Verify API is running

```bash
# Test locally on server (Gunicorn direct)
curl http://127.0.0.1:5001/api/health
# Expected: {"status": "ok", "ts": "2026-05-16T..."}

# Check Gunicorn is listening
ss -tlnp | grep 5001
# Expected: LISTEN  0  ...  127.0.0.1:5001
```

---

## STEP 11 — Configure Nginx to proxy /api/

```bash
# Check if Nginx is installed
nginx -v

# If not: apt-get install -y nginx

# Create/update the site config
cat > /etc/nginx/sites-available/littlescholarhub << 'EOF'
# HTTP → HTTPS redirect
server {
    listen 80;
    listen [::]:80;
    server_name littlescholarhub.com www.littlescholarhub.com;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }
    location / {
        return 301 https://www.littlescholarhub.com$request_uri;
    }
}

# Main HTTPS server (SSL added by certbot in next step)
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name www.littlescholarhub.com;

    # SSL certs — certbot fills these in
    ssl_certificate     /etc/letsencrypt/live/littlescholarhub.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/littlescholarhub.com/privkey.pem;
    include             /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam         /etc/letsencrypt/ssl-dhparams.pem;

    # React web app (Step 2 of web deploy)
    root /var/www/littlescholarhub/lsh.web/dist;
    index index.html;
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Python API — proxy to Gunicorn
    location /api/ {
        proxy_pass         http://127.0.0.1:5001;
        proxy_http_version 1.1;
        proxy_set_header   Host              $host;
        proxy_set_header   X-Real-IP         $remote_addr;
        proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
        proxy_read_timeout 120;
    }

    access_log /var/log/nginx/littlescholarhub_access.log;
    error_log  /var/log/nginx/littlescholarhub_error.log;
}
EOF

# Enable the site
ln -sfn /etc/nginx/sites-available/littlescholarhub \
        /etc/nginx/sites-enabled/littlescholarhub
rm -f /etc/nginx/sites-enabled/default

# Test and reload
nginx -t && systemctl reload nginx
```

---

## STEP 12 — Get SSL certificate (Let's Encrypt)

> Make sure DNS is pointing to your server IP before this step!

```bash
apt-get install -y certbot python3-certbot-nginx

certbot --nginx \
  -d littlescholarhub.com \
  -d www.littlescholarhub.com \
  --non-interactive \
  --agree-tos \
  --email admin@littlescholarhub.com \
  --redirect
```

Certbot will:
1. Get certificates from Let's Encrypt
2. Automatically update your Nginx config with SSL paths
3. Set up HTTP → HTTPS redirect

```bash
# Final Nginx reload
nginx -t && systemctl reload nginx
```

---

## STEP 13 — Final end-to-end test

```bash
# Health check via public HTTPS URL
curl https://www.littlescholarhub.com/api/health
# Expected: {"status": "ok", "ts": "..."}

# Test auth endpoint
curl -X POST https://www.littlescholarhub.com/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"Test123!","name":"Test"}'
```

---

## Useful commands (day-to-day)

```bash
# View live API logs
journalctl -u lsh-api -f

# Restart API after code changes
systemctl restart lsh-api

# Check API status
systemctl status lsh-api

# View Nginx error log
tail -f /var/log/nginx/littlescholarhub_error.log

# View Gunicorn access log
tail -f /var/log/lsh-api-access.log

# Renew SSL cert (auto, but manual if needed)
certbot renew --dry-run
```

---

## Troubleshooting

| Problem | Command to diagnose |
|---|---|
| Service won't start | `journalctl -u lsh-api -n 50` |
| DB connection fails | `curl http://127.0.0.1:5001/api/health` |
| 502 Bad Gateway | `systemctl status lsh-api` + check port 5001 |
| ODBC driver missing | `odbcinst -q -d` |
| Permission denied | `ls -la /var/www/littlescholarhub/lsh.api` |
| SSL cert issues | `certbot certificates` |
