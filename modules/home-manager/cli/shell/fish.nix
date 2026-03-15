{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    home-manager.cli.shell.fish.enable = lib.mkEnableOption "Enable fish functionality.";
  };

  config = lib.mkIf config.home-manager.cli.shell.fish.enable {
    programs.fish = {
      enable = true;

      # Aliases are handled in their own dedicated attribute set
      shellAliases = {
        chx = "chmod +x";
        pr = "python3 main.py";
        df = "cd ~/.dotfiles";
        grep = "grep -i";
        ".." = lib.mkDefault "cd ..";
        mkdir = "mkdir -p";
        cmdf = "${pkgs.commit-dotfiles}/bin/commit-dotfiles";
        sl = "ls";
        cr = "cargo run";
        ct = "cargo test";
        fdf = "${pkgs.fzfdf}/bin/fzfdf";
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
