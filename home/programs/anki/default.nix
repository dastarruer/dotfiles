{
  config,
  pkgs,
  ...
}: let
  theme = import ./addons/recolor.nix {inherit config;};
  passfailConfig = import ./addons/passfail2.nix {inherit config;};
in {
  home.packages = with pkgs; [
    (anki.withAddons (with ankiAddons; [
      (passfail2.withConfig {
        config = passfailConfig;
      })
      (recolor.withConfig {
        config = theme;
      })
    ]))
  ];
}
