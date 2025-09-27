#!/usr/bin/env bash

# Check if the user passed an argument
if [[ -z "$1" ]]; then
  echo "Usage: $0 <value>"
  exit 1
fi


# Path to hypridle file
config_file="$HOME/.config/hypr/hypridle.conf"

case "$1" in
  0)
    ln -sf "$config_file/no-suspend.conf" "$HOME/.config/hypr/hypridle.conf"
    notify-send "Idle suspend disabled"
    ;;
  5)
    ln -sf "$config_file/5min.conf" "$HOME/.config/hypr/hypridle.conf"
    notify-send "Will suspend after 5 minutes"
    ;;
  30)
    ln -sf "$config_file/30min.conf" "$HOME/.config/hypr/hypridle.conf"
    notify-send "Will suspend after 30 minutes"
    ;;
  *)
    echo "Error: Invalid value '$1'. Allowed values: 0, 5, 30"
    exit 1
    ;;
esac

# Track current selection for Waybar
echo "$1" > "$XDG_RUNTIME_DIR/hypridle-timeout"

# Restart hypridle
systemctl restart hypridle.service --user
