{lib, ...}: {
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
    #{ appId = "com.brave.Browser"; origin = "flathub"; }
    "com.obsproject.Studio"
    #"im.riot.Riot"
  ];
}
