---
type: regex
target: { source: file, path: blog.py }
pattern: 're\.sub|\.replace\(|^import re$'
flags: m
match: not_contains
---
