---
description: Pre-merge check of a branch with planted security issues; krav-maga should find and rank them.
tags: [main]
runs: 3
max_turns: 25
allowed_tools: [Read, Glob, Grep, Bash, Skill]
---

I'm about to merge my feature branch into main. Can you check the changes first? (git diff main)
