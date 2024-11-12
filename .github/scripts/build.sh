#!/bin/sh
set -e
ARCH=$1

# Überprüfe, ob ARCH übergeben wurde
if [ -z "$ARCH" ]; then
    echo "Usage: $0 <architecture>"
    exit 1
fi

# Architektur-Mapping und Auswahl des richtigen Builder-Images
case "$ARCH" in
    x86_64 | amd64)
        BUILDER_IMAGE="homeassistant/amd64-builder"
        ARCH_FLAG="--amd64"
        ;;
    armv6l | armhf)
        BUILDER_IMAGE="homeassistant/armv7-builder"
        ARCH_FLAG="--armv7"
        ;;
    aarch64)
        BUILDER_IMAGE="homeassistant/aarch64-builder"
        ARCH_FLAG="--aarch64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Führe den Docker-Builder aus ohne das unbekannte Argument
docker run --rm --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v ${GITHUB_WORKSPACE:-$(PWD)}/addon-hyperhdr:/data \
    ${BUILDER_IMAGE} \
    --target /data \
    --docker-user "${DOCKER_USER}" \
    --docker-password "${DOCKER_PASSWORD}" \
    --no-latest \
    ${ARCH_FLAG}
