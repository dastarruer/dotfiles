{
  pkgs,
  inputs,
  ...
}: {
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    kitty
    vscode-fhs
    git
    gh
    neofetch
    zoxide
    cargo
    fzf
    playerctl
    libnotify
    nixd
    alejandra
    firefox
    btop
    python3
    xfce.thunar
    btop
    ffmpeg
  ];

  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
