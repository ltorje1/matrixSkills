#!/usr/bin/env bash
# Workspace: a duration parser that silently ignores garbage, signs and repeats.
cat > parse_duration.py <<'PY'
import re

UNITS = {"h": 3600, "m": 60, "s": 1}


def parse_duration(text):
    """Parse strings like '1h30m' or '45s' into seconds."""
    total = 0
    for amount, unit in re.findall(r"(\d+)([hms])", text):
        total += int(amount) * UNITS[unit]
    return total
PY
