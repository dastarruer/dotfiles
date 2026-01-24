# Installation

In the NixOS installer, run the following commands:
```sh
nix-shell -p disko
sudo disko --mode disko --flake github:dastarruer/dotfiles.#dastarruer
sudo nixos-install --no-channel-copy --no-root-password --flake github:dastarruer/dotfiles#dastarruer
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
