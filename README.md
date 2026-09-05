#!/usr/bin/env python3
"""
update_stats.py

Scans the LeetCode solution folders in this repo and rewrites the
stats table in README.md (between <!-- STATS_START --> and <!-- STATS_END -->).

Folder -> category/difficulty mapping is defined in CATEGORY_FOLDERS below.
A "solved problem" = one file inside a folder that matches SOLUTION_EXTENSIONS,
excluding files listed in IGNORE_FILES.

Usage:
    python update_stats.py

Run this from the root of the repo (same level as README.md).
"""

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent
README_PATH = REPO_ROOT / "README.md"

# Map: category name -> {difficulty: folder_name}
CATEGORY_FOLDERS = {
    "Python + DSA": {
        "Easy": "Python-Easy",
        "Medium": "Python-Medium",
        "Hard": "Python-Hard",
    },
    "MySQL": {
        "Easy": "MySQL-Easy",
        "Medium": "MySQL-Medium",
        "Hard": "MySQL-Hard",
    },
}

# Which file types count as "a solution" per category
SOLUTION_EXTENSIONS = {
    "Python + DSA": {".py"},
    "MySQL": {".sql"},
}

# Files to ignore even if they match the extension (e.g. templates, init files)
IGNORE_FILES = {"__init__.py", "readme.md", "template.py", "template.sql", ".gitkeep"}


def count_solutions(folder: Path, valid_exts: set) -> int:
    """Count solution files directly inside `folder`, including one level
    of subfolders (e.g. Python-Easy/001-two-sum/solution.py)."""
    if not folder.exists():
        return 0

    count = 0
    for path in folder.rglob("*"):
        if path.is_file() and path.suffix.lower() in valid_exts:
            if path.name.lower() not in IGNORE_FILES:
                count += 1
    return count


def build_stats_table(counts: dict) -> str:
    """counts = {category: {difficulty: n}} -> markdown table string."""
    row_icons = {"Python + DSA": "🐍", "MySQL": "🗄️"}
    total_easy = total_medium = total_hard = 0
    lines = []

    for category, diffs in counts.items():
        e, m, h = diffs["Easy"], diffs["Medium"], diffs["Hard"]
        total_easy += e
        total_medium += m
        total_hard += h
        icon = row_icons.get(category, "")
        lines.append(f"| {icon} {category} | {e} | {m} | {h} | {e + m + h} |")

    grand_total = total_easy + total_medium + total_hard
    lines.append(
        f"| **🏆 Overall** | **{total_easy}** | **{total_medium}** | "
        f"**{total_hard}** | **{grand_total}** |"
    )

    table = "\n".join(
        [
            "| Category | 🟢 Easy | 🟡 Medium | 🔴 Hard | 🏆 Total |",
            "|:--------:|:--------:|:----------:|:--------:|:---------:|",
            *lines,
        ]
    )

    header = f"<p align=\"center\">\n\n### 🔥 Problems Solved: **{grand_total}**\n\n</p>"

    return f"{header}\n\n{table}"


def update_readme(new_stats_block: str):
    if not README_PATH.exists():
        print(f"ERROR: {README_PATH} not found.", file=sys.stderr)
        sys.exit(1)

    content = README_PATH.read_text(encoding="utf-8")

    pattern = re.compile(
        r"(<!-- STATS_START -->)(.*?)(<!-- STATS_END -->)", re.DOTALL
    )

    if not pattern.search(content):
        print(
            "ERROR: Could not find <!-- STATS_START --> / <!-- STATS_END --> "
            "markers in README.md.",
            file=sys.stderr,
        )
        sys.exit(1)

    replacement = f"\\1\n{new_stats_block}\n\\3"
    new_content = pattern.sub(replacement, content)

    if new_content != content:
        README_PATH.write_text(new_content, encoding="utf-8")
        print("README.md stats updated.")
    else:
        print("README.md stats already up to date. No changes made.")


def main():
    counts = {}
    for category, diffs in CATEGORY_FOLDERS.items():
        valid_exts = SOLUTION_EXTENSIONS[category]
        counts[category] = {}
        for difficulty, folder_name in diffs.items():
            folder = REPO_ROOT / folder_name
            n = count_solutions(folder, valid_exts)
            counts[category][difficulty] = n
            print(f"{folder_name}: {n} solution(s)")

    stats_block = build_stats_table(counts)
    update_readme(stats_block)


if __name__ == "__main__":
    main()