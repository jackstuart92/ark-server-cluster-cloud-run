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
ARG SESSION_NAME
ARG SERVER_PASSWORD
ARG SERVER_ADMIN_PASSWORD
ARG MAP
CMD ["./ShooterGame/Binaries/Linux/ShooterGameServer", "${MAP}?listen?SessionName=${SESSION_NAME}?ServerPassword=${SERVER_PASSWORD}?ServerAdminPassword=${SERVER_ADMIN_PASSWORD}", "-nosteamclient", "-game", "-server", "-log"] 