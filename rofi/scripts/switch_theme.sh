#!/usr/bin/env bash

# Define options
OPTIONS="Catppuccin\nGruvbox\nRose Pine\nTokyo Night Storm"

# Show the menu and get the user's choice
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Theme switcher:")

# Add the current theme to a file so that change_wallpaper.sh knows which is the current theme 
echo "${CHOICE// /-}" | tr '[:upper:]' '[:lower:]' > "$HOME/.current_theme"

# Themes
BTOP=""
WAL=""
OBSIDIAN=""
GTK="Mint-Y-Dark-Purple"

case $CHOICE in
    "Catppuccin")
        WAL="$HOME/.config/wal/colorschemes/catppuccin-mocha.json"
        OBSIDIAN="Catppuccin"
        GTK="Catppuccin-Dark"
        ;;
    "Gruvbox")
        WAL="base16-gruvbox-hard"
        OBSIDIAN="Material Gruvbox"
        GTK="Gruvbox-Dark"
        ;;
    "Rose Pine")
        WAL="$HOME/.config/wal/colorschemes/rose-pine.json"
        OBSIDIAN="rose-pine"
        ;;
    "Tokyo Night Storm")
        WAL="tokyonight-night"
	OBSIDIAN="Tokyo Night"
	;;
    *)
        exit 1 # Exit if the user selects nothing or closes rofi
        ;;
esac

notify-send -t 300 "Updating pywal..."
wal --theme "$WAL" --contrast 4.5

# Symlink a bunch of files
ln -sfn $HOME/.cache/wal/zathurarc $HOME/.config/zathura/zathurarc
# ln -sf $HOME/.cache/wal/colors-spicetify.ini $HOME/.config/spicetify/Themes/Onepunch/color.ini
ln -sfn $HOME/.cache/wal/dunstrc $HOME/.config/dunstrc

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

# Update GTK
sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK/" ~/.config/gtk-3.0/settings.ini

# Optionally send a reload signal to xfsettingsd if you're on XFCE
killall -SIGUSR1 xfsettingsd 2>/dev/null

# Update Obsidian
notify-send -t 500 "Updating Obsidian..."
sed -i "s/\"cssTheme\": *\"[^\"]*\"/\"cssTheme\": \"$OBSIDIAN\"/" ~/Documents/vault/.obsidian/appearance.json
pkill -f obsidian/app.asar && obsidian & disown

source ~/.config/fish/config.fish
