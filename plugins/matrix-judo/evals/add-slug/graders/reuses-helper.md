---
type: regex
target: { source: file, path: blog.py }
pattern: 'from utils(?:\.text)? import[^\n]*slugify|import utils\.text'
---
