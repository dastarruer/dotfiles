# Does not need to be manually imported; will be imported as is necessary
{...}: {
  flake.nixosModules.flatpak = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.wayland.windowManager.hyprland;
    in {
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
