{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./source
    ./hyprlock.nix
    ./plugins.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
