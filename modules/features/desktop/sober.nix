{self, ...}: {
  flake.nixosModules.desktop_obsidian = {...}: {
    imports = [
      self.nixosModules.flatpak
    ];

    home-manager.users.dastarruer = {
      services.flatpak = {
        packages = [
          "flathub:app/org.vinegarhq.Sober/x86_64/stable"
        ];

        # It bothers me about this everytime I start sober so here
        overrides."org.vinegarhq.Sober".Context = {
          filesystems = [
            "xdg-run/app/com.discordapp.Discord:create"
            "xdg-run/discord-ipc-0"

            "!home"
            "!host"
          ];
        };
      };
    };
  };
}
