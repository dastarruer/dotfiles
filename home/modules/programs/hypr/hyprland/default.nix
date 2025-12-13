{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./colors.nix
    ./windowrules.nix
    ./misc.nix
    ./layerrules.nix
    ./keybinds.nix
    ./input.nix
    ./decoration.nix
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
    # Hyprland packages needed
    packages = with pkgs; [
      waybar
      swww
      jq
      socat

      # Network manager
      networkmanagerapplet
    ];

    # This line does not do anything, so this env variable is declared in config.fish
    # sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
