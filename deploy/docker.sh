#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin

if [ $TRAVIS_TAG ]; then
    docker build -t networktocode/nautobot-lab:"$TRAVIS_TAG" .
    docker push networktocode/nautobot-lab:"$TRAVIS_TAG"
fi

docker build -t networktocode/nautobot-lab:latest .
docker push networktocode/nautobot-lab:latest
