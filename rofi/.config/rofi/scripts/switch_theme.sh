#!/bin/bash

# Define options
OPTIONS="Catppuccin\nGruvbox"

# Show the menu and get the user's choice
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Theme switcher:")

# Add the current theme to a file so that change_wallpaper.sh knows which is the current theme 
echo "${CHOICE,,}" > $HOME/.current_theme

# Themes
BTOP=""
WAL=""
OBSIDIAN=""
SPICETIFY=""

case $CHOICE in
    "Catppuccin")
        BTOP="catppuccin"
        WAL="$HOME/.config/wal/colorschemes/catppuccin-mocha.json"
        OBSIDIAN="Catppuccin"
        SPICETIFY="catppuccin"
        ;;
    "Gruvbox")
        BTOP="gruvbox"
        WAL="base16-gruvbox-hard"
        OBSIDIAN="Material Gruvbox"
        SPICETIFY="Gruvify"
        ;;
    *)
        exit 1 # Exit if the user selects nothing or closes rofi
        ;;
esac

notify-send -t 300 "Updating pywal..."
wal --theme "$WAL"
notify-send -t 100 "Updating Firefox..."
pywalfox update
notify-send -t 500 "Changing wallpaper..."
~/bin/change_wallpaper.sh

# Change spicetify (spotify) theme 
notify-send -t 500 "Updating Spotify..."
$HOME/.spicetify/spicetify config current_theme $SPICETIFY  # For some reason i gotta specify spicetify's exact path'
$HOME/.spicetify/spicetify apply

# Change Obsidian theme 
notify-send -t 500 "Updating Obsidian..."
sed -i "s/\"cssTheme\": *\"[^\"]*\"/\"cssTheme\": \"$OBSIDIAN\"/" ~/Documents/vault/.obsidian/appearance.json
flatpak kill md.obsidian.Obsidian && flatpak run md.obsidian.Obsidian

notify-send -t 500 "Updating btop..."
# Change btop theme
sed -i "s|^color_theme *= *\"[^\"]*\"|color_theme = \"$BTOP\"|" ~/dotfiles/btop/.config/btop.conf
pkill -USR1 btop  # Refresh btop if running
