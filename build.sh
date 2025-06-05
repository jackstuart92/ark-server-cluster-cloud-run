#!/bin/bash

# Exit on error
set -e

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

# Check if the map name is provided
if [ -z "$1" ]; then
  echo "Usage: ./build.sh <map-name>"
  exit 1
fi

# Get the map name from the first argument
MAP_NAME=$1

# Get the GCP project ID
PROJECT_ID=$(gcloud config get-value project)

# Define the image name
IMAGE_NAME="gcr.io/${PROJECT_ID}/ark-server-${MAP_NAME}"

# Build the Docker image
docker build \
  --build-arg "SESSION_NAME=${SESSION_NAME}" \
  --build-arg "SERVER_PASSWORD=${SERVER_PASSWORD}" \
  --build-arg "SERVER_ADMIN_PASSWORD=${SERVER_ADMIN_PASSWORD}" \
  --build-arg "MAP=${MAP_NAME}" \
  -t ${IMAGE_NAME} ./server

# Push the Docker image to GCR
docker push ${IMAGE_NAME}

echo "Successfully built and pushed ${IMAGE_NAME}" 