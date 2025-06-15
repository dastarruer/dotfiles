{ config, pkgs, ... }:

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
     oh-my-fish
     cargo
     fzf
     agenix-cli
     playerctl
     libnotify
  ];
}