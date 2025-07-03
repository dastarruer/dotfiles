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
    gruvbox-gtk-theme

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

    # Screenshots
    tesseract
    grimblast

    # because i cant be bothered to put it in the config js run pywalfox install to install pywalfox and yh thats it
    pywal16
    pywalfox-native

    # FONTS
    font-awesome
    nerd-fonts._3270
    nerd-fonts.jetbrains-mono
    fira-code
  ];
}
