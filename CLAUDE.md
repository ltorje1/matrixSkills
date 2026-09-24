# The Construct — project notes

This repo is a Claude Code plugin marketplace named `the-construct`. The design is in `docs/superpowers/specs/2026-09-24-the-construct-design.md`.

## Layout

- `.claude-plugin/marketplace.json` lists `matrix-operator` and every art (all plugin and skill names use the `matrix-` prefix), with source `./plugins/<name>`.
- `plugins/matrix-<art>/` holds one plugin per art: `.claude-plugin/plugin.json` and `skills/matrix-<art>/SKILL.md`.
- `plugins/matrix-operator/` holds the theatrics:
  - SessionStart hook: a line from `quotes.txt` plus the flavor rule.
  - PreToolUse(`Skill`) hook: the upload banner.
- `tests/hooks.test.sh` holds the tests, with fixtures in `tests/fixtures/`.

## Add a new art

1. Create `plugins/matrix-<art>/.claude-plugin/plugin.json` (copy an existing one).
2. Write `plugins/matrix-<art>/skills/matrix-<art>/SKILL.md` from the template:
   - frontmatter `name: matrix-<art>` and `description: Use when ...`;
   - sections Opening (original ASCII stance + motto), Kata, Rules, Anti-patterns, Closing.
3. Add the art to `.claude-plugin/marketplace.json`.
4. Add `matrix-<art>` to `ARTS=` in `plugins/matrix-operator/scripts/upload-banner.sh`, and to the list in the `rule` text in `session-start.sh`.
5. Run `bash tests/hooks.test.sh` and `claude plugin validate .`.

## Constraints

- **No film dialogue or assets.** Quotes, mottos and ASCII art must be original; long verbatim film quotes also get blocked by output filters. The only nod allowed is the short "I know <art>." line.
- **Theatrics never break a session.** Hook scripts exit 0 silently on any failure and never return a permission decision.
- **Visible banner.** Hook `systemMessage` is shown to the user for synchronous SessionStart and PreToolUse hooks (per the hooks docs, 2026-09). Don't make these hooks `async`, or the message stops reaching the user.
- **Skill names.** The Skill tool's `tool_input.skill` arrives namespaced (`matrix-aikido:matrix-aikido`). The banner strips everything up to the last `:`, matches the result against `ARTS`, and drops the `matrix-` prefix only for display ("I know aikido.").

## Test

```
bash tests/hooks.test.sh
claude plugin validate .
```
