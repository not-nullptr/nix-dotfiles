{
  description = "my system ^_^";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "github:petrkozorezov/firefox-addons-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      stylix,
      ...
    }@inputs:
    let
      hosts = builtins.readDir ./hosts;
      hostNames = builtins.filter (name: hosts.${name} == "directory") (builtins.attrNames hosts);
      modules = import ./modules { lib = nixpkgs.lib; };
      mkConfig =
        hostName:
        let
          host = import ./hosts/${hostName}/host.nix;
        in
        nixpkgs.lib.nixosSystem {
          system = host.system;
          specialArgs = {
            inherit
              inputs
              host
              modules
              ;
          }; # pass it down i think
          modules = [
            stylix.nixosModules.stylix
            (
              { config, ... }:
              {
                nixpkgs.overlays = [
                  inputs.firefox-addons.overlays.default
                ];
              }
            )
            ./hosts/${hostName}/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (hostName: {
          name = hostName;
          value = mkConfig hostName;
        }) hostNames
      );
    };
}
