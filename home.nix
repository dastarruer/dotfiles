{
  pkgs,
  lib,
  ...
}: let
  # Firefox theme that I will use
  firefox-theme = "https://github.com/cascadefox/cascade";
in {
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
      ".config/hypr".source = ./hypr;
      ".config/rofi".source = ./rofi;

      # Fetch firefox theme (https://www.reddit.com/r/NixOS/comments/1f5wbjd/installing_a_complex_user_css_for_firefox/)
      ".mozilla/firefox/czemx9az.default/chrome" = {
        source = "${builtins.fetchGit {
          url = firefox-theme;
          rev = "f8c6bb5a36f24aba61995204ff5497c865e78e50";
        }}/chrome";
        recursive = true;
      };
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
