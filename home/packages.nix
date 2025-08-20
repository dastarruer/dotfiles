{pkgs, ...}: {
  # Allow fonts
  fonts.fontconfig.enable = true;

  # User specific packages
  home.packages = with pkgs; [
    # Apps
    xfce.thunar
    todoist-electron
    # musescore
    foliate
    # vesktop

    # Screenshots
    tesseract

    # Other
    fzf
    playerctl
    ffmpeg
  ];

  # idk why i have to enable this
  programs.home-manager.enable = true;
}
