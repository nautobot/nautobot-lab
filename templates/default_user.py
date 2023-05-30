#!/usr/bin/env python3

import os
import django
import nautobot

print("Initialize Nautobot and Django Settings.")
nautobot.setup()
django.setup()

from django.contrib.auth import get_user_model
from nautobot.users.models import Token

print("Create User() model instance.")
User = get_user_model()

print(f"Create {os.getenv('NAUTOBOT_USERNAME')} account.")
account = User(
    username=os.getenv("NAUTOBOT_USERNAME"),
    email=os.getenv("NAUTOBOT_EMAIL"),
    is_superuser=True,
    is_staff=True,
)
account.set_password(
    raw_password=os.getenv("NAUTOBOT_PASSWORD")
)
account.save()

print(f"Create {os.getenv('NAUTOBOT_USERNAME')} API token.")
token = Token(
    key=os.getenv("NAUTOBOT_TOKEN"),
    write_enabled=True,
    user_id=account.pk
)
token.save()
