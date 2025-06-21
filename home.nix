{
  pkgs,
  lib,
  ...
}: let
in {
  imports = [
    ./home/fish.nix
    ./home/firefox.nix
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # Symlink a bunch of files
    file = {
      "bin".source = ./bin;
      ".bashrc".source = ./bashrc/.bashrc;
      ".config/kitty".source = ./kitty;
      ".config/neofetch".source = ./neofetch;
      ".config/pywal".source = ./pywal;
      ".config/starship".source = ./starship;
      "Pictures/wallpapers".source = ./wallpapers;
      ".config/waybar".source = ./waybar;
      ".config/yazi".source = ./yazi;
      ".config/zathura".source = ./zathura;
      ".config/hypr".source = ./hypr;
      ".config/rofi".source = ./rofi;
    };

    # Set PATH variables
    sessionPath = [
      "$HOME/bin"
    ];

    # User specific packages
    packages = with pkgs; [
      starship
      vesktop
      pywal16
      pywalfox-native
    ];

    # I couldn't tell you what this does but oh well
    stateVersion = "22.11";
  };

  programs = {
    home-manager.enable = true;

    # Fish stuff
    starship.enable = true;
    zoxide.enable = true;
  };
}
