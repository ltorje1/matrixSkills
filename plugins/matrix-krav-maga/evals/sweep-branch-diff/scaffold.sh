#!/usr/bin/env bash
# Workspace: git repo whose feature branch plants three security issues and one clean change.
set -e
g() { git -c user.name=eval -c user.email=eval@example.com "$@"; }
git init -q -b main
cat > app.py <<'PY'
def format_currency(cents):
    return f"{cents / 100:.2f}"
PY
g add . && g commit -qm "initial"
git checkout -qb feature
cat > orders.py <<'PY'
import sqlite3

PAYMENTS_API_KEY = "pk-prod-7f3a9c2e1b4d8a60"


def search_orders(db: sqlite3.Connection, customer_name: str):
    query = "SELECT id, total FROM orders WHERE customer = '" + customer_name + "'"
    return db.execute(query).fetchall()


def get_order(db: sqlite3.Connection, current_user_id: int, order_id: int):
    row = db.execute("SELECT id, owner_id, total FROM orders WHERE id = ?", (order_id,)).fetchone()
    return row
PY
cat > app.py <<'PY'
def format_currency(cents):
    return f"{cents / 100:,.2f}"
PY
g add . && g commit -qm "orders: search and lookup"
