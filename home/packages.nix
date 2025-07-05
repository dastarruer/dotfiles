{pkgs, ...}: {
  # Allow fonts
  fonts.fontconfig.enable = true;

  # User specific packages
  home.packages = with pkgs; [
    starship
    vesktop
    anki-bin
    flatpak
    vscode-fhs
    xfce.thunar
    firefox
    obsidian
    todoist-electron
    localsend
    gh
    zoxide
    cargo
    fzf
    playerctl
    nixd
    alejandra
    btop
    python3
    ffmpeg
    yazi
    rustfmt

    # Screenshots
    tesseract
    grimblast

    # Apps

    # because i cant be bothered to put it in the config js run pywalfox install to install pywalfox and yh thats it
    pywal16
    # pywalfox-native
  ];

  # Enable programs here so that stylix can configure them
  programs = {
    home-manager.enable = true;

    # Shell stuff
    starship.enable = true;
    zoxide.enable = true;
  };
}
