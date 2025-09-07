{pkgs, ...}: {
  home.packages = with pkgs; [
    cliphist
  ];
}
