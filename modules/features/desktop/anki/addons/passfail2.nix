{...}: {
  flake.nixosModules.desktop_anki = {
    config,
    pkgs,
    ...
  }: {
    home-manager.users.dastarruer = {
      programs.anki.addons = with pkgs.ankiAddons; [
        (passfail2.withConfig {
          config = {
            again_button_name = "Incorrect";
            good_button_name = "Correct";
            again_button_textcolor = "#${config.lib.stylix.colors.base06}";
            good_button_textcolor = "#${config.lib.stylix.colors.base06}";
          };
        })
      ];
    };
  };
}
