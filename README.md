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
| `matrix-kung-fu` | Root-cause debugging kata: reproduce → isolate → hypothesize → fix → verify | a bug or failing test |
| `matrix-aikido` | Redirect, don't resist: answer hostile review or fixed constraints with the smallest redirecting change | harsh feedback, pushback |
| `matrix-jiu-jitsu` | Characterization tests first, then refactor | changing legacy or untested code |
| `matrix-wing-chun` | Shortest path: YAGNI, remove indirection | overengineered code, "simplify this" |
| `matrix-krav-maga` | Fast, pragmatic security sweep of a diff | input, auth, secrets, queries in a change |
| `matrix-tai-chi` | Calm incident response: stabilize → communicate → diagnose → fix → learn | outages, prod fires |
| `matrix-muay-thai` | Eight-angle code review with ranked findings | reviewing a diff or PR |
| `matrix-drunken-boxing` | Chaotic edge-case and fuzz input generation | hardening tests |
| `matrix-judo` | Reuse what exists before writing anything new | adding functionality or dependencies |
| `matrix-kendo` | One precise, single-purpose edit | targeted fixes in sensitive code |

Every art opens with its ASCII stance and motto, then does real work in plain prose.

## The operator

`matrix-operator` is optional. It adds:

- a short Morpheus-style line when a session starts;
- the `Uploading <art>.skill … "I know <art>."` banner whenever an art loads.

The operator only prints messages: it never blocks tools or changes your work. It needs `bash` and `jq`, and stays silent if `jq` is missing.

## Development

```
bash tests/hooks.test.sh      # hook scripts, manifests, skill frontmatter
claude plugin validate .      # marketplace manifest
```

See `CLAUDE.md` for how to add a new art.

## Disclaimer

An unofficial fan parody inspired by *The Matrix*. It is not affiliated with or endorsed by the film's rights holders, and it contains no film assets or dialogue.
