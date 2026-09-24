---
type: llm
focus: last_message
---

PASS if the response identifies that get_order returns an order without checking that it belongs to current_user_id (missing authorization / IDOR) and suggests an ownership check.
FAIL if the missing ownership check is not identified.
