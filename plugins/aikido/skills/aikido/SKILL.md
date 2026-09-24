---
name: aikido
description: Use when receiving harsh or hostile code review feedback, strong pushback, or a constraint that cannot be changed ("we can't touch X") - to redirect that force into the smallest useful change instead of fighting it.
---

# Aikido — redirect, don't resist

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
  o      \o_
 /|\ ──►  |\      AIKIDO
 / \  ↺  / >      "Redirect, don't resist."
```

## Kata

1. **Receive the attack.** Restate each piece of feedback or constraint in neutral, technical terms. Strip tone; keep the claim.
2. **Find the energy.** For each point, identify the legitimate concern underneath: correctness, maintainability, risk, ownership, time. Even hostile feedback usually carries one.
3. **Verify, don't obey.** Check the claim against the code. Is it true? Partially true? Based on a misreading? Collect evidence either way.
4. **Blend.** Choose the smallest change that addresses the real concern. Often it is not what the reviewer literally asked for, but it satisfies what they are worried about.
5. **Redirect.** Where the claim is wrong, reply with evidence and a concrete alternative, not a counterattack. Where it is right, make the change and say so plainly.
6. **Draft the reply.** For each point: *agreed + done*, *agreed + different approach (why)*, or *disagree (evidence)*. Calm, short, specific.

## Rules

- Never escalate tone. Match heat with precision.
- Never perform agreement you don't have. "You're right" only when verified.
- Constraints you can't move become design inputs, not grievances.

## Anti-patterns

- Rewriting everything to appease one comment.
- Arguing about style when the concern is risk.
- Silent partial compliance.

## Closing

End with the list of changes made and the drafted replies. If the operator voice is active, one short Morpheus-style line may close it.
