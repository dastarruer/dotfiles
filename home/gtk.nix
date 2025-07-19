{pkgs, ...}: {
  gtk = {
    enable = true;

    font = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };
  };
}
