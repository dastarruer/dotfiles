#!/bin/bash

# Define the main options for Rofi
main_options="Full Screenshot\nRegion Screenshot\nOCR"

# Display main options in Rofi and capture the selection
main_choice=$(echo -e "$main_options" | rofi -dmenu -p "Flameshot:")

# Handle the main choice
case "$main_choice" in
    "Region Screenshot")
        echo "Selected: Region Screenshot"
        sleep 0.3
        flameshot gui
        ;;

    "Full Screenshot")
        echo "Selected: Full Screenshot"

        # Define the secondary options for full screenshot
        full_options="Copy to Clipboard\nSave as"
        
        # Display secondary options in Rofi and capture the selection
        full_choice=$(echo -e "$full_options" | rofi -dmenu -p "Flameshot:")

        case "$full_choice" in
            "Copy to Clipboard")
                sleep 0.3
                flameshot full -c
                ;;

            "Save as")
                sleep 0.3
                flameshot full 
                ;;
            
            *)
                echo "No valid option selected for full screenshot."
                ;;
        esac
        ;;
    *)
        echo "No valid option selected."
        ;;
esac
