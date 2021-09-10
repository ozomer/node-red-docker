#!/bin/bash
export NODE_RED_VERSION=$(grep -oE "\"node-red\": \"(\w*.\w*.\w*.\w*.\w*.)" package.json | cut -d\" -f4)

echo "#########################################################################"
echo "node-red version: ${NODE_RED_VERSION}"
echo "#########################################################################"

docker buildx build --rm --no-cache \
    --platform linux/arm64,linux/amd64 \
    --build-arg ARCH=arm64_amd64 \
    --build-arg NODE_VERSION=12 \
    --build-arg NODE_RED_VERSION=${NODE_RED_VERSION} \
    --build-arg OS=buster-slim \
    --build-arg BUILD_DATE="$(date +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg TAG_SUFFIX=default \
    --file Dockerfile.debian \
    --tag orenzomer/node-red-build:v${NODE_RED_VERSION} \
    --output "type=registry" .
