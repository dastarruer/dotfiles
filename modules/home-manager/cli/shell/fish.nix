{
  config,
  lib,
  pkgs,
  ...
}: let
  rclone = config.home-manager.cli.rclone;
in {
  options = {
    home-manager.cli.shell.fish.enable = lib.mkEnableOption "Enable fish functionality.";
  };

  config = lib.mkIf config.home-manager.cli.shell.fish.enable {
    programs.fish = {
      enable = true;

      # Aliases are handled in their own dedicated attribute set
      shellAliases = {
        code = "${lib.getExe config.programs.vscode.package}";
        chx = "chmod +x";
        pr = "python3 main.py";
        df = "cd ~/.dotfiles";
        grep = "grep -i";
        ".." = "z ..";
        b = "btop";
        mkdir = "mkdir -p";
        cmdf = "${pkgs.commit-dotfiles}/bin/commit-dotfiles";
        backup = lib.mkIf rclone.enable "${pkgs.backup}/bin/backup";
        sl = "ls";
        zth = "zathura";
        ga = "git add";
        gb = "git branch";
        "g." = "git add . && git status";
        gs = "git status";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline --graph --decorate";
        gch = "git checkout";
        cr = "cargo run";
        ct = "cargo test";
        y = "yazi";
        fdf = "${pkgs.fzfdf}/bin/fzfdf";
        fish-edit = "nano ~/.dotfiles/fish/.config/fish/config.fish";
        cp = "cp -r";
        rm = "rm -r";
      };

      interactiveShellInit = ''
        # Remove default greeting
        set -g fish_greeting ""

        # Run fastfetch on startup
        fastfetch
      '';
    };
  };
}
