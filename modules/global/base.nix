# this is the base configuration applied across all of my hosts.
# it should set up basic things (like sddm, hyprland, xdg, etc) which
# i want everywhere.

{
  pkgs,
  inputs,
  host,
  modules,
  config,
  lib,
  ...
}:

let
  getUser =
    username:
    let
      specificUserPath = ../../hosts/${host.hostName}/users/${username}/user.nix;
      globalUserPath = ../../global-users/${username}/user.nix;
      specificUserExists = builtins.pathExists specificUserPath;
      globalUserExists = builtins.pathExists globalUserPath;
      specificUser = if specificUserExists then import specificUserPath else null;
      globalUser = if globalUserExists then import globalUserPath else null;
    in
    if !specificUserExists && !globalUserExists then
      throw "Neither specific user file (${specificUserPath}) nor global user file (${globalUserPath}) exists for user ${username}, which means we can't know their username or home directory. Create a global user at globalUsers/${username}/user.nix or a specific user at hosts/${host.hostName}/users/${username}/user.nix."
    else
      lib.mergeAttrs (if globalUserExists then globalUser else { }) (
        if specificUserExists then specificUser else { }
      );
in
{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  imports = [
    ../../hosts/${host.hostName}/hardware-configuration.nix
    ../../configs/global/base.nix
    modules.global.desktop.sddm
    modules.global.desktop.hyprland
    modules.global.desktop.xdg
    modules.global.desktop.seatd
    modules.global.desktop.gnome-keyring
    modules.global.drivers.libimobiledevice
  ];

  services.flatpak.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = host.hostName;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  console.keyMap = "uk";

  users.users = builtins.listToAttrs (
    map (username: {
      name = username;
      value = getUser username;
    }) (builtins.attrNames (builtins.readDir ../../hosts/${host.hostName}/users))
  );

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        host
        modules
        ;
    };
    users = builtins.listToAttrs (
      map (username: {
        name = username;
        value = import ../../global-users/base.nix {
          inherit
            inputs
            host
            modules
            lib
            config
            pkgs
            ;
          user =
            let
              user = getUser username;
            in
            {
              inherit username user;
            };
        };
      }) (builtins.attrNames (builtins.readDir ../../hosts/${host.hostName}/users))
    );
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

  environment.systemPackages = with pkgs; [
    git
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
