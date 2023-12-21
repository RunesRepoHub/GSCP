#!/usr/bin/env bash

source ~/GSCP/Core/Core.sh

# This script will configure and start a Docker container running a Minecraft server with mod support.

echo "Welcome to the Minecraft Docker setup script with mod support!"

# Prompt the user for configuration settings
read -p "Enter the Minecraft server version (e.g., 'latest', '1.16.3'): " version
read -p "Enter the server port (default is 25565): " port
read -p "Enter the amount of RAM to allocate for the server (e.g., '2G', '1024M'): " ram
read -p "Enter the URL for the mods (zip file), or leave blank for no mods: " mod_url

# Set defaults if user input is empty
version=${version:-latest}
port=${port:-25565}
ram=${ram:-1024M}

# Create a directory for mods if a URL is provided
if [[ -n "$mod_url" ]]; then
    echo "Setting up mods..."
    mods_dir="mods"
    mkdir -p "${mods_dir}"
    cd "${mods_dir}"
    echo "Downloading mods from ${mod_url}..."
    curl -o mods.zip "${mod_url}"
    unzip mods.zip
    rm mods.zip
    cd ..
    mod_volume_arg="-v $(pwd)/${mods_dir}:/data/mods"
else
    mod_volume_arg=""
    echo "No mods will be installed."
fi

# Pull the Minecraft server Docker image
echo "Pulling the itzg/minecraft-server Docker image..."
docker pull itzg/minecraft-server:${version}

# Run the Minecraft server Docker container with mod support
echo "Starting the Minecraft server Docker container with mod support..."
docker run -d -p ${port}:25565 -e MEMORY=${ram} -e EULA=TRUE ${mod_volume_arg} --name mc-server itzg/minecraft-server:${version}

echo "Minecraft server is now running on port ${port} with ${ram} RAM."

