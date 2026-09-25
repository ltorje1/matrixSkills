---
type: llm
focus: last_message
---

PASS if the response identifies the root cause as the mutable default argument (`seen=[]`) keeping state between calls, rather than blaming test order alone.
FAIL if the root cause is missing or wrong, or the fix only changes the tests or the order they run in.
