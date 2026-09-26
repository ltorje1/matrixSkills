# The Construct — Matrix martial-arts skills for Claude Code

## Context
The repo `matrixSkills` is empty apart from LICENSE (Apache-2.0) and README. The idea comes from the scene in *The Matrix* where kung fu is uploaded into Neo's mind ("I know kung fu"). Claude skills work much the same way: knowledge is loaded into the agent when it's needed.

We ship **10 martial-arts skills**. Each one encodes a real development technique and comes wrapped in "upload" theatrics: an upload banner, an ASCII stance, and Morpheus flavor lines.

Decisions from brainstorming:
- **Useful + theatrical:** every art does real work.
- **One plugin per art:** installing a plugin is the upload.
- **All 10 arts in v1.**
- **Morpheus voice:** flavor lines only.
- **ASCII:** a hook banner plus the skill opening with its stance. No animation command.

## Repo layout (the repo is the marketplace `the-construct`)
```
.claude-plugin/marketplace.json        # lists operator + 10 arts, source "./plugins/<name>"
plugins/
  operator/                            # shared theatrics, optional but recommended
    .claude-plugin/plugin.json
    hooks/hooks.json                   # SessionStart + PreToolUse(matcher "Skill")
    scripts/session-start.sh           # random Morpheus line (systemMessage) + flavor-rule additionalContext
    scripts/upload-banner.sh           # reads stdin JSON, if skill ∈ ARTS → systemMessage upload bar + "I know <art>."
    quotes.txt
  kung-fu/ .claude-plugin/plugin.json, skills/kung-fu/SKILL.md
  aikido/ … (same shape ×10)
tests/
  hooks.test.sh                        # fixture JSON → hook scripts → jq assertions
  fixtures/*.json
docs/superpowers/specs/2026-09-24-the-construct-design.md   # this design, committed first
CLAUDE.md, CHANGES.md, README.md (install + roster + credits/disclaimer: fan parody, no film assets)
```

## Art roster (plugin = skill name; the description starts "Use when…" so the skill triggers correctly)
| Art | Technique | Trigger |
|---|---|---|
| kung-fu | root-cause debugging kata: reproduce → isolate → hypothesize → fix → verify | a bug or failing test |
| aikido | redirect, don't resist: defuse hostile review or legacy constraints with the smallest redirecting change | pushback, a harsh review, "can't change X" |
| jiu-jitsu | position before submission: characterization tests first, then refactor | refactoring untested or legacy code |
| wing-chun | centerline: cut to the shortest path, YAGNI, remove abstraction | overengineered code, a request to simplify |
| krav-maga | fast pragmatic security sweep of a diff (inputs, authn/z, secrets, injection) | pre-merge security check |
| tai-chi | calm incident response: stabilize → communicate → diagnose → fix → postmortem | outage, prod fire |
| muay-thai | 8-limb review: correctness, errors, tests, security, perf, naming, API, docs | review a diff or PR |
| drunken-boxing | chaotic edge-case and fuzz input generation for tests | hardening tests, "what could break this" |
| judo | leverage: reuse an existing util or library before writing new code, minimal-force diff | adding functionality |
| kendo | one precise cut: single-purpose surgical edit, no drive-by changes | a targeted fix in a sensitive area |

**SKILL.md template (the same for every art):**
- Frontmatter: `name`, `description`.
- Body:
  1. **Opening:** print the art's ASCII stance, 3–5 lines embedded verbatim, plus the art's one-line motto.
  2. **Kata:** the numbered technique steps.
  3. **Rules and anti-patterns.**
  4. **Closing:** one short Morpheus-style line, only when the operator voice is present; the technical output stays plain.

Keep each file under ~120 lines.

## Operator plugin (theatrics)
- **`upload-banner.sh` (PreToolUse, matcher `Skill`):**
  - Reads `tool_input.skill`. It acts only when the name (namespace stripped) is in the hard-coded list of 10 arts; any other skill → exit 0 with no output.
  - For a match, emits `{"systemMessage": "Uploading <art>.skill [████████████████] 100%\n\"I know <art>.\""}`. It never blocks the tool call and never sets permissionDecision.
- **`session-start.sh` (SessionStart, matcher `startup`):**
  - Shows a random quote from `quotes.txt` to the user via systemMessage.
  - Adds a short `hookSpecificOutput.additionalContext` rule: "Morpheus flavor only as the opener/closer of the-construct arts; all technical content in plain prose."
- **Dependencies:** bash + jq. If jq is missing, fall back to exit 0 silently; the theatrics must never break a session.
- **Verify first:** while building, check against the hooks docs that `systemMessage` reaches the user's terminal for both events. If it doesn't, fall back to the channel the docs name, and record the result in CLAUDE.md.

## Repo conventions
- Commits follow the global format (`setup:` / `feature:` / `docs:` + `Agent: claude` trailer).
- `CHANGES.md` ledger.
- Short project `CLAUDE.md` covering the layout, how to add an art (5-step checklist), and the test commands.

## Build order
1. Commit the spec doc, CLAUDE.md, CHANGES.md and the marketplace skeleton.
2. Operator plugin with hook scripts, written test-first against fixtures.
3. The 10 art plugins from the template. They are independent, so they can be written in parallel.
4. README (install instructions, roster, ASCII hero).

## Verification
- `bash tests/hooks.test.sh`:
  - an art skill gives the banner JSON;
  - a non-art skill gives empty output;
  - malformed stdin exits 0;
  - the session-start output is valid JSON with exactly one context field.
- `claude plugin validate .`, and on each plugin dir if supported: manifest and frontmatter checks.
- Manual smoke test, documented in CHANGES.md:
  1. `/plugin marketplace add ./`
  2. `/plugin install operator@the-construct` and `/plugin install aikido@the-construct`
  3. Restart and see the Morpheus line.
  4. Ask "a reviewer left a hostile comment…" → the upload banner shows, then the ASCII stance and the aikido kata.
- A spot check that a non-art skill (e.g. superpowers) shows no banner.
