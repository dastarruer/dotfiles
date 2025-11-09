# ddcutil lets me control the backlight of my external monitor
{
  pkgs,
  config,
  ...
}: {
  # This is so brillo can control the monitor. but it's slow, so I'll do something else (https://wiki.nixos.org/wiki/Backlight#Via_ddcci-driver)

  # Allow ddcci-driver to be used kernels > 6.8
  nixpkgs.overlays = [
    (self: super: {
      linuxPackages_latest = super.linuxPackages_latest.extend (lpself: lpsuper: {
        ddcci-driver = super.linuxPackages_latest.ddcci-driver.overrideAttrs (oldAttrs: {
          version = super.linuxPackages_latest.ddcci-driver.version + "-FIXED";
          src = pkgs.fetchFromGitLab {
            owner = "ddcci-driver-linux";
            repo = "ddcci-driver-linux";
            rev = "0233e1ee5eddb4b8a706464f3097bad5620b65f4";
            hash = "sha256-Osvojt8UE+cenOuMoSY+T+sODTAAKkvY/XmBa5bQX88=";
          };
          patches = [
            (pkgs.fetchpatch {
              name = "ddcci-e0605c9cdff7bf3fe9587434614473ba8b7e5f63.patch";
              url = "https://gitlab.com/nullbytepl/ddcci-driver-linux/-/commit/e0605c9cdff7bf3fe9587434614473ba8b7e5f63.patch";
              hash = "sha256-sTq03HtWQBd7Wy4o1XbdmMjXQE2dG+1jajx4HtwBHjM=";
            })
          ];
        });
      });
    })
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ddcci-driver];

  boot.kernelModules = ["ddcci-backlight"];

  services.udev.extraRules = let
    bash = "${pkgs.bash}/bin/bash";
    ddcciDev = "AMDGPU DM i2c hw bus 1";
    ddcciNode = "/sys/bus/i2c/devices/i2c-7/new_device";
  in ''
      SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${bash} -c 'sleep 30; printf ddcci\ 0x37 > ${ddcciNode}'"
    # '';

  # https://wiki.nixos.org/wiki/Backlight#Via_ddcutil
  # this way i have to manually use the ddcutil command but it's faster so yk
  # hardware.i2c.enable = true;
  # environment.systemPackages = [pkgs.ddcutil];

  # # Give user access to monitor brightness control
  # users.users.dastarruer.extraGroups = ["ic2"];
}
