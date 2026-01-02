{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.desktop.sober.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Sober, an app for playing Roblox on Linux.";
    };
  };

  config = lib.mkIf config.dotfiles.desktop.sober.enable {
    services.flatpak = {
      packages = [
        "flathub:app/org.vinegarhq.Sober/x86_64/stable"
      ];

      # It bothers me about this everytime I start sober so here
      overrides."org.vinegarhq.Sober" = {
        filesystems = [
          "xdg-run/app/com.discordapp.Discord:create"
          "xdg-run/discord-ipc-0"

          "!home"
          "!host"
        ];
      };
    };
  };
}
