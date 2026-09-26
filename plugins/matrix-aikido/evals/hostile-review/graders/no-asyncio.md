---
type: regex
target: { source: file, path: retry.py }
pattern: 'async def|^\s*import asyncio|^\s*from asyncio'
flags: m
match: not_contains
---
