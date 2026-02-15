{
  pkgs,
  config,
  ...
}: {
  config = {
    # Based off grimblast manual
    wayland.windowManager.hyprland.settings = {
      env = [
        "SLURP_ARGS, -d -b ${config.lib.stylix.colors.base00}80 -B ${config.lib.stylix.colors.base05}4D -c ${config.home-manager.theme.accent} -w ${toString config.wayland.windowManager.hyprland.settings.general.border_size}"
      ];

      bind = [
        "SUPER, P, exec, ${pkgs.grimblast}/bin/grimblast copysave area -n"
        "SUPER+SHIFT, P, exec, ${pkgs.grimblast}/bin/grimblast copysave active -n"
        "SUPER+CTRL, P, exec, ${pkgs.grimblast}/bin/grimblast copysave screen -n"
        ''SUPER+SHIFT, O, exec, ${pkgs.grimblast}/bin/grimblast save area - | ${pkgs.tesseract}/bin/tesseract stdin stdout | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send "Clipboard:" "$(${pkgs.wl-clipboard}/bin/wl-paste)"''
        "SUPER, M, exec, ${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -"
      ];

      # Remove animations for grimblast: https://github.com/hyprwm/Hyprland/discussions/12964
      layerrule = [
        "no_anim on, match:namespace selection"
      ];
    };
  };
}
