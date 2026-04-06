# HELLO FUTURE ME basically spicetify on nix will not work if you also install spotify in packages.nix so yeah
# https://gerg-l.github.io/spicetify-nix/usage.html
{
  inputs,
  config,
  lib,
  ...
}: {
  perSystem = {system, ...}: {
    flake.nixosModules.desktop_spicetify = {...}: let
      hyprland = config.programs.hyprland;
      dunst = config.services.dunst;

      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
    in {
      home-manager.users.dastarruer = {
        imports = [
          inputs.spicetify-nix.homeManagerModules.default
        ];

        # Periodically clear spicetify cache. Sometimes (rarely) spotify will silently fail to start if cache is not cleared
        systemd.user.tmpfiles.rules = [
          "d %h/.cache/spotify - - - 5d -"
        ];

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

        home-manager.window-manager.dunst.excludeTitles = lib.mkIf dunst.enable ["Spotify"];

        wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
          # looks aesthetic innit
          windowrule = [
            "float on, match:class spotify"
            "move 81 146, match:class spotify"
            "size 1068 670, match:class spotify"

            "workspace 5 silent,match:class spotify"
          ];
        };
      };
    };
  };
}
