#!/usr/bin/env bash
# GSCP/Scripts/Docker-compose/CS2.sh

source ~/GSCP/Core/Core.sh

echo "Configuring and starting CS2 server using Docker..."

# Prompt the user for configuration settings
read -p "Enter the CS2 server version (e.g., 'latest', '1.2.3'): " version
read -p "Enter the server port (default is 27015): " port
read -p "Enter the amount of RAM to allocate for the server (e.g., '2G', '1024M'): " ram
read -p "Enter the URL for the server configuration file, or leave blank for default: " config_url

# Set defaults if user input is empty
version=${version:-latest}
port=${port:-27015}
ram=${ram:-1024M}

# Create a directory for the server configuration if a URL is provided
config_volume_arg=""
if [[ -n "$config_url" ]]; then
    echo "Setting up server configuration..."
    config_dir="cs2-config"
    mkdir -p "${config_dir}"
    cd "${config_dir}"
    echo "Downloading server configuration from ${config_url}..."
    curl -o server-config.cfg "${config_url}"
    cd ..
    config_volume_arg="-v $(pwd)/${config_dir}:/path/to/cs2/config"
else
    echo "Using default server configuration."
fi

# Pull the CS2 server Docker image
echo "Pulling the CS2 server Docker image..."
docker pull cs2server:${version}

# Run the CS2 server Docker container
echo "Starting the CS2 server Docker container..."
docker run -d -p ${port}:27015 -e RAM=${ram} ${config_volume_arg} --name cs2-server cs2server:${version}

echo "CS2 server is now running on port ${port} with ${ram} of RAM."
