#!/bin/bash

# Define options
OPTIONS="Catppuccin\nGruvbox"

# Show the menu and get the user's choice
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Theme switcher:")

# Add the current theme to a file so that change_wallpaper.sh knows which is the current theme 
echo "${CHOICE,,}" > $HOME/.current_theme
#
# Themes
BTOP=""
DUNST=""
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
wal --theme "$WAL"

# Pywal color file
WAL_COLORS="$HOME/.cache/wal/colors"

# Extract colors
BACKGROUND=$(sed -n '1p' "$WAL_COLORS")
FOREGROUND=$(sed -n '2p' "$WAL_COLORS")
FRAME=$(sed -n '4p' "$WAL_COLORS")
CRITICAL_FRAME=$(sed -n '9p' "$WAL_COLORS")

# Path to dunst template
DUNST_TEMPLATE="$HOME/dotfiles/dunst/.config/dunst/dunstrc.template"
DUNST_CONFIG="$HOME/.cache/wal/dunstrc"

# Replace placeholders in the template and generate the final dunstrc
# sed -e "s|__background__|$BACKGROUND|g" \
#     -e "s|__foreground__|$FOREGROUND|g" \
#     -e "s|__frame__|$FRAME|g" \
#     -e "s|__critical_frame__|$CRITICAL_FRAME|g" \
#     "$DUNST_TEMPLATE" >> "$DUNST_CONFIG"

# Restart Dunst to apply changes
pkill dunst ; dunst -conf "$DUNST_CONFIG" --startup-notification & disown

notify-send -t 300 "Updating pywal..."
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
#sed -i "s|^color_theme *= *\"[^\"]*\"|color_theme = \"$BTOP\"|" ~/dotfiles/btop/.config/btop.conf
#pkill -USR1 btop  # Refresh btop if running
