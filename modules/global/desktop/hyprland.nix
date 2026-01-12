{ pkgs, ... }:

let
  commit = "5e181111216ba05c89b245d9b239b47a914fd714";
in
{
  nixpkgs.overlays = [
    (self: super: {
      hyprland = super.hyprland.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "hyprwm";
          repo = "Hyprland";
          rev = commit;
          # fetch submodules so subprojects/hyprland-protocols exists
          fetchSubmodules = true;
          # compute sha256 (see instructions below)
          sha256 = "ZRzxg/4idOnm8AtiTN6S3fd+pTNmipfdVsNnAhRuwBc=";
        };
      });
    })
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
