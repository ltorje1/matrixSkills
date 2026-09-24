#!/usr/bin/env bash
# Workspace: messy, untested pricing code with two quirks callers may rely on:
# a discount of 100 or more zeroes the total, and a negative quantity yields a negative total (refund).
cat > pricing.py <<'PY'
def calc(p, q, d=None):
    t = p * q
    if d != None:
        if d > 0:
            if d < 100:
                t = t - t * d / 100
            else:
                t = 0
    return round(t, 2)


def calc_all(lines, d=None):
    tot = 0
    for l in lines:
        tot = tot + calc(l[0], l[1], d)
    return tot
PY
