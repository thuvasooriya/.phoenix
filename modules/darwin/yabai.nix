{lib, ...}: {
  services.yabai = {
    enable = false;
    enableScriptingAddition = true;
    config = {
      # focus_follows_mouse = "autoraise";
      mouse_follows_focus = "off";
      space_focus_follows_mouse = "off";
      # window_origin_display
      window_placement = "second_child";
      # window_opacity = "on";
      # window_opacity_duration = "0.0";
      window_topmost = "on";
      window_shadow = "float";
      # active_window_border_color = "0xff5c7e81";
      # normal_window_border_color = "0xff505050";
      # insert_window_border_color = "0xffd75f5f";
      # active_window_opacity = "1.0";
      # normal_window_opacity = "0.9";
      split_ratio = "0.5";
      auto_balance = "on";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      # mouse_action2 = "resize";
      layout = "bsp";
      top_padding = 5;
      bottom_padding = 5;
      left_padding = 5;
      right_padding = 5;
      window_gap = 5;
    };

    extraConfig = ''
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      sudo yabai --load-sa

      # rules
      yabai -m rule --add app="^(Finder|Calendar|.scrcpy-wrapped|Shortcuts|Movist Pro|Little Snitch|Calculator|Software Update|Dictionary|System Preferences|System Settings|zoom.us|Photo Booth|Archive Utility|Python|App Store|Raycast|Activity Monitor)$" manage=off
      yabai -m rule --add label="About This Mac" app="System Information" title="About This Mac" manage=off
      yabai -m rule --add app="^sioyek$" space=3
      yabai -m rule --add app="^Orion$" space=2
      yabai -m rule --add app="^Ghostty$" space=1
      yabai -m rule --add app="^Calendar$" space=1
      # yabai -m rule --add app!="^(Calendar|Ghostty|Orion|sioyek)$" space=4
      yabai -m rule --add app="(WhatsApp|ria|spotube)" manage=off
      # yabai -m rule --add app="ria" manage=off
      # yabai -m rule --add app="spotube" title="Spotube" manage=off

      borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0 &
    '';
  };
}
