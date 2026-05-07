#!/usr/bin/env python3
"""
ydl.py — yt-dlp wrapper with interactive format/quality selector
Deps: yt-dlp  (pip install yt-dlp  OR  pacman -S yt-dlp)
"""

import sys
import subprocess
import json
import os
from shutil import which

# ──────────────────────────────────────────────
# Helpers
# ──────────────────────────────────────────────

RESET  = "\033[0m"
BOLD   = "\033[1m"
CYAN   = "\033[36m"
GREEN  = "\033[32m"
YELLOW = "\033[33m"
RED    = "\033[31m"
DIM    = "\033[2m"


def die(msg: str) -> None:
    print(f"{RED}error:{RESET} {msg}", file=sys.stderr)
    sys.exit(1)


def check_deps() -> None:
    if not which("yt-dlp"):
        die("yt-dlp not found. Install: pacman -S yt-dlp  OR  pip install yt-dlp")


def fmt_size(bytes_: int | None) -> str:
    if not bytes_:
        return "?"
    for unit in ("B", "KB", "MB", "GB"):
        if bytes_ < 1024:
            return f"{bytes_:.1f} {unit}"
        bytes_ /= 1024
    return f"{bytes_:.1f} TB"


# ──────────────────────────────────────────────
# Format fetching
# ──────────────────────────────────────────────

def fetch_formats(url: str) -> tuple[dict, list[dict]]:
    """Return (info_dict, sorted_formats)."""
    print(f"{DIM}fetching formats…{RESET}")
    result = subprocess.run(
        ["yt-dlp", "--dump-json", "--no-playlist", url],
        capture_output=True, text=True
    )
    if result.returncode != 0:
        die(result.stderr.strip() or "yt-dlp failed to fetch info")

    info = json.loads(result.stdout)
    formats = info.get("formats", [])

    # Sort: video+audio first, then video-only, then audio-only
    def sort_key(f):
        has_v = f.get("vcodec", "none") != "none"
        has_a = f.get("acodec", "none") != "none"
        height = f.get("height") or 0
        tbr    = f.get("tbr") or 0
        if has_v and has_a:   return (0, -height, -tbr)
        elif has_v:           return (1, -height, -tbr)
        else:                 return (2, 0, -tbr)

    return info, sorted(formats, key=sort_key)


# ──────────────────────────────────────────────
# Display
# ──────────────────────────────────────────────

def print_formats(formats: list[dict]) -> None:
    col = f"{CYAN}{BOLD}"
    print(f"\n{col}{'#':>4}  {'ID':<14} {'EXT':<6} {'RES':<10} {'FPS':<5} {'CODEC':<18} {'SIZE':>8}  NOTE{RESET}")
    print("─" * 80)

    for i, f in enumerate(formats):
        fid    = f.get("format_id", "?")
        ext    = f.get("ext", "?")
        height = f.get("height")
        fps    = f.get("fps")
        vcodec = f.get("vcodec", "none")
        acodec = f.get("acodec", "none")
        size   = fmt_size(f.get("filesize") or f.get("filesize_approx"))
        note   = f.get("format_note", "")

        # resolution label
        if height:
            res = f"{height}p"
        elif vcodec == "none":
            res = "audio"
        else:
            res = "?"

        # codec summary
        vc = vcodec.split(".")[0] if vcodec != "none" else "-"
        ac = acodec.split(".")[0] if acodec != "none" else "-"
        codec = f"{vc}/{ac}"

        fps_s = f"{int(fps)}" if fps else "-"

        # row color
        has_v = vcodec != "none"
        has_a = acodec != "none"
        if has_v and has_a:
            row_color = GREEN
        elif has_v:
            row_color = YELLOW
        else:
            row_color = DIM

        print(f"{row_color}{i+1:>4}  {fid:<14} {ext:<6} {res:<10} {fps_s:<5} {codec:<18} {size:>8}  {note}{RESET}")

    print()
    print(f"  {GREEN}green{RESET} = video+audio  {YELLOW}yellow{RESET} = video-only  {DIM}dim{RESET} = audio-only")
    print()


# ──────────────────────────────────────────────
# User input
# ──────────────────────────────────────────────

PRESETS = {
    "b":  "bestvideo+bestaudio/best",
    "bv": "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best",
    "ba": "bestaudio/best",
    "wa": "worstaudio/worst",
    "wv": "worstvideo/worst",
}


