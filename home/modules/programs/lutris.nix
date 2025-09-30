{pkgs, ...}: {
  programs.lutris = {
    enable = true;

    defaultWinePackage = pkgs.proton-ge-bin;
    protonPackages = with pkgs; [
      proton-ge-bin
    ];

    extraPackages = with pkgs; [
      gamescope
      gamemode
    ];
  };
}
