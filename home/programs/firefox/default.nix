# Check here (https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265) for more stuff
{
  inputs,
  pkgs,
  ...
}: let
  # Folder under which all firefox stuff goes
  firefoxProfile = "default";
in {
  imports = [
    ./containers.nix
    ./extensions.nix
    ./settings.nix
    ./search.nix
    ./theme
  ];

  programs.firefox = {
    enable = true;

    # Use firefox nightly
    package = inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin;
  };

  stylix.targets.firefox = {
    # Tell stylix to style this profile
    profileNames = ["${firefoxProfile}"];

    colorTheme.enable = true;
  };

  # PIP rules
  # wayland.windowManager.hyprland.settings.windowrule = [
  #   "float, title:^(Picture-in-Picture)$"
  #   "move 1492 839, title:^(Picture-in-Picture)$"
  #   "size 427 240, title:^(Picture-in-Picture)$"
  #   "pin, title:^(Picture-in-Picture)$"
  # ];
}
