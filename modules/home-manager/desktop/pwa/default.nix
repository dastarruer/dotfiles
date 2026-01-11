{
  config,
  lib,
  ...
}: {
  imports = [
    ./whatsapp.nix
    ./hianime.nix
    ./streaming.nix
    ./youtube.nix
  ];

  options = {
    home-manager.desktop.pwa.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.desktop.enable;
      description = "Enable PWAs for various web apps.";
    };
  };
}
