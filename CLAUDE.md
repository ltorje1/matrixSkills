# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A Claude Code plugin marketplace named `the-construct`: martial-arts skills themed on the Matrix "I know kung fu" upload. There is no build step; the deliverables are Markdown skills, JSON manifests and two bash hook scripts.

- `docs/superpowers/specs/2026-09-24-the-construct-design.md` is the original design. It predates the `matrix-` prefix, so its names are historical.
- `CHANGES.md` is the session ledger, including every eval scoreboard.

## Architecture

- `.claude-plugin/marketplace.json` lists `matrix-operator` plus one plugin per art, each with source `./plugins/<name>`. Every plugin and skill name uses the `matrix-` prefix.
- **Art plugins:** `plugins/matrix-<art>/` holds only `.claude-plugin/plugin.json` and `skills/matrix-<art>/SKILL.md`. Each skill encodes one real engineering technique (the "kata"), wrapped in an opening ASCII stance and motto.
- **The operator plugin:** `plugins/matrix-operator/` is optional theatrics, wired through `hooks/hooks.json`.
  - `scripts/session-start.sh` (SessionStart, `startup`) shows a random line from `quotes.txt` via `systemMessage`. It also adds `additionalContext` that limits Claude's flavor to an opener or closer.
  - `scripts/upload-banner.sh` (PreToolUse, matcher `Skill`) reads `tool_input.skill`, which arrives namespaced (`matrix-aikido:matrix-aikido`). It strips everything up to the last `:` and matches against its hard-coded `ARTS` list. For a match it emits `Uploading aikido.skill … "I know aikido."`, with the prefix dropped only for display. Any other skill, or unprefixed names, get no output.
- **Coupling:** the art list lives in three places: `marketplace.json`, `ARTS=` in `upload-banner.sh`, and the `rule` text in `session-start.sh`. `tests/hooks.test.sh` checks the first two against each other.

## Commands

```
bash tests/hooks.test.sh                       # hook scripts, manifests, skill frontmatter (no model calls)
claude plugin validate .                       # marketplace manifest
claude plugin validate plugins/matrix-<art>    # one plugin
```

The test script has no filter. To see only failures, run `bash tests/hooks.test.sh | grep FAIL`.

### Evals (model calls; they count against the user's usage limits)

Evals use the user's credentials. If `ANTHROPIC_API_KEY` is set, it takes precedence over the subscription login. Unset it in a subshell, because the user's hook blocks commands starting with `env`.

```
# main cases, with and without the plugin (reports WITH / W/OUT / Δ)
(unset ANTHROPIC_API_KEY; claude plugin eval plugins/matrix-<art> --tag main \
  --scaffold --allow-tools Bash Write Edit --judge-model sonnet --trust-plugin --no-publish -j 2)

# near-miss cases need no baseline
(unset ANTHROPIC_API_KEY; claude plugin eval plugins/matrix-<art> --tag near-miss --ablation none \
  --scaffold --allow-tools Bash Write Edit --trust-plugin --no-publish -j 2)
```

- **One case:** `--case <name>`.
- **Cheap grader debugging:** `--ablation none --runs 1`.
- **Agent-run flags:** `--trust-plugin` is required when there's no TTY (agent-run). Reports from agent-started runs stay local under `plugins/*/evals/results/`, which is gitignored.
- **Cost:** a full main + near-miss pass costs about $1.25 per art (list price). Run arts one at a time, not concurrently: running three suites in parallel once used up the whole session limit.

## Add a new art

1. Copy an existing `plugins/matrix-<art>/.claude-plugin/plugin.json`.
2. Write `skills/matrix-<art>/SKILL.md`:
   - frontmatter `name: matrix-<art>` and a `description` starting with `Use when` (both enforced by the tests);
   - sections Opening (original ASCII stance + motto), Kata, Rules, Anti-patterns, Closing.
3. Add the art to `marketplace.json`, to `ARTS=` in `upload-banner.sh`, and to the `rule` text in `session-start.sh`.
4. Add evals in `plugins/matrix-<art>/evals/`, following an existing art:
   - a `main` case (`case.yaml` pointing at `scaffold.sh`, `prompt.md`, `graders/*.md`) plus the shared `skill-fired`, `motto-shown` and `flavor-discipline` graders;
   - a `near-miss` case whose only grader asserts the skill did not fire (`min: 0`, `max: 0`, `arm: both`).
5. Run the tests, validate, then run the evals.

## Constraints

- **No film dialogue or assets.** Quotes, mottos, ASCII art and closing lines must be original. Every skill's Closing forbids quoting or paraphrasing the film; a near-verbatim line slipped through once, and long verbatim quotes also trip output filters. The only nod allowed is the short "I know <art>." line.
- **Theatrics never break a session.** Hook scripts exit 0 silently on any failure, including missing `jq`, and never return a permission decision.
- **Keep the hooks synchronous.** Their `systemMessage` reaches the user only for synchronous SessionStart and PreToolUse hooks; making them `async` hides it.
- **Don't write skills to pass their eval.** Kata text stays generic, with no scenario-specific hints; the evals measure whether the technique transfers.

## Eval pitfalls we hit

- **Regex graders over file content match mentions too.** A `no-asyncio` check failed on a docstring that pointed callers to `asyncio.to_thread`. Match real code (`async def`, `import asyncio`), not words.
- **`tool_used` `input_match` runs against JSON-encoded tool input,** so quotes are `\"` and newlines are `\n`. Check patterns locally with node against `JSON.stringify` samples before spending model runs.
- **`llm` rubrics need explicit PASS/FAIL conditions,** including what counts as a PASS when the thing is absent. Even so, the `flavor-discipline` judge is noisy: it failed about a quarter of compliant responses. Treat it as an indicator, not a score.
- **Usage limits and timeouts show up as failing graders** ("judge call failed", "timed out"), and a timed-out baseline run inflates Δ. Check each run's `error` and the grader explanations before trusting a score.
- **Detect usage limits from error fields only.** Claude's answers can contain text like "429 (rate limited)".
- **`git` doesn't run inside the eval sandbox** (xcode-select). Scaffolds run outside it and may use git, but Claude has to read the files directly.
