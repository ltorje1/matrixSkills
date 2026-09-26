---
type: regex
target: { source: file, path: inventory.py }
pattern: 'seen\s*=\s*\[\]\s*\)'
match: not_contains
---
