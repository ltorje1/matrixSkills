# matrixSkills — The Construct

"I know Kung Fu"

```
   o      \o/
  /|\  →   |      Uploading kung-fu.skill [████████████████] 100%
  / \     / \     "I know kung-fu."
```

A Claude Code plugin marketplace of martial-arts skills. Each art is a separate
plugin that encodes one real engineering technique. Installing it is the upload.

## Install

```
/plugin marketplace add ltorje1/matrixSkills
/plugin install matrix-operator@the-construct   # theatrics: upload banner + operator lines
/plugin install matrix-kung-fu@the-construct    # then any arts you want
```

From a local clone: `/plugin marketplace add ./` inside the repo.

## The arts

| Plugin | Technique | Loads when |
|---|---|---|
| `matrix-tai-chi` | Calm incident response: stabilize → communicate → diagnose → fix → learn | outages, prod fires |
| `matrix-muay-thai` | Eight-angle code review with severity labels and a verdict | reviewing a diff or PR |
| `matrix-jiu-jitsu` | Characterization tests first, then refactor | changing legacy or untested code |
| `matrix-kung-fu` | Root-cause debugging kata: reproduce → isolate → hypothesize → fix → verify | a bug or failing test |
| `matrix-kendo` | One precise, single-purpose edit | targeted fixes in sensitive code |
| `matrix-krav-maga` | Fast, pragmatic security sweep with ranked findings | pre-merge checks; input, auth, secrets, queries |
| `matrix-aikido` | Find the real worry behind every review comment, even wrong ones, and absorb it with the smallest change | harsh feedback, pushback |
| `matrix-wing-chun` | Shortest path: YAGNI, remove indirection | overengineered code, "simplify this" |
| `matrix-drunken-boxing` | Chaotic edge-case and fuzz input generation | hardening tests |
| `matrix-judo` | Reuse what exists before writing anything new | adding functionality or dependencies |

Every art opens with its ASCII stance and motto, then does real work in plain prose.

## Does it actually help?

Each art was evaluated with `claude plugin eval` on a realistic task: 3 runs with the skill vs 3 runs of plain Claude, scored by automated checks.

| Art | Plain Claude → with skill | What the skill adds |
|---|---|---|
| tai-chi | 0.33 → 1.00 | drafts a status update and a postmortem outline during an outage |
| muay-thai | 0.67 → 1.00 | severity labels on every finding, plus an overall verdict |
| jiu-jitsu | 0.67 → 0.92 | pins odd existing behavior in tests before refactoring |
| kung-fu | 0.75 → 1.00 | adds a regression test for the bug it fixed |
| kendo | 0.67 → 0.89 | lists the issues it noticed but deliberately left alone |
| krav-maga | 0.88 → 1.00 | ranks security findings by severity |
| aikido | 0.83 → 0.94 | addresses the real concern behind a wrong review comment |
| wing-chun, drunken-boxing, judo | 1.00 → 1.00 | nothing measurable: plain Claude already does this well |

The skills don't make Claude find more bugs; plain Claude found every planted issue on its own. What they add is the process step a senior engineer includes and a default answer skips. Each skill loaded in 29 of 30 main runs and in none of 30 nearby "should not load" prompts. With only 3 runs per side, treat anything under ±0.2 as noise. Full history is in `CHANGES.md`.

## The operator

`matrix-operator` is optional. It adds:

- a short Morpheus-style line when a session starts;
- the `Uploading <art>.skill … "I know <art>."` banner whenever an art loads.

The operator only prints messages: it never blocks tools or changes your work. It needs `bash` and `jq`, and stays silent if `jq` is missing.

## Development

Changes follow the workflow in `CLAUDE.md`: a worktree per change, an intent file, then plan, implement, review, test and open a PR. Enable the pre-commit hook once per clone:

```
git config core.hooksPath .githooks
```

It runs the local tests before every commit, and offers to run evals when an art's skill or evals change.

```
bash tests/hooks.test.sh      # hook scripts, manifests, skill frontmatter
claude plugin validate .      # marketplace manifest
```

Each art has an eval suite in `plugins/matrix-<art>/evals/`: a main task plus a near-miss prompt where the skill must not load. Evals call the model with your own credentials:

```
claude plugin eval plugins/matrix-<art> --scaffold --allow-tools Bash Write Edit
```

See `CLAUDE.md` for how to add a new art, the full eval commands, and the pitfalls we hit.

## Disclaimer

An unofficial fan parody inspired by *The Matrix*. It is not affiliated with or endorsed by the film's rights holders, and it contains no film assets or dialogue.
