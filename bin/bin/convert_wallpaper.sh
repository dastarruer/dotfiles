#!/usr/bin/env bash
# Convert wallpaper color scheme to catppuccin

WALLPAPER=$1
NAME=$1
THEME=${2:-catppuccin} # Default to catppuccin if no theme is provided

# Validate the theme selection
if [[ "$THEME" != "catppuccin" && "$THEME" != "rose-pine" && "$THEME" != "gruvbox" && "$THEME" != "tokyo-dark" ]] then
    echo "Invalid theme. Choose from: catppuccin, rose-pine, gruvbox, tokyo-storm."
    exit 1
fi

gowall convert "$WALLPAPER" -t "$THEME"
read

echo "Moving to wallpapers..."
mv ~/Pictures/gowall/$WALLPAPER ~/dotfiles/wallpapers/Pictures/wallpapers/$THEME/$NAME

echo "Committing dotfiles..."
commit_dotfiles.sh "Added $NAME wallpaper ($THEME theme)"

