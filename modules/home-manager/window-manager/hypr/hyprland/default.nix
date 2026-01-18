{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./binds

    ./colors.nix
    ./windowrules.nix
    ./misc.nix
    ./input.nix
    ./decoration.nix
    ./autostart.nix
    # ./plugins.nix
  ];

  options = {
    home-manager.window-manager.hypr.hyprland.enable = lib.mkEnableOption "Enable hyprland, a script to send notifications on low battery.";
  };

  config = lib.mkIf config.home-manager.window-manager.hypr.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      # # set to the flake package for more up to date software
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

      # For stuff between apps like clipboard access, drag and drop, etc.
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    # Use wayland for chromium/electron apps
    home.sessionVariables.NIXOS_OZONE_WL = "1";

    # Use hyprland cachix to avoid building hyprland from source.
    # Only needed if flake package is being used
    # https://wiki.hypr.land/Nix/Cachix/
    nix.settings = {
      extra-substituters = [
        "https://hyprland.cachix.org"
      ];
      extra-trusted-substituters = [
        "https://hyprland.cachix.org"
      ];
      extra-trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    # Workaround to open hyprlinks in current workspace (just like the one here!): https://www.reddit.com/r/hyprland/comments/1b5jvvm/opening_browser_in_the_current_workspace/
    xdg = {
      # The script to run every time a url is clicked
      desktopEntries."open_url" = {
        name = "Open URL";

        exec = let
          firefoxPkg = config.programs.firefox.package;
        in "${pkgs.writeShellApplication {
          name = "open-url";

          runtimeInputs = with pkgs; [
            jq
            hyprland
            firefoxPkg
          ];

          text = let
            firefoxExe = lib.getExe firefoxPkg;
          in ''
            #!/run/current-system/sw/bin/bash
            # Get current workspace ID
            workspace_id=$(hyprctl activeworkspace -j | jq ".id")

            # Get the address of a Firefox window on the current workspace, if any
            current_ff_address=$(hyprctl clients -j | jq -r ".[] | select(.initialClass == \"firefox-nightly\" and .workspace.id == $workspace_id) | .address")

            # Get the URL from the first argument
            url="$1"

            # Check if a URL was provided
            if [ -z "$url" ]; then
                echo "No URL provided" >&2
                exit 1
            fi

            if [ -n "$current_ff_address" ]; then
                # Focus the existing Firefox window
                hyprctl dispatch focuswindow address:"$current_ff_address"
                # Open the URL in a new tab
                ${firefoxExe} --new-tab "$url" &
            else
                # No Firefox window on this workspace, open a new window
                ${firefoxExe} --new-window "$url" &
            fi
          '';
        }}/bin/open-url %u";
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
  };
}
