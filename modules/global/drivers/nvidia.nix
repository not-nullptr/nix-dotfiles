{
  hardware.nvidia.modesetting.enable = true;
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  services.xserver.videoDrivers = [ "nvidia" ];
}
