#!/bin/sh
# fonts-manifest.sh - keeps fonts/manifest.txt in sync with the font files in the folder.
# Used by the PhotoCraft app in the dockercraft-casaos store (berg-maia/dockercraft-casaos).
# A manifest.txt whose first line is not "# auto-generated" is treated as hand-made and left alone.
# Change the folder or the interval with the ROOT and INTERVAL environment variables.

command -v fc-scan >/dev/null 2>&1 || apk add --no-cache fontconfig >/dev/null 2>&1 \
  || echo "fonts-manifest: could not install fontconfig; manifest will not be generated"

ROOT="${ROOT:-/usr/share/nginx/html}"
D="$ROOT/fonts"; M="$D/manifest.txt"; MARK="# auto-generated"
last=""
while true; do
  if [ -d "$D" ] && { [ ! -f "$M" ] || head -n1 "$M" | grep -q "^$MARK"; }; then
    sig=$(find "$D" -type f \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) -exec ls -ln {} + 2>/dev/null | md5sum)
    if [ "$sig" != "$last" ]; then
      last="$sig"
      tmp="$M.tmp"
      echo "$MARK from the font files in this folder. Remove this line to keep manual edits." > "$tmp"
      find "$D" -type f \( -iname '*.ttf' -o -iname '*.otf' -o -iname '*.ttc' \) | sort | while IFS= read -r f; do
        fc-scan --format '%{family[0]} | %{style[0]} | fonts/REL\n' "$f" 2>/dev/null | head -n1 | sed "s#REL#${f#$D/}#"
      done >> "$tmp"
      mv "$tmp" "$M"
      echo "fonts manifest: $(grep -vc '^#' "$M") fonts"
    fi
  fi
  sleep "${INTERVAL:-60}"
done
