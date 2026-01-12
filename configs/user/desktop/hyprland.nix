{
  config,
  palette,
  host,
  inputs,
  ...
}:

let
  catppuccin = config.catppuccin;
  colours = palette.${catppuccin.flavor}.colors;
  accent = catppuccin.accent;
  colour = colour: "rgb(${builtins.substring 1 (-1) colours.${colour}.hex})";
  homeDir = config.home.homeDirectory;
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      exec-once = [
        "swww img ${homeDir}/Pictures/Wallpapers/railroad.jpg"
        "waybar"
      ];

      workspace = [
        # why doesn't this work?
        "name:scratchpad, gapsout:0"
      ];

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod SHIFT, Q, killactive"
        "$mod, SPACE, exec, rofi -show drun"

        # mod + shift + left/right/up/down to move windows
        "$mod SHIFT, LEFT, movewindow, l"
        "$mod SHIFT, RIGHT, movewindow, r"
        "$mod SHIFT, UP, movewindow, u"
        "$mod SHIFT, DOWN, movewindow, d"

        # mod + left/right/up/down to move focus
        "$mod, LEFT, movefocus, l"
        "$mod, RIGHT, movefocus, r"
        "$mod, UP, movefocus, u"
        "$mod, DOWN, movefocus, d"

        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));

      bezier = [
        "quintic, 0.19, 1, 0.22, 1"
      ];

      animation = [
        "windowsIn, 1, 6, quintic, popin"
        "windowsOut, 1, 6, quintic, popin"
        "windowsMove, 1, 6, quintic, slide"
        "border, 1, 6, quintic"
        "borderangle, 1, 6, quintic"
        "fade, 1, 6, quintic"
        "workspaces, 1, 6, quintic"
      ];

      general = {
        border_size = 2;
        gaps_in = 10;
        gaps_out = 15;
        "col.active_border" = colour accent;
        "col.inactive_border" = colour "mantle";
      };

      decoration = {
        rounding = 12;
        rounding_power = 4.0;

        blur = {
          enabled = true;
          size = 32;
          passes = 3;
          noise = 0.2;
        };

        shadow = {
          enabled = true;
          render_power = 4;
          range = 16;
          color = "rgba(0, 0, 0, 0.25)";
          color_inactive = "rgba(0, 0, 0, 0.15)";
        };
      };

      input = {
        kb_layout = "gb";
      };

      gesture = [
        # 3 finger swipe left/right to switch workspace
        "3, horizontal, scale: 0.5, workspace"

        # 3 finger swipe up to enter scratch workspace
        "3, up, scale: 0.5, special, scratchpad"

        # 4 finger swipe move window
        "4, left, dispatcher, movewindow, l"
        "4, right, dispatcher, movewindow, r"
        "4, up, dispatcher, movewindow, u"
        "4, down, dispatcher, movewindow, d"
      ];
    };
  };

  services.swww = {
    enable = true;
    # settings = {
    #   preload = [
    #     "${homeDir}/Pictures/Wallpapers/railroad.jpg"
    #   ];

    #   wallpapers = [
    #     {
    #       monitor = "";
    #       path = "${homeDir}/Pictures/Wallpapers/railroad.jpg";
    #     }
    #   ];
    # };
  };
}
