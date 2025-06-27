#!/usr/bin/env bash
# Just symlink the files here because who the hell is rebuilding every time I make a tiny change

dotfiles=$HOME/.dotfiles

# Bashrc
ln -sfn $dotfiles/bashrc/.bashrc $HOME/.bashrc

# Bin
ln -sfn $dotfiles/bin $HOME/bin

# Git config
ln -sfn "$dotfiles/gitconfig/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$dotfiles/gitconfig/.gitignore_global" "$HOME/.gitignore_global"

# Hyprland config
ln -sfn "$dotfiles/hypr" "$HOME/.config/hypr"

# Kitty config
ln -sfn "$dotfiles/kitty" "$HOME/.config/kitty"

# Neofetch
ln -sfn "$dotfiles/neofetch" "$HOME/.config/neofetch"

# Pywal
ln -sfn "$dotfiles/pywal" "$HOME/.config/wal"

# Rofi
ln -sfn "$dotfiles/rofi" "$HOME/.config/rofi"

# Starship
ln -sfn "$dotfiles/starship" "$HOME/.config/starship"

# Wallpapers
ln -sfn "$dotfiles/wallpapers" "$HOME/Pictures/wallpapers"

# Waybar
ln -sfn "$dotfiles/waybar" "$HOME/.config/waybar"

# Yazi
ln -sfn "$dotfiles/yazi" "$HOME/.config/yazi"

# Zathura
ln -sfn "$dotfiles/zathura" "$HOME/.config/zathura"


