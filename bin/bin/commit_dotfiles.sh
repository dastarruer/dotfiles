#!/bin/bash

# Add installed packages to install script
echo "Adding apt packages..."
dpkg --get-selections | awk '{print $1}' > ~/dotfiles/install/apt_packages.txt
echo "Adding snap packages..."
snap list | awk 'NR>1 {print $1}' > ~/dotfiles/install/snap_packages.txt
echo "Packages added."

# Directories to include in public repo
PUBLIC_DIRS=(
    "$HOME/dotfiles/btop"
    "$HOME/dotfiles/firefox-chrome"
    "$HOME/dotfiles/neofetch"
    "$HOME/dotfiles/polybar"
    "$HOME/dotfiles/rofi"
    "$HOME/dotfiles/wallpapers"
    "$HOME/dotfiles/cava"
    "$HOME/dotfiles/kitty"
    "$HOME/dotfiles/picom"
    "$HOME/dotfiles/pywal"
    "$HOME/dotfiles/spicetify"
    "$HOME/dotfiles/yazi"
)

CURRENT_DIR=$(pwd)
PRIVATE_DOTFILES="$HOME/dotfiles"
PUBLIC_DOTFILES="$HOME/.public-dotfiles"

# Ensure PUBLIC_DOTFILES exists
mkdir -p "$PUBLIC_DOTFILES"

cd "$PRIVATE_DOTFILES"

# Get commit message
if [ -z "$1" ]; then
  read -rp "Enter commit message: " COMMIT_MESSAGE
  if [ -z "$COMMIT_MESSAGE" ]; then
    echo "No commit message provided. Exiting..."
    exit 1
  fi
else
  COMMIT_MESSAGE="$1"
fi

# Push changes to private repo if there are any
if ! git diff --quiet || ! git diff --staged --quiet; then
    echo "Changes detected in private repo. Committing..."
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push
else
    echo "No changes in private repo. Skipping commit and push."
fi

# Sync public directories
CHANGES_DETECTED=false
for DIR in "${PUBLIC_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "Syncing $DIR..."
        if rsync -avh --progress --delete --checksum "$DIR" "$PUBLIC_DOTFILES" | grep -q '^'; then
            echo "Synced $DIR successfully."
            CHANGES_DETECTED=true
        else
            echo "No changes detected in $DIR. Skipping..."
        fi
    else
        echo "Warning: Source directory $DIR does not exist. Skipping..."
    fi
done

# Terminate early if no changes were made in the public repo
if [ "$CHANGES_DETECTED" = false ]; then
    echo "No changes detected in public repo. Exiting..."
    exit 0
fi

# Commit and push public repo if there were changes
cd "$PUBLIC_DOTFILES"
git add .
git commit -m "$COMMIT_MESSAGE"
git push

cd "$CURRENT_DIR"
echo "Finished commit with message: '$COMMIT_MESSAGE'"