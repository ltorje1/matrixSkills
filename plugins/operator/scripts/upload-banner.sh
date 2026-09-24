#!/usr/bin/env bash
# PreToolUse(Skill): show the upload banner when one of the-construct's arts loads.
# Theatrics must never break a session, so every failure path exits 0 silently.
ARTS="kung-fu aikido jiu-jitsu wing-chun krav-maga tai-chi muay-thai drunken-boxing judo kendo"

command -v jq >/dev/null 2>&1 || exit 0
skill=$(jq -r '.tool_input.skill // empty' 2>/dev/null) || exit 0
art=${skill##*:}
[ -n "$art" ] || exit 0
case " $ARTS " in *" $art "*) ;; *) exit 0 ;; esac

jq -n --arg art "$art" \
  '{systemMessage: "Uploading \($art).skill [████████████████] 100%\n\"I know \($art).\""}'
