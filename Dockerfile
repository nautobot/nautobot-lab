FROM public.ecr.aws/ubuntu/ubuntu:22.04_stable

ARG NAUTOBOT_VERSION="2.1.4"

ARG DB_NAME="nautobot"

ARG DB_USER="nautobot"

ARG DB_PASSWORD="E1x3oasg"

ARG DB_HOST="localhost"

ARG DB_PORT="5432"

ARG NAPALM_USERNAME

ARG NAPALM_PASSWORD

ARG NAUTOBOT_USERNAME="demo"

ARG NAUTOBOT_EMAIL="opensource@networktocode.com"

ARG NAUTOBOT_PASSWORD="nautobot"

ARG NAUTOBOT_TOKEN="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

ENV NAUTOBOT_VERSION=${NAUTOBOT_VERSION}

ENV NAUTOBOT_ROOT="/opt/nautobot"

ENV PATH="$NAUTOBOT_ROOT/bin:$PATH"

ENV DB_NAME=${DB_NAME}

ENV DB_USER=${DB_USER}

ENV DB_PASSWORD=${DB_PASSWORD}

ENV DB_HOST=${DB_HOST}

ENV DB_PORT=${DB_PORT}

ENV NAPALM_USERNAME=${NAPALM_USERNAME}

ENV NAPALM_PASSWORD=${NAPALM_PASSWORD}

ENV NAUTOBOT_USERNAME=${NAUTOBOT_USERNAME}

ENV NAUTOBOT_EMAIL=${NAUTOBOT_EMAIL}

ENV NAUTOBOT_PASSWORD=${NAUTOBOT_PASSWORD}

ENV NAUTOBOT_TOKEN=${NAUTOBOT_TOKEN}

ENV DEBIAN_FRONTEND=noninteractive

ENV DEBCONF_NONINTERACTIVE_SEEN=true

WORKDIR /opt/nautobot

COPY pb_nautobot_install.yml .

COPY templates templates

# hadolint ignore=DL3008,DL3013
RUN apt-get update -y && \
    apt-get install -y tzdata --no-install-recommends && \
    ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get install -y python3 python3-psycopg2 python3-pip \
      python3-venv python3-dev python3-apt postgresql-14 \
      libpq-dev redis-server systemctl git --no-install-recommends && \
    pip3 install --no-cache-dir pip setuptools wheel --upgrade && \
    pip3 install --no-cache-dir --requirement ./templates/requirements.txt && \
    ansible-galaxy collection install community.postgresql && \
    ansible-playbook pb_nautobot_install.yml && \
    pip3 uninstall -y ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000/tcp

VOLUME /var/lib/redis

VOLUME /var/lib/postgresql/12/main

HEALTHCHECK CMD supervisorctl status || exit 1

CMD ["sh", "-c", "${NAUTOBOT_ROOT}/bin/supervisord", "-c", "/etc/supervisord.conf"]
