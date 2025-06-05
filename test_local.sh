#!/bin/bash

# --- Local ARK Server Test Script ---
# This script allows you to build and run an ARK server container locally for testing purposes.
# It mimics the behavior of the deployment scripts but uses local Docker instead of Google Cloud Run.

# Exit on error
set -e

# --- Configuration ---
# Load environment variables from .env file.
# Make sure you have a .env file copied from .env.example with your desired settings.
if [ -f .env ]; then
  . ./.env
else
  echo "Error: .env file not found. Please copy .env.example to .env and configure it."
  exit 1
fi

# Check if the map name is provided.
if [ -z "$1" ]; then
  echo "Usage: ./test_local.sh <map-name>"
  # You can find available map names in deploy_all.sh
  echo "Example: ./test_local.sh TheIsland_WP"
  exit 1
fi

# Get the map name from the first argument
MAP_NAME=$1
# Docker image tags must be lowercase, so we convert the map name.
LOCAL_IMAGE_NAME="ark-server-local-${MAP_NAME,,}"

echo "--- Starting Local Test for Map: ${MAP_NAME} ---"

# --- Step 1: Build the Docker Image ---
echo "Building Docker image..."
docker build -t ${LOCAL_IMAGE_NAME} ./server
echo "Image built and tagged as ${LOCAL_IMAGE_NAME}"

# --- Step 2: Run the Docker Container ---
# This step replaces 'gcloud run deploy'.
# We will run the container locally, mapping the necessary ports and environment variables.

echo "Stopping any existing container named 'ark-server-local'..."
docker stop ark-server-local >/dev/null 2>&1 || true # Stop if running
docker rm ark-server-local >/dev/null 2>&1 || true   # Remove if exists

echo "Running new container..."
echo "Server logs will be displayed below. Press CTRL+C to stop the server."

# Note: This local test does not mount a persistent volume for saved data by default.
# The server will save its data inside the container, which will be lost when the container is removed.
# For persistent local data, you could add a Docker volume mount like:
# -v ark-local-data:/server/ShooterGame/Saved/Cluster
docker run -it --rm \
  --name "ark-server-local" \
  -p 7777:7777/udp \
  -p 27020:27020/tcp \
  -e "SESSION_NAME=${SESSION_NAME}" \
  -e "SERVER_PASSWORD=${SERVER_PASSWORD}" \
  -e "SERVER_ADMIN_PASSWORD=${SERVER_ADMIN_PASSWORD}" \
  -e "MAP=${MAP_NAME}" \
  -e "CLUSTER_ID=${CLUSTER_ID}" \
  "${LOCAL_IMAGE_NAME}"

echo "--- Local Test for ${MAP_NAME} Finished ---" 