{lib, ...}: {
  imports = [
    ./ludusavi.nix
    ./lutris.nix
    ./steam.nix
  ];

  options = {
    home-manager.desktop.gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable gaming desktop apps.";
    };
  };
}
