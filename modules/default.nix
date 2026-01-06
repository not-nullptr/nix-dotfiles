{
  global = {
    desktop = {
      gnome-keyring = ./global/desktop/gnome-keyring.nix;
      hyprland = ./global/desktop/hyprland.nix;
      kitty = ./global/desktop/kitty.nix;
      sddm = ./global/desktop/sddm.nix;
      seatd = ./global/desktop/seatd.nix;
      xdg = ./global/desktop/xdg.nix;
    };

    drivers = {
      nvidia = ./global/drivers/nvidia.nix;
    };

    base = ./global/base.nix;
  };

  user = {
    cli = {
      nixd = ./user/cli/nixd.nix;
      nixfmt = ./user/cli/nixfmt.nix;
    };

    desktop = {
      firefox = ./user/desktop/firefox.nix;
      rofi = ./user/desktop/rofi.nix;
      vscode = ./user/desktop/vscode.nix;
    };

    base = ./user/base.nix;
  };
}