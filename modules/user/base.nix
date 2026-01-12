{ modules, ... }:

{
  imports = [
    modules.user.desktop.brightnessctl
    modules.user.desktop.rofi
    modules.user.desktop.firefox
    modules.user.desktop.geist
    modules.user.desktop.swww
    modules.user.desktop.waybar
  ];
}
