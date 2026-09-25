#!/usr/bin/env bash
# Workspace: test_report fails only when run after test_normalize (shared mutable default argument).
cat > inventory.py <<'PY'
def normalize(skus, seen=[]):
    """Return SKUs upper-cased with duplicates removed, keeping first-seen order."""
    out = []
    for s in skus:
        s = s.strip().upper()
        if s not in seen:
            seen.append(s)
            out.append(s)
    return out


def report(skus):
    return f"{len(normalize(skus))} unique SKUs"
PY
cat > test_inventory.py <<'PY'
import unittest

from inventory import normalize, report


class TestInventory(unittest.TestCase):
    def test_normalize(self):
        self.assertEqual(normalize(["ab1", " AB1", "cd2"]), ["AB1", "CD2"])

    def test_report(self):
        self.assertEqual(report(["ab1", "cd2", "ef3"]), "3 unique SKUs")


if __name__ == "__main__":
    unittest.main()
PY
