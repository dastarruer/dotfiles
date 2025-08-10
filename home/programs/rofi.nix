{pkgs, ...}: {
  programs.rofi = {
    enable = true;

    # Specify rofi-wayland because wayland
    package = pkgs.rofi-wayland;

    # Specify the terminal to use for launching terminal programs
    # terminal = "${pkgs.kitty}/bin/kitty";

    # Config
    extraConfig = {
      hover-select = true;
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
      modi = [
        "drun"
        "run"
        "filebrowser"
        "window"
      ];
      show-icons = true;
      display-drun = " Apps";
      display-run = "󰲌 Run";
      display-filebrowser = " Files";
      display-window = " Win";
      drun-display-format = "{icon} {name}";
      window-format = "{w} · {c}";
      kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
      kb-row-down = "Down,Control+j";
      kb-accept-entry = "Control+m,Return,KP_Enter";
      kb-remove-to-eol = "Control+Shift+e";
      kb-mode-next = "Shift+Right,Control+Tab,Control+l";
      kb-mode-previous = "Shift+Left,Control+Shift+Tab,Control+h";
      kb-remove-char-back = "BackSpace";
      kb-mode-complete = "Control+Shift+l";
    };
  };

  # Other rofi packages
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

      # Cliphist
      "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
    ];
  };
}
