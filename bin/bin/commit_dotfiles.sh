#!/bin/bash

# Add installed packages to install script
echo "Adding apt packages..."
dpkg --get-selections | awk '{print $1}' > ~/dotfiles/install/apt_packages.txt
echo "Adding snap packages..."
snap list | awk 'NR>1 {print $1}' > ~/dotfiles/install/snap_packages.txt
echo "Packages added."

# Directories to include in the public repo
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

PRIVATE_DOTFILES="$HOME/dotfiles"
PUBLIC_DOTFILES="$HOME/.public-dotfiles"

# Ensure PUBLIC_DOTFILES exists
mkdir -p "$PUBLIC_DOTFILES"

# Get commit message
if [ -z "$1" ]; then
  COMMIT_MESSAGE="stuff"
else
  COMMIT_MESSAGE="$1"
fi

# Check for changes in the private repo
cd "$PRIVATE_DOTFILES"
if [ -n "$(git status --porcelain)" ]; then
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
        rsync -avh --delete "$DIR" "$PUBLIC_DOTFILES"
        CHANGES_DETECTED=true
    else
        echo "Warning: Source directory $DIR does not exist. Skipping..."
    fi
done

# Check for changes in the public repo
cd "$PUBLIC_DOTFILES"
if [ "$CHANGES_DETECTED" = true ] && [ -n "$(git status --porcelain)" ]; then
    echo "Changes detected in public repo. Committing..."
    git add .
    git commit -m "$COMMIT_MESSAGE"
    git push
else
    echo "No changes in public repo. Skipping commit and push."
fi

echo "Finished commit with message: '$COMMIT_MESSAGE'"
