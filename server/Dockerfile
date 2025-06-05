FROM ubuntu:22.04

# Set environment variables to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install SteamCMD
RUN echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y steamcmd && \
    ln -s /usr/games/steamcmd /usr/bin/steamcmd

# Download ARK Server
RUN mkdir /server && \
    steamcmd +force_install_dir /server +login anonymous +app_update 2430930 validate +quit

# Find and prepare the server executable. This is more robust than assuming a fixed path.
RUN \
    ARK_SERVER_SCRIPT=$(find /server -name "ArkAscendedServer.sh") && \
    if [ -z "$ARK_SERVER_SCRIPT" ]; then \
        echo "ERROR: ArkAscendedServer.sh not found!" >&2; \
        ls -lR /server; \
        exit 1; \
    fi && \
    chmod +x "$ARK_SERVER_SCRIPT" && \
    ln -s "$ARK_SERVER_SCRIPT" /usr/local/bin/run_ark.sh

# Expose ports
EXPOSE 7777/udp
EXPOSE 27020/tcp

# Set the working directory
WORKDIR /server

# Set environment variables for the server
ENV SESSION_NAME="MyArkServer"
ENV SERVER_PASSWORD="MyPassword"
ENV SERVER_ADMIN_PASSWORD="MySecretAdminPassword"
ENV MAP="TheIsland_WP"
ENV CLUSTER_ID="myarkcluster"

# Start the server using the symlink. The arguments will be appended by the test script.
CMD ["run_ark.sh", "${MAP}?listen?SessionName=${SESSION_NAME}?ServerPassword=${SERVER_PASSWORD}?ServerAdminPassword=${SERVER_ADMIN_PASSWORD}", "-nosteamclient", "-game", "-server", "-log", "-clusterid=${CLUSTER_ID}"] 