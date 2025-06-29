{pkgs, ...}: {
  # Allow fonts
  fonts.fontconfig.enable = true;

  # User specific packages
  home.packages = with pkgs; [
    starship
    vesktop
    pywal16
    pywalfox-native
    anki-bin
    flatpak
    vscode-fhs
    xfce.thunar
    firefox
    obsidian
    zathura

    kitty
    git
    gh
    fastfetch
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

    # TODO: Get screenshots working
    tesseract
    grimblast
    imagemagick
    slop
    ffcast
    xsel

    # FONTS
    font-awesome
    nerd-fonts._3270
    nerd-fonts.jetbrains-mono
    fira-code
  ];
}
