/*
   https://github.com/in-a-dil-emma/declarative-flatpak

To find the link to a flatpak, run:
flatpak run {flatpak}
and then just take the link that it gives you.

Example: flatpak run net.ankiweb.Anki
error: app/net.ankiweb.Anki/x86_64/master not installed
*/
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  # Import flatpak home manager module
  imports = [
    inputs.flatpaks.homeModules.default
  ];

  # This is needed for launching flatpaks with rofi
  home.packages = with pkgs; [flatpak];

  services.flatpak = {
    enable = true;

    # Add remotes here
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };

    # Add packages here
    packages = [
      "flathub:app/md.obsidian.Obsidian/x86_64/stable"
      "flathub:app/org.vinegarhq.Sober/x86_64/stable"
    ];

    overrides = {
      global = {
        # Give all flatpaks access to the home dir
        filesystems = {
          "home" = true;
        };

        # Remove x11 support for flatpaks, making them run only on wayland
        sockets = {
          "x11" = false;
          "fallback-x11" = false;
        };
      };

      # It bothers me about this everytime I start sober so here
      "org.vinegarhq.Sober" = {
        filesystems = {
          "xdg-run/app/com.discordapp.Discord:create" = true;
          "xdg-run/discord-ipc-0" = true;

          "home" = false;
          "host" = false;
        };
      };

      "md.obsidian.Obsidian" = {
        sockets = {
          # Enable wayland support for obsidian
          "wayland" = true;
          "x11" = false;
          "fallback-x11" = false;
        };
      };
    };
  };

  # Run this command in order to give flatpak acces to system fonts (https://wiki.nixos.org/wiki/Fonts#Solution_1:_Copy_fonts_to_$HOME/.local/share/fonts)
  # Note that fonts.fontDir.enable = true is required for this, which is already declared in configuration.nix
  home.activation.copyFonts = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "$HOME/.local/share/fonts"
    cp -L /run/current-system/sw/share/X11/fonts/* "$HOME/.local/share/fonts/" || true
  '';
}
