{...}: {
  programs.zathura = {
    enable = true;

    options = {
      window-title-home-tilde = true;
      statusbar-basename = true;
      selection-clipboard = "clipboard";
    };
  };
}
