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

    # hyprland.url = "github:hyprwm/Hyprland?ref=v0.53.1"; # no follow -- cachix

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.7.0";
  };

  outputs =
    {
      self,
      nixpkgs,
      stylix,
      nix-flatpak,
      ...
    }@inputs:
    let
      gitInfo = {
        # commit should be self.rev or self.dirtyRev, whichever exists
        commit = self.rev or self.dirtyRev;
        branch = "main"; # todo!
        dirty = (self.rev or "") != self.dirtyRev;
      };
      hosts = builtins.readDir ./hosts;
      hostNames = builtins.filter (name: hosts.${name} == "directory") (builtins.attrNames hosts);
      modules = import ./modules { lib = nixpkgs.lib; };
      mkConfig =
        hostName:
        let
          host =
            let
              h = import ./hosts/${hostName}/host.nix;
            in
            {
              system = h.system or "x86_64-linux";
              highPerformance = h.highPerformance or false;
              hostName = h.hostName;
            };
        in
        nixpkgs.lib.nixosSystem {
          system = host.system;
          specialArgs = {
            inherit
              inputs
              host
              modules
              gitInfo
              ;
          }; # pass it down i think
          modules = [
            stylix.nixosModules.stylix
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
