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
  ...
}: {
  # Import flatpak home manager module
  imports = [
    inputs.flatpaks.homeModule
  ];

  services.flatpak = {
    # Enable flatpaks
    enable = true;

    # Add remotes here
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };

    # Add packages here
    packages = [
      #"flathub:app/org.vinegarhq.Sober/x86_64/stable"
      "flathub:app/md.obsidian.Obsidian/x86_64/master"
    ];

    overrides = {
      global = {
        # Give all flatpaks access to the home dir
        filesystems = [
          "home"
        ];

        # Remove x11 support for flatpaks, making them run only on wayland
        sockets = [
          "!x11"
          "!fallback-x11"
        ];
      };

      # It bothers me about this everytime I start sober so here
      "org.vinegarhq.Sober" = {
        filesystems = [
          "!host"
          "!home"

          # Sober overrides
          "xdg-run/app/com.discordapp.Discord:create"
          "xdg-run/discord-ipc-0"
        ];
      };

      "md.obsidian.Obsidian" = {
        sockets = [
          # Enable wayland support for obsidian
          "wayland"
          "!x11"
          "!fallback-x11"
        ];
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
