{ pkgs, ... }:

{
  imports = [
    ./nm-applet.nix
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
  };
}
