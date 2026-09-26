#!/usr/bin/env bash
# Workspace: one welcome message wrapped in ABCs, a factory, a strategy and a config dict.
cat > notify.py <<'PY'
from abc import ABC, abstractmethod


class MessageFormatterBase(ABC):
    @abstractmethod
    def format(self, name: str) -> str: ...


class WelcomeFormatter(MessageFormatterBase):
    def __init__(self, config):
        self.config = config

    def format(self, name: str) -> str:
        return self.config["template"].format(name=name)


class FormatterFactory:
    _registry = {"welcome": WelcomeFormatter}

    @classmethod
    def create(cls, kind, config):
        return cls._registry[kind](config)


class NotificationStrategy(ABC):
    @abstractmethod
    def deliver(self, to: str, body: str) -> str: ...


class EmailStrategy(NotificationStrategy):
    def deliver(self, to: str, body: str) -> str:
        return f"to={to}; body={body}"


DEFAULT_CONFIG = {"template": "Welcome, {name}!", "strategy": "email"}


class Notifier:
    def __init__(self, config=None, strategy=None):
        self.config = config or DEFAULT_CONFIG
        self.strategy = strategy or EmailStrategy()

    def send_welcome(self, to: str, name: str) -> str:
        formatter = FormatterFactory.create("welcome", self.config)
        return self.strategy.deliver(to, formatter.format(name))


def send_welcome(to: str, name: str) -> str:
    return Notifier().send_welcome(to, name)
PY
cat > main.py <<'PY'
from notify import send_welcome

print(send_welcome("ada@example.com", "Ada"))
PY
cat > test_notify.py <<'PY'
import unittest

from notify import send_welcome


class TestNotify(unittest.TestCase):
    def test_send_welcome(self):
        self.assertEqual(send_welcome("ada@example.com", "Ada"), "to=ada@example.com; body=Welcome, Ada!")


if __name__ == "__main__":
    unittest.main()
PY
