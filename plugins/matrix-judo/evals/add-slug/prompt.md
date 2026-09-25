---
description: New feature where a helper already exists; judo should find and reuse it.
tags: [main]
runs: 3
max_turns: 25
allowed_tools: [Read, Glob, Grep, Write, Edit, Bash, Skill]
---

make_post() in blog.py should also return a "slug" field generated from the title: lowercase, hyphens instead of spaces, no punctuation. Please add it.
