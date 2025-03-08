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

# Check if private repo has changes
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
        echo "Syncing up $DIR..."
        if rsync -avh --progress --delete "$DIR" "$PUBLIC_DOTFILES"; then
            echo "Synced $DIR successfully."
            CHANGES_DETECTED=true
        else
            echo "Syncing $DIR failed."
            exit 1
        fi
    else
        echo "Warning: Source directory $DIR does not exist. Skipping..."
    fi
done

# Commit and push public repo if there are changes
if [ "$CHANGES_DETECTED" = true ]; then
    cd "$PUBLIC_DOTFILES"
    if ! git diff --quiet || ! git diff --staged --quiet; then
        echo "Changes detected in public repo. Committing..."
        git add .
        git commit -m "$COMMIT_MESSAGE"
        git push
    else
        echo "No new changes in public repo. Skipping commit and push."
    fi
else
    echo "No changes detected in public repo files. Skipping commit and push."
fi

cd "$CURRENT_DIR"
echo "Finished commit with message: '$COMMIT_MESSAGE'"