def pick_format(formats: list[dict]) -> str:
    print(f"{BOLD}Enter format #{RESET} (1–{len(formats)}), or a preset:")
    print(f"  {CYAN}b{RESET}=best  {CYAN}bv{RESET}=best mp4  {CYAN}ba{RESET}=best audio  {CYAN}wa{RESET}=worst audio  {CYAN}wv{RESET}=worst video")
    print(f"  Or type a raw yt-dlp format string (e.g. {DIM}137+140{RESET})\n")

    while True:
        try:
            raw = input(f"{BOLD}>{RESET} ").strip()
        except (KeyboardInterrupt, EOFError):
            print()
            sys.exit(0)

        if not raw:
            continue

        if raw in PRESETS:
            return PRESETS[raw]

        if raw.isdigit():
            idx = int(raw) - 1
            if 0 <= idx < len(formats):
                fid = formats[idx]["format_id"]
                # if video-only, merge with best audio automatically
                f = formats[idx]
                if f.get("vcodec", "none") != "none" and f.get("acodec", "none") == "none":
                    print(f"{DIM}video-only format — merging with bestaudio{RESET}")
                    return f"{fid}+bestaudio/best"
                return fid
            print(f"{RED}out of range{RESET}")
            continue

        # treat as raw format string
        return raw


def pick_output_dir() -> str:
    default = os.path.expanduser("~/Downloads")
    raw = input(f"\n{BOLD}Output directory{RESET} [{default}]: ").strip()
    return raw or default


def pick_subtitles(info: dict) -> tuple[bool, str]:
    """Return (embed_subs, comma-separated lang codes). Empty langs = no subs."""
    available = info.get("subtitles", {})
    auto_subs = info.get("automatic_captions", {})

    all_langs = sorted(set(list(available.keys()) + list(auto_subs.keys())))
    manual    = sorted(available.keys())
    auto      = sorted(k for k in auto_subs if k not in available)

    if not all_langs:
        print(f"{DIM}no subtitles available for this video{RESET}")
        return False, ""

    print(f"\n{BOLD}Subtitles{RESET}")
    if manual:
        print(f"  manual : {CYAN}{', '.join(manual)}{RESET}")
    if auto:
        print(f"  auto   : {DIM}{', '.join(auto)}{RESET}")
    print(f"  Enter lang codes (e.g. {CYAN}en,hi{RESET}), {CYAN}all{RESET} for all, or {CYAN}n{RESET} to skip")

    while True:
        try:
            raw = input(f"{BOLD}>{RESET} ").strip().lower()
        except (KeyboardInterrupt, EOFError):
            print()
            sys.exit(0)

        if raw in ("n", "no", ""):
            return False, ""
        if raw == "all":
            return True, "all"
        # validate each code exists
        codes = [c.strip() for c in raw.split(",") if c.strip()]
        invalid = [c for c in codes if c not in all_langs]
        if invalid:
            print(f"{YELLOW}not found:{RESET} {', '.join(invalid)} — try again or {CYAN}n{RESET} to skip")
            continue
        return True, ",".join(codes)


# ──────────────────────────────────────────────
# Download
# ──────────────────────────────────────────────

def download(url: str, fmt: str, outdir: str, sub_langs: str) -> None:
    os.makedirs(outdir, exist_ok=True)
    template = os.path.join(outdir, "%(title)s.%(ext)s")

    cmd = [
        "yt-dlp",
        "--format", fmt,
        "--output", template,
        "--merge-output-format", "mp4",
        "--embed-chapters",          # chapter markers in file
        "--progress",
        "--no-playlist",
    ]

    if sub_langs:
        cmd += [
            "--write-subs",
            "--write-auto-subs",     # fallback to auto-captions
            "--embed-subs",
            "--sub-langs", sub_langs,
            "--convert-subs", "srt", # universal compat
        ]

    cmd.append(url)

    print(f"\n{CYAN}running:{RESET} {' '.join(cmd)}\n")
    result = subprocess.run(cmd)
    if result.returncode != 0:
        die("download failed")
    print(f"\n{GREEN}done!{RESET} saved to {outdir}")


# ──────────────────────────────────────────────
# Entry point
# ──────────────────────────────────────────────

def main() -> None:
    check_deps()

    if len(sys.argv) < 2:
        url = input(f"{BOLD}URL:{RESET} ").strip()
    else:
        url = sys.argv[1]

    if not url:
        die("no URL provided")

    info, formats = fetch_formats(url)

    title    = info.get("title", "unknown")
    uploader = info.get("uploader", "?")
    duration = info.get("duration_string", "?")

    print(f"\n{BOLD}{title}{RESET}")
    print(f"{DIM}channel: {uploader}  |  duration: {duration}{RESET}")

    print_formats(formats)

    fmt          = pick_format(formats)
    _, sub_langs = pick_subtitles(info)
    outdir       = pick_output_dir()

    download(url, fmt, outdir, sub_langs)


if __name__ == "__main__":
    main()
