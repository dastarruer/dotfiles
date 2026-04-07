{self, ...}: {
  flake.nixosModules.desktop_timer = {...}: {
    imports = [
      self.nixosModules.flatpak
    ];

    home-manager.users.dastarruer = {
      services.flatpak = {
        packages = [
          "flathub:app/com.github.vikdevelop.timer/x86_64/stable"
        ];
      };
    };
  };
}
