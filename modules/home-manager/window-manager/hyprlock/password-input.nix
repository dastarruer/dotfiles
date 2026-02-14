{...}: {
  programs.hyprlock.settings = {
    label = [
      {
        monitor = "";
        text = "Enter Password";
        color = "rgba(242, 243, 244, 0.75)";
        font_size = 10;
        font_family = "JetBrains Mono Nerd Font";
        position = "0, -438";
        halign = "center";
        valign = "center";
      }
    ];

    input-field = [
      {
        monitor = "";
        size = "300, 30";
        outline_thickness = 0;
        dots_size = 0.25;
        dots_spacing = 0.55;
        dots_center = true;
        dots_rounding = -1;
        outer_color = "rgba(242, 243, 244, 0)";
        inner_color = "rgba(242, 243, 244, 0)";
        font_color = "rgba(242, 243, 244, 0.75)";
        fade_on_empty = false;
        placeholder_text = "";
        hide_input = false;
        check_color = "rgba(204, 136, 34, 0)";
        fail_color = "rgba(204, 34, 34, 0)";
        fail_text = "$FAIL <b>($ATTEMPTS)</b>";
        capslock_color = "-1";
        numlock_color = "-1";
        bothlock_color = "-1";
        invert_numlock = false;
        swap_font_color = false;
        position = "0, -468";
        halign = "center";
        valign = "center";
      }
    ];
  };
}
