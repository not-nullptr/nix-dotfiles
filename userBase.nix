{ config, pkgs, hostVars, ...}:

{
  imports = [
    ./hosts/${hostVars.hostName}/users/nullptr/home.nix
    ./modules/user/base.nix
    ./configs/user/base.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
