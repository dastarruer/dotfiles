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

  # For stuff between apps like clipboard access, drag and drop, etc.
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

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
