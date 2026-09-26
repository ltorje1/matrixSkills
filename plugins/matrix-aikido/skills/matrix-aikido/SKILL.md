---
name: matrix-aikido
description: Use when receiving harsh or hostile code review feedback, strong pushback, or a constraint that cannot be changed ("we can't touch X") - find the real worry behind every comment, even the wrong or petty ones, and absorb it with the smallest change instead of just agreeing or arguing.
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

1. **Receive.** Restate each comment or constraint as a neutral technical claim. Strip the tone; keep the claim.
2. **Verify.** Check each claim against the code and label it **correct**, **partly correct**, or **wrong**, with evidence.
3. **Find the worry.** For *every* comment, including the wrong and the petty ones, name the outcome the reviewer is afraid of: an outage, a hang, data loss, a security hole, code nobody can follow, being ignored. A wrong demand often guards a real worry. The literal request can be mistaken while the fear behind it is valid.
4. **Blend.** Remove each worry with the smallest change that does it, even when the literal demand is wrong and you are not doing what was asked. If no code change fits, commit to a concrete follow-up: a test, a metric, an issue.
5. **Redirect.** Answer each comment in one of three forms:
   - *agreed + done*;
   - *not as asked, but this addresses the concern* (and why);
   - *disagree (evidence) + here is what I did about the worry*.
6. **Draft the replies.** Calm, short, specific. No sarcasm, no grovelling.

## Rules

- No comment gets a bare "no". Every reply names the worry and what happened to it.
- Never perform agreement you don't have. "You're right" only when verified.
- Constraints you can't move become design inputs, not grievances.

## Anti-patterns

- Winning the argument while leaving the worry in place.
- Implementing a wrong demand literally just to end the conversation.
- Rewriting everything to appease one comment.

## Closing

End with a table (comment → verdict → worry → what changed), then the drafted replies. If the operator voice is active, one short, original Morpheus-style line may close it. Never quote or paraphrase film dialogue.
