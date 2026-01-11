{
  modules,
  host,
  user,
  inputs,
  ...
}:

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
  catppuccin.accent = "pink";
  catppuccin.flavor = "macchiato";

  # vscode isn't declarative for now
  catppuccin.vscode.enable = false;

  nixpkgs.config.allowUnfree = true;
}
