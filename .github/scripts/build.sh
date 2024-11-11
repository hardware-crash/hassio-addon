#!/bin/bash
set -e

ARCH_INPUT=$1

# Architektur-Mapping
case "$ARCH_INPUT" in
    amd64)
        ARCH="x86_64"
        ;;
    armhf)
        ARCH="armv6l"
        ;;
    aarch64)
        ARCH="aarch64"
        ;;
    x86_64)
        ARCH="x86_64"
        ;;
    armv6l)
        ARCH="armv6l"
        ;;
    *)
        echo "Unsupported architecture: $ARCH_INPUT"
        exit 1
        ;;
esac

# Definiere Download-URL und Build-Version
DOWNLOAD_URL="https://github.com/awawa-dev/HyperHDR/releases/download"
BUILD_VERSION="${RELEASE}" # Annahme: RELEASE ist in der Umgebung gesetzt

# Konstruiere die Datei-URL
FILE_URL="${DOWNLOAD_URL}/v${BUILD_VERSION}/HyperHDR-${BUILD_VERSION}-Linux-${ARCH}.tar.gz"

echo "Downloading ${FILE_URL}"

# Download und Extraktion
wget "${FILE_URL}" -O /tmp/HyperHDR.tar.gz

# Überprüfe die heruntergeladene Datei
echo "Verifiziere die heruntergeladene Datei:"
ls -lh /tmp/HyperHDR.tar.gz

# Extrahiere nach /usr
tar -xvz -C /usr -f /tmp/HyperHDR.tar.gz
