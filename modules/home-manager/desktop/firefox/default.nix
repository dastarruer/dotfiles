# Check here (https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265) for more stuff
{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
  imports = [
    ./containers.nix
    ./settings.nix
    ./search.nix
    ./extensions
    ./theme.nix
  ];

  options = {
    home-manager.desktop.firefox = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.home-manager.desktop.enable;
        description = "Enable firefox.";
      };
      profile = lib.mkOption {
        type = lib.types.str;
        default = "default";
        description = "Name of the default profile.";
      };
      deckFixes = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Apply Steam Deck specific Firefox settings.";
      };
    };
  };

  config = lib.mkIf config.home-manager.desktop.firefox.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };

    # stylix.targets.firefox = {
    #   # Tell stylix to style this profile
    #   profileNames = ["${config.home-manager.desktop.firefox.profile}"];

    #   colorTheme.enable = true;
    # };

    # Windowrules for picture-in-picture
    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      windowrule = [
        "float on, match:title Picture-in-Picture"
        "move 1492 839, match:title Picture-in-Picture"
        "size 427 240, match:title Picture-in-Picture"
        "pin on, match:title Picture-in-Picture"
      ];
    };
  };
}
