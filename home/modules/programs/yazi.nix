{pkgs, ...}: {
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
      ];
    };
  };
}
