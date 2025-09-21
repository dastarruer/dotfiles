{pkgs, ...}: {
  # Allow fonts
  fonts.fontconfig.enable = true;

  # User specific packages
  home.packages = with pkgs; [
    # Apps
    xfce.thunar
    todoist-electron
    # qbittorrent # need this for... reasons
    # musescore
    # kdePackages.kdenlive
    # vesktop

    # Other
    fzf
    tesseract
    playerctl
    ffmpeg
  ];

  # idk why i have to enable this
  programs.home-manager.enable = true;
}
