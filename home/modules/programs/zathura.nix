{...}: {
  programs.zathura = {
    enable = true;

    options = {
      # Set dark mode by default
      recolor = true;

      # Fill window upon opening
      adjust_window = "best-fit";
      adjust_open = "best-fit";

      window-title-home-tilde = true;
      statusbar-basename = true;
      selection-clipboard = "clipboard";
      restore-session = true;
    };
  };
}
