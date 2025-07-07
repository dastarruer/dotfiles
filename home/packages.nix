{
  pkgs,
  inputs,
  ...
}: {
  # Allow fonts
  fonts.fontconfig.enable = true;

  # User specific packages
  home.packages = with pkgs; [
    # Apps
    vscode-fhs
    xfce.thunar
    firefox
    obsidian
    todoist-electron
    musescore
    localsend
    vesktop
    anki-bin

    # Screenshots
    tesseract
    grimblast

    # Other
    gh
    flatpak
    cargo
    fzf
    playerctl
    nixd
    alejandra
    ffmpeg
    rustfmt
    inputs.hyprsession-nix.packages.${system}.default
  ];

  # Enable programs here so that stylix can configure them
  programs = {
    home-manager.enable = true;
    btop.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
  };
}
