#!/usr/bin/env bash
# PreToolUse(Skill): show the upload banner when one of the-construct's arts loads.
# Theatrics must never break a session, so every failure path exits 0 silently.
ARTS="matrix-kung-fu matrix-aikido matrix-jiu-jitsu matrix-wing-chun matrix-krav-maga matrix-tai-chi matrix-muay-thai matrix-drunken-boxing matrix-judo matrix-kendo"

command -v jq >/dev/null 2>&1 || exit 0
skill=$(jq -r '.tool_input.skill // empty' 2>/dev/null) || exit 0
name=${skill##*:}
[ -n "$name" ] || exit 0
case " $ARTS " in *" $name "*) ;; *) exit 0 ;; esac
art=${name#matrix-}

jq -n --arg art "$art" \
  '{systemMessage: "Uploading \($art).skill [████████████████] 100%\n\"I know \($art).\""}'
