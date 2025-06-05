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
RUN add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y steamcmd

# Download ARK Server
RUN mkdir /server && \
    steamcmd +force_install_dir /server +login anonymous +app_update 2430930 validate +quit

# Expose ports
EXPOSE 7777/udp
EXPOSE 27020/tcp

# Set the working directory
WORKDIR /server

# Start the server
ENV SESSION_NAME="MyArkServer"
ENV SERVER_PASSWORD="MyPassword"
ENV SERVER_ADMIN_PASSWORD="MySecretAdminPassword"
# As of June 2025, the latest map is Astraeos
ENV MAP="TheIsland_WP"
ENV CLUSTER_ID="myarkcluster"

CMD exec ./ShooterGame/Binaries/Linux/ShooterGameServer "${MAP}?listen?SessionName=${SESSION_NAME}?ServerPassword=${SERVER_PASSWORD}?ServerAdminPassword=${SERVER_ADMIN_PASSWORD}" -nosteamclient -game -server -log -clusterid=${CLUSTER_ID} 