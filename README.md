# Installation

In the NixOS installer, run the following commands:
```sh
nix-shell -p disko
sudo disko --mode disko --flake github:dastarruer/dotfiles#dastarruer
sudo nixos-install --no-channel-copy --no-root-password --flake github:dastarruer/dotfiles#dastarruer
```

Then after rebooting into hyprland, run:

```sh
home-manager switch --flake ~/.dotfiles --impure -b backup
```

Reboot, and then run the following to set up secrets:

```sh
sudo nixos-rebuild switch --flake ~/.dotfiles#dastarruer --impure
home-manager switch --flake ~/.dotfiles --impure -b backup
```
