#!/usr/bin/env bash
# GSCP/Scripts/Docker-compose/Arma-reforger.sh

echo "Configuring and starting an Arma Reforger server using Docker with mods support..."

# Prompt the user for configuration settings
read -p "Enter the Arma Reforger server version (e.g., 'latest', '1.0.0'): " version
read -p "Enter the server port (default is 2002): " port
read -p "Enter the amount of RAM to allocate for the server (e.g., '4G', '4096M'): " ram
read -p "Enter the URL for the mods (zip file), or leave blank for no mods: " mod_url

# Set defaults if user input is empty
version=${version:-latest}
port=${port:-2002}
ram=${ram:-4096M}

# Create a directory for mods if a URL is provided
if [[ -n "$mod_url" ]]; then
    echo "Setting up mods..."
    mods_dir="arma-reforger-mods"
    mkdir -p "${mods_dir}"
    cd "${mods_dir}"
    echo "Downloading mods from ${mod_url}..."
    curl -o mods.zip "${mod_url}"
    unzip mods.zip
    rm mods.zip
    cd ..
    mod_volume_arg="-v $(pwd)/${mods_dir}:/arma-reforger/mods"
else
    mod_volume_arg=""
    echo "No mods will be installed."
fi

# Pull the Arma Reforger server Docker image
echo "Pulling the Arma Reforger server Docker image..."
docker pull reforger/arma-server:${version}

# Run the Arma Reforger server Docker container with mod support
echo "Starting the Arma Reforger server Docker container with mod support..."
docker run -d -p ${port}:2002 -p ${port}:2003 -p ${port}:2004 -p ${port}:2005 -e RAM=${ram} ${mod_volume_arg} --name arma-reforger-server reforger/arma-server:${version}

echo "Arma Reforger server is now running on port ${port} with ${ram} of RAM."
