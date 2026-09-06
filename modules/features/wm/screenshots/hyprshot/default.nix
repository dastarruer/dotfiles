{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    screenshot = config.custom.wm.screenshot.kind;
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = config.custom.wm.wm == "hyprland";
    screenshotPath = config.custom.wm.screenshot.path;
  in
    lib.mkIf (screenshot == "hyprshot") {
      home-manager.users.dastarruer = lib.mkIf hyprland {
        wayland.windowManager.hyprland.settings = {
          env = [
            {
              _args = [
                "SLURP_ARGS"
                "-d -b ${config.lib.stylix.colors.base00}80 -B ${config.lib.stylix.colors.base05}4D -c ${config.custom.theme.accent} -w ${toString hmConfig.wayland.windowManager.hyprland.settings.config.general.border_size}"
              ];
            }
          ];

          bind = [
            # Screenshot selected region
            {
              _args = [
                "SUPER + P"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${lib.getExe pkgs.hyprshot} -m region -o ${screenshotPath} -f $(date +'%Y-%m-%d_%H-%M-%S').png")
                '')
              ];
            }

            # Screenshot active window
            {
              _args = [
                "SUPER + SHIFT + P"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${lib.getExe pkgs.hyprshot} -m window -m active -o ${screenshotPath} -f $(date +'%Y-%m-%d_%H-%M-%S').png")
                '')
              ];
            }

            # Screenshot current monitor
            {
              _args = [
                "SUPER + CTRL + P"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${lib.getExe pkgs.hyprshot} -m output -m active -o ${screenshotPath} -f $(date +'%Y-%m-%d_%H-%M-%S').png")
                '')
              ];
            }

            # Screenshot all monitors
            {
              _args = [
                "SUPER + SHIFT + CTRL + P"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${lib.getExe pkgs.hyprshot} -m output -o ${screenshotPath} --mode all")
                '')
              ];
            }

            # OCR
            {
              _args = [
                "SUPER + SHIFT + O"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${lib.getExe pkgs.hyprshot} -m region - | ${lib.getExe pkgs.tesseract} stdin stdout | ${pkgs.wl-clipboard}/bin/wl-copy && ${lib.getExe pkgs.libnotify} 'OCR Copied to Clipboard'")
                '')
              ];
            }

            # Open clipboard image in Swappy
            {
              _args = [
                "SUPER + M"
                (lib.generators.mkLuaInline ''
                  hl.dsp.exec_cmd("${pkgs.wl-clipboard}/bin/wl-copy | ${lib.getExe pkgs.swappy} -f -")
                '')
              ];
            }
          ];

          # Remove animations for hyprshot selection
          layer_rule = [
            {
              match.namespace = "selection";
              no_anim = true;
            }
          ];
        };
      };
    };
}
