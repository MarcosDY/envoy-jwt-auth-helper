#!/bin/bash

# Builds docker image

DOCKER_IMAGE="envoy-jwt-auth-helper"
SERVICE_VERSION="1.0.0"
GCR_REPOSITORY="us.gcr.io/scytale-registry"

echo "Building ${DOCKER_IMAGE}"
docker build --no-cache --tag ${DOCKER_IMAGE} .

if [[ "$1" == 'push' ]]
then
  echo "Tagging image ${DOCKER_IMAGE} as ${GCR_REPOSITORY}/${DOCKER_IMAGE}:${SERVICE_VERSION}"
  docker tag ${DOCKER_IMAGE} ${GCR_REPOSITORY}/${DOCKER_IMAGE}:${SERVICE_VERSION}

  echo "Publishing image ${GCR_REPOSITORY}/${DOCKER_IMAGE}:${SERVICE_VERSION}"
  docker push ${GCR_REPOSITORY}/${DOCKER_IMAGE}:${SERVICE_VERSION}
fi
