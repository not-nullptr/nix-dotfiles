{
  description = "my system ^_^";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      hosts = builtins.readDir ./hosts;
      hostNames = builtins.filter (name: hosts.${name} == "directory") (builtins.attrNames hosts);
      modules = import ./modules;
      mkConfig = hostName: 
      let
        hostVars = import ./hosts/${hostName}/host.nix;
      in
      nixpkgs.lib.nixosSystem {
        system = hostVars.system;
        specialArgs = { inherit inputs hostVars modules; }; # pass it down i think
        modules = [
          ./hosts/${hostName}/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    in
    {
      nixosConfigurations = builtins.listToAttrs (map (hostName: {
        name = hostName;
        value = mkConfig hostName;
      }) hostNames);
    };
}
