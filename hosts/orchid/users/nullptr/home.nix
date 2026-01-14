{
  home.stateVersion = "25.11";

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1, 1920x1080@120, 3840x0, 1"
      "DP-1, 1920x1080@144, 0x0, 1"
      "DP-2, 1920x1080@360, 1920x0, 1"
    ];

    device = [
      {
        name = "razer-razer-naga-v2-hyperspeed";
        sensitivity = -0.965;
        accel_profile = "flat";
      }
    ];
  };
}
