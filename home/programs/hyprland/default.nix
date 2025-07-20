{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./source
    ./hyprlock.nix
    ./hypridle.nix
    # ./plugins.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Hyprland packages needed
  home.packages = with pkgs; [
    waybar
    swww

    # Clipboard functionality
    cliphist
    wl-clipboard

    # Network manager
    networkmanagerapplet
  ];
}
