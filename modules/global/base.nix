# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  host,
  modules,
  palette,
  config,
  lib,
  ...
}:

{
  imports = [
    ../../hosts/${host.hostName}/hardware-configuration.nix
    ../../configs/global/base.nix
    modules.global.desktop.sddm
    modules.global.desktop.hyprland
    modules.global.desktop.xdg
    modules.global.desktop.seatd
    modules.global.desktop.gnome-keyring
  ];

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
      value = import ../../hosts/${host.hostName}/users/${username}/user.nix;
    }) (builtins.attrNames (builtins.readDir ../../hosts/${host.hostName}/users))
  );

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        host
        modules
        palette
        ;
    };
    users = builtins.listToAttrs (
      map (username: {
        name = username;
        value = import ../../userBase.nix {
          inherit
            inputs
            host
            modules
            palette
            lib
            config
            pkgs
            ;
          user =
            let
              user = import ../../hosts/${host.hostName}/users/${username}/user.nix;
            in
            {
              inherit user username;
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
