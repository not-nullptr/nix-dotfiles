{
  # pkgs,
  modules,
  ...
}:

{
  imports = [
    modules.user.desktop.vscode
    modules.user.cli.nixd
    modules.user.cli.nixfmt
  ];

  home.stateVersion = "25.11";

  home.packages = [ ];

  programs.home-manager.enable = true;
}
