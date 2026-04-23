{...}: {
  flake.nixosModules.shell = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    fastfetch = hmConfig.programs.fastfetch;
  in {
    programs.fish.enable = true;

    users.users.dastarruer.shell = pkgs.fish;

    home-manager.users.dastarruer = {
      programs.fish = {
        enable = true;

        plugins = with pkgs.fishPlugins; [
          {
            name = "done";
            src = done.src;
          }
        ];

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

          # Configure done (sends notifications after running long commands)
          set -g __done_min_cmd_duration 15000  # 15 seconds
          set -g __done_ring_bell 0
          set -U __done_exclude '^git' # Exclude git commands

          # Run fastfetch on startup
          ${lib.optionalString (fastfetch.enable) "fastfetch"}
        '';
      };
    };
  };
}
