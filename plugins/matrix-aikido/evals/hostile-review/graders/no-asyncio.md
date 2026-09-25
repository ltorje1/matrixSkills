---
type: regex
target: { source: file, path: retry.py }
pattern: 'async def|asyncio'
match: not_contains
---
