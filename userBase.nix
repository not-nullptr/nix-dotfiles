{
  config,
  modules,
  host,
  user,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  accent = "mauve";
  flavor = "macchiato";
  cursorSize = 20;
  # cursorName =
  #   { flavor, accent }:
  #   "catppuccin-${flavor}-${accent}-cursors";
in
{
  imports = [
    ./hosts/${host.hostName}/users/${user.username}/home.nix
    modules.user.base
    ./configs/user/base.nix
    inputs.catppuccin.homeModules.catppuccin
  ];

  # boilerplate we'd repeat across users
  home.username = user.username;
  home.homeDirectory = if builtins.hasAttr "home" user then user.home else "/home/${user.username}";

  # certain theming things for consistency across all my machines
  catppuccin.enable = true;
  catppuccin.accent = accent;
  catppuccin.flavor = flavor;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    hyprcursor = {
      enable = true;
      size = cursorSize;
    };
    size = cursorSize;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };

  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,${toString cursorSize}"
      ];
    };
  };

  # vscode isn't declarative for now
  catppuccin.vscode.enable = false;
  nixpkgs.config.allowUnfree = true;

  home.file."Pictures/Wallpapers".source = ./wallpapers;
}
