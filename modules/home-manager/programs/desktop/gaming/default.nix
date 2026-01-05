{lib, ...}: {
  imports = [
    ./ludusavi.nix
    ./lutris.nix
  ];

  options = {
    dotfiles.desktop.gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable gaming desktop apps.";
    };
  };
}
