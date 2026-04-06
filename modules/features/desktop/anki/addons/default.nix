{...}: {
  flake.nixosModules.desktop_anki = {pkgs, ...}: {
    home-manager.users.dastarruer = {
      # install addons that don't need configuration
      programs.anki.addons = with pkgs.ankiAddons; [
        review-heatmap
        anki-quizlet-importer-extended
        image-occlusion-enhanced
        fsrs4anki-helper
      ];
    };
  };
}
