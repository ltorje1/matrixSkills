---
name: matrix-wing-chun
description: Use when code feels overengineered, when asked to simplify, or when reviewing new abstractions, layers, config options, or indirection - cut to the shortest path.
---

# Wing Chun — own the centerline

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
   o
  /|──►        WING CHUN
  / \          "The shortest line wins."
```

## Kata

1. **Find the centerline.** State in one sentence what this code must do for its callers today. That is the only requirement.
2. **Trace the path.** Follow a real call from entry to effect. Count the hops: wrappers, interfaces, factories, config lookups.
3. **Mark every hop that doesn't earn its place.** An abstraction earns its place when it has two or more real users, hides real complexity, or isolates a real boundary (I/O, third party). "Might need it later" does not count.
4. **Strike.** For each marked hop, propose the direct version: inline the wrapper, delete the unused option, replace the single-implementation interface with the concrete type.
5. **Guard.** Confirm the tests still pass. If there are none for the path, add one before simplifying.
6. **Measure.** Report lines removed, hops removed, and anything intentionally kept (with the reason).

## Rules

- Delete before you add.
- One implementation needs no interface. One caller needs no parameter.
- Configurability for cases nobody asked for is weight, not strength.

## Anti-patterns

- Replacing one abstraction with a cleverer one.
- Simplifying code by moving complexity into callers.
- Removing a seam that tests depend on.

## Closing

End with the before/after path and the measurements. If the operator voice is active, one short Morpheus-style line may close it.
