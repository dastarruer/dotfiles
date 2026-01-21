# https://www.youtube.com/watch?v=rCVW8BGnYIc
# Many settings in that video are deprecated however
{pkgs, ...}: {
  programs.dconf.enable = true;

  users.users.dastarruer.extraGroups = ["libvirtd"];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme # Needed for virt-manager icons, otherwise will not run
  ];

  services.spice-vdagentd.enable = true;
  virtualisation = {
    # USB support inside virtual machines
    spiceUSBRedirection.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
  };
}
