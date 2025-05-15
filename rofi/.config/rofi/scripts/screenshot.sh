#!/bin/bash

# Define the main options for Rofi
main_options="region screenshot\nfull screenshot\nocr"

# Display main options in Rofi and capture the selection
main_choice=$(echo -e "$main_options" | rofi -dmenu -p "Flameshot:")

# Handle the main choice
case "$main_choice" in
    "region screenshot")
        echo "Selected: Region Screenshot"
        sleep 0.3
        flameshot gui
        ;;

    "full screenshot")
        echo "Selected: Full Screenshot"

        # Define the secondary options for full screenshot
        full_options="copy to clipboard\nsave as"
        
        # Display secondary options in Rofi and capture the selection
        full_choice=$(echo -e "$full_options" | rofi -dmenu -p "Flameshot:")

        case "$full_choice" in
            "copy to clipboard")
                sleep 0.3
                flameshot full -c
                ;;

            "save as")
                sleep 0.3
                flameshot full 
                ;;
            
            *)
                echo "No valid option selected for full screenshot."
                ;;
        esac
        ;;
    "ocr")
        sleep 0.3
        flameshot gui -r | tesseract stdin stdout | xsel --clipboard --input 
        notify-send "Clipboard:" "$(xsel --clipboard --output)"
        ;;
    *)
        echo "No valid option selected."
        ;;
esac
