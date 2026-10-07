# Not meant to be imported manually; meant to be imported by other modules
{inputs,...}: {
  flake.nixosModules.desktop_gaming = {
    pkgs,
    lib,
    ...
  }: {
    # Enable the new ntsync kernel module for improved multithreading performance w newer versions of proton/wine
    boot.kernelModules = ["ntsync"];

    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };
        custom = {
          start = "${lib.getExe pkgs.libnotify} 'GameMode started'";
          end = "${lib.getExe pkgs.libnotify} 'GameMode ended'";
        };
      };
    };

    # Allow gamemode to renice processes
    users.users.dastarruer.extraGroups = ["gamemode"];

    programs.gamescope = {
      # package = lib.mkForce config.multiverse.pinned.gamescope;
      enable = true;
      capSysNice = true;
    };
  };
}
