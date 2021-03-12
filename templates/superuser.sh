#!/bin/bash

SUPERUSER_NAME="demo"
SUPERUSER_EMAIL="nautobot@example.com"
SUPERUSER_PASSWORD="nautobot"
SUPERUSER_API_TOKEN="abcdef1234567890abcdef1234567890"

nautobot-server shell --interface python << END

from django.contrib.auth.models import User
from nautobot.users.models import Token
u=User.objects.create_superuser('${SUPERUSER_NAME}', '${SUPERUSER_EMAIL}', '${SUPERUSER_PASSWORD}')
t=Token.objects.create(user=u, key='${SUPERUSER_API_TOKEN}')
u.save()
t.save()
