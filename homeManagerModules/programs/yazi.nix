{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    dotfiles.yazi.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable yazi, a terminal file browser.";
    };
  };

  config = lib.mkIf config.dotfiles.yazi.enable {
    programs.yazi = {
      enable = true;

      keymap = {
        mgr.prepend_keymap = [
          {
            on = "<C-n>";
            run = ''shell -- ${pkgs.dragon-drop}/bin/dragon-drop -x -i -T "$1"'';
            desc = "Initiate drag and drop";
          }
          {
            on = "<C-f>";
            run = "cd /home/dastarruer/Documents/school/G10";
            desc = "Change to schoolwork dir";
          }
          {
            on = "<C-o>";
            run = ''shell -- ${pkgs.ocrmypdf}/bin/ocrmypdf --skip-text "$1" "$1"'';
            desc = "Add OCR layer to pdf";
          }
        ];
      };
    };
  };
}
