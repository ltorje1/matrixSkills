# Session ledger

## 2026-09-25 · claude · 54147c6
REQ: eval pilot — kendo, jiu-jitsu, krav-maga (main + near-miss cases)
Changed: plugins/matrix-{kendo,jiu-jitsu,krav-maga}/evals/, krav-maga description, .gitignore, CLAUDE.md
Watch: Pilot Δ (runs=3): jiu-jitsu +0.25 (pins negative-qty quirk, baseline never does); kendo +0.22 (only the noticed-but-untouched list; baseline also avoids drive-bys; fired 2/3); krav-maga ≈+0.13 after dropping a timed-out baseline run (reported +0.42; baseline finds the same bugs, gain is severity ranking). All near-misses 0 false fires. Humor not yet rated by humans.

## 2026-09-24 · claude · b5e13e6
REQ: rename — matrix- prefix on all plugin and skill names
Changed: plugins/* → plugins/matrix-*, skill names, marketplace.json, upload-banner.sh ARTS, session-start.sh rule, tests, README, CLAUDE.md
Watch: Install ids are now matrix-<art>@the-construct; the banner still shows the bare art ("I know aikido."). Unprefixed skill names get no banner (on purpose). The design spec keeps the old names as a historical record.

## 2026-09-24 · claude · 6467344
REQ: the-construct v1 — marketplace, operator plugin, 10 martial-arts skills
Changed: .claude-plugin/marketplace.json, plugins/{operator,kung-fu,aikido,jiu-jitsu,wing-chun,krav-maga,tai-chi,muay-thai,drunken-boxing,judo,kendo}, tests/, README.md
Watch: Live-checked only the SessionStart hook (headless run; model call failed, API key had no credit). Still untested live: the skill triggering and the upload banner. Quotes must stay original (verbatim film lines tripped the output filter).
