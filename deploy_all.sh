#!/bin/bash

# Exit on error
set -e

# --- Configuration ---
# Add the map names you want to deploy to this list.

# ARK: Survival Ascended Map List (as of June 2025)
# Official maps require the "_WP" suffix for the server command line.
# Custom maps like "Astraeos" may have a different naming scheme.

# --- Available Maps ---
# "TheIsland_WP"
# "ScorchedEarth_WP"
# "TheCenter_WP"
# "Aberration_WP"
# "Extinction_WP"
# "Astraeos" - The latest custom map

# --- Upcoming Maps ---
# "Ragnarok_WP"
# "Valguero_WP"

MAPS=(
    "TheIsland_WP"
    "ScorchedEarth_WP"
    "TheCenter_WP"
    "Aberration_WP"
    "Extinction_WP"
    "Astraeos"
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