#!/bin/bash
set -e

ARCH_INPUT=$1

# Architektur-Mapping
case "$ARCH_INPUT" in
    x86_64 | amd64)
        ARCH="x86_64"
        ;;
    armv6l | armhf)
        ARCH="armv6l"
        ;;
    aarch64)
        ARCH="aarch64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH_INPUT"
        exit 1
        ;;
esac

# Definiere weitere benötigte Argumente, falls vorhanden
DOWNLOAD_URL="https://github.com/awawa-dev/HyperHDR/releases/download"
BUILD_VERSION="${RELEASE}" # Annahme: RELEASE ist in der Umgebung gesetzt

# Docker-Build ausführen
docker build \
    --build-arg DOWNLOAD_URL="${DOWNLOAD_URL}" \
    --build-arg BUILD_VERSION="${BUILD_VERSION}" \
    --build-arg BUILD_ARCH="${ARCH}" \
    -t your-docker-repo/hyperhdr:${BUILD_VERSION}-${ARCH} .
