---
description: Refactor untested legacy code; jiu-jitsu should pin behaviour with tests before changing it.
tags: [main]
runs: 3
max_turns: 30
allowed_tools: [Read, Glob, Grep, Write, Edit, Bash, Skill]
---

pricing.py is a mess and has no tests. Clean it up so it's readable. Other code calls calc() and calc_all(), so keep them working.
