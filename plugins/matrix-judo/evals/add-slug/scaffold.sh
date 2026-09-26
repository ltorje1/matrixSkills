#!/usr/bin/env bash
# Workspace: blog code that needs a slug; a suitable helper already exists in utils/text.py.
mkdir -p utils
: > utils/__init__.py
cat > utils/text.py <<'PY'
import re
import unicodedata


def truncate(text, limit):
    return text if len(text) <= limit else text[: limit - 1] + "…"


def slugify(text):
    """Lowercase ASCII slug: 'Hello, World!' -> 'hello-world'."""
    text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode()
    text = re.sub(r"[^\w\s-]", "", text).strip().lower()
    return re.sub(r"[\s_-]+", "-", text)


def word_count(text):
    return len(text.split())
PY
cat > blog.py <<'PY'
from datetime import date


def make_post(title, body):
    return {
        "title": title,
        "body": body,
        "published": date.today().isoformat(),
    }
PY
