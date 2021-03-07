#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
docker build -t networktocode/nautobot-lab:latest .
docker push networktocode/nautobot-lab:latest
