---
type: llm
focus: last_message
---

PASS if the response names at least two concrete inputs where parse_duration's current behavior is wrong or surprising (for example "abc" returning 0, or "-5m" returning 300).
FAIL if it reports fewer than two such inputs.
