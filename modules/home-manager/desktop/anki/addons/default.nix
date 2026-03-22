{pkgs, ...}: {
  imports = [
    ./passfail2.nix
    ./auto-sync.nix
    # Fails to build for now
    # ./fsrs4anki-helper.nix
  ];

  # install addons that don't need configuration
  programs.anki.addons = with pkgs.ankiAddons; [
    review-heatmap
    anki-quizlet-importer-extended
    image-occlusion-enhanced
    fsrs4anki-helper
  ];
}
