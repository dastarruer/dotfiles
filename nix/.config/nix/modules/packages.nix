{ pkgs, inputs, ... }:

{
    # Install firefox.
  programs.firefox.enable = true;

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
  ];

  # For nixd i think
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
}