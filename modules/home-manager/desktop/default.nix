{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./terminals
    ./calibre.nix
    ./libreoffice.nix
    ./gaming
    ./pwa
    ./vscode
    ./firefox
    ./spicetify
    ./zathura.nix
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
    ./kdenlive.nix
  ];

  options = {
    home-manager.desktop.enable = lib.mkEnableOption "Enable all desktop apps.";
  };

  config = lib.mkIf config.home-manager.desktop.enable {
    home.packages = with pkgs; [
      thunar
      todoist-electron
      brave
      gimp
    ];
  };
}
