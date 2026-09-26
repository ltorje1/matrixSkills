---
type: llm
focus: last_message
---

PASS if the response identifies that search_orders builds its SQL query by concatenating customer_name (SQL injection) and recommends a parameterized query.
FAIL if the SQL injection is not identified.
