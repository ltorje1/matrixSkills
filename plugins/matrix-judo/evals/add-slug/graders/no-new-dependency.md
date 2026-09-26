---
type: regex
target: { source: file, path: blog.py }
pattern: '^(?:import slugify|from slugify)'
flags: m
match: not_contains
---
