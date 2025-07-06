{pkgs, ...}: {
  programs.rofi = {
    enable = true;

    # font = "JetBrainsMono Nerd Font Mono 12";

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
      # icon-theme = "Papirus-Dark";
      # icon-theme = "Tela-circle-dracula";
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
}
