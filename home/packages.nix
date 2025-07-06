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
    python3
    ffmpeg
    yazi
    rustfmt

    # Screenshots
    tesseract
    grimblast
  ];

  # Enable programs here so that stylix can configure them
  programs = {
    home-manager.enable = true;
    btop.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
  };
}
