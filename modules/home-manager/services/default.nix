{
  config,
  lib,
  ...
}: {
  imports = [
    ./smart-pause-resume.nix
    ./caps-lock.nix
    ./backup.nix
  ];

  options = {
    home-manager.services.enable =
      lib.mkEnableOption "Enable daily automated backups.";
  };
}
