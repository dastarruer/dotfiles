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

  home = {
    # Hyprland packages needed
    packages = with pkgs; [
      waybar
      swww

      # Network manager
      networkmanagerapplet
    ];

    # This line does not do anything, so this env variable is declared in config.fish
    # sessionVariables.NIXOS_OZONE_WL = "1";
  };

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
  xdg = {
    # The script to run every time a url is clicked
    desktopEntries."open_url" = {
      name = "Open URL";
      exec = "${pkgs.writeShellScript "open-url" ''
        #!/run/current-system/sw/bin/bash
        # Get current workspace ID
        workspace_id=$(${pkgs.hyprland}/bin/hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq ".id")

        # Get the address of a Firefox window on the current workspace, if any
        current_ff_address=$(${pkgs.hyprland}/bin/hyprctl clients -j | ${pkgs.jq}/bin/jq -r ".[] | select(.initialClass == \"firefox-nightly\" and .workspace.id == $workspace_id) | .address")

        # Get the URL from the first argument
        url="$1"

        # Check if a URL was provided
        if [ -z "$url" ]; then
            echo "No URL provided" >&2
            exit 1
        fi

        if [ -n "$current_ff_address" ]; then
            # Focus the existing Firefox window
            ${pkgs.hyprland}/bin/hyprctl dispatch focuswindow address:"$current_ff_address"
            # Open the URL in a new tab
            ${inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin}/bin/firefox-nightly --new-tab "$url" &
        else
            # No Firefox window on this workspace, open a new window
            ${inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin}/bin/firefox-nightly --new-window "$url" &
        fi
      ''} %u";
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
