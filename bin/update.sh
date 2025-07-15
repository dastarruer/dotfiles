#!/usr/bin/env bash

cd $HOME/.dotfiles
nix flake update
$HOME/bin/commit_dotfiles.sh "Update system"
sudo nixos-rebuild switch --flake ~/.dotfiles/
