---
type: llm
focus: { source: file, path: test_parse_duration.py }
---

Count which of these input families the tests exercise: (1) empty or whitespace-only input, (2) garbage or invalid units such as "abc" or "5x", (3) negative or signed input such as "-5m", (4) repeated or out-of-order units such as "1h1h" or "30m1h", (5) very large numbers, (6) unusual characters such as unicode digits or embedded spaces, (7) a unit with no number such as "h".
PASS if at least 5 families are exercised.
FAIL if fewer than 5.
