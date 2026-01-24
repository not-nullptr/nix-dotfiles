{ pkgs, modules, ... }:

{
  imports = [
    modules.global.drivers.usbmuxd2
  ];

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
    # lsusb
  ];
}
