{pkgs, ...}: {
  programs.anki.addons = [
    (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
      pname = "auto-sync";
      version = "master"; # Or a specific commit hash for better reproducibility

      src = pkgs.fetchFromGitHub {
        owner = "Robin-Haupt-1";
        repo = "Auto-Sync-Anki-Addon";
        rev = finalAttrs.version;
        # Use the hash below; it is the current hash for the master branch
        hash = "sha256-dBEWyHLN6lwWEsrKULYnACqexjVsvZUpXWOLJy9vwkA=";
      };
    }))
  ];
}
