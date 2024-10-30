#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/catpuccin-wallpapers"

# Get a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Set wallpaper based on the desktop environment
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    # GNOME
    gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"
elif [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
    # KDE Plasma
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
    var allDesktops = desktops();
    for (i = 0; i < allDesktops.length; i++) {
        d = allDesktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
        d.writeConfig('Image', 'file://$WALLPAPER');
    }"
elif [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]; then
    # XFCE
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$WALLPAPER"
else
    echo "Your desktop environment is not supported by this script."
    exit 1
fi

echo "Wallpaper set to $WALLPAPER"
