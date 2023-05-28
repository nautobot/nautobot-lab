#!/usr/bin/env python3

import os
import django
import nautobot

# Initialize Nautobot and Django Settings.
nautobot.setup()
django.setup()

from django.contrib.auth import get_user_model
from nautobot.users.models import Token

# Create User() model instance.
User = get_user_model()

account = User(
    username=os.getenv("NAUTOBOT_USERNAME"),
    email=os.getenv("NAUTOBOT_EMAIL"),
    is_superuser=True,
    is_staff=True,
    tokens=token
)
account.set_password(
    raw_password=os.getenv("NAUTOBOT_PASSWORD")
)
account.save()

token = Token(
    key=os.getenv("NAUTOBOT_TOKEN"),
    write_enabled=True,
    user_id=account
)
token.save()
