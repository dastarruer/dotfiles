{
  lib,
  config,
  ...
}: let
in {
  imports = [
    ./home/fish.nix
    ./home/firefox.nix
    ./home/flatpak.nix
    ./home/spicetify.nix
    ./home/packages.nix
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # Symlink a bunch of files
    file = {
      # $HOME files
      "bin" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/bin";
      };
      ".bashrc" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/bashrc/.bashrc";
      };
      ".gitconfig" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/gitconfig/.gitconfig";
      };
      ".gitignore_global" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/gitconfig/.gitignore_global";
      };
      "Pictures/wallpapers" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/wallpapers";
      };

      # .config files
      ".config/hypr" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/hypr";
      };
      ".config/kitty" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/kitty";
      };
      ".config/neofetch" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/neofetch";
      };
      ".config/wal" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/wal";
      };
      ".config/rofi" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/rofi";
      };
      ".config/starship" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/starship";
      };
      ".config/waybar" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/waybar";
      };
      ".config/yazi" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/yazi";
      };
      ".config/zathura" = {
        source =
          config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.dotfiles/zathura";
      };
    };

    # Set PATH variables
    sessionPath = [
      "$HOME/bin"
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
