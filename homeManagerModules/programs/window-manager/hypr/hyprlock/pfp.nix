{inputs, ...}: {
  programs.hyprlock.settings.image = [
    {
      monitor = "";
      path = "${inputs.self.outPath}/config/images/pfp.png";
      border_color = "0xffdddddd";
      border_size = 3;
      size = 173;
      rounding = -1;
      rotate = 0;
      reload_time = -1;
      reload_cmd = "";
      position = "0, 125";
      halign = "center";
      valign = "center";
      shadow_passes = 3;
      shadow_size = 2;
      shadow_boost = 0.5;
    }
  ];
}
