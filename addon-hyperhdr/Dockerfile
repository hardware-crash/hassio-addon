# Stage 1: Builder
FROM ubuntu:22.04 AS builder

# Setze Build-Argumente
ARG DOWNLOAD_URL=https://github.com/awawa-dev/HyperHDR/releases/download
ARG BUILD_VERSION=20.0.0.0

# Installiere notwendige Pakete
RUN apt-get update && apt-get install -y wget tar

# Download und Extraktion von HyperHDR
RUN set -e; \
    ARCH=$(uname -m) && \
    case "$ARCH" in \
        x86_64) ARCH="x86_64" ;; \
        aarch64) ARCH="aarch64" ;; \
        armv6l) ARCH="armv6l" ;; \
        *) echo "Unsupported architecture: $ARCH"; exit 1 ;; \
    esac && \
    FILE_URL="${DOWNLOAD_URL}/v${BUILD_VERSION}/HyperHDR-${BUILD_VERSION}-Linux-${ARCH}.tar.gz" && \
    echo "Downloading ${FILE_URL}" && \
    wget --tries=3 "${FILE_URL}" -O /tmp/HyperHDR.tar.gz && \
    echo "Downloaded HyperHDR.tar.gz, size:" && \
    ls -lh /tmp/HyperHDR.tar.gz && \
    echo "Extracting HyperHDR.tar.gz..." && \
    tar -xvz --no-same-owner --no-same-permissions -C /usr -f /tmp/HyperHDR.tar.gz && \
    echo "Extraction complete."

# Stage 2: Final Image
FROM ubuntu:22.04

# Kopiere extrahierte Dateien aus dem Builder-Stage
COPY --from=builder /usr /usr

# Kopiere dein Run-Skript
COPY run.sh /

# Mache das Run-Skript ausführbar
RUN chmod a+x /run.sh

# Definiere Volume
VOLUME /config

# Definiere Entrypoint oder CMD
CMD ["/run.sh"]
