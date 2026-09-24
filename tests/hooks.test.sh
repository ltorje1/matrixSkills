#!/usr/bin/env bash
# Tests for the operator plugin hook scripts. Usage: bash tests/hooks.test.sh
set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FIX="$ROOT/tests/fixtures"
BANNER="$ROOT/plugins/matrix-operator/scripts/upload-banner.sh"
SESSION="$ROOT/plugins/matrix-operator/scripts/session-start.sh"

pass=0
fail=0
check() { # check <description> <command...>
  local desc="$1"; shift
  if "$@" >/dev/null; then pass=$((pass + 1)); echo "ok   - $desc"
  else fail=$((fail + 1)); echo "FAIL - $desc"; fi
}

# --- upload-banner.sh --------------------------------------------------------
out=$(bash "$BANNER" < "$FIX/skill-art-namespaced.json"); code=$?
check "namespaced art exits 0" test "$code" -eq 0
check "namespaced art emits valid JSON" jq -e . <<<"$out"
check "banner names the art" jq -e '.systemMessage | contains("Uploading aikido.skill")' <<<"$out"
check "banner says I know aikido" jq -e '.systemMessage | contains("I know aikido.")' <<<"$out"
check "banner never makes a permission decision" jq -e '.hookSpecificOutput.permissionDecision == null' <<<"$out"

out=$(bash "$BANNER" < "$FIX/skill-art-bare.json")
check "bare art name also gets a banner" jq -e '.systemMessage | contains("I know kung-fu.")' <<<"$out"

out=$(bash "$BANNER" < "$FIX/skill-other.json"); code=$?
check "non-art skill exits 0" test "$code" -eq 0
check "non-art skill prints nothing" test -z "$out"

out=$(bash "$BANNER" < "$FIX/skill-unprefixed.json")
check "art name without matrix- prefix prints nothing" test -z "$out"

out=$(bash "$BANNER" < "$FIX/malformed.txt" 2>/dev/null); code=$?
check "malformed stdin exits 0" test "$code" -eq 0
check "malformed stdin prints nothing" test -z "$out"

# Every art plugin in the marketplace must be in the banner's list, and vice versa.
listed=$(jq -r '.plugins[].name | select(. != "matrix-operator")' "$ROOT/.claude-plugin/marketplace.json" | sort)
known=$(sed -n 's/^ARTS="\(.*\)"$/\1/p' "$BANNER" | tr ' ' '\n' | sort)
check "banner art list matches marketplace" test "$listed" = "$known"

# --- session-start.sh --------------------------------------------------------
out=$(bash "$SESSION" < "$FIX/session-start.json"); code=$?
check "session-start exits 0" test "$code" -eq 0
check "session-start emits valid JSON" jq -e . <<<"$out"
check "session-start shows a Morpheus line" jq -e '.systemMessage | length > 0' <<<"$out"
quote=$(jq -r '.systemMessage' <<<"$out")
check "Morpheus line comes from quotes.txt" grep -qF -- "$quote" "$ROOT/plugins/matrix-operator/quotes.txt"
check "session-start adds the flavor rule as context" jq -e '.hookSpecificOutput.additionalContext | contains("the-construct")' <<<"$out"
check "session-start uses exactly one context field" jq -e 'has("additional_context") | not' <<<"$out"

# --- manifests ---------------------------------------------------------------
for manifest in "$ROOT"/.claude-plugin/marketplace.json "$ROOT"/plugins/*/.claude-plugin/plugin.json "$ROOT"/plugins/matrix-operator/hooks/hooks.json; do
  check "valid JSON: ${manifest#"$ROOT"/}" jq -e . "$manifest"
done

# --- skills ------------------------------------------------------------------
for art in $listed; do
  skill="$ROOT/plugins/$art/skills/$art/SKILL.md"
  check "$art: SKILL.md name matches plugin" grep -qx "name: $art" "$skill"
  check "$art: description starts with 'Use when'" grep -q '^description: Use when' "$skill"
done

echo "---"
echo "$pass passed, $fail failed"
test "$fail" -eq 0
