{...}: {
  flake.nixosModules.desktop_terminal = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.custom.wm.wm == "hyprland";
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
      wayland.windowManager.hyprland.settings = lib.mkIf hyprland {
        bind = [
          {_args = ["SUPER + RETURN" (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("footclient")'')];}
        ];
      };
    };
  };
}
