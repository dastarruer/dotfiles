{...}: {
  flake.nixosModules.wm = {...}: {
    nixpkgs.overlays = [
      (final: prev: {
        toggle-focused-monitor = prev.writeShellApplication {
          name = "toggle-focused-monitor";
          runtimeInputs = with prev; [
            hyprland
            jq
          ];

          text = ''
            # Recommended by the hyprland wiki to avoid race conditions: https://wiki.hypr.land/Configuring/Basics/Dispatchers/#cursor
            sleep 0.5

            focused=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
            # I'll keep this here in case i need it, but for now we don't need to know the dpms state
            # state=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .dpmsStatus')

            hyprctl dispatch 'hl.dsp.dpms({ action = "toggle", monitor = "'"$focused"'" })'
          '';
        };
      })
    ];
  };
}
