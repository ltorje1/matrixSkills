---
type: llm
focus: last_message
---

PASS if the review points out that load_rates swallows every exception (`except Exception: pass`) and silently returns None.
FAIL if this is not identified.
