{...}: {
  flake.nixosModules.shell = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = {
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
          # cmdf = "${pkgs.commit-dotfiles}/bin/commit-dotfiles";
          sl = "ls";
          cr = "cargo run";
          ct = "cargo test";
          cp = "cp -r";
          rm = "rm -r";
        };

        interactiveShellInit = ''
          # Remove default greeting
          set -g fish_greeting ""

          # Run fastfetch on startup
          ${lib.optionalString (config.programs.fastfetch.enable) "fastfetch"}
        '';
      };
    };
  };
}
