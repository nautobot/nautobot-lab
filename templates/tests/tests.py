import pytest


def test_installed_plugins(nautobot):
    assert len(nautobot.plugins.installed_plugins()) > 1
