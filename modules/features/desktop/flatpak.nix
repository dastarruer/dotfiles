# Does not need to be manually imported; will be imported as is necessary
{inputs, ...}: {
  flake.nixosModules.flatpak = {
    config,
    pkgs,
    lib,
    ...
  }: {
    # Needs to be enabled at the system level as well
    services.flatpak.enable = true;

    # Allow fonts to work with flatpak (https://wiki.nixos.org/wiki/Fonts#Flatpak_applications_can't_find_system_fonts)
    # If any issues arise, read through the wiki
    # Note that home-manager flatpak configuration is in flatpak.nix
    fonts.fontDir.enable = true;

    home-manager.users.dastarruer = let
      hmConfig = config.home-manager.users.dastarruer;
      hyprland = hmConfig.wayland.windowManager.hyprland;
    in {
      imports = [
        inputs.flatpaks.homeModules.default
      ];

      # Otherwise, an error will be thrown
      # The specific desktop portal used is configured by whatever wm or de is enabled
      xdg.portal.enable = true;

      # This is needed for launching flatpaks with rofi
      home.packages = with pkgs; [
        flatpak
      ];

      # FUTURE ME IF flatpak list throws an error, then run:
      # sudo rm -rf /var/lib/flatpak/repo
      # sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      # sudo flatpak remote-add --if-not-exists flathub-beta https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo
      services.flatpak = {
        enable = true;

        # Add remotes here
        remotes = {
          "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
          "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
        };

        overrides = {
          "global".Context = {
            # Give all flatpaks access to the home dir
            filesystems = [
              "home"
            ];

            # Remove x11 support for flatpaks, making them run only on wayland
            sockets = lib.mkIf hyprland.enable [
              "!x11"
              "!fallback-x11"
            ];
          };
        };
      };
    };
  };
}
