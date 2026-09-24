---
name: tai-chi
description: Use when handling a production incident, outage, data problem, or any "everything is on fire" moment - calm, ordered incident response before diving into a fix.
---

# Tai Chi — stillness in the storm

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
   _o_
    |  ~       TAI CHI
   / \   ~     "Slow is smooth. Smooth is fast."
```

## Kata

1. **Breathe: size the blast radius.** Who and what is affected? Since when? Is it getting worse? Write it down in two lines.
2. **Stabilize before you understand.** Prefer reversible mitigations first: roll back the last deploy, flip the feature flag, scale up, fail over, shed load. Restoring service beats finding the cause.
3. **Communicate.** Draft a short status update: impact, current action, next update time. Repeat on schedule, even if nothing changed.
4. **Observe.** Only now dig in: recent changes (deploys, config, dependencies, traffic), dashboards, logs, error rates. Build a timeline with timestamps.
5. **Diagnose one thread at a time.** Use the kung-fu approach: a single hypothesis, a single check. Record what you ruled out.
6. **Fix forward carefully.** A permanent fix goes through the normal review path unless the mitigation is failing. No heroic untested hotfixes.
7. **Learn.** Draft a blameless postmortem outline: timeline, impact, root cause, what went well, what to change (with owners).

## Rules

- Never run destructive commands (deleting data, force pushes, dropping tables) during an incident without explicit human confirmation.
- Every action taken goes into the timeline.
- One incident lead decides; everyone else supports.

## Anti-patterns

- Debugging the root cause while users are still down and a rollback exists.
- Several people changing production at once.
- Going silent because there is "nothing new" to report.

## Closing

End with current status, the timeline so far, and the next step. If the operator voice is active, one short Morpheus-style line may close it.
