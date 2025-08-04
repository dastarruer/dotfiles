# UNUSED BECAUSE HYPRLAND SUPERIORITY
{...}: {
  imports = [
    ../../pipewire.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable GNOME
  services.desktopManager.gnome.enable = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
