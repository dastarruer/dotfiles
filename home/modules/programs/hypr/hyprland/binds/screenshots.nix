{pkgs, ...}: {
  # Based off grimblast manual
  wayland.windowManager.hyprland.settings = {
    "bind" = [
      "SUPER, P, exec, ${pkgs.grimblast}/bin/grimblast copysave active -n"
      "SUPER+SHIFT, P, exec, ${pkgs.grimblast}/bin/grimblast copysave area -n"
      "SUPER+CTRL, P, exec, ${pkgs.grimblast}/bin/grimblast copysave screen -n"
      ''SUPER+SHIFT, O, exec, ${pkgs.grimblast}/bin/grimblast save area - | ${pkgs.tesseract}/bin/tesseract stdin stdout | ${pkgs.wl-clipboard}/bin/wl-copy && notify-send "Clipboard:" "$(${pkgs.wl-clipboard}/bin/wl-paste)"''
    ];
  };
}
