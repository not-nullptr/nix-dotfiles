{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod SHIFT, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"

        # mod + shift + left/right/up/down to move windows
        "$mod SHIFT, LEFT, movewindow, l"
        "$mod SHIFT, RIGHT, movewindow, r"
        "$mod SHIFT, UP, movewindow, u"
        "$mod SHIFT, DOWN, movewindow, d"

        # mod + left/right/up/down to move focus
        "$mod, LEFT, focuswindow, l"
        "$mod, RIGHT, focuswindow, r"
        "$mod, UP, focuswindow, u"
        "$mod, DOWN, focuswindow, d"
      ];
      monitor = [
        "HDMI-A-1, 1920x1080@120, 3840x0, 1"
        "DP-1, 1920x1080@144, 0x0, 1"
        "DP-2, 1920x1080@360, 1920x0, 1"
      ];
      bezier = [
        "quintic, 0.19, 1, 0.22, 1"
      ];
      animation = [
        "windowsIn, 1, 7, quintic, popin"
        "windowsOut, 1, 7, quintic, popin"
        "windowsMove, 1, 7, quintic, slide"
      ];
      general = {

      };
    };
    extraConfig = ''
      device {
        name=razer-razer-naga-v2-hyperspeed
        sensitivity = -0.965
        accel_profile = flat
      }

      input {
        kb_layout = gb
      }
    '';
  };
}
