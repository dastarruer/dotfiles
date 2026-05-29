{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = config.custom.wm.wm == "hyprland";
  in {
    home-manager.users.dastarruer = lib.mkIf hyprland {
      # Create the screenshots dir, deleting files older than 30 days
      systemd.user.tmpfiles.rules = [
        "d %h/Pictures/screenshots - - - 30d -"
      ];

      # Based off grimblast manual
      wayland.windowManager.hyprland.settings = let
        screenshotDir = "${config.home-manager.users.dastarruer.home.homeDirectory}/Pictures/screenshots";
      in {
        # Let grim capture screen
        permission = [
          {
            binary = "${lib.getExe pkgs.grim}";
            type = "screencopy";
            mode = "allow";
          }
        ];

        env = [
          {
            _args = [
              "SLURP_ARGS"
              "-d -b ${config.lib.stylix.colors.base00}80 -B ${config.lib.stylix.colors.base05}4D -c ${config.custom.theme.accent} -w ${toString hmConfig.wayland.windowManager.hyprland.settings.config.general.border_size}"
            ];
          }
        ];

        bind = [
          # Copysave area to your specified directory
          {
            _args = [
              "SUPER + P"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.grimblast}/bin/grimblast copysave area ${screenshotDir}/$(date +'%Y-%m-%d_%H-%M-%S').png -n")'')
            ];
          }
          # Copysave active window
          {
            _args = [
              "SUPER + SHIFT + P"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.grimblast}/bin/grimblast copysave active ${screenshotDir}/$(date +'%Y-%m-%d_%H-%M-%S').png -n")'')
            ];
          }
          # Copysave full screen
          {
            _args = [
              "SUPER + CTRL + P"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.grimblast}/bin/grimblast copysave output ${screenshotDir}/$(date +'%Y-%m-%d_%H-%M-%S').png -n")'')
            ];
          }
          # Copysave all monitors
          {
            _args = [
              "SUPER + SHIFT + CTRL + P"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.grimblast}/bin/grimblast copysave screen ${screenshotDir}/$(date +'%Y-%m-%d_%H-%M-%S').png -n")'')
            ];
          }

          # OCR (Optical Character Recognition)
          {
            _args = [
              "SUPER + SHIFT + O"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.grimblast}/bin/grimblast save area - | ${pkgs.tesseract}/bin/tesseract stdin stdout | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send 'OCR Copied to Clipboard'")'')
            ];
          }
          # Open last paste in Swappy for editing
          {
            _args = [
              "SUPER + M"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -")'')
            ];
          }
        ];

        # Remove animations for grimblast: https://github.com/hyprwm/Hyprland/discussions/12964
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
