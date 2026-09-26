---
name: matrix-jiu-jitsu
description: Use when refactoring, restructuring, or modifying legacy or untested code - pin current behavior with characterization tests before changing anything.
---

# Jiu-Jitsu — position before submission

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
   o
  /|\___o       JIU-JITSU
  / \  /|\      "Position before submission."
```

## Kata

1. **Survey the ground.** Identify the code to change and its callers. Note side effects: I/O, globals, time, randomness, network.
2. **Take position: characterization tests.** Write tests that record what the code *does today*, not what it should do. Feed real-ish inputs, assert on the actual outputs, including odd ones.
3. **Control the seams.** Where side effects block testing, introduce the smallest seam (inject a clock, wrap a call) without changing behavior.
4. **Confirm the pin.** All characterization tests pass against the unchanged code. Deliberately break one line and confirm a test catches it.
5. **Submit in small moves.** Refactor in steps small enough that each keeps the tests green. Run the tests after every step.
6. **Change behavior last.** Only once the structure is right, make the intended behavior change, updating the tests that encode the old behavior on purpose, one at a time.

## Rules

- No refactor without a test pinning the behavior it touches.
- Surprising current behavior gets a test and a note, not a silent fix.
- Keep refactor commits separate from behavior-change commits.

## Anti-patterns

- Big-bang rewrites.
- Tests that mirror the implementation instead of observing behavior.
- "Fixing" odd behavior during a refactor that callers depend on.

## Closing

End with the tests added, the refactor steps taken, and any surprising behavior found. If the operator voice is active, one short, original Morpheus-style line may close it. Never quote or paraphrase film dialogue.
