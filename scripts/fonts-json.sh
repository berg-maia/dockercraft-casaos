#!/bin/sh
# fonts-json.sh - keeps fonts/fonts.json in sync with the font files in the folder.
# Used by TraceDraw in the dockercraft-casaos store (berg-maia/dockercraft-casaos).
#
# TraceDraw reads fonts/fonts.json next to the page: {"Family": ["File-Regular.ttf", ...]}.
# Rules of the app: files must be directly in the folder (no subfolders), end in
# .ttf, .otf or .ttc, and have names with only letters, digits, . _ and -.
# Files that break the rules are skipped (a message is printed).
#
# A fonts.json without the "_auto-generated" key is treated as hand-made and left alone.
# Change the folder or the interval with the ROOT and INTERVAL environment variables.

command -v fc-scan >/dev/null 2>&1 || apk add --no-cache fontconfig >/dev/null 2>&1 \
  || echo "fonts-json: could not install fontconfig; fonts.json will not be generated"

ROOT="${ROOT:-/usr/share/nginx/html}"
D="$ROOT/fonts"; J="$D/fonts.json"
TAB=$(printf '\t')
last=""
while true; do
  if [ -d "$D" ] && { [ ! -f "$J" ] || grep -q '"_auto-generated"' "$J"; }; then
    sig=$(find "$D" -maxdepth 1 -type f \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) -exec ls -ln {} + 2>/dev/null | md5sum)
    if [ "$sig" != "$last" ]; then
      last="$sig"
      tmp="$J.tmp"
      find "$D" -maxdepth 1 -type f \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) | sort | while IFS= read -r f; do
        b="${f##*/}"
        case "$b" in
          .*|*[!A-Za-z0-9._-]*) echo "fonts-json: skipping '$b' (use only letters, digits, . _ - in the file name)" >&2; continue ;;
        esac
        [ "${#b}" -le 128 ] || { echo "fonts-json: skipping '$b' (name too long)" >&2; continue; }
        fam=$(fc-scan --format '%{family[0]}\n' "$f" 2>/dev/null | head -n1)
        [ -n "$fam" ] && printf '%s\t%s\n' "$fam" "$b"
      done | sort -t "$TAB" -k1,1 -k2,2 | awk -F'\t' '
        function esc(s) { gsub(/\\/, "\\\\", s); gsub(/"/, "\\\"", s); return s }
        BEGIN { print "{"; printf "\"_auto-generated\": \"From the font files in this folder. Remove this key to keep manual edits.\"" }
        { if ($1 != cur) { if (cur != "") printf "]"; printf ",\n\"%s\": [\"%s\"", esc($1), esc($2); cur = $1 }
          else printf ", \"%s\"", esc($2) }
        END { if (cur != "") printf "]"; print "\n}" }' > "$tmp"
      if [ -f "$J" ] || grep -q '\]' "$tmp"; then mv "$tmp" "$J"; echo "fonts-json: $(grep -c '\]' "$J") families"; else rm -f "$tmp"; fi
    fi
  fi
  sleep "${INTERVAL:-60}"
done
