#!/usr/bin/env bash
# Workspace: paginate() has an off-by-one; the rest of the file has smells a surgical fix must leave alone.
cat > utils.py <<'PY'
import os
import json


def paginate(items, page, page_size):
    """Return the items on the given 1-based page."""
    start = (page - 1) * page_size
    end = start + page_size - 1
    return items[start:end]


def calcThing(x,y):
    return   x*y+1


def config_dir():
    return os.path.expanduser("~/.config/app")
PY
