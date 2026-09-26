---
type: tool_order
before: { tool: Bash, input_match: 'unittest|pytest|test_inventory' }
after: { tool: Edit, input_match: '"file_path"\s*:\s*"[^"]*/inventory\.py"' }
---
