#!/bin/sh
# fonts-json.sh - keeps fonts/fonts.json in sync with the font files in the folder.
# Used by TraceDraw in the dockercraft-casaos store (berg-maia/dockercraft-casaos).
#
# TraceDraw reads fonts/fonts.json next to the page: {"Family": ["File-Regular.ttf", ...]}.
# Rules of the app: files must be directly in the folder (no subfolders), end in
# .ttf, .otf or .ttc, and have names with only letters, digits, . _ and -.
# A file whose name breaks the name rule (Google's "Roboto[wdth,wght].ttf" style names have commas,
# for example) gets a link with a safe name next to it (commas, spaces and other symbols become "-").
# The original file is never touched or renamed. Links whose original was deleted are removed.
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
    sig=$(find "$D" -maxdepth 1 \( -type f -o -type l \) \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) -exec ls -ln {} + 2>/dev/null | md5sum)
    if [ "$sig" != "$last" ]; then
      last="$sig"
      tmp="$J.tmp"
      # links made earlier whose original file is gone
      find "$D" -maxdepth 1 -type l | while IFS= read -r l; do [ -e "$l" ] || rm -f "$l"; done
      # a safe-named link for each file whose own name the app would reject
      find "$D" -maxdepth 1 -type f \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) | while IFS= read -r f; do
        b="${f##*/}"
        case "$b" in
          .*|*[!A-Za-z0-9._-]*)
            s=$(printf '%s' "$b" | tr -c 'A-Za-z0-9._\n-' '-' | sed 's/^\.*//')
            if [ -n "$s" ] && [ ! -e "$D/$s" ]; then ln -s "$b" "$D/$s" && echo "fonts-json: '$b' -> '$s'" >&2
            elif [ ! -L "$D/$s" ]; then echo "fonts-json: cannot make a safe name for '$b'; rename it using only letters, digits, . _ -" >&2; fi ;;
        esac
      done
      find "$D" -maxdepth 1 \( -type f -o -type l \) \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) | sort | while IFS= read -r f; do
        b="${f##*/}"
        case "$b" in
          .*|*[!A-Za-z0-9._-]*) continue ;;
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
