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

case $CHOICE in
    "Catppuccin")
        BTOP="catppuccin"
        WAL="$HOME/.config/wal/colorschemes/catppuccin-mocha.json"
        OBSIDIAN="Catppuccin"
        ;;
    "Gruvbox")
        BTOP="gruvbox"
        WAL="base16-gruvbox-hard"
        OBSIDIAN="Material Gruvbox"
        ;;
    "Rose Pine")
        BTOP="catppuccin"
        WAL="$HOME/.config/wal/colorschemes/rose-pine.json"
        OBSIDIAN="rose-pine"
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

# Update Spicetify (Spotify)
notify-send -t 500 "Updating Spotify..."
SPOTIFY_STATUS=$(playerctl -p spotify status 2>/dev/null)
SPOTIFY_POSITION=$(playerctl -p spotify position 2>/dev/null)

$HOME/.spicetify/spicetify apply
pkill spotify
spotify &

# Wait for Spotify to start
sleep 3

# Resume playback if Spotify was playing before
if [[ "$SPOTIFY_STATUS" == "Playing" ]]; then
    sleep 1  # Allow Spotify to fully initialize
    playerctl -p spotify play
    sleep 1  # Wait before seeking
    playerctl -p spotify position "$SPOTIFY_POSITION"
fi

# Update Obsidian  
notify-send -t 500 "Updating Obsidian..."
sed -i "s/\"cssTheme\": *\"[^\"]*\"/\"cssTheme\": \"$OBSIDIAN\"/" ~/Documents/vault/.obsidian/appearance.json
flatpak kill md.obsidian.Obsidian && flatpak run md.obsidian.Obsidian & disown

# Update btop 
# notify-send -t 500 "Updating btop..."
#sed -i "s|^color_theme *= *\"[^\"]*\"|color_theme = \"$BTOP\"|" ~/dotfiles/btop/.config/btop.conf
#pkill -USR1 btop  # Refresh btop if running
