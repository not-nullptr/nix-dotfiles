{
  modules,
  host,
  user,
  ...
}:

{
  imports = [
    ./hosts/${host.hostName}/users/${user.username}/home.nix
    modules.user.base
    ./configs/user/base.nix
  ];

  home.username = user.username;
  home.homeDirectory = if builtins.hasAttr "home" user then user.home else "/home/${user.username}";
  nixpkgs.config.allowUnfree = true;
}
