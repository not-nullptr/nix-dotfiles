# { inputs, host, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # package = inputs.hyprland.packages.${host.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${host.system}.xdg-desktop-portal-hyprland;
  };
}
