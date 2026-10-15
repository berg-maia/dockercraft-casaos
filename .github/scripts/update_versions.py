import glob
import json
import re
import subprocess


def run(*cmd):
    return subprocess.run(cmd, capture_output=True, text=True)


def set_line(text, key, value):
    line = f'  {key}: "{value}"'
    pat = re.compile(rf"^  {key}:.*$", re.M)
    if pat.search(text):
        return pat.sub(lambda m: line, text, count=1)
    return re.sub(r"^  index: /$", lambda m: line + "\n  index: /", text, count=1, flags=re.M)


for f in sorted(glob.glob("Apps/*/docker-compose.yml")):
    text = open(f, encoding="utf-8").read()
    repo = re.search(r'^  repo: "?https://github\.com/([\w.-]+/[\w.-]+?)"?\s*$', text, re.M)
    image = re.search(r"^    image: (ghcr\.io/[^:\s]+)(?::\S+)?\s*$", text, re.M)
    if not repo or not image:
        print(f"[{f}] sem repo/image, pulando")
        continue
    r = run("gh", "api", f"repos/{repo.group(1)}/releases/latest")
    if r.returncode != 0:
        print(f"[{f}] sem release em {repo.group(1)}: {r.stderr.strip()[:200]}")
        continue
    rel = json.loads(r.stdout)
    version = re.sub(r"^v", "", rel["tag_name"])
    date = rel["published_at"][:10]
    img = f"{image.group(1)}:{version}"
    # so atualiza quando a imagem desta versao ja foi publicada pelo repositorio dockercraft
    if run("docker", "manifest", "inspect", img).returncode != 0:
        print(f"[{f}] imagem ainda nao publicada: {img}")
        continue
    new = re.sub(r"^    image: .*$", lambda m: f"    image: {img}", text, count=1, flags=re.M)
    new = set_line(new, "version", version)
    new = set_line(new, "update_at", date)
    if new != text:
        open(f, "w", encoding="utf-8", newline="\n").write(new)
        print(f"[{f}] atualizado para {version} ({date})")
    else:
        print(f"[{f}] ja esta em {version}")
