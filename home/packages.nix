{pkgs, ...}: {
  # Allow fonts
  fonts.fontconfig.enable = true;

  # User specific packages
  home.packages = with pkgs; [
    # Apps
    xfce.thunar
    firefox
    todoist-electron
    musescore
    vesktop

    # Screenshots
    tesseract
    grimblast

    # Clipboard
    wl-clipboard
    cliphist
    go # a dependency of cliphist

    # Other
    gh
    fzf
    playerctl
    ffmpeg
  ];

  # idk why i have to enable this
  programs.home-manager.enable = true;
}
