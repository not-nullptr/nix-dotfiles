{ modules, hostVars, ...}:

{
  imports = [
    ./hosts/${hostVars.hostName}/users/nullptr/home.nix
    modules.user.base
    ./configs/user/base.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
