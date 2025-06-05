# Use a dedicated, pre-configured SteamCMD image.
FROM cm2network/steamcmd:latest

# Switch to root to install Wine and create directories
USER root

# Enable 32-bit architecture and install Wine
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends wine64 wine32 && \
    rm -rf /var/lib/apt/lists/*

# Create the server directory
RUN mkdir /server && \
    chown -R steam:steam /server

# Switch back to steam user for server installation
USER steam

# Install the ARK server (will download Windows files)
RUN /home/steam/steamcmd/steamcmd.sh \
        +force_install_dir /server \
        +login anonymous \
        +app_update 2430930 \
        +quit

# Switch back to root for final setup
USER root

# Find the Windows server executable and create the runner script
RUN ARK_SERVER_EXE=$(find /server -type f -name "ArkAscendedServer.exe") && \
    if [ -z "$ARK_SERVER_EXE" ]; then \
        echo "ERROR: ArkAscendedServer.exe not found!" >&2; \
        exit 1; \
    fi && \
    echo '#!/bin/sh' > /usr/local/bin/run_ark.sh && \
    echo "/usr/lib/wine/wine64 \"$ARK_SERVER_EXE\" \"\${MAP}?listen?SessionName=\${SESSION_NAME}?ServerPassword=\${SERVER_PASSWORD}?ServerAdminPassword=\${SERVER_ADMIN_PASSWORD}\" -nosteamclient -game -server -log \"-clusterid=\${CLUSTER_ID}\"" >> /usr/local/bin/run_ark.sh && \
    chmod +x /usr/local/bin/run_ark.sh

# --- Runtime Configuration ---
WORKDIR /server

# Set environment variables (can be overridden)
ENV SESSION_NAME="Ark_Cloud_Run_Wine"
ENV SERVER_PASSWORD="changeme"
ENV SERVER_ADMIN_PASSWORD="changeme"
ENV CLUSTER_ID="arkclusterwine"
ENV MAP="TheIsland_WP"

# Expose ports
EXPOSE 7777/udp
EXPOSE 7778/udp

# Define the entrypoint to launch the server
CMD ["/usr/local/bin/run_ark.sh"] 