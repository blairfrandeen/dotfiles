#!/usr/bin/python3

from datetime import date, timedelta
from pathlib import Path

NOTES_DIR = Path.home() / "notes"

daily_note_glob = "[0-9]" * 4 + "-" + "[0-9]" * 2 + "-" + "[0-9]" * 2 + ".md"
daily_note_paths = sorted(list(NOTES_DIR.glob(daily_note_glob)))

dates = [date.fromisoformat(file.stem) for file in daily_note_paths]


def get_daily_note_path(note_date: date) -> Path:
    return (NOTES_DIR / note_date.strftime("%Y-%m-%d")).with_suffix(".md")


def breadcrumb(note_date: date = date.today()) -> str:
    prev_date = dates[dates.index(note_date) - 1]
    try:
        next_date = dates[dates.index(note_date) + 1]
    except IndexError:
        next_date = date.today() + timedelta(days=1)
    prev_file = get_daily_note_path(prev_date).stem
    next_file = get_daily_note_path(next_date).stem
    return "[[%s|<< Yesterday]] | [[%s| Tomorrow >>]]" % (prev_file, next_file)


def has_breadcrumb(line: str) -> bool:
    return (
        line.startswith("[[")
        and line.strip().endswith("| Tomorrow >>]]")
        and "<< Yesterday]] | [[" in line
    )


def update_breadcrumbs(note_date: date):
    dn_file = get_daily_note_path(note_date)
    with open(dn_file, "r") as file:
        lines = file.readlines()

    if len(lines) < 2:
        return False
    bc_line = lines[1]
    if has_breadcrumb(bc_line):
        lines[1] = breadcrumb(note_date) + "\n"
    else:
        lines.insert(1, breadcrumb(note_date) + "\n")

    with open(dn_file, "w") as file:
        file.writelines(lines)

    return True


def update_all():
    """Danger zone"""
    num_updated = 0
    for d in dates:
        if update_breadcrumbs(d):
            num_updated += 1
    print("%d files updated!" % num_updated)


if __name__ == "__main__":
    print(breadcrumb())
