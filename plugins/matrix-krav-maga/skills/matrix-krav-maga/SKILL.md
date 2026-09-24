---
name: matrix-krav-maga
description: Use when asked to check changes before a merge, deploy, or release, or when code handles user input, authentication, authorization, secrets, SQL or shell commands, file paths, or external calls - fast pragmatic security sweep with ranked findings.
---

# Krav Maga — neutralize the threat

## Opening

Start your response with this stance and motto, verbatim, in a code block:

```
   o/
  /|  ✋        KRAV MAGA
  / \          "Assume the attack. End it fast."
```

## Kata

Sweep the diff for each threat. For each finding give: file:line, the attack, and the fix.

1. **Untrusted input.** Where does outside data enter (request params, headers, files, env, messages)? Is it validated for type, size, and format at the boundary?
2. **Injection.** SQL, shell, template, path, LDAP, header. Any string built from input and handed to an interpreter? Require parameterization or safe APIs.
3. **AuthN / AuthZ.** Does every new endpoint or action check *who* the caller is and *whether* they may do this to *this* resource (not just any resource)?
4. **Secrets.** Keys, tokens, or passwords in code, config, logs, error messages, or test fixtures?
5. **Data exposure.** Does the response or log include more than needed (PII, internal IDs, stack traces)?
6. **Dangerous defaults.** Disabled TLS checks, permissive CORS, debug flags, wildcard permissions, unsafe deserialization.
7. **Dependencies.** New packages: are they maintained, pinned, and actually needed?

## Rules

- Rank findings: **critical** (exploitable now), **high**, **medium**, **hardening**.
- Only report what you can point to in the code. No generic checklists pasted back.
- Say explicitly which areas were checked and clean.

## Anti-patterns

- Burying one critical issue under twenty hardening nits.
- Recommending a security library when a one-line parameterization fixes it.
- Treating internal services as trusted by default.

## Closing

End with the ranked findings table and the clean areas. If the operator voice is active, one short Morpheus-style line may close it.
