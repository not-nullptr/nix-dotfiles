{
  home.stateVersion = "25.11";

  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 2560x1440@60, 0x0, 1.6"
    ];

    device = [
      {
        name = "syna8005:00-06cb:cd8c-touchpad";
        sensitivity = 0.25;
        accel_profile = "flat";
        natural_scroll = true;
        scroll_factor = 0.25;
      }
    ];
  };
}
