#!/bin/bash

# Exit on error
set -e

# --- Configuration ---
# Add the map names you want to deploy to this list.

# Currently Available Maps for ARK: Survival Ascended:
# "TheIsland_WP"
# "ScorchedEarth_WP"
# "TheCenter_WP"

# Upcoming Maps (server names are based on the original game and may change):
# "Ragnarok_WP"
# "Aberration_P"
# "Extinction"
# "Valguero_P"
# "Genesis"
# "CrystalIsles"
# "Gen2"
# "LostIsland"
# "Fjordur"

MAPS=(
    "TheIsland_WP"
    "ScorchedEarth_WP"
    "TheCenter_WP"
)


# --- Deployment Loop ---
echo "Starting deployment for all maps..."

for MAP_NAME in "${MAPS[@]}"; do
  echo "----------------------------------------"
  echo "Building and deploying: ${MAP_NAME}"
  echo "----------------------------------------"

  # Build the Docker image for the map
  echo "Building image for ${MAP_NAME}..."
  bash ./build.sh "${MAP_NAME}"
  
  # Deploy the server for the map
  echo "Deploying server for ${MAP_NAME}..."
  bash ./deploy.sh "${MAP_NAME}"

  echo "${MAP_NAME} deployed successfully."
done

echo "----------------------------------------"
echo "All maps have been deployed."
echo "----------------------------------------" 