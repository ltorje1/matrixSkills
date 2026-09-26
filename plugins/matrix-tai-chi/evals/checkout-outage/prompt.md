---
description: Live outage right after a deploy; tai-chi should mitigate first, communicate, then diagnose.
tags: [main]
runs: 3
max_turns: 20
allowed_tools: [Read, Glob, Grep, Skill]
---

PROD IS DOWN. Checkout has been returning 500s for about 40% of users since 14:05. deploy_log.txt and error_sample.log are here. What do I do??
