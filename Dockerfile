FROM ubuntu:20.04

MAINTAINER James Williams <james.williams@networktocode.com>

ENV DEBIAN_FRONTEND=noninteractive

ENV DEBCONF_NONINTERACTIVE_SEEN=true

WORKDIR /opt/nautobot

COPY pb_nautobot_install.yml .

COPY templates templates

COPY supervisord.conf /etc/supervisord.conf

COPY tzseeds.txt .

RUN debconf-set-selections tzseeds.txt

RUN apt-get update -y && \
    apt-get install -y python3 \
    python3-psycopg2 python3-pip \
    python3-venv python3-dev \
    python3-apt postgresql libpq-dev \
    redis-server systemctl git

RUN pip3 install pip --upgrade && \
    pip install ansible==3.0.0 supervisor nautobot

RUN ansible-galaxy collection install community.postgresql

RUN ansible-playbook pb_nautobot_install.yml

RUN pip uninstall -y ansible && apt-get clean

EXPOSE 8000/tcp

VOLUME /var/lib/redis

VOLUME /var/lib/postgresql/12/main

CMD /usr/local/bin/supervisord -c /etc/supervisord.conf
