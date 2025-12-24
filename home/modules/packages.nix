{pkgs, ...}: {
  # Allow fonts
  fonts.fontconfig.enable = true;

  # Packages that don't need extra config
  home.packages = with pkgs; [
    xfce.thunar
    todoist-electron
    brave
    # qbittorrent # need this for... reasons
    # musescore
    # kdePackages.kdenlive
    # vesktop
    ffmpeg
  ];

  # idk why i have to enable this
  programs.home-manager.enable = true;
}
