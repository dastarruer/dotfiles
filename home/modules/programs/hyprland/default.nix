{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./colors.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # set to the flake package for more up to date software
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # For stuff between apps like clipboard access, drag and drop, etc.
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Hyprland packages needed
  home.packages = with pkgs; [
    waybar
    swww

    # Network manager
    networkmanagerapplet

    jq
  ];

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile = {
    "hypr/hyprland.conf".enable = false;
    "hypr/hypridle.conf".enable = false;
    "hypr/hyprlock.conf".enable = false;
  };

  # Symlink hyprland config
  home.file.".config/hypr" = {
    source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/.dotfiles/config/hypr";
    recursive = true;
  };

  # Workaround to open hyprlinks in current workspace (just like the one here!): https://www.reddit.com/r/hyprland/comments/1b5jvvm/opening_browser_in_the_current_workspace/
  # First add the script to path
  home.sessionPath = [
    "$HOME/bin/open_url.sh"
  ];

  xdg = {
    # The script to run every time a url is clicked
    desktopEntries."open_url" = {
      name = "Open URL";
      exec = "open_url.sh %u";
      terminal = false;
      type = "Application";

      # Don't show this in rofi
      noDisplay = true;
    };

    # This section just runs the previously declared .desktop file when a link is clicked
    mimeApps = {
      associations.added = {
        "x-scheme-handler/http" = ["open_url.desktop"];
        "x-scheme-handler/https" = ["open_url.desktop"];
      };

      defaultApplications = {
        "x-scheme-handler/http" = ["open_url.desktop"];
        "x-scheme-handler/https" = ["open_url.desktop"];
      };
    };
  };
}
