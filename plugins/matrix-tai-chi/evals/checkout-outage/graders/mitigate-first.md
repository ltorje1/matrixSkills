---
type: llm
focus: last_message
---

PASS if the first recommended action is a reversible mitigation that restores service (for example rolling back v2.3.1), before any code-level fix or deep investigation.
FAIL if it leads with debugging or a code hotfix, or doesn't recommend a rollback or equivalent mitigation.
