# matrixSkills — The Construct

"I know Kung Fu"

```
   o      \o/
  /|\  →   |      Uploading kung-fu.skill [████████████████] 100%
  / \     / \     "I know kung-fu."
```

A Claude Code plugin marketplace of martial-arts skills. Each art is a separate plugin that teaches Claude one real engineering technique, such as incident response, code review or safe refactoring. Installing an art is the upload.

## Quick start

Inside Claude Code, run each command on its own:

1. Add the marketplace:
   ```
   /plugin marketplace add ltorje1/matrixSkills
   ```
2. Install an art, and choose **Install for you**:
   ```
   /plugin install matrix-tai-chi@the-construct
   ```
3. Optional: add the upload banner and operator lines:
   ```
   /plugin install matrix-operator@the-construct
   ```
4. Activate:
   ```
   /reload-plugins
   ```

For shell installs, team setup, managing plugins and troubleshooting, see the **[user guide](docs/user-guide.md)**.

## The arts

| Art | Use it for |
|---|---|
| `matrix-tai-chi` | production incidents |
| `matrix-muay-thai` | reviewing a diff or PR |
| `matrix-jiu-jitsu` | refactoring untested or legacy code |
| `matrix-kung-fu` | debugging |
| `matrix-kendo` | a targeted fix in sensitive code |
| `matrix-krav-maga` | security check before merging |
| `matrix-aikido` | handling harsh review feedback |
| `matrix-wing-chun` | simplifying overengineered code |
| `matrix-drunken-boxing` | edge-case and fuzz tests |
| `matrix-judo` | reusing existing code before writing new |

Every art opens with its ASCII stance and motto, then does real work in plain prose. Example prompts, and how to invoke each art directly, are in **[docs/arts.md](docs/arts.md)**.

## Does it actually help?

Each art was evaluated against plain Claude on a realistic task. Five show clear gains, led by tai-chi, which went from 0.33 to 1.00 because it drafts status updates and postmortems during incidents. Two more, krav-maga and aikido, consistently add one specific behavior, but their gains are within the noise of a small test. Three (wing-chun, drunken-boxing, judo) are flavor only.

The skills don't make Claude find more bugs. They add the process step a careful engineer includes and a quick answer skips. The full numbers are in [docs/arts.md](docs/arts.md).

## Documentation

- [User guide](docs/user-guide.md): install, use, choose, manage, troubleshoot.
- [The arts](docs/arts.md): what each art does, example prompts, measured results.
- [CLAUDE.md](CLAUDE.md): contributing: architecture, workflow, evals.

## Development

Changes follow the workflow in `CLAUDE.md`: a worktree per change, an intent file, then plan, implement, review, test and open a PR. Enable the pre-commit hook once per clone:

```
git config core.hooksPath .githooks
```

It runs the local tests before every commit, and offers to run evals when an art's skill or evals change.

```
bash tests/hooks.test.sh      # hook scripts, manifests, skill frontmatter, docs coverage
claude plugin validate .      # marketplace manifest
```

## Disclaimer

An unofficial fan parody inspired by *The Matrix*. It is not affiliated with or endorsed by the film's rights holders, and it contains no film assets or dialogue.
