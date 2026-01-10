# HELLO FUTURE ME basically spicetify on nix will not work if you also install spotify in packages.nix so yeah
# https://gerg-l.github.io/spicetify-nix/usage.html
{
  config,
  lib,
  spicePkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
in {
  imports = [
    ./extensions.nix
    ./snippets.nix
    ./theme.nix
  ];

  options = {
    home-manager.desktop.spicetify.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enableAll;
      description = "Enable spicetify, a modified version of Spotify.";
    };
  };

  config = lib.mkIf config.home-manager.desktop.spicetify.enable {
    programs.spicetify = {
      enable = true;

      # Custom apps
      enabledCustomApps = with spicePkgs.apps; [
        marketplace
      ];

      # Chromium devtools
      alwaysEnableDevTools = true;

      wayland = true;
    };

    wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
      # looks aesthetic innit
      windowrule = [
        "float on, match:class ^(spotify)$"
        "move 81 146, match:class ^(spotify)$"
        "size 1068 670, match:class ^(spotify)$"
      ];

      windowrulev2 = [
        "workspace 5 silent,match:class ^(spotify)$"
      ];
    };
  };
}
