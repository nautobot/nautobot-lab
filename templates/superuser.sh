#!/bin/bash

if [ "$CREATE_SUPERUSER" == "true" ]; then

  nautobot-server shell --interface python << END
import os
from django.contrib.auth.models import User
from nautobot.users.models import Token

u=User.objects.filter(username=os.getenv('SUPERUSER_NAME'))

if not u:
  u=User.objects.create_superuser(
    os.getenv('SUPERUSER_NAME'),
    os.getenv('SUPERUSER_EMAIL'),
    os.getenv('SUPERUSER_PASSWORD')
  )
  t=Token.objects.create(user=u, key=os.getenv('SUPERUSER_API_TOKEN'))
  u.save()
  t.save()

END

fi
