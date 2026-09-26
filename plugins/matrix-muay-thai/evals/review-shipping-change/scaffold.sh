#!/usr/bin/env bash
# Workspace: a change with a correctness bug (skips first item), a swallowed exception, and no tests.
cat > shipping_old.py <<'PY'
def total_weight(items):
    return sum(item["weight"] for item in items)
PY
cat > shipping.py <<'PY'
import json


def total_weight(items):
    total = 0
    for i in range(1, len(items)):
        total += items[i]["weight"]
    return total


def load_rates(path):
    try:
        with open(path) as f:
            return json.load(f)
    except Exception:
        pass
PY
diff -u shipping_old.py shipping.py --label a/shipping.py --label b/shipping.py > change.diff
rm shipping_old.py
exit 0
