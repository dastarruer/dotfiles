# HELLO FUTURE ME basically spicetify on nix will not work if you also install spotify in packages.nix so yeah
# https://gerg-l.github.io/spicetify-nix/usage.html
{inputs, ...}: {
  flake.nixosModules.desktop_spicetify = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;

    hyprland = hmConfig.wayland.windowManager.hyprland;
    dunst = hmConfig.services.dunst;

    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    # Silence alerts for spotify notifications
    custom.wm.dunst.excludeTitles = lib.mkIf (config ? custom.wm && dunst.enable) ["Spotify"];

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
}
