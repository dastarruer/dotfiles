{...}: {
  programs.rofi.extraConfig = {
    modi = "drun";
    show-icons = false;
    icon-theme = "Papirus-Dark";
    drun-display-format = "{name}";
    display-drun = "search: ";

    timeout-action = "kb-cancel";
    timeout-delay = 0;

    filebrowser-directories-first = true;
    filebrowser-sorting-method = "name";
  };
}
