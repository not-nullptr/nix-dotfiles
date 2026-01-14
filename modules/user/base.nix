{ modules, ... }:

{
  imports = [
    modules.user.desktop.brightnessctl
    modules.user.desktop.rofi
    modules.user.desktop.firefox
    modules.user.desktop.swww
    modules.user.desktop.waybar
    modules.user.desktop.equibop
    modules.user.desktop.pavucontrol
  ];
}
