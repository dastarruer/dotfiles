{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home/fish.nix
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    file = {
      ".config/btop".source = ./btop;
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
    };

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
