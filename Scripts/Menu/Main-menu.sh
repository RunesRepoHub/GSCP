#!/usr/bin/env bash

echo "Please select an option:"
echo "1) Docker Menu"
echo "2) Option 2"
echo "3) Option 3"
echo "4) Exit"

read -p "Enter your choice [1-4]: " option

case $option in
    1)
        echo "Launching Docker Menu..."
        ./GSCP/Scripts/Menu/Docker-menu.sh
        ;;
    2)
        echo "You chose Option 2"
        # Add your command for Option 2 here
        ;;
    3)
        echo "You chose Option 3"
        # Add your command for Option 3 here
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
esac

