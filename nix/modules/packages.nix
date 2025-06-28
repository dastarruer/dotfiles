{
  pkgs,
  inputs,
  ...
}: {
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    kitty
    git
    gh
    fastfetch
    zoxide
    cargo
    fzf
    playerctl
    libnotify
    nixd
    alejandra
    btop
    python3
    ffmpeg
    yazi
    rustfmt
  ];

  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
