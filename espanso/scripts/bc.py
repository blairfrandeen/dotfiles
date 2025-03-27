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


if __name__ == "__main__":
    print(breadcrumb())
