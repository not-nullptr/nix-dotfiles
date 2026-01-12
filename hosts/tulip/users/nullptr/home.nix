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
      "eDP-1, 2560x1440@60, 0x0, 1.6"
    ];

    device = [
      {
        name = "syna8005:00-06cb:cd8c-touchpad";
        sensitivity = 0.25;
        accel_profile = "flat";
        natural_scroll = true;
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
