{
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./modules/default.nix

    inputs.sops-nix.homeManagerModules.sops
  ];

  # Set up user
  home = {
    # Set username and home directory
    username = "dastarruer";
    homeDirectory = lib.mkForce "/home/dastarruer";

    # I couldn't tell you what this does but oh well
    stateVersion = "25.11";

    sessionVariables = {
      # Allow unfree packages.
      NIXPKGS_ALLOW_UNFREE = "1";

      # Necessary for grimblast and other screenshot tools
      XDG_SCREENSHOTS_DIR = "/home/dastarruer/Pictures/screenshots";
    };

    # Create the save dir for screenshots
    activation.createScreenshotDir = lib.hm.dag.entryBefore ["writeBoundary"] ''
      mkdir -p "$HOME/Pictures/screenshots"
    '';
  };

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Set some necessary sops settings
  sops = {
    age.keyFile = "/home/dastarruer/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets/secrets.yaml;

    # Put secrets here so on reinstall no errors pop up
    secrets = {
      name = {};
      email = {};
    };
  };

  services.polkit-gnome.enable = true;

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
            ${inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin}/bin/firefox-nightly --new-tab "$url" &
        else
            # No Firefox window on this workspace, open a new window
            ${inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin}/bin/firefox-nightly --new-window "$url" &
        fi
      ''} %u";
      terminal = false;
      type = "Application";

      # Don't show this in rofi
      noDisplay = true;
    };

    # This section just runs the previously declared .desktop file when a link is clicked
    mimeApps = {
      enable = true;
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

  # Settings to make fonts less blurry
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    hinting = "full"; # Best for monospace fonts, though not great for other fonts
    subpixelRendering = "vertical-rgb"; # Seems to reduce color fringing more on my monitor as opposed to rgb

    # Set lcdfilter to light manually, since hm does not yet have an option to do this yet
    configFile."lcdfilter-light" = {
      enable = true;
      label = "lcdfilter-light";
      priority = 10;
      text = ''
        <match target="font">
            <edit name="lcdfilter" mode="assign">
            <const>lcdlight</const>
            </edit>
        </match>
      '';
    };
  };
}
