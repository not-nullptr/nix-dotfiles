{
  modules,
  host,
  user,
  inputs,
  lib,
  ...
}:

let
  globalUsers = import ../global-users { inherit lib; };
in
{
  imports = [
    inputs.stylix.homeModules.stylix
    ../hosts/${host.hostName}/users/${user.username}/home.nix
    modules.user.base
    globalUsers.${user.username}.home
    ../configs/user/base.nix
  ];

  home.username = user.username;
  home.homeDirectory = if builtins.hasAttr "home" user then user.home else "/home/${user.username}";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.firefox-addons.overlays.default
  ];

  home.file."Pictures/Wallpapers".source = ../wallpapers;
}
