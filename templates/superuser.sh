#!/bin/bash

if [ "$CREATE_SUPERUSER" == "true" ]; then
  nautobot-server shell --interface python << END
from django.contrib.auth.models import User
from nautobot.users.models import Token

u=User.objects.create_superuser('${SUPERUSER_NAME}', '${SUPERUSER_EMAIL}', '${SUPERUSER_PASSWORD}')
u.save()
t=Token.objects.create(user=u, key='${SUPERUSER_API_TOKEN}')
t.save()
END

  echo > ~/nautobot.creds << END
username: ${SUPERUSER_NAME}
password: ${SUPERUSER_PASSWORD}
email: ${SUPERUSER_EMAIL}
api_token: ${SUPERUSER_API_TOKEN}
END

  chmod 400 ~/nautobot.creds
  cat ~/nautobot.creds

fi
