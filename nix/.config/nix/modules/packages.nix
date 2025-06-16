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
    stow
    neofetch
    starship
    zoxide
    cargo
    fzf
    playerctl
    libnotify
    nixd
    alejandra
    firefox
    btop
  ];

  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
