{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./binds

    ./colors.nix
    ./windowrules.nix
    ./misc.nix
    ./layerrules.nix
    ./input.nix
    ./decoration.nix
    ./autostart.nix
    # ./plugins.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # set to the flake package for more up to date software
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # For stuff between apps like clipboard access, drag and drop, etc.
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  home = {
    # Use wayland
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
