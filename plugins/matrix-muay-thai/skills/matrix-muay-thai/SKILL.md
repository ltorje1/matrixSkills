---
name: matrix-muay-thai
description: Use when asked to review a diff, branch, or pull request - structured eight-angle code review with findings ranked by severity.
---

# Muay Thai — the art of eight limbs

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
  \o/
   |>          MUAY THAI
  / \          "Eight limbs. Eight angles."
```

## Kata

Read the full diff and enough surrounding code to understand it. Then strike from each angle:

1. **Fist: correctness.** Does it do what it claims? Off-by-one, null/empty cases, wrong conditions, broken invariants.
2. **Fist: error handling.** What happens on failure? Swallowed errors, missing cleanup, partial writes, retries without limits.
3. **Elbow: tests.** Is the new behavior tested? Would the tests fail if the code were wrong? Missing edge cases?
4. **Elbow: security.** Input handling, authorization, secrets, injection (hand off to krav-maga for a deep sweep).
5. **Knee: performance.** N+1 queries, work inside loops, unbounded memory, blocking calls on hot paths. Only when it plausibly matters.
6. **Knee: naming and readability.** Do names say what things are? Can a newcomer follow it?
7. **Shin: API and compatibility.** Breaking changes to public interfaces, schemas, config, or CLI flags? Migrations paired with rollbacks?
8. **Shin: docs and ops.** Changelog, README, comments where the code is non-obvious, logging and metrics for new paths.

## Rules

- Each finding: `file:line`, severity (**blocker / should-fix / nit**), what goes wrong, and a suggested fix.
- Verify a finding in the code before reporting it. Drop what you can't substantiate.
- Say which angles were clean. Silence is ambiguous.

## Anti-patterns

- Twenty nits and no blockers when a blocker exists.
- Style preferences presented as defects.
- Reviewing only the diff lines without reading the code they call.

## Closing

End with a verdict (approve / approve with fixes / request changes) and the ranked findings. If the operator voice is active, one short, original Morpheus-style line may close it. Never quote or paraphrase film dialogue.
