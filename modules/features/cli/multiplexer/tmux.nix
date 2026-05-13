{...}: {
  flake.nixosModules.cli_multiplexer = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      fish = config.programs.fish;
      multiplexer = config.custom.cli.multiplexer;
      fzfSessionSwitcher = pkgs.writeShellApplication {
        name = "tmux-fzf-switch";
        runtimeInputs = with pkgs; [
          tmux
          gnused
          fzf
          busybox # xargs
        ];

        text = ''
          # Fetch sessions, handle case where tmux server isn't running
          sessions=$(tmux list-sessions -F "#S" 2>/dev/null || true)

          if [ -z "$sessions" ]; then
              echo "No sessions running. Creating 'main'..."
              tmux new-session -s main
              exit 0
          fi

          target=$(echo "$sessions" | fzf --reverse --header='Jump to Session')

          [ -z "$target" ] && exit 0

          if [ -n "''${TMUX:-}" ]; then
              tmux switch-client -t "$target"
          else
              tmux attach-session -t "$target"
          fi
        '';
      };
    in {
      home.packages = [fzfSessionSwitcher];

      programs.fish.shellAliases."tmj" = "${lib.getExe fzfSessionSwitcher}";

      programs.tmux = lib.mkIf (multiplexer == "tmux") {
        enable = true;

        plugins = with pkgs.tmuxPlugins; [
          better-mouse-mode
          tmux-fzf
          {
            plugin = yank;
            extraConfig = ''
              # Set wl-copy to the copy command just in case
              set -g @override_copy_command 'wl-copy'
            '';
          }
          {
            plugin = resurrect;
            extraConfig = ''
              set -g @resurrect-processes 'yazi'
            '';
          }
          {
            plugin = continuum;
            extraConfig = ''
              set -g @continuum-restore 'on'
            '';
          }
        ];

        shell = lib.mkIf fish.enable "${lib.getExe pkgs.fish}";
        sensibleOnTop = true;

        keyMode = "vi";
        prefix = "C-a";
        mouse = true;

        extraConfig = ''
          # Bind hjkl to switching windows
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          bind -n C-j display-popup -E ${lib.getExe fzfSessionSwitcher}
        '';
      };
    };
  };
}
