import pynautobot
import pytest


@pytest.fixture
def nautobot():
    return pynautobot.api(
        url="http://localhost:8000",
        token="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    )
