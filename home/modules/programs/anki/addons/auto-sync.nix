{pkgs, ...}: {
  # TODO: Maybe add this to nixpkgs
  # this addon needs to be built manually
  programs.anki.addons = [
    (pkgs.anki-utils.buildAnkiAddon
      (finalAttrs: {
        pname = "Auto-Sync-Anki-Addon";
        # To find the version, run: git ls-remote --tags https://github.com/Robin-Haupt-1/Auto-Sync-Anki-Addon.git
        version = "v1.0";
        src = pkgs.fetchFromGitHub {
          owner = "Robin-Haupt-1";
          repo = "Auto-Sync-Anki-Addon";
          rev = finalAttrs.version;
          hash = "sha256-pXEagmdHiOLTIIP+qvgQFtlvwMrQsXyVxnZHFizq5Uc=";
        };
        postPatch = ''
          substituteInPlace options_dialog.py \
            --replace "from PyQt5 import QtCore, QtGui" "from PyQt6 import QtCore, QtGui"
          substituteInPlace main.py \
            --replace "from PyQt5 import QtCore, QtGui" "from PyQt6 import QtCore, QtGui"
          substituteInPlace config.py \
            --replace "from PyQt5 import QtCore, QtGui" "from PyQt6 import QtCore, QtGui"
          substituteInPlace constants.py \
            --replace "QStyle.SP_BrowserReload" "QStyle.StandardPixmap.SP_BrowserReload"
        '';
      }))
  ];
}
