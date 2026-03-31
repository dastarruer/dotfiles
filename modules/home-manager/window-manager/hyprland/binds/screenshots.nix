{
  pkgs,
  config,
  ...
}: {
  # Create the screenshots dir, deleting files older than 30 days
  systemd.user.tmpfiles.rules = [
    "d %h/Pictures/screenshots - - - 30d -"
  ];

  # Based off grimblast manual
  wayland.windowManager.hyprland.settings = let
    screenshotDir = "${config.home.homeDirectory}/Pictures/screenshots";
  in {
    # Let grim capture screen
    permission = [
      "${pkgs.grim}/bin/grim, screencopy, allow"
    ];

    env = [
      "SLURP_ARGS, -d -b ${config.lib.stylix.colors.base00}80 -B ${config.lib.stylix.colors.base05}4D -c ${config.home-manager.theme.accent} -w ${toString config.wayland.windowManager.hyprland.settings.general.border_size}"
    ];

    bind = [
      # Copysave area to your specified directory
      "SUPER, P, exec, ${pkgs.grimblast}/bin/grimblast copysave area ${screenshotDir}/$(date +'%Y-%m-%d_%H-%M-%S').png -n"

      # Copysave active window
      "SUPER+SHIFT, P, exec, ${pkgs.grimblast}/bin/grimblast copysave active ${screenshotDir}/$(date +'%Y-%m-%d_%H-%M-%S').png -n"

      # Copysave full screen
      "SUPER+CTRL, P, exec, ${pkgs.grimblast}/bin/grimblast copysave screen ${screenshotDir}/$(date +'%Y-%m-%d_%H-%M-%S').png -n"

      # OCR (Optical Character Recognition)
      ''SUPER+SHIFT, O, exec, ${pkgs.grimblast}/bin/grimblast save area - | ${pkgs.tesseract}/bin/tesseract stdin stdout | ${pkgs.wl-clipboard}/bin/wl-copy && ${pkgs.libnotify}/bin/notify-send "OCR Copied to Clipboard"''

      # Open last paste in Swappy for editing
      "SUPER, M, exec, ${pkgs.wl-clipboard}/bin/wl-paste | ${pkgs.swappy}/bin/swappy -f -"
    ];

    # Remove animations for grimblast: https://github.com/hyprwm/Hyprland/discussions/12964
    layerrule = [
      "no_anim on, match:namespace selection"
    ];
  };
}
