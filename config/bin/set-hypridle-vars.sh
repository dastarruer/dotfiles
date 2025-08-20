#!/usr/bin/env bash

# Check if the user passed an argument
if [[ -z "$1" ]]; then
  echo "Usage: $0 <value>"
  exit 1
fi

# Path to hypridle file
config_file="$HOME/.config/hypr/hypridle.conf"

# If the variable already exists, replace it. Otherwise append it.
if grep -q "^\$suspend_secs" "$config_file"; then
  sed -i "s/^\$suspend_secs = .*/\$suspend_secs = $1/" "$config_file"
else
  echo "\$suspend_secs = $1" >> "$config_file"
fi

echo "Updated suspend_secs to '$1' in $config_file"

# Restart hypridle
pkill hypridle && hypridle &
