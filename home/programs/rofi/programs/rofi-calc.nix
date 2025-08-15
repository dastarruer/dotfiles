{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi-calc
  ];

  # Hyprland keybinds
  wayland.windowManager.hyprland.settings = {
    "$menu" = "rofi -show drun";
    bind = [
      # Rofi-calc
      "$mainMod, C, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}' | xclip --clipboard --input && notify-send -t 1000 \"Copied to clipboard\""

      "$mainMod, D, exec, $menu"
    ];
  };
}
