# https://www.youtube.com/watch?v=rCVW8BGnYIc
# Many settings in that video are deprecated however
{pkgs, ...}: {
  virtualisation.docker.enable = true;

  programs.dconf.enable = true;

  users.users.dastarruer.extraGroups = [
    "libvirtd"
    "kvm" # Allow this user to use hardware acceleration i think
    "docker" # Sudoless access to docker commands
  ];

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
    samba # yes this is declared w services.samba but gemini said i should put this here anyways
  ];

  # Clipboard sharing daemon
  services.spice-vdagentd.enable = true;

  # File-sharing between VMs
  services.samba = {
    enable = true;
    openFirewall = true; # Allows the VM to reach the host's Samba ports
  };

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
