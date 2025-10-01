# Installation

First, install NixOS with Gnome, which sets up internet and networking for you.
After installing NixOS, clone this repo, and run `nixos-rebuild`:

```sh
git clone https://github.com/dastarruer/dotfiles .dotfiles
sudo nixos-rebuild boot --flake ~/.dotfiles --impure
```

Then after rebooting into hyprland, run:
```sh
home-manager switch --flake ~/.dotfiles --impure -b backup
```

# Issues
## Issues with flatpak   
Check `flatpak.nix` to find fixes to any issues with flatpak.

## Issues with sops
Sops is bad and bad. Move all declarations of secrets to `home.nix` which might fix the problem. Maybe not.
