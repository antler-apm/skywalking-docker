#!/bin/bash

VERSION=6.0.0-beta

docker build --build-arg RELEASE_VERSION=$VERSION .

DOCKER_ORG=antler
DOCKER_REPO=skywalking-oap-server
OAP=$(docker images --filter 'label=image=oap' -q | head -1)

docker tag $OAP $DOCKER_ORG/$DOCKER_REPO:$VERSION
docker push $DOCKER_ORG/$DOCKER_REPO:$VERSION
