{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./colors.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # set to the flake package for more up to date software
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # For stuff between apps like clipboard access, drag and drop, etc.
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Hyprland packages needed
  home.packages = with pkgs; [
    waybar
    swww

    # Network manager
    networkmanagerapplet
  ];

  # Symlink hyprland config
  # Do this manually because apparently symlinking a directory is too hard for home manager...
  home.activation.linkHyprland = lib.hm.dag.entryAfter ["writeBoundary"] ''
    SRC="$HOME/.dotfiles/config/hypr"
    DEST="$HOME/.config/hypr"

    # Remove existing symlink or directory
    if [ -e "$DEST" ]; then
        rm -rf "$DEST"
    fi

    # Create symlink
    ln -s "$SRC" "$DEST"
  '';
}
