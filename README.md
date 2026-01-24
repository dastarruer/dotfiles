# Installation

First, install NixOS with Gnome, which sets up internet and networking for you.
After installing NixOS, clone this repo, and run `nixos-rebuild`:

```sh
sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- \
  --flake github:dastarruer/dotfiles#<host> \
  --disk main <disk-name>
```

> ![NOTE]
> To get `<disk-name>`, run `lsblk`.

Then after rebooting into hyprland, run:

```sh
home-manager switch --flake ~/.dotfiles --impure -b backup
```

# Issues

## Issues with flatpak

Check `flatpak.nix` to find fixes to any issues with flatpak.

## Issues with sops

Sops is bad and bad. Move all declarations of secrets to `home.nix` which might fix the problem. Maybe not.
