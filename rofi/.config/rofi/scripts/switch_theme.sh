#!/bin/bash

# Define options
OPTIONS="Catppuccin\nGruvbox\nRose Pine"

# Show the menu and get the user's choice
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Theme switcher:")

# Add the current theme to a file so that change_wallpaper.sh knows which is the current theme 
echo "${CHOICE// /-}" | tr '[:upper:]' '[:lower:]' > "$HOME/.current_theme"

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
        SPICETIFY="gruvbox"
        ;;
    "Rose Pine")
        BTOP="catppuccin"
        WAL="$HOME/.config/wal/colorschemes/rose-pine.json"
        OBSIDIAN="Rose Pine"
        SPICETIFY="rose-pine"
        ;;
    *)
        exit 1 # Exit if the user selects nothing or closes rofi
        ;;
esac

notify-send -t 300 "Updating pywal..."
wal --theme "$WAL"

# Restart Dunst to apply changes
DUNST_CONFIG="$HOME/.cache/wal/dunstrc"
notify-send -t 300 "Updating dunst..."
pkill dunst ; dunst -conf "$DUNST_CONFIG" --startup-notification & disown

# Update firefox
notify-send -t 100 "Updating Firefox..."
pywalfox update

# Update wallpaper
notify-send -t 500 "Changing wallpaper..."
~/bin/change_wallpaper.sh

# Update spicetify (spotify)  
notify-send -t 500 "Updating Spotify..."
$HOME/.spicetify/spicetify config color_scheme $SPICETIFY  # For some reason i gotta specify spicetify's exact path'
$HOME/.spicetify/spicetify apply

# Update Obsidian  
notify-send -t 500 "Updating Obsidian..."
sed -i "s/\"cssTheme\": *\"[^\"]*\"/\"cssTheme\": \"$OBSIDIAN\"/" ~/Documents/vault/.obsidian/appearance.json
flatpak kill md.obsidian.Obsidian && flatpak run md.obsidian.Obsidian & disown

# Update btop 
# notify-send -t 500 "Updating btop..."
#sed -i "s|^color_theme *= *\"[^\"]*\"|color_theme = \"$BTOP\"|" ~/dotfiles/btop/.config/btop.conf
#pkill -USR1 btop  # Refresh btop if running
