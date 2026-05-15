#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${1:-http://localhost:8888}"
SITEMAP_URL="${BASE_URL/8888/1313}/sitemap.xml"

echo "Fetching sitemap from $SITEMAP_URL..."
urls=$(curl -sf "$SITEMAP_URL" | grep -o '<loc>[^<]*</loc>' | sed 's/<[^>]*>//g' | sed -E "s|https?://[^/]*|$BASE_URL|g")

if [ -z "$urls" ]; then
  echo "ERROR: No URLs found. Is Hugo running?" >&2
  exit 1
fi

total=$(echo "$urls" | wc -l | tr -d ' ')
echo "Testing $total pages..."
echo ""

fail=0
pass=0

while IFS= read -r url; do
  ct=$(curl -s -o /dev/null -w "%{content_type}" "$url")
  if echo "$ct" | grep -q "text/html"; then
    echo "FAIL  $url  ($ct)"
    fail=$((fail + 1))
  else
    pass=$((pass + 1))
  fi
done <<< "$urls"

echo ""
echo "Results: $pass passed, $fail failed out of $total pages"

[ "$fail" -eq 0 ]
