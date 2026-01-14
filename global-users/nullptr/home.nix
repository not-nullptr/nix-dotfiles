{
  modules,
  pkgs,
  ...
}:

let
  cursorSize = 20;
in
{
  imports = [
    modules.user.desktop.kitty
    modules.user.desktop.vscode
    modules.user.cli.nixd
    modules.user.cli.nixfmt
  ];

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    hyprcursor = {
      enable = true;
      size = cursorSize;
    };
    size = cursorSize;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };

  wayland.windowManager.hyprland = {
    settings = {
      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,${toString cursorSize}"
        "ELECTRON_OZNE_PLATFORM_HINT,wayland"
        "NIXOS_OZONE_WL,1"
      ];
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "nullptr@vert.sh";
        name = "not-nullptr";
      };
    };
  };
}
