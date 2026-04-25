{...}: {
  flake.nixosModules.desktop_terminal = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = hmConfig.wayland.windowManager.hyprland;
    terminal = config.custom.desktop.terminal;
  in {
    home-manager.users.dastarruer = lib.mkIf (terminal == "foot") {
      programs.foot = {
        enable = true;
        # This starts the foot --server mode via systemd
        server.enable = true;

        settings = {
          main = {
            pad = "20x20";
          };

          scrollback.lines = 10000;

          cursor = {
            style = "block";
            blink = "no";
          };

          mouse.hide-when-typing = "yes";

          tweak = {
            # Disable ligatures (if using a font that supports them)
            font-monospace-warn = "no";
          };
        };
      };

      # Use footclient for fast window creation (talks to the systemd server)
      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        bind = [
          "SUPER, RETURN, exec, footclient"
        ];

        "exec-once" = [
          # For some reason, the systemd foot service does not start properly on startup. This is a workaround
          "${pkgs.systemd}/bin/systemctl --user start foot.service"
        ];
      };
    };
  };
}
