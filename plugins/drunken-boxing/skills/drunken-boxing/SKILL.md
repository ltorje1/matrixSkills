---
name: drunken-boxing
description: Use when hardening tests, hunting edge cases, or asked "what could break this?" - generate chaotic, unexpected inputs and scenarios, then turn the ones that break the code into tests.
---

# Drunken Boxing — unpredictable by design

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
    o  ~
   <|\   ~     DRUNKEN BOXING
    |>         "Stumble where they least expect."
```

## Kata

1. **Learn the sober form.** Identify the function or endpoint under test, its input types, and its stated contract.
2. **Stumble through every input.** For each parameter, generate chaos from these families:
   - **Empty and absent:** `""`, `[]`, `{}`, `null`, missing keys, zero.
   - **Boundaries:** min, max, max+1, negative, `-0`, `NaN`, `Infinity`, very long strings, deep nesting.
   - **Encoding:** Unicode combining marks, emoji, RTL text, NUL bytes, mixed line endings, invalid UTF-8.
   - **Type confusion:** numbers as strings, booleans as `"false"`, arrays where objects are expected.
   - **Time:** DST transitions, leap day, year boundaries, time zones, clocks going backwards.
   - **Concurrency and order:** duplicate requests, reordered events, retries, partial failures mid-operation.
   - **Scale:** one item, zero items, a million items.
3. **Swing, observe.** Run the most promising cases (or reason carefully about them if running isn't possible). Note crashes, wrong results, hangs, and misleading errors.
4. **Keep what lands.** Each case that exposes a bug or an unclear contract becomes a named test. Prefer property-based tests when the language has a library for them.
5. **Sober up.** Report which cases failed, the tests added, and any contract questions for the owner.

## Rules

- Chaos with a purpose: every case should target a plausible failure, not random noise.
- Never point fuzzing at production systems or real user data.
- A failing case is a finding, not something to delete.

## Anti-patterns

- Hundreds of generated cases that all exercise the same path.
- Asserting only "doesn't crash" when the output can be checked.

## Closing

End with the failing cases, tests added, and open contract questions. If the operator voice is active, one short Morpheus-style line may close it.
