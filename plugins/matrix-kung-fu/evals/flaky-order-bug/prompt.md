---
description: Order-dependent test failure caused by shared state; kung-fu should reproduce, find the root cause, fix it and add a regression test.
tags: [main]
runs: 3
max_turns: 30
allowed_tools: [Read, Glob, Grep, Write, Edit, Bash, Skill]
---

test_report in test_inventory.py fails when I run the whole file, but passes when I run it on its own. What's going on? Please fix it.
