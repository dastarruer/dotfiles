{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      kill-apps = prev.writeShellApplication {
        name = "kill-apps";

        runtimeInputs = with prev; [
          procps # pkill
        ];

        text = ''
          pkill -f todoist
          pkill -f anki
          pkill -f spotify
          pkill -f obsidian
          # Kill without cleanup
          pkill -9 codium
        '';
      };
    })
  ];
}
