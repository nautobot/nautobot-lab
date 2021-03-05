FROM ubuntu:latest

MAINTAINER James Williams <james.williams@networktocode.com>

RUN apt-get update -y && apt-get install -y git python3 python3-psycopg2 python3-pip python3-venv python3-dev

RUN pip3 install pip --upgrade

RUN pip install ansible==3.0.0 supervisor

RUN ansible-galaxy collection install community.postgresql

WORKDIR /opt/nautobot

COPY pb.yaml .
COPY templates .

RUN ansible-playbook pb.yaml

# RUN sudo -u nautobot /opt/nautobot/venv/bin/nautobot-server makemigrations --config=/opt/nautobot/nautobot_config.py
# 
# RUN sudo -u nautobot /opt/nautobot/venv/bin/nautobot-server migrate --config=/opt/nautobot/nautobot_config.py
# 
# RUN sudo -u nautobot /opt/nautobot/venv/bin/nautobot-server collectstatic --config=/opt/nautobot/nautobot_config.py

EXPOSE 8000/tcp
EXPOSE 8001/tcp
