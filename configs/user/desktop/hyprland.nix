{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod SHIFT, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"
      ];
      monitor = [
        "HDMI-A-1, 1920x1080@120, 3840x0, 1"
        "DP-1, 1920x1080@144, 0x0, 1"
        "DP-2, 1920x1080@360, 1920x0, 1"
      ];
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
