#!/usr/bin/env bash
set -euo pipefail

PUBLIC_DIR="${1:-public}"

if [ ! -d "$PUBLIC_DIR" ]; then
  echo "ERROR: '$PUBLIC_DIR' not found. Run 'make deploy' first." >&2
  exit 1
fi

fail=0
pass=0

while IFS= read -r html; do
  # skip Hugo alias redirects (meta-refresh stubs)
  if grep -q 'http-equiv=refresh\|http-equiv="refresh"' "$html" 2>/dev/null; then
    continue
  fi
  md="${html%index.html}index.md"
  if [ -f "$md" ]; then
    pass=$((pass + 1))
  else
    echo "MISSING: $md"
    fail=$((fail + 1))
  fi
done < <(find "$PUBLIC_DIR" -name "index.html" \
  -not -path "$PUBLIC_DIR/admin/*" \
  -not -path "$PUBLIC_DIR/files/*" \
  -not -path "$PUBLIC_DIR/imgs/*" \
  -not -path "$PUBLIC_DIR/ox-hugo/*" \
  -not -path "$PUBLIC_DIR/posts/*" \
  -not -path "*/page/*")

total=$((pass + fail))
echo "Results: $pass passed, $fail failed out of $total pages"

[ "$fail" -eq 0 ]
