{
  # pkgs,
  modules,
  ...
}:

{
  imports = [
    modules.user.desktop.kitty
    modules.user.desktop.vscode
    modules.user.cli.nixd
    modules.user.cli.nixfmt
  ];

  home.stateVersion = "25.11";
  home.packages = [ ];
  programs.home-manager.enable = true;

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

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "nullptr@vert.sh";
        name = "not-nullptr";
      };
    };
  };
}
