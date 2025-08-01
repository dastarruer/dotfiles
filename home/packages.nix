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
    rofi-calc
    gh
    flatpak
    cargo
    fzf
    playerctl
    ffmpeg
  ];

  # Enable programs here so that stylix can configure them
  programs = {
    home-manager.enable = true;
    btop.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
  };
}
