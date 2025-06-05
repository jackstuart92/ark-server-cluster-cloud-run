#!/bin/bash

# Exit on error
set -e

# Load environment variables from .env file
if [ -f .env ]; then
  . ./.env
fi

# Check if the map name is provided
if [ -z "$1" ]; then
  echo "Usage: ./deploy.sh <map-name>"
  exit 1
fi

# Get the map name from the first argument
MAP_NAME=$1

# Get the GCP project ID
PROJECT_ID=$(gcloud config get-value project)

# Define the image name
IMAGE_NAME="gcr.io/${PROJECT_ID}/ark-server-${MAP_NAME}"

# Deploy the container to Cloud Run
gcloud run deploy "ark-server-${MAP_NAME}" \
  --image="${IMAGE_NAME}" \
  --platform="managed" \
  --region="europe-west2" \
  --port="7777" \
  --cpu="2" \
  --memory="8Gi" \
  --no-allow-unauthenticated \
  --min-instances=1 \
  --set-env-vars="SESSION_NAME=${SESSION_NAME},SERVER_PASSWORD=${SERVER_PASSWORD},SERVER_ADMIN_PASSWORD=${SERVER_ADMIN_PASSWORD},MAP=${MAP_NAME},CLUSTER_ID=${CLUSTER_ID}" \
  --volume name=shared-ark-data,gcs,bucket=${GCS_BUCKET_NAME} \
  --mount name=shared-ark-data,path=/server/ShooterGame/Saved/Cluster

echo "Successfully deployed ${IMAGE_NAME} to Cloud Run" 