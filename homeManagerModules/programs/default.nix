{lib, ...}: {
  imports = [
    ./fastfetch.nix
    ./firefox
    ./git.nix
    ./kitty.nix
    ./shell
    ./rofi
    ./rclone.nix
    ./spicetify
    ./gaming
    ./distrobox.nix
    ./zathura.nix
    ./imv.nix
    ./dunst
    ./whatsapp.nix
    ./waybar
    ./vscodium
    ./hypr
    ./flameshot.nix
    ./anki
    ./sherlock.nix
    ./foliate.nix
    ./btop.nix
    ./obs.nix
    ./yazi.nix
    ./zoxide.nix
    ./cliphist.nix
    ./mpv.nix
    ./direnv.nix
    ./steam-link.nix
    ./obsidian.nix
    ./sober.nix
    ./swww.nix
    ./batsignal.nix
    ./calibre.nix
    ./libreoffice.nix
  ];

  # Enable all programs by default
  myPrograms = {
    calibre.enable = lib.mkDefault true;
    distrobox.enable = lib.mkDefault true;
    libreoffice.enable = lib.mkDefault true;
    flameshot.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault true;

    # Modules that do not work as of now
    whatsapp.enable = lib.mkDefault false;
  };
}
