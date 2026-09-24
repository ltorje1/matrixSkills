#!/usr/bin/env bash
# SessionStart: greet the user with an operator line and set the flavor-text rule for Claude.
command -v jq >/dev/null 2>&1 || exit 0
cat >/dev/null  # drain hook input; not needed

quotes_file="$(dirname "$0")/../quotes.txt"
lines=()
while IFS= read -r line; do [ -n "$line" ] && lines+=("$line"); done < "$quotes_file"
[ "${#lines[@]}" -gt 0 ] || exit 0
quote="${lines[RANDOM % ${#lines[@]}]}"

rule="When you use a skill from the-construct marketplace (kung-fu, aikido, jiu-jitsu, wing-chun, krav-maga, tai-chi, muay-thai, drunken-boxing, judo, kendo), you may add one short Morpheus-style line as an opener or closer. Keep all technical content in plain, clear prose. Do not quote film dialogue."

jq -n --arg q "$quote" --arg r "$rule" \
  '{systemMessage: $q, hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $r}}'
