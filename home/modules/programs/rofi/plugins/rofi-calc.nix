{pkgs, ...}: {
  programs.rofi.plugins = with pkgs; [
    # Install it like this because wayland (https://discourse.nixos.org/t/rofi-calc-not-working-with-rofi-wayland/51301/2)
    (rofi-calc.override {rofi-unwrapped = rofi-unwrapped;})
  ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, C, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}'\" | wl-copy && notify-send -t 1000 \"Copied to clipboard\""
    ];
  };
}
