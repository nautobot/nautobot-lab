FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

ENV DEBCONF_NONINTERACTIVE_SEEN=true

WORKDIR /opt/nautobot

COPY pb_nautobot_install.yml .

COPY templates templates

COPY supervisord.conf /etc/supervisord.conf

COPY tzseeds.txt .

COPY requirements.txt .

RUN debconf-set-selections tzseeds.txt

# hadolint ignore=DL3008,DL3009
RUN apt-get update -y && \
    apt-get install -y python3 \
    python3-psycopg2 python3-pip \
    python3-venv python3-dev \
    python3-apt postgresql libpq-dev \
    redis-server systemctl git --no-install-recommends

# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir pip --upgrade && \
    pip install --no-cache-dir --requirement requirements.txt

RUN ansible-galaxy collection install community.postgresql

RUN ansible-playbook pb_nautobot_install.yml

RUN pip uninstall -y ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000/tcp

VOLUME /var/lib/redis

VOLUME /var/lib/postgresql/12/main

HEALTHCHECK CMD supervisorctl status || exit 1

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]
