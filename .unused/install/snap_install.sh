#!/usr/bin/env bash
# Install all Snap packages

# Check if the package list file exists
if [ ! -f snap_packages.txt ]; then
  echo "Error: snap_packages.txt not found."
  exit 1
fi

# Install packages from the list
echo "Installing packages..."
while read -r package; do
  if ! snap list | awk 'NR>1 {print $1}' | grep -qw "$package"; then
    echo "Installing $package..."
    sudo snap install "$package"
  else
    echo "$package is already installed, skipping..."
  fi
done < snap_packages.txt

echo "Done!"
