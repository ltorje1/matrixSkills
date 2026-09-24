---
name: matrix-kendo
description: Use when making a targeted fix or change in sensitive, shared, or unfamiliar code - one precise, single-purpose edit with no drive-by refactors, formatting churn, or scope creep.
---

# Kendo — one precise cut

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
      /
   o /         KENDO
  /|/          "One cut. Clean. Complete."
  / \
```

## Kata

1. **Stance: define the cut.** Write the change as one sentence: "Change X so that Y." If it needs "and", it is two cuts; do them separately.
2. **Measure the distance.** Find the exact lines to change. Read the surrounding code and its callers so the cut doesn't land somewhere unexpected.
3. **Strike.** Make only that change. Every changed line must trace back to the one-sentence goal.
4. **Zanshin: stay aware after the strike.** Review the diff line by line. Revert anything unrelated: reformatting, import reordering, renames, "while I'm here" fixes.
5. **Confirm.** Run the relevant tests, plus a test that proves the change (add one if it is missing).
6. **Note what you didn't cut.** List issues you noticed but deliberately left alone, so they can become their own changes.

## Rules

- Diff size proportional to intent.
- Preserve comments and code you don't fully understand.
- No formatter runs over files you didn't otherwise change.

## Anti-patterns

- A one-line fix delivered inside a 400-line diff.
- Renaming things "for clarity" in the same commit as a behavior change.

## Closing

End with the one-sentence cut, the diff summary, test evidence, and the noticed-but-untouched list. If the operator voice is active, one short Morpheus-style line may close it.
