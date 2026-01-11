{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./calibre.nix
    ./libreoffice.nix
    ./gaming
    ./vscode
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
    ./flameshot.nix
    ./timer.nix
    ./hianime.nix
    ./streaming.nix
    ./youtube.nix
  ];

  options = {
    home-manager.desktop.enable = lib.mkEnableOption "Enable all desktop apps.";
  };

  config = lib.mkIf config.home-manager.desktop.enable {
    home.packages = with pkgs; [
      thunar
      todoist-electron
      brave
    ];
  };
}
