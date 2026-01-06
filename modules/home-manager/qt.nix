# Style qt apps similar to gtk apps
{pkgs, ...}: {
  qt = {
    enable = true;

    platformTheme.name = "adwaita";

    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
