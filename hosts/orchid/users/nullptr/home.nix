{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # focus the second monitor on startup
      "hyprctl dispatch focusmonitor DP-2"
    ];

    monitor = [
      "HDMI-A-1, 1920x1080@120, 3840x0, 1"
      "DP-1, 1920x1080@144, 0x0, 1"
      "DP-2, 1920x1080@360, 1920x0, 1"
    ];

    # on boot, we want workspace 1 to be on DP-1, workspace 2 on DP-2, and workspace 3 on HDMI-A-1
    workspace = [
      "1,monitor:DP-1"
      "2,monitor:DP-2"
      "3,monitor:HDMI-A-1"
    ];

    device = [
      {
        name = "razer-razer-naga-v2-hyperspeed";
        sensitivity = -0.965;
        accel_profile = "flat";
      }
    ];
  };

  # figma linux
  home.packages = with pkgs; [
    figma-linux
  ];
}
