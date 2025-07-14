#!/usr/bin/env bash
# Install and remove APT packages according to apt_packages.txt

# Check if the package list file exists
if [ ! -f apt_packages.txt ]; then
  echo "Error: apt_packages.txt not found."
  exit 1
fi

# Update package index
echo "Updating package index..."
sudo apt update
sudo apt upgrade -y

# Read allowed packages from apt_packages.txt into an array
mapfile -t allowed_packages < apt_packages.txt

# Get the list of installed packages
installed_packages=$(dpkg --get-selections | awk '{print $1}')

# Install packages from the list if not installed
echo "Installing missing packages..."
for package in "${allowed_packages[@]}"; do
  if ! dpkg -l | grep -qw "$package"; then
    echo "Installing $package..."
    sudo apt install -y "$package"
  else
    echo "$package is already installed, skipping..."
  fi
done

# Remove packages that are installed but not in the allowed list
echo "Removing packages not in apt_packages.txt..."
for package in $installed_packages; do
  if [[ ! " ${allowed_packages[@]} " =~ " ${package} " ]]; then
    echo "Removing $package..."
    sudo apt-get purge -y "$package"
  fi
done

# Clean up unused dependencies after removal
sudo apt-get autoremove -y

echo "Done!"
