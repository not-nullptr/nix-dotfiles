{ modules, ... }:

{
  imports = [
    modules.user.desktop.rofi
    modules.user.desktop.firefox
  ];
}
