---
name: matrix-kung-fu
description: Use when facing a bug, a failing test, a crash, or behavior nobody can explain - before proposing any fix. Root-cause debugging kata.
---

# Kung Fu — root-cause debugging kata

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
   o      \o/
  /|\  →   |     KUNG FU
  / \     / \    "Find the root, not the leaf."
```

## Kata

1. **Reproduce.** Get a deterministic failing case: a test, a command, or exact steps. No reproduction, no fix. If you can't reproduce it, gather evidence (logs, versions, inputs) until you can.
2. **Read the error fully.** Stack trace top to bottom, the exact message, the exact line. Note what the error *actually* says, not what you expect it to say.
3. **Isolate.** Shrink the failing case. Bisect: inputs, commits (`git bisect`), code paths, config. Stop when removing anything else makes the bug disappear.
4. **Hypothesize, one at a time.** State a single falsifiable hypothesis: "X happens because Y." Predict what you will observe if it is true.
5. **Test the hypothesis.** Add a log, an assertion, or a debugger breakpoint that confirms or kills it. Killed? Return to step 4 with what you learned.
6. **Fix the root.** Change the cause, not the symptom. Write a regression test that fails before the fix and passes after.
7. **Verify.** Run the original reproduction, the new test, and the surrounding test suite. Report the evidence.

## Rules

- One variable at a time. Changing three things at once teaches nothing.
- After three failed hypotheses, step back and question an assumption you have been treating as fact.
- Never silence the error (catch-and-ignore, skip the test, widen a timeout) and call it fixed.

## Anti-patterns

- Guess-and-check edits without a hypothesis.
- "Works on my machine" as a conclusion.
- Fixing where the error surfaced instead of where the bad state was created.

## Closing

End with a summary: root cause, fix, evidence. If the operator voice is active, one short Morpheus-style line may close it.
