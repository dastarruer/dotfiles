{pkgs, ...}: {
  # Packages that don't need extra config
  home.packages = with pkgs; [
    thunar
    todoist-electron
    brave
    # qbittorrent # need this for... reasons
    # musescore
    # kdePackages.kdenlive
    # vesktop
    ffmpeg
  ];

  programs.home-manager.enable = true;
}
