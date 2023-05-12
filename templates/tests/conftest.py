import subprocess
import pynautobot
import pytest


@pytest.fixture
def nautobot():
    token = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    create_token = [
        "u=User.objects.get_or_create(username='demo', password='nautobot', is_staff=True, is_superuser=True)",
        "u=u[0]",
        "u.validated_save()",
        f"t=Token.objects.get_or_create(key='{token}', user_id=u.pk, write_enabled=True)",
        "t=t[0]",
        "t.validated_save()"
    ]
    nautobot_shell = [
        "nautobot-server",
        "nbshell",
        "--command",
        "; ".join(create_token)
    ]
    subprocess.run(nautobot_shell, check=True)
    return pynautobot.api(
        url="http://localhost:8000",
        token=f"{token}",
    )
