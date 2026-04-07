{self, ...}: {
  flake.nixosModules.desktop_steam-link = {...}: {
    imports = [
      self.nixosModules.flatpak
    ];

    home-manager.users.dastarruer = {
      services.flatpak = {
        packages = [
          "flathub:app/com.valvesoftware.SteamLink/x86_64/stable"
        ];
      };
    };
  };
}
