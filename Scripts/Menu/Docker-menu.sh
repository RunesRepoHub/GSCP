#!/usr/bin/env bash

source ~/GSCP/Core/Core.sh

echo "Please select an option:"
echo "1) Arma Reforger Server"
echo "2) CS2 Server"
echo "3) Arma 3 Server"
echo "4) Minecraft Server"
echo "5) Exit"

read -p "Enter your choice [1-5]: " option

case $option in
    1)
        echo "Starting Arma Reforger Server..."
        bash $ROOT_FOLDER/$DOCKER_COMPOSE_FOLDER/$ARMA_REFORGER
        ;;
    2)
        echo "Starting CS2 Server..."
        bash $ROOT_FOLDER/$DOCKER_COMPOSE_FOLDER/$CS2
        ;;
    3)
        echo "Starting Arma 3 Server..."
        bash $ROOT_FOLDER/$DOCKER_COMPOSE_FOLDER/$ARMA3
        ;;
    4)
        echo "Starting Minecraft Server..."
        bash $ROOT_FOLDER/$DOCKER_COMPOSE_FOLDER/$MINECRAFT
        ;;
    5)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
esac

