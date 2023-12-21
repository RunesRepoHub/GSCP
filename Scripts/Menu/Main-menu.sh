#!/usr/bin/env bash

source ~/GSCP/Core/Core.sh

echo "Please select an option:"
echo "1) Docker Menu"
echo "2) Option 2"
echo "3) Option 3"
echo "4) Exit"

read -p "Enter your choice [1-4]: " option

case $option in
    1)
        echo "Launching Docker Menu..."
        bash $ROOT_FOLDER/$SCRIPT_FOLDER/$MENU_FOLDER/$DOCKER
        ;;
    2)
        echo "You chose Option 2"
        # Add your command for Option 2 here
        ;;
    3)
        echo -e "${Green}Updating...${NC}"
        cd $ROOT_FOLDER
        git pull
        echo -e "${Green}You can now run the script fully updated${NC}"
        exit 0
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

