#!/bin/bash

# Theme to apply (from argument)
THEME_NAME="$1"

if [ -z "$THEME_NAME" ]; then
    echo "Usage: $0 <ThemeName>"
    exit 1
fi

# Set the GTK theme via gsettings
gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"

# If xsettingsd is running, restart it to reload settings
if pgrep xsettingsd > /dev/null; then
    killall xsettingsd
    sleep 0.5
    xsettingsd &
fi

# Optionally send a reload signal to xfsettingsd if you're on XFCE
killall -SIGUSR1 xfsettingsd 2>/dev/null

echo "GTK theme switched to '$THEME_NAME' and settings reloaded."
