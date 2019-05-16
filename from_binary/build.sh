#!/bin/bash

VERSION=6.1.0

docker build --build-arg RELEASE_VERSION=$VERSION .

DOCKER_ORG=antler
DOCKER_REPO=skywalking-collector
SKYWALKING_COLLECTOR=$(docker images --filter 'label=image=skywalking-collector' -q | head -1)

docker tag $SKYWALKING_COLLECTOR $DOCKER_ORG/$DOCKER_REPO:$VERSION
docker push $DOCKER_ORG/$DOCKER_REPO:$VERSION

DOCKER_REPO=skywalking-ui
SKYWALKING_UI=$(docker images --filter 'label=image=skywalking-ui' -q | head -1)

docker tag $SKYWALKING_UI $DOCKER_ORG/$DOCKER_REPO:$VERSION
docker push $DOCKER_ORG/$DOCKER_REPO:$VERSION

