#!/usr/bin/env bash
# GSCP/Scripts/Docker-compose/Arma3.sh

source ~/GSCP/Core/Core.sh

echo "Configuring and starting an Arma 3 server using Docker with mods support..."

# Prompt the user for configuration settings
read -p "Enter the Arma 3 server version (e.g., 'latest', '1.98.146373'): " version
read -p "Enter the server port (default is 2302): " port
read -p "Enter the amount of RAM to allocate for the server (e.g., '4G', '4096M'): " ram
read -p "Enter the URL for the mods (zip file), or leave blank for no mods: " mod_url

# Set defaults if user input is empty
version=${version:-latest}
port=${port:-2302}
ram=${ram:-4096M}

# Create a directory for mods if a URL is provided
if [[ -n "$mod_url" ]]; then
    echo "Setting up mods..."
    mods_dir="arma3-mods"
    mkdir -p "${mods_dir}"
    cd "${mods_dir}"
    echo "Downloading mods from ${mod_url}..."
    curl -o mods.zip "${mod_url}"
    unzip mods.zip
    rm mods.zip
    cd ..
    mod_volume_arg="-v $(pwd)/${mods_dir}:/arma3/mods"
else
    mod_volume_arg=""
    echo "No mods will be installed."
fi

# Pull the Arma 3 server Docker image
echo "Pulling the Arma 3 server Docker image..."
docker pull armaserver/arma3:${version}

# Run the Arma 3 server Docker container with mod support
echo "Starting the Arma 3 server Docker container with mod support..."
docker run -d -p ${port}:2302 -p ${port}:2303 -p ${port}:2304 -p ${port}:2305 -e RAM=${ram} ${mod_volume_arg} --name arma3-server armaserver/arma3:${version}

echo "Arma 3 server is now running on port ${port} with ${ram} of RAM."
