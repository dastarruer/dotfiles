{...}: {
  programs.hyprlock.settings.label = [
    {
      monitor = "";
      text = ''
        cmd[update:1000] echo "$(${./scripts/battery-status.sh})"
      '';
      color = "rgba(242, 243, 244, 0.75)";
      font_size = 15;
      font_family = "JetBrains Mono Nerd Font Propo";
      position = "-25, 512";
      halign = "right";
      valign = "center";
    }
  ];
}
