{lib, ...}: {
  imports = [
    ./calibre.nix
    ./libreoffice.nix
    ./gaming
    ./vscodium
    ./firefox
    ./kitty.nix
    ./spicetify
    ./zathura.nix
    ./whatsapp.nix
    ./anki
    ./foliate.nix
    ./obs.nix
    ./mpv.nix
    ./steam-link.nix
    ./obsidian.nix
    ./sober.nix
    ./imv.nix
  ];

  options = {
    dotfiles.desktop.enableAll = lib.mkEnableOption "Enable all desktop apps.";
  };
}
