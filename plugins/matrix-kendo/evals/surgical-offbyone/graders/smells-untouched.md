---
type: regex
target: { source: file, path: utils.py }
pattern: '(?=[\s\S]*^import json$)(?=[\s\S]*^def calcThing\(x,y\):$)(?=[\s\S]*^    return   x\*y\+1$)'
flags: m
---
