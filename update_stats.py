#!/usr/bin/env python3

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent
README_PATH = REPO_ROOT / "README.md"


# Your actual repository structure
CATEGORY_FOLDERS = {
    "Python + DSA": {
        "Easy": REPO_ROOT / "python & DSA" / "Easy",
        "Medium": REPO_ROOT / "python & DSA" / "Medium",
        "Hard": REPO_ROOT / "python & DSA" / "Hard",
    },
    "MySQL": {
        "Easy": REPO_ROOT / "MySQL" / "Easy",
        "Medium": REPO_ROOT / "MySQL" / "Medium",
        "Hard": REPO_ROOT / "MySQL" / "Hard",
    },
}


# File extensions that represent solutions
SOLUTION_EXTENSIONS = {
    "Python + DSA": {".py"},
    "MySQL": {".sql"},
}


# Files that should not be counted
IGNORE_FILES = {
    "__init__.py",
    "template.py",
    "template.sql",
    ".gitkeep",
}


def count_solutions(folder: Path, valid_extensions: set) -> int:

    if not folder.exists():
        return 0

    count = 0

    for path in folder.rglob("*"):

        if not path.is_file():
            continue

        if path.name.lower() in {
            file.lower() for file in IGNORE_FILES
        }:
            continue

        if path.suffix.lower() in valid_extensions:
            count += 1

    return count


def build_stats_table(counts: dict) -> str:

    total_easy = 0
    total_medium = 0
    total_hard = 0

    rows = []

    for category, difficulties in counts.items():

        easy = difficulties["Easy"]
        medium = difficulties["Medium"]
        hard = difficulties["Hard"]

        total = easy + medium + hard

        total_easy += easy
        total_medium += medium
        total_hard += hard

        if category == "Python + DSA":
            icon = "🐍"
        else:
            icon = "🗄️"

        rows.append(
            f"| {icon} {category} | "
            f"{easy} | "
            f"{medium} | "
            f"{hard} | "
            f"{total} |"
        )

    overall = total_easy + total_medium + total_hard

    rows.append(
        f"| **🏆 Overall** | "
        f"**{total_easy}** | "
        f"**{total_medium}** | "
        f"**{total_hard}** | "
        f"**{overall}** |"
    )

    return "\n".join([
        "<p align=\"center\">",
        "",
        f"### 🔥 Problems Solved: **{overall}**",
        "",
        "</p>",
        "",
        "| Category | 🟢 Easy | 🟡 Medium | 🔴 Hard | 🏆 Total |",
        "|:--------:|:--------:|:----------:|:--------:|:---------:|",
        *rows
    ])


def update_readme(stats_block: str):

    if not README_PATH.exists():

        print(
            "ERROR: README.md not found.",
            file=sys.stderr
        )

        sys.exit(1)

    content = README_PATH.read_text(
        encoding="utf-8"
    )

    pattern = re.compile(
        r"(<!-- STATS_START -->)"
        r"(.*?)"
        r"(<!-- STATS_END -->)",
        re.DOTALL
    )

    if not pattern.search(content):

        print(
            "ERROR: Could not find "
            "<!-- STATS_START --> and "
            "<!-- STATS_END --> "
            "in README.md.",
            file=sys.stderr
        )

        sys.exit(1)

    replacement = (
        r"\1"
        + "\n\n"
        + stats_block
        + "\n\n"
        + r"\3"
    )

    new_content = pattern.sub(
        replacement,
        content,
        count=1
    )

    if new_content != content:

        README_PATH.write_text(
            new_content,
            encoding="utf-8"
        )

        print("README.md stats updated successfully.")

    else:

        print(
            "README.md stats are already up to date."
        )


def main():

    counts = {}

    print("\n========== SOLUTION COUNTS ==========\n")

    for category, difficulties in CATEGORY_FOLDERS.items():

        counts[category] = {}

        extensions = SOLUTION_EXTENSIONS[category]

        for difficulty, folder in difficulties.items():

            count = count_solutions(
                folder,
                extensions
            )

            counts[category][difficulty] = count

            print(
                f"{category} - {difficulty}: {count}"
            )

    print("\n=====================================\n")

    stats_block = build_stats_table(counts)

    update_readme(stats_block)

    print("\nDone!")


if __name__ == "__main__":
    main()