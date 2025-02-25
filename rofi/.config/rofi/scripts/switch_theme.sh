#!/bin/bash

# Change gtk theme
GTK_CONFIG="$HOME/dotfiles/gtk-3.0/.config/gtk-3.0/settings.ini"
NEW_THEME="Gruvbox-Yellow-Dark"
sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$NEW_THEME/" "$GTK_CONFIG"

# Save workspace layout
~/bin/save_workspace_layouts.sh

# Logout
i3-msg exit