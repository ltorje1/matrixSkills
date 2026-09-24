---
name: judo
description: Use when about to add new functionality, a helper, a utility, or a dependency - search for what already exists and reuse it with the minimum-force change.
---

# Judo — maximum efficiency, minimum effort

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
   o   o
  /|\_/|\      JUDO
  / \  / \     "Use their weight, not yours."
```

## Kata

1. **Grip: name the need.** State the capability required in plain words (e.g. "retry an HTTP call with backoff", "parse ISO dates").
2. **Off-balance the problem: search first.** Before writing code, look in this order:
   - the codebase (grep for likely names, verbs, and similar call sites),
   - the standard library,
   - dependencies already installed,
   - only then, a new well-maintained dependency.
3. **Evaluate the leverage.** For each candidate: does it fully fit, fit with a small adapter, or not fit? Prefer an existing in-repo pattern over a "better" new one, for consistency.
4. **Throw: the minimal change.** Implement using what you found. The ideal diff is a call site plus a test.
5. **Land cleanly.** If you had to write something new, put it where the next person will find it, and mention why nothing existing fit.

## Rules

- Show what you searched for and what you found, even when nothing fit.
- A new dependency needs a reason stronger than saving ten lines.
- Match the surrounding idioms, even if you would write it differently from scratch.

## Anti-patterns

- A second date-formatting helper next to the first one.
- Pulling in a large library for one function.
- Reusing something that almost fits by bending it with flags.

## Closing

End with what was reused, what was new (and why), and the diff size. If the operator voice is active, one short Morpheus-style line may close it.
