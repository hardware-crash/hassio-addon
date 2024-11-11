#!/bin/sh
set -e
ARCH=$1

# Überprüfe, ob ARCH übergeben wurde
if [ -z "$ARCH" ]; then
    echo "Usage: $0 <architecture>"
    exit 1
fi

# Überprüfe, ob die Build-Architektur unterstützt wird
case "$ARCH" in
    x86_64 | amd64 | aarch64 | armhf)
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Führe den Docker-Builder aus
docker run --rm --privileged \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    -v ${GITHUB_WORKSPACE:-$(PWD)}/addon-hyperhdr:/data \
    homeassistant/amd64-builder \
    --target /data \
    --docker-user "${DOCKER_USER}" \
    --docker-password "${DOCKER_PASSWORD}" \
    --no-latest \
    --${ARCH:-all}
