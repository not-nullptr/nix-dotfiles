{
  config,
  palette,
  ...
}:

let
  catppuccin = config.catppuccin;
  colours = palette.${catppuccin.flavor}.colors;
  accent = catppuccin.accent;
  colour = colour: colours.${colour}.hex;
  iconSize = "18px";
  icon = glyph: "<span font=\"${iconSize}\">${glyph}</span>";
in
{
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
          format = "${icon "{icon}"}  {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          format-charging = "${icon "{icon}"}  {capacity}%";
          format-icons-charging = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "clock" = {
          format = "${icon ""}  {:%d/%m/%Y %H:%M}";
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
      * {
        color: ${colour "text"};
      }

      #waybar {
        background: ${colour "base"};
        color: ${colour "text"};
        border-bottom: 2px solid ${colour accent};
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
        background: ${colour accent};
      }

      button.active label {
        color: ${colour "base"};
      }
    '';
  };
}
