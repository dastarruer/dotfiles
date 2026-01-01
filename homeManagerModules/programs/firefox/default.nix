# Check here (https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265) for more stuff
{
  config,
  lib,
  firefoxPkgs,
  ...
}: {
  imports = [
    ./containers.nix
    ./settings.nix
    ./search.nix
    ./extensions
    ./theme
  ];

  options = {
    myPrograms.firefox = {
      enable = lib.mkEnableOption "Enable firefox .";
      profile = lib.mkOption {
        type = lib.types.str;
        default = "default";
        description = "Name of the default profile. Set to `default` by default.";
      };
    };
  };

  config = lib.mkIf config.myPrograms.firefox.enable {
    programs.firefox = {
      enable = true;

      # Use firefox nightly
      package = firefoxPkgs.firefox-nightly-bin;
    };

    stylix.targets.firefox = {
      # Tell stylix to style this profile
      profileNames = ["${config.myPrograms.firefox.profile}"];

      colorTheme.enable = true;
    };

    # Windowrules for picture-in-picture
    wayland.windowManager.hyprland.settings = {
      windowrule = [
        "float, title:^(Picture-in-Picture)$"
        "move 1492 839, title:^(Picture-in-Picture)$"
        "size 427 240, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
      ];
    };
  };
}
