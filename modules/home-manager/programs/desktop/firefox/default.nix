# Check here (https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265) for more stuff
{
  config,
  lib,
  firefoxPkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
  imports = [
    ./containers.nix
    ./settings.nix
    ./search.nix
    ./extensions
    ./theme
  ];

  options = {
    home-manager.desktop.firefox = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.home-manager.desktop.enableAll;
        description = "Enable firefox.";
      };
      profile = lib.mkOption {
        type = lib.types.str;
        default = "default";
        description = "Name of the default profile. Set to `default` by default.";
      };
    };
  };

  config = lib.mkIf config.home-manager.desktop.firefox.enable {
    programs.firefox = {
      enable = true;

      # Use firefox nightly
      package = firefoxPkgs.firefox-nightly-bin;
    };

    stylix.targets.firefox = {
      # Tell stylix to style this profile
      profileNames = ["${config.home-manager.desktop.firefox.profile}"];

      colorTheme.enable = true;
    };

    # Windowrules for picture-in-picture
    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      windowrule = [
        "float, title:^(Picture-in-Picture)$"
        "move 1492 839, title:^(Picture-in-Picture)$"
        "size 427 240, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
      ];
    };
  };
}
