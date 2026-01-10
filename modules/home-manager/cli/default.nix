{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./shell
    ./btop.nix
    ./git.nix
    ./rclone.nix
    ./yazi.nix
    ./zoxide.nix
    ./distrobox.nix
    ./direnv.nix
    ./cliphist.nix
  ];

  options = {
    home-manager.cli.enable = lib.mkEnableOption "Enable CLI utilities.";
  };

  config = lib.mkIf config.home-manager.cli.enable {
    home.packages = with pkgs; [
      ffmpeg
    ];
  };
}
