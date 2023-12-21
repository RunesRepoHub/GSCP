#!/bin/bash

echo "CS2 Dedicated Server Setup Script"
echo "---------------------------------"

# Prompt for Steam credentials
read -p "Enter your Steam username: " STEAMUSER
read -sp "Enter your Steam password: " ACCOUNTPASSWORD
echo ""

# Create named volume for SteamCMD login session
echo "Creating named volume for SteamCMD login session..."
docker volume create steamcmd_login_volume

# Activate SteamCMD login session and wait for it to finish
echo "Activating SteamCMD login session..."
docker run -it --rm \
  -v "steamcmd_login_volume:/home/steam/Steam" \
  cm2network/steamcmd \
  bash -c '/home/steam/steamcmd/steamcmd.sh +login "$STEAMUSER" "$ACCOUNTPASSWORD" +quit'

# Set up CS2 dedicated server data directory
echo "Setting up CS2 dedicated server data directory..."
mkdir -p "$(pwd)/cs2-data"
chmod 777 "$(pwd)/cs2-data"

# Run CS2 dedicated server
echo "Running CS2 dedicated server..."
docker run -d --net=host \
  -v "$(pwd)/cs2-data:/home/steam/cs2-dedicated/" \
  -v "steamcmd_login_volume:/home/steam/Steam" \
  --name=cs2-dedicated -e STEAMUSER="$STEAMUSER" cm2network/cs2

echo "CS2 Dedicated Server is now running."
