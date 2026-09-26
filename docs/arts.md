# The arts

One section per art, ordered by how much it measurably improves on plain Claude. For installing and general usage, see the [user guide](user-guide.md).

## How the numbers were measured

- **The test:** each art got a realistic task in a small scratch project, run 3 times with the art installed and 3 times with plain Claude. It was scored by automated checks on the behavior the technique asks for. The score is the share of checks passed.
- **Loading:** each art also got a nearby prompt where it should *not* load. No art loaded on its nearby prompt.
- **When:** measured September 2026 with `claude plugin eval` and Claude Code's default model. History is in [CHANGES.md](../CHANGES.md).
- **Noise:** with only 3 runs per side, treat differences under ±0.2 as noise.
- **Example prompts:** each art's example is the prompt from its test, so it's known to load the art.

## Summary

| Art | Use it for | Plain Claude → with art |
|---|---|---|
| [tai-chi](#matrix-tai-chi) | production incidents | 0.33 → 1.00 |
| [muay-thai](#matrix-muay-thai) | reviewing a diff or PR | 0.67 → 1.00 |
| [jiu-jitsu](#matrix-jiu-jitsu) | refactoring untested or legacy code | 0.67 → 0.92 |
| [kung-fu](#matrix-kung-fu) | debugging | 0.75 → 1.00 |
| [kendo](#matrix-kendo) | a targeted fix in sensitive code | 0.67 → 0.89 |
| [krav-maga](#matrix-krav-maga) | security check before merging | 0.88 → 1.00 |
| [aikido](#matrix-aikido) | handling harsh review feedback | 0.83 → 0.94 |
| [wing-chun](#matrix-wing-chun) | simplifying overengineered code | 1.00 → 1.00 |
| [drunken-boxing](#matrix-drunken-boxing) | edge-case and fuzz tests | 1.00 → 1.00 |
| [judo](#matrix-judo) | reusing existing code before writing new | 1.00 → 1.00 |

---

## matrix-tai-chi

*"Slow is smooth. Smooth is fast."*: calm incident response.

- **Loads when:** there's a production incident, an outage, or an "everything is on fire" moment.
- **What it does:** it sizes the blast radius, mitigates with something reversible before investigating, drafts status updates, builds a timeline, diagnoses one thread at a time, and outlines a blameless postmortem. It won't run destructive commands without your confirmation.
- **What it adds:** plain Claude also recommends rolling back first. Only tai-chi drafted a stakeholder status update and a postmortem outline (3 of 3 runs vs 0 of 3).
- **Example prompt:** "PROD IS DOWN. Checkout has been returning 500s for about 40% of users since 14:05. deploy_log.txt and error_sample.log are here. What do I do??"
- **Invoke directly:** `/matrix-tai-chi:matrix-tai-chi`

## matrix-muay-thai

*"Eight limbs. Eight angles."*: structured code review.

- **Loads when:** you ask for a review of a diff, branch or pull request.
- **What it does:** it reviews from eight angles: correctness, error handling, tests, security, performance, naming, API compatibility, docs and operations. Every finding gets `file:line`, a severity (blocker / should-fix / nit) and a suggested fix, and the review ends with a verdict.
- **What it adds:** plain Claude found the same bugs. Only muay-thai labelled every finding by severity and gave an overall verdict (3 vs 0). It also flagged the missing tests more reliably (3 vs 2).
- **Example prompt:** "Can you review my change before I open the PR? The diff is in change.diff and the new code is in shipping.py."
- **Invoke directly:** `/matrix-muay-thai:matrix-muay-thai`

## matrix-jiu-jitsu

*"Position before submission."*: characterization tests before refactoring.

- **Loads when:** you're refactoring or restructuring legacy or untested code.
- **What it does:** it pins current behavior with tests first, including odd behavior that callers may rely on. It adds only the seams it needs, refactors in small steps with the tests green after each one, and changes behavior last.
- **What it adds:** plain Claude also writes tests first. Only jiu-jitsu pinned the surprising "negative quantity gives a refund" behavior before refactoring (3 vs 0).
- **Example prompt:** "pricing.py is a mess and has no tests. Clean it up so it's readable. Other code calls calc() and calc_all(), so keep them working."
- **Invoke directly:** `/matrix-jiu-jitsu:matrix-jiu-jitsu`

## matrix-kung-fu

*"Find the root, not the leaf."*: root-cause debugging.

- **Loads when:** there's a bug, a failing or flaky test, a crash, or behavior nobody can explain.
- **What it does:** reproduce, read the error fully, isolate, test one hypothesis at a time, fix the root cause, add a regression test, then verify.
- **What it adds:** plain Claude also reproduced the bug and found the root cause. Only kung-fu added a regression test (3 vs 0).
- **Example prompt:** "test_report in test_inventory.py fails when I run the whole file, but passes when I run it on its own. What's going on? Please fix it."
- **Invoke directly:** `/matrix-kung-fu:matrix-kung-fu`

## matrix-kendo

*"One cut. Clean. Complete."*: surgical, single-purpose edits.

- **Loads when:** you want a targeted fix in sensitive, shared or unfamiliar code.
- **What it does:** it states the change in one sentence, makes only that change, reverts anything unrelated, proves the change with a test, and lists what it noticed but deliberately left alone.
- **What it adds:** plain Claude also avoided drive-by edits. Only kendo reported the issues it noticed and left alone (2 vs 0). Kendo loaded in 2 of 3 runs; invoke it directly when it matters.
- **Example prompt:** "paginate() in utils.py drops the last item of every page. Fix the off-by-one."
- **Invoke directly:** `/matrix-kendo:matrix-kendo`

## matrix-krav-maga

*"Assume the attack. End it fast."*: a pragmatic security sweep.

- **Loads when:** you're checking changes before a merge, deploy or release, or the code handles user input, authentication or authorization, secrets, SQL or shell commands, file paths, or external calls.
- **What it does:** it sweeps for untrusted input, injection, authentication and authorization, secrets, data exposure, dangerous defaults and dependencies. It ranks findings (critical / high / medium / hardening) with `file:line` and a fix, and lists which areas are clean.
- **What it adds:** plain Claude found all three planted issues too. Krav-maga ranked them by severity every time (3 vs 1 of 2).
- **Example prompt:** "I'm about to merge my feature branch into main. Can you check the changes first? (git diff main)"
- **Invoke directly:** `/matrix-krav-maga:matrix-krav-maga`

## matrix-aikido

*"Redirect, don't resist."*: turning harsh feedback into the right change.

- **Loads when:** you get harsh or hostile review feedback, strong pushback, or a constraint you can't change.
- **What it does:** it restates each comment neutrally and checks it against the code. Then it names the real worry behind every comment, including the wrong and petty ones, and removes that worry with the smallest change. It drafts calm replies and ends with a table of comment, verdict, worry and what changed.
- **What it adds:** plain Claude also fixes the valid comments, rejects the wrong ones and stays calm. Only aikido dealt with the real concern behind a wrong comment (5 of 6 runs vs 0 of 6). For example, it rejected an incorrect "rewrite this with asyncio" demand but documented how async callers should use the function safely.
- **Example prompt:** "A reviewer left some pretty harsh comments on my PR, they're in review.md. Make whatever changes are actually justified in retry.py and draft my replies to each comment."
- **Invoke directly:** `/matrix-aikido:matrix-aikido`

## matrix-wing-chun

*"The shortest line wins."*: ruthless simplification.

- **Loads when:** code feels overengineered, you ask to simplify, or you're reviewing new abstractions or layers.
- **What it does:** it traces the real call path and removes every layer that doesn't earn its place. It keeps the public behavior and reports what was removed.
- **What it adds:** nothing measurable. Plain Claude simplified just as well (49 lines down to 2, same public function). Install it for the flavor.
- **Example prompt:** "notify.py feels way too complicated for what it does. Simplify it. main.py and the tests use it."
- **Invoke directly:** `/matrix-wing-chun:matrix-wing-chun`

## matrix-drunken-boxing

*"Stumble where they least expect."*: chaotic edge-case hunting.

- **Loads when:** you're hardening tests, hunting edge cases, or asking "what could break this?"
- **What it does:** it throws inputs from many families at the code: empty values, boundaries, encoding, type confusion, time, concurrency, scale. It turns the cases that break the code into named tests and reports open questions about what the code should accept.
- **What it adds:** nothing measurable. Plain Claude covered as many edge-case families and found the same breakages. Install it for the flavor.
- **Example prompt:** "Write tests for parse_duration.py in test_parse_duration.py. I want to know what could break it. Don't change parse_duration.py."
- **Invoke directly:** `/matrix-drunken-boxing:matrix-drunken-boxing`

## matrix-judo

*"Use their weight, not yours."*: reuse before writing.

- **Loads when:** you're about to add a new function, helper, utility or dependency.
- **What it does:** before writing anything new, it searches the codebase, the standard library and the installed dependencies. It prefers the smallest change: a call site plus a test.
- **What it adds:** nothing measurable. Plain Claude also found and reused the existing helper. Install it for the flavor.
- **Example prompt:** "make_post() in blog.py should also return a "slug" field generated from the title: lowercase, hyphens instead of spaces, no punctuation. Please add it."
- **Invoke directly:** `/matrix-judo:matrix-judo`
