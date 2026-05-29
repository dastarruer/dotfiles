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

    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in {
    # Silence alerts for spotify notifications
    custom.wm.notifications.excludeTitles = ["Spotify"];

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
        window_rule = [
          {
            match.class = "Spotify";
            move = lib.generators.mkLuaInline "{81, 146}";
            size = lib.generators.mkLuaInline "{1068, 670}";
            workspace = "5 silent";
            float = true;
          }
        ];
      };
    };
  };
}
