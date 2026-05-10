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
    in {
      programs.tmux = lib.mkIf (multiplexer == "tmux") {
        enable = true;

        shell = lib.mkIf fish.enable "${lib.getExe pkgs.fish}";
        sensibleOnTop = true;
        keyMode = "vi";
        prefix = "C-a";

        # Bind hjkl to switching windows
        extraConfig = ''
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R
        '';
      };
    };
  };
}
