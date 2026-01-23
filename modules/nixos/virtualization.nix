# https://www.youtube.com/watch?v=rCVW8BGnYIc
# Many settings in that video are deprecated however
{pkgs, ...}: {
  programs.dconf.enable = true;

  users.users.dastarruer.extraGroups = ["libvirtd"];

  environment.systemPackages = with pkgs; [
    # Command to quickly set up a windows 11 vm
    quickemu

    # Virtualization tools
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
        package = pkgs.qemu_kvm;
        swtpm.enable = true;

        # Required to access VM files inside the nixos host machine
        vhostUserPackages = [pkgs.virtiofsd];
      };
    };
  };
}
