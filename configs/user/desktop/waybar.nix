{
  config,
  ...
}:

let
  colours = config.lib.stylix.colors;
  iconSize = "16px";
  icon = glyph: "<span font=\"${iconSize}\">${glyph}</span>";
in
{
  stylix.targets.waybar.font = "sansSerif";

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        font-family = "Geist, Symbols Nerd Font";
        layer = "top";
        position = "top";
        height = 28;
        margin = "10 15 0 15";
        spacing = 20;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "temperature"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        "battery" = {
          format = "${icon "{icon} "} {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          # format-charging = "${icon "{icon}"}  {capacity}%";
          # format-icons-charging = [
          #   ""
          #   ""
          #   ""
          #   ""
          #   ""
          # ];
        };

        "clock" = {
          format = "${icon " "}{:%d/%m/%Y %H:%M}";
        };

        "temperature" = {
          format = "${icon "{icon}"}  {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
      };
    };

    style = ''
      #waybar {
        border-bottom: 2px solid #${colours.base05};
        border-radius: 8px;
      }

      #waybar > box {
        padding-top: 4px;
        padding-left: 4px;
        padding-bottom: 6px;
        padding-right: 18px;
      }

      button {
        background: transparent;
      }

      button.active {
        background: #${colours.base02};
      }

      button.active label {
        color: #${colours.base05};
      }
    '';
  };
}
