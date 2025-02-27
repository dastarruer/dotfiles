#!/bin/bash

nmcli radio wifi on

notify-send "Searching for connections..."

# Get a list of Wi-Fi networks
wifi_list=$(nmcli -t -f SSID device wifi list | grep -v '^--$' | sort -u)

# Use Rofi to display the list and capture the selection
selected_ssid=$(echo "$wifi_list" | rofi -dmenu -p -i "Select Wi-Fi")

# Exit if no SSID was selected
if [[ -z "$selected_ssid" ]]; then
  exit 0
fi

# Prompt for the Wi-Fi password using Rofi
password=$(rofi -dmenu -password -p "Enter password for $selected_ssid")

# Exit if no password was entered
if [[ -z "$password" ]]; then
  exit 0
fi

notify-send "Connecting to $selected_ssid..."

# Attempt to connect to the selected Wi-Fi with the entered password
nmcli device wifi connect "$selected_ssid" password "$password"

# Check if the connection was successful
if [[ $? -eq 0 ]]; then
  notify-send "Wi-Fi Connected" "Successfully connected to $selected_ssid"
else
  notify-send "Wi-Fi Connection Failed" "Could not connect to $selected_ssid. Check the password."
fi
