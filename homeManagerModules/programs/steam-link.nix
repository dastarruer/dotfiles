{...}: {
  services.flatpak = {
    packages = [
      "flathub:app/com.valvesoftware.SteamLink/x86_64/stable"
    ];
  };
}
