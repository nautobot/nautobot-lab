FROM public.ecr.aws/ubuntu/ubuntu:20.04_stable 

ENV NAUTOBOT_VERSION="1.2.8"

ENV NAUTOBOT_ROOT="/opt/nautobot"

ENV PATH="$NAUTOBOT_ROOT/bin:$PATH"

ENV DB_NAME="nautobot"

ENV DB_USER="nautobot"

ENV DB_PASSWORD="E1x3oasg"

ENV DB_HOST="localhost"

ENV DB_PORT="5432"

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
      python3-venv python3-dev python3-apt postgresql-12 \
      libpq-dev redis-server systemctl git --no-install-recommends && \
    pip3 install --no-cache-dir pip --upgrade && \
    pip install --no-cache-dir --requirement ./templates/requirements.txt && \
    ansible-galaxy collection install community.postgresql && \
    ansible-playbook pb_nautobot_install.yml && \
    pip uninstall -y ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000/tcp

VOLUME /var/lib/redis

VOLUME /var/lib/postgresql/12/main

HEALTHCHECK CMD supervisorctl status || exit 1

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]
