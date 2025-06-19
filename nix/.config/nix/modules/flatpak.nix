{lib, pkgs, ...}: {
  services.flatpak.enable = true;
  # Add a new remote. Keep the default one (flathub)
  services.flatpak.remotes = lib.mkOptionDefault [
    {
      name = "flathub-beta";
      location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
    }
  ];

  services.flatpak.update.auto.enable = true;
  services.flatpak.uninstallUnmanaged = true;

  # Add here the flatpaks you want to install
  services.flatpak.packages = [
    "org.vinegarhq.Sober" # Roblox w the gc
  ];

  # For sober flatpak
  system.activationScripts.flatpakOverrides.text = ''
    # Apply persistent flatpak override on activation
    ${pkgs.flatpak}/bin/flatpak override --user \
      --filesystem=xdg-run/app/com.discordapp.Discord:create \
      --filesystem=xdg-run/discord-ipc-0 \
      org.vinegarhq.Sober
  '';
}
