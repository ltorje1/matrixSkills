# The Construct: user guide

The Construct is a Claude Code plugin marketplace of martial-arts skills. Each art is a separate plugin that teaches Claude one engineering technique, such as incident response, code review or safe refactoring. When an art loads, Claude follows that technique and opens with a small ASCII stance, like Neo getting kung fu uploaded.

- **Which arts to install, and what each one does:** [arts.md](arts.md).
- **Contributing:** [CLAUDE.md](../CLAUDE.md).

## Contents

- [Quick start](#quick-start)
- [Installing](#installing)
- [Using the arts](#using-the-arts)
- [Choosing arts](#choosing-arts)
- [Managing plugins](#managing-plugins)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)

## Quick start

You need Claude Code. The optional theatrics plugin also needs `bash` and `jq`.

Run each command below on its own, inside a Claude Code session.

**1. Add the marketplace.** Type only this line into the prompt:

```
/plugin marketplace add ltorje1/matrixSkills
```

**2. Install an art.** `matrix-tai-chi` (incident response) is a good first pick:

```
/plugin install matrix-tai-chi@the-construct
```

Claude Code opens the plugin panel. Choose **Install for you**.

**3. Optional: install the theatrics** (the upload banner and operator lines):

```
/plugin install matrix-operator@the-construct
```

**4. Activate the plugins:**

```
/reload-plugins
```

**5. Try it.** Ask something like:

> Prod is down: checkout has been returning 500s since the deploy 10 minutes ago. What do I do?

You should see `Uploading tai-chi.skill … "I know tai-chi."` (if you installed the operator), then the tai-chi stance, then an ordered incident plan: roll back first, a drafted status update, the diagnosis steps, and a postmortem outline.

<details>
<summary>Prefer your shell?</summary>

```
claude plugin marketplace add ltorje1/matrixSkills
```

```
claude plugin install matrix-tai-chi@the-construct
```

Shell installs use user scope by default. The plugins load the next time you start Claude Code.
</details>

## Installing

### Marketplace sources

| You want | Source to add |
|---|---|
| The latest version from GitHub | `ltorje1/matrixSkills` |
| A specific branch or tag | `ltorje1/matrixSkills#<branch-or-tag>` |
| A local clone | an absolute path, such as `/Users/you/code/matrixSkills`, or a relative one starting with `./` or `../` |

A bare `name/name` is always read as a GitHub repository, so local relative paths must start with `./` or `../`.

### Scopes

When you install from the `/plugin` panel, you choose who gets the plugin:

| Scope | Who gets it | Where it's recorded |
|---|---|---|
| **User** (Install for you) | you, in every project on this machine | `~/.claude/settings.json` |
| **Project** | everyone who works in this repository | `.claude/settings.json` (commit it) |
| **Local** | you, in this repository only | `.claude/settings.local.json` |

From the shell, add `--scope project` or `--scope local` to `claude plugin install`.

### Set up a whole team

To give everyone in a repository the marketplace and a set of arts, commit this to the repository's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "the-construct": {
      "source": { "source": "github", "repo": "ltorje1/matrixSkills" }
    }
  },
  "enabledPlugins": {
    "matrix-tai-chi@the-construct": true,
    "matrix-muay-thai@the-construct": true,
    "matrix-jiu-jitsu@the-construct": true
  }
}
```

Two things to know:

- **Workspace trust:** Claude Code honors these entries only after a collaborator accepts the workspace trust dialog for the folder.
- **One install each:** enabling a plugin in project settings doesn't download it. Each collaborator runs the install once per plugin, for example:

  ```
  claude plugin install matrix-tai-chi@the-construct --scope project
  ```

## Using the arts

### Automatic loading

You don't have to name an art. Claude loads one when your request matches what it's for: a bug, a code review, an outage, a refactor of untested code, and so on. [arts.md](arts.md) gives an example prompt for each art that has been verified to load it.

### Invoking an art directly

Type the art's full name as a command, followed by your request:

```
/matrix-kendo:matrix-kendo fix the off-by-one in paginate() and touch nothing else
```

Every art uses the form `/matrix-<art>:matrix-<art>`.

### What you'll see

1. **The upload banner** (only with `matrix-operator` installed): `Uploading kendo.skill [████████████████] 100%` and `"I know kendo."`.
2. **The art's stance and motto** in a small code block.
3. **The work itself, in plain prose.** The theatrics stay in the opening and at most one closing line.
4. **A closing summary** in the art's format, for example ranked findings, a timeline, or a list of tests added.

### The operator

`matrix-operator` is purely theatrical:

- a short original line when a session starts;
- the upload banner whenever an art loads.

It never blocks a tool, changes your files, or makes network calls. Without it, the arts work exactly the same, just with no banner.

## Choosing arts

Every art was measured on a realistic task against plain Claude. In short:

- **Clear gains:**
  - `matrix-tai-chi`: incidents;
  - `matrix-muay-thai`: code review;
  - `matrix-jiu-jitsu`: refactoring legacy code;
  - `matrix-kung-fu`: debugging;
  - `matrix-kendo`: surgical fixes.
- **Smaller gains** (consistent, but within the noise of a small test):
  - `matrix-krav-maga`: security checks before merging;
  - `matrix-aikido`: handling hostile review.
- **Flavor only,** because plain Claude already does these well:
  - `matrix-wing-chun`: simplifying;
  - `matrix-drunken-boxing`: edge-case tests;
  - `matrix-judo`: reusing existing code.

The skills don't make Claude find more bugs. They add the process step a careful engineer includes and a quick answer skips. Details and numbers are in [arts.md](arts.md).

## Managing plugins

| To | In a session | In your shell |
|---|---|---|
| See what's installed | `/plugin` → **Installed** tab | `claude plugin list` |
| Get the latest arts list | `/plugin marketplace update the-construct` | `claude plugin marketplace update the-construct` |
| Update one plugin | `/plugin` → **Installed** tab | `claude plugin update matrix-kung-fu@the-construct` |
| Apply changes without restarting | `/reload-plugins` | (restart Claude Code) |
| Turn a plugin off | `/plugin disable` | `claude plugin disable matrix-kung-fu@the-construct` |
| Turn it back on | `/plugin enable` | `claude plugin enable matrix-kung-fu@the-construct` |
| Remove it | `/plugin uninstall` | `claude plugin uninstall matrix-kung-fu@the-construct` |

Third-party marketplaces don't auto-update by default, so run the marketplace update now and then to get new or improved arts.

## Troubleshooting

**"Invalid marketplace source format"**
The source field got more than the source, usually a whole pasted block of commands. Enter only `ltorje1/matrixSkills`, then run each install command separately.

**"Plugin not found in marketplace"**
Use the full name with the prefix, such as `matrix-kendo@the-construct` and not `kendo@the-construct`. If the art is new, run `/plugin marketplace update the-construct` first.

**Adding the marketplace fails validation**
You probably pinned a branch or tag that doesn't contain `.claude-plugin/marketplace.json`. Add `ltorje1/matrixSkills` without a `#ref`.

**No upload banner**
- Is `matrix-operator` installed and enabled? Check with `claude plugin list`.
- Is `jq` installed? Check with `jq --version`. Without it the operator stays silent on purpose.
- Did you run `/reload-plugins` or restart after installing?
- The banner shows only when an art loads, not on every message.

**An art doesn't load when you expect it to**
Phrase the request the way the examples in [arts.md](arts.md) do, or invoke the art directly with `/matrix-<art>:matrix-<art>`. Confirm it's enabled with `claude plugin list`.

**Too much flavor**
Uninstall `matrix-operator` to remove the banner and the operator lines. The arts still open with their stance and motto; that's part of each skill and can't be turned off separately.

## FAQ

**What does it cost in tokens?**
- **Each installed art:** about 40 tokens per session just by being installed, for its name and description.
- **Each time an art loads:** about 480 tokens.
- **The operator:** one short paragraph at session start, plus a banner line when an art loads.

You can check any plugin with `claude plugin details matrix-kung-fu@the-construct`.

**Does it send my code anywhere?**
No. The arts are Markdown instructions. The operator runs two small local bash scripts. Nothing makes network calls.

**Does an art change my code on its own?**
No. An art only changes how Claude approaches the task. Claude still asks for permission as it normally would.

**Is this official?**
No. It's an unofficial fan parody inspired by *The Matrix*. It isn't affiliated with or endorsed by the film's rights holders, and it contains no film assets or dialogue.
