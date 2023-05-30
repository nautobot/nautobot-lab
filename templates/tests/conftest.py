import os
import pytest
import pynautobot


@pytest.fixture
def nautobot():
    token = os.getenv("NAUTOBOT_TOKEN")

    return pynautobot.api(
        url="http://localhost:8000",
        token=f"{token}",
    )
