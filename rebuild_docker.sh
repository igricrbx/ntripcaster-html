#!/bin/bash
set -xe

# Require script to be run as sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (sudo)" >&2
    exit 1
fi

# Check if container exists
if docker ps -a --format '{{.Names}}' | grep -q '^ntripcaster$'; then
    docker stop ntripcaster
    docker rm ntripcaster
fi

docker build -t ntripcaster .
docker run -d --name ntripcaster -p 2101:2101 ntripcaster