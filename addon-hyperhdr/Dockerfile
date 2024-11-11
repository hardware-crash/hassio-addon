ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG DOWNLOAD_URL
ARG BUILD_VERSION
ARG BUILD_ARCH

ENV LANG C.UTF-8

# Installiere notwendige Pakete
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    git cmake build-essential \
    libasound2-dev qtbase5-dev libqt5serialport5-dev libqt5sql5-sqlite \
    libqt5svg5-dev libqt5x11extras5-dev libusb-1.0-0-dev \
    python3-minimal rpm libcec-dev libxcb-image0-dev \
    libxcb-util0-dev libxcb-shm0-dev libglvnd-dev \
    libxcb-render0-dev libxcb-randr0-dev libxrandr-dev \
    libxrender-dev libavahi-core-dev libavahi-compat-libdnssd-dev \
    libjpeg-dev libturbojpeg0-dev libssl-dev zlib1g-dev \
    ca-certificates curl wget dialog apt-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Kopiere und mache das Run-Skript ausführbar
COPY run.sh /
RUN chmod a+x /run.sh

# Erstelle das Zielverzeichnis und überprüfe es
RUN mkdir -p /opt/hyperhdr && ls -ld /opt/hyperhdr

# Download und Extraktion in /opt/hyperhdr mit angepassten Berechtigungen
RUN wget -q "${DOWNLOAD_URL}/v${BUILD_VERSION}/HyperHDR-${BUILD_VERSION}-Linux-${BUILD_ARCH}.tar.gz" -O /tmp/HyperHDR.tar.gz && \
    echo "Verifiziere die heruntergeladene Datei:" && \
    ls -lh /tmp/HyperHDR.tar.gz && \
    tar -xvz --no-same-owner --no-same-permissions -C /opt/hyperhdr -f /tmp/HyperHDR.tar.gz && \
    # Erstelle symbolische Links für die ausführbaren Dateien
    ln -s /opt/hyperhdr/bin/hyperhdr /usr/local/bin/hyperhdr && \
    ln -s /opt/hyperhdr/bin/hyperhdr-remote /usr/local/bin/hyperhdr-remote && \
    echo "Extraktion abgeschlossen." && \
    ls -l /opt/hyperhdr/bin && \
    ls -l /usr/local/bin/hyperhdr /usr/local/bin/hyperhdr-remote

VOLUME /config
EXPOSE 8090 8092 19333 19400 19444 19445
RUN echo 'Running webUI on port 8090. Port 19444-19445 exposed for json, protobuffer server (screen-cap)'
CMD [ "/run.sh" ]
