#!/bin/bash
# Little Scholars Hub — one-command deploy.  Usage: bash deploy.sh [all|web|api]  (default all)
# Builds the web app (Node 20) + publishes it, and/or restarts the Python API.
set -e
ROOT=/var/www/littlescholarhub
export PATH=/opt/node20/bin:$PATH
TS=$(date +%Y%m%d%H%M%S)
TARGET=${1:-all}

if [ "$TARGET" = api ] || [ "$TARGET" = all ]; then
  echo ">> [api] restarting lsh-api"
  systemctl restart lsh-api && sleep 2 && systemctl is-active lsh-api
fi

# Contract gate. Three merges have silently deleted backend contracts the web
# app depends on (worksheet detail, theme threading, the demo/quiz split) and
# nothing failed loudly -- the app just degraded to serving arithmetic on
# colouring pages. Fail the deploy instead of shipping that again.
echo ">> [contract] checking API contract"
$ROOT/lsh.api/venv/bin/python $ROOT/contract_test.py http://127.0.0.1:5001

if [ "$TARGET" = web ] || [ "$TARGET" = all ]; then
  echo ">> [web] building ($TS) with node $(node -v)"
  cd $ROOT/lsh.web/src
  [ -d node_modules ] || npm install --no-audit --no-fund
  npm run build:web
  # ── lsh-seo ── refresh robots/sitemap, then publish
  # `expo export` copies src/public/* into dist, but emits no 404.html, and the
  # sitemap's lastmod should track the deploy rather than whenever it was
  # first written.
  $ROOT/lsh.api/venv/bin/python $ROOT/make_seo.py $ROOT/lsh.web/src/dist
  $ROOT/lsh.api/venv/bin/python $ROOT/topic_pages.py $ROOT/lsh.web/src/dist
  cp $ROOT/lsh.web/src/public/robots.txt $ROOT/lsh.web/src/public/sitemap.xml $ROOT/lsh.web/src/dist/ 2>/dev/null || true

  echo ">> [web] publishing"
  cd $ROOT/lsh.web
  mv dist dist_old_$TS
  cp -r src/dist dist
  # The 404 body is the app shell, so a person who mistypes a URL still lands
  # in a working app while the status line stays honest for crawlers.
  cp dist/index.html dist/404.html
  chown -R www-data:webdev dist
  nginx -t && systemctl reload nginx
  echo ">> [web] published (backup: dist_old_$TS)"
fi

echo ">> health: $(curl -s http://127.0.0.1:5001/api/health)"
echo ">> DONE $TS"
