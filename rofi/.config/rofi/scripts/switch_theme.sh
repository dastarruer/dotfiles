#!/bin/bash

# Define options
OPTIONS="Catppuccin\nGruvbox"

# Show the menu and get the user's choice
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Theme switcher:")

# Add the current theme to a file so that change_wallpaper.sh knows which is the current theme 
echo "${CHOICE,,}" > $HOME/.current_theme

# Themes
WAL=""
OBSIDIAN=""

case $CHOICE in
    "Catppuccin")
        OBSIDIAN="Catppuccin"
        WAL="$HOME/.config/wal/colorschemes/catppuccin-mocha.json"
        ;;
    "Gruvbox")
        OBSIDIAN="Obsidian gruvbox"
        WAL="base16-gruvbox-hard"
        ;;
    *)
        exit 1 # Exit if the user selects nothing or closes rofi
        ;;
esac

wal --theme "$WAL"
pywalfox update
~/bin/change_wallpaper.sh

# Change Obsidian theme 
sed -i "s/\"cssTheme\": *\"[^\"]*\"/\"cssTheme\": \"$OBSIDIAN\"/" ~/Documents/vault/.obsidian/appearance.json
flatpak kill md.obsidian.Obsidian && flatpak run md.obsidian.Obsidian
