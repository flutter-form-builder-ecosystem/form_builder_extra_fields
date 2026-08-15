#!/usr/bin/env bash
# Build pub.dev / README GIFs from widget-test frames.
# Expected to run inside ghcr.io/cirruslabs/flutter:3.38.4 or with Flutter 3.38 on PATH.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SHOT_DIR="${SHOT_DIR:-/tmp/extra-shots}"
OUT="$ROOT/screenshots"
export SHOT_DIR

cd "$ROOT"
flutter test tool/generate_screenshots.dart --reporter compact

python3 - <<'PY'
import glob, os, subprocess, sys
shot = os.environ.get("SHOT_DIR", "/tmp/extra-shots")
out = os.path.join(os.environ.get("ROOT", "."), "screenshots")
# ROOT passed below
PY

ROOT="$ROOT" SHOT_DIR="$SHOT_DIR" python3 - <<'PY'
import glob, os, subprocess
from pathlib import Path

shot = Path(os.environ["SHOT_DIR"])
out = Path(os.environ["ROOT"]) / "screenshots"
out.mkdir(exist_ok=True)

groups = {
    "complete_form": sorted(shot.glob("complete_*.png")),
    "color_picker": sorted(shot.glob("color_*.png")),
    "rating_bar": sorted(shot.glob("rating_*.png")),
    "searchable": sorted(shot.glob("search_*.png")),
}

for name, frames in groups.items():
    if not frames:
        print("skip", name, "(no frames)")
        continue
    dest = out / f"{name}.gif"
    # Sibling GIFs are 230x409. Hold each frame ~0.9s.
    args = ["ffmpeg", "-y", "-hide_banner", "-loglevel", "error"]
    for frame in frames:
        args += ["-loop", "1", "-t", "0.9", "-i", str(frame)]
    n = len(frames)
    filt = "".join(f"[{i}:v]scale=230:409:flags=lanczos,setsar=1[v{i}];" for i in range(n))
    filt += "".join(f"[v{i}]" for i in range(n)) + f"concat=n={n}:v=1:a=0,split[a][b];[a]palettegen=stats_mode=full[p];[b][p]paletteuse=dither=bayer"
    args += ["-filter_complex", filt, "-loop", "0", str(dest)]
    subprocess.check_call(args)
    print(f"wrote {dest} ({dest.stat().st_size} bytes, {n} frames)")
PY
