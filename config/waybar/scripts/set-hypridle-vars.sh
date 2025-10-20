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
    ln -sf "$HOME/.dotfiles/config/hypr/hypridle/no-suspend.conf" "$config_file"
    notify-send "Idle suspend disabled"
    ;;
  5)
    ln -sf "$HOME/.dotfiles/config/hypr/hypridle/5min.conf" "$config_file"
    notify-send "Will suspend after 5 minutes"
    ;;
  30)
    ln -sf "$HOME/.dotfiles/config/hypr/hypridle/30min.conf" "$config_file"
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
