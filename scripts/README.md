# scripts

Helper scripts that the apps in this store download and run **inside their own container**. They are not part of the store itself and CasaOS does not read this folder.

| Script | Used by | What it does |
|---|---|---|
| [`fonts-manifest.sh`](#fonts-manifestsh) | PhotoCraft | Keeps `fonts/manifest.txt` up to date |
| [`fonts-json.sh`](#fonts-jsonsh) | TraceDraw | Keeps `fonts/fonts.json` up to date |

## fonts-manifest.sh

Used by **PhotoCraft**.

PhotoCraft ships with two fonts (Inter and JetBrains Mono). It can load more fonts from a `fonts/` folder next to the app, but only the ones listed in `fonts/manifest.txt`, one per line:

```text
Family | Style | fonts/path/to/file.ttf
```

Writing that list by hand is tedious, so this script does it. It scans the `fonts/` folder (`.ttf`, `.otf` and `.ttc`, including subfolders) and keeps `manifest.txt` up to date.

### How it works

1. Installs `fontconfig` (for `fc-scan`) if it is missing. This needs internet access the first time a container is created.
2. Every 60 seconds it checks whether the list of font files changed. If it did, it rewrites `fonts/manifest.txt` with the family and style read from each font file.
3. Add or remove a font in the folder and it shows up in PhotoCraft after the next check. Reload the page to see it.

If the first line of `manifest.txt` is not `# auto-generated ...`, the script treats the file as hand-made and **never touches it**. To take over the file yourself, delete that first line.

### How the store uses it

The PhotoCraft compose file overrides the container command so that, on every start, it downloads this script to `/opt/fonts-manifest.sh` (keeping the previous copy if the download fails), runs it in the background and then starts nginx as usual. The fonts folder is the only extra volume.

Because the script is downloaded from the `main` branch on each start, an update here reaches users the next time their container restarts, with no change to the compose file. For the same reason, only trusted changes should be merged into this file.

### Settings

| Variable | Default | Meaning |
|---|---|---|
| `ROOT` | `/usr/share/nginx/html` | Site folder that contains `fonts/` |
| `INTERVAL` | `60` | Seconds between checks |

### Limits

- Needs `fc-scan`. Without it (no internet on first run) no manifest is generated and PhotoCraft keeps its two built-in fonts.
- For each font file only the first style that `fc-scan` reports is listed. A variable font gets one line, and the app reads its weights from the font itself. For a `.ttc` collection only the first face is listed.
- Font licenses are not handled. Keep each font's license file next to it, as most licenses (such as the SIL Open Font License) require.

### Using it without the store

Any `docker compose` setup of `ghcr.io/berg-maia/photocraft-web` can do the same: mount a folder on `/usr/share/nginx/html/fonts`, then use this command:

```yaml
    command: ["sh", "-c", "wget -qO /tmp/fonts-manifest.sh https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/scripts/fonts-manifest.sh && mv /tmp/fonts-manifest.sh /opt/fonts-manifest.sh; sh /opt/fonts-manifest.sh & exec nginx -g 'daemon off;'"]
```


The script is for PhotoCraft only; TraceDraw has its own, below.

## fonts-json.sh

Used by **TraceDraw**.

TraceDraw can load extra fonts from a `fonts/` folder next to the app. It reads `fonts/fonts.json`, which maps each family to its files:

```json
{"Open Sans": ["OpenSans-Regular.ttf", "OpenSans-Bold.ttf"]}
```

This script builds that file from the fonts in the folder and keeps it up to date.

### How it works

1. Installs `fontconfig` (for `fc-scan`) if it is missing. This needs internet access the first time a container is created.
2. Every 60 seconds it checks whether the font files changed. If they did, it rewrites `fonts/fonts.json`, grouping the files by the family name read from each font.
3. Add or remove a font and it shows up in TraceDraw after the next check. Reload the page to see it.

If `fonts.json` does not have the `"_auto-generated"` key, the script treats the file as hand-made and **never touches it**. To take over the file yourself, delete that key.

### File name rules

TraceDraw only accepts font files that are **directly in the folder** (no subfolders), end in `.ttf`, `.otf` or `.ttc`, and have names with only letters, digits, `.`, `_` and `-` (up to 128 characters). Anything else is ignored by the app without a warning.

Font files downloaded from Google Fonts often break the rule (for example `Roboto-VariableFont_wdth,wght.ttf` has a comma). For those the script creates a link with a safe name next to the original (`Roboto-VariableFont_wdth-wght.ttf`) and lists the link. The original file is never renamed or changed. A link whose original was deleted is removed. If no safe name can be made, a message in the container log asks you to rename the file.

### How the store uses it

The TraceDraw compose file overrides the container command so that, on every start, it downloads this script to `/opt/fonts-json.sh` (keeping the previous copy if the download fails), runs it in the background and then starts nginx as usual. The fonts folder is the only extra volume. As with the other script, the download comes from the `main` branch, so only trusted changes should be merged into this file.

### Settings

Same as `fonts-manifest.sh`: `ROOT` (default `/usr/share/nginx/html`) and `INTERVAL` (default `60` seconds).

### Limits

- Needs `fc-scan`. Without it (no internet on first run) no `fonts.json` is generated and TraceDraw keeps its built-in fonts.
- Only the first face of a `.ttc` collection is listed. A variable font is listed once, and the app reads its weights from the font itself.
- Subfolders are not scanned, because TraceDraw does not read them.
- Font licenses are not handled. Keep each font's license file with it, as most licenses (such as the SIL Open Font License) require.

### Using it without the store

Any `docker compose` setup of `ghcr.io/berg-maia/tracedraw-web` can do the same: mount a folder on `/usr/share/nginx/html/fonts`, then use this command:

```yaml
    command: ["sh", "-c", "wget -qO /tmp/fonts-json.sh https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/scripts/fonts-json.sh && mv /tmp/fonts-json.sh /opt/fonts-json.sh; sh /opt/fonts-json.sh & exec nginx -g 'daemon off;'"]
```

The other apps in the store do not load external fonts, so they do not use these scripts.
