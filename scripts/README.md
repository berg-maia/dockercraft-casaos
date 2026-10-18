# scripts

Helper scripts that the apps in this store download and run **inside their own container**. They are not part of the store itself and CasaOS does not read this folder.

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

The other ArtCraft apps do not load external fonts, so they do not use this script.
