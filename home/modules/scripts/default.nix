# A collection of bash scripts that have been added to nixpkgs using overlays. This is so that scripts can be added to things like keybinds, or home.packages
{...}: {
  imports = [
    ./change-wallpaper.nix
    ./brightness.nix
    ./apps.nix
    ./headphones.nix
    ./kill-apps.nix
    ./move-windows-to-monitor.nix
    ./screenshot.nix
    ./toggle-monitors.nix
    ./backup.nix
    ./power.nix
    ./fzfdf.nix
    ./commit-dotfiles.nix
  ];
}
