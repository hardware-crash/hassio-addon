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

# Definiere Download-URL und Build-Version
DOWNLOAD_URL="https://github.com/awawa-dev/HyperHDR/releases/download"
BUILD_VERSION="${RELEASE}" # Annahme: RELEASE ist in der Umgebung gesetzt

# Konstruiere die Datei-URL
FILE_URL="${DOWNLOAD_URL}/v${BUILD_VERSION}/HyperHDR-${BUILD_VERSION}-Linux-${ARCH}.tar.gz"

echo "Downloading ${FILE_URL}"

# Download und Extraktion
wget --tries=3 "${FILE_URL}" -O /tmp/HyperHDR.tar.gz

# Überprüfe die heruntergeladene Datei
echo "Verifiziere die heruntergeladene Datei:"
ls -lh /tmp/HyperHDR.tar.gz

# Extrahiere nach /usr mit angepassten Berechtigungen
tar -xvz --no-same-owner --no-same-permissions -C /usr -f /tmp/HyperHDR.tar.gz

echo "Extraction complete."
