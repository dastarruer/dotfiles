{...}: {
  imports = [
    ./workspaces.nix
    ./windows.nix
    ./media.nix
  ];

  wayland.windowManager.hyprland.settings = {
    # General Mod and Terminal
    "bind" = [
      # Rofi
      "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
      "SUPER, D, exec, rofi -show drun"
      "SUPER, C, exec, rofi -show calc -modi calc -no-show-match -no-sort -calc-command \"echo -n '{result}'\" | wl-copy && notify-send -t 1000 \"Copied to clipboard\""
      "SUPER, A, exec, rofi -modi emoji -show emoji"
    ];
  };
}
