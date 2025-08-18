#!/usr/bin/env bash

# Check if the user passed an argument
if [[ -z "$1" ]]; then
  echo "Usage: $0 <value>"
  exit 1
fi

# Path to hypridle variables file
config_file="$HOME/.config/hypr/hypridle-variables.conf"

# Write the argument into the file
echo "\$screen_off_secs = 300
\$suspend_secs = $1" > "$config_file"

echo "Wrote '$1' to $config_file"

# Reload hyprland
hyprctl reload
