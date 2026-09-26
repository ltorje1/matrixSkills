# Intent: user documentation for installing and using the-construct

## Goal
Anyone with Claude Code can install the-construct's plugins, pick the arts worth having, use them, and fix common problems, without reading the source or asking the author.

## Why
- The README install block combines three commands and inline comments in one code block. The author pasted the whole block into the "Enter marketplace source" field and got `Invalid marketplace source format`.
- There is no guidance on team setup, on managing plugins (update, disable, uninstall), or on what an art looks like in use.
- The eval results say which arts are worth installing. That is the most useful advice we have, and it isn't framed for users.

## Audience
Developers who use Claude Code (terminal, desktop app, IDE), and team leads who want the plugins for a whole repository. Not contributors: `CLAUDE.md` covers development.

## Success criteria
1. **Quick start that survives copy-paste.** One command per code block, numbered steps, no inline comments inside commands. It gets a new user from nothing to a working art.
2. **Install paths:** GitHub shorthand, local clone, pinning a branch or tag (`#ref`), the three scopes, and team setup through `.claude/settings.json`.
3. **Usage:** automatic loading with a realistic example prompt per art (taken from the eval prompts, which are verified to trigger), explicit invocation (`/matrix-<art>:matrix-<art>`), what the output looks like, and what the operator adds.
4. **Choosing arts:** a recommendation grounded in the measured with/without results, including which arts are flavor only.
5. **Managing plugins:** update the marketplace and plugins, reload without a restart, disable, uninstall.
6. **Troubleshooting** covering the failures we actually hit: invalid source format, the marketplace not found on `main`, no banner (operator missing, `jq` missing, not reloaded), and a skill that doesn't load.
7. **Accuracy:** every command is verified against the current Claude Code docs or CLI (2026-09). Nothing is invented.
8. **No drift:** a test fails if an art is missing from the user docs.

## Out of scope
- Contributor and eval documentation, which stays in `CLAUDE.md`.
- Any change to the plugins themselves.
- Publishing to an official marketplace.
- Screenshots or GIFs.

## Open questions
None blocking. Single guide file vs split: decided in the plan.

## Plan
1. **`docs/user-guide.md`,** the main guide:
   - quick start;
   - install (sources, pinning, scopes, team setup);
   - using the arts (automatic vs explicit, what you see, the operator);
   - choosing arts (short, links to the reference);
   - managing plugins;
   - troubleshooting;
   - FAQ (token cost, network, flavor).
2. **`docs/arts.md`,** a reference with one section per art: when it loads, an example prompt, what it does, what it adds over plain Claude (measured), and how to invoke it.
3. **`README.md`:** slim it to the pitch, a quick start that is safe to copy, a short arts list, the "does it help" summary with a link to `docs/arts.md`, a documentation index, development pointers, and the disclaimer. The detailed results table moves to `docs/arts.md`, so it isn't kept in two places.
4. **`tests/hooks.test.sh`:** check that every art in `marketplace.json` has a section in `docs/arts.md`.
5. **Verify:**
   - Run the read-only commands the guide shows.
   - Check each flag against the CLI `--help`.
   - Follow the quick start in a scratch session: add the marketplace from the local clone, then list.

## Gaps
- **Windows:** hooks run through `bash` and need `jq`. We haven't tested Windows. The guide states the requirement and makes no claims about Windows support.
- **No release tags yet:** `#ref` pinning is documented with the general syntax plus a branch example, not a made-up tag.
- **Token cost:** measured with `claude plugin details`: about 40 tokens per art per session just from being installed, about 480 when an art loads. The operator's session-start rule adds about one short paragraph. This goes in the FAQ.
- **Scope precedence:** with project scope, each collaborator still runs `claude plugin install ... --scope project` once. That comes from the docs and is stated explicitly.
- **Flavor too much:** the answer is to uninstall `matrix-operator`. The arts still open with their stance, and that can't be switched off separately; the FAQ says so.
- **The eval numbers will go stale.** `docs/arts.md` dates them and links to `CHANGES.md`.
- **Keeping the art list in sync:** covered by the new test (plan item 4). CLAUDE.md's "Add a new art" checklist gets a step for `docs/arts.md`.

## Review and verification
- **Criteria 1–6:** met by `docs/user-guide.md` (quick start, installing, using, choosing, managing, troubleshooting, FAQ), `docs/arts.md` (per-art reference with verified example prompts) and the slimmed `README.md`. Every quick-start command sits in its own block.
- **Criterion 7:**
  - `claude plugin disable/enable/uninstall/update/details --help` and `claude plugin marketplace update --help` match the documented forms.
  - `claude plugin marketplace update the-construct` ran successfully.
  - Scopes, `#ref`, `/reload-plugins`, `extraKnownMarketplaces`/`enabledPlugins`, and skill arguments were checked against the current docs.
- **Criterion 8:** `tests/hooks.test.sh` now checks that every art has a `## matrix-<art>` section in `docs/arts.md`. Renaming one section made it fail, as intended. Result: 61 passed, 0 failed. `claude plugin validate .` passes.
- **All relative links and anchors** in `README.md` and `docs/*.md` resolve (checked with a script).
- **Fixed during review:**
  - The README said "seven of ten measurably improve", which contradicted the stated ±0.2 noise threshold. It now says five clear gains plus two smaller, consistent ones.
  - A troubleshooting entry claimed more than we know; it was rephrased to the observed failure (validation fails).
- **Evals:** not applicable, because no skill or eval files changed.
