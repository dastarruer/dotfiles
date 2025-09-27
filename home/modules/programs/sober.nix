{...}: {
  services.flatpak = {
    packages = [
      "flathub:app/org.vinegarhq.Sober/x86_64/stable"
    ];

    # It bothers me about this everytime I start sober so here
    overrides."org.vinegarhq.Sober" = {
      filesystems = {
        "xdg-run/app/com.discordapp.Discord:create" = true;
        "xdg-run/discord-ipc-0" = true;

        "home" = false;
        "host" = false;
      };
    };
  };
}
