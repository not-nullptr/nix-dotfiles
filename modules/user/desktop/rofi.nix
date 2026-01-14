{
  config,
  lib,
  host,
  ...
}:

let
  mkLiteral = config.lib.formats.rasi.mkLiteral;
  coloursRaw = config.lib.stylix.colors;
  hexToRgb =
    hexString:
    let
      # Helper function to convert a single hex digit to decimal
      hexDigitToDec =
        c:
        if c == "0" then
          0
        else if c == "1" then
          1
        else if c == "2" then
          2
        else if c == "3" then
          3
        else if c == "4" then
          4
        else if c == "5" then
          5
        else if c == "6" then
          6
        else if c == "7" then
          7
        else if c == "8" then
          8
        else if c == "9" then
          9
        else if c == "a" || c == "A" then
          10
        else if c == "b" || c == "B" then
          11
        else if c == "c" || c == "C" then
          12
        else if c == "d" || c == "D" then
          13
        else if c == "e" || c == "E" then
          14
        else if c == "f" || c == "F" then
          15
        else
          throw "Invalid hex digit: ${c}";

      hexPairToDec =
        str:
        let
          chars = lib.stringToCharacters str;
          high = hexDigitToDec (builtins.elemAt chars 0);
          low = hexDigitToDec (builtins.elemAt chars 1);
        in
        high * 16 + low;

      red = builtins.substring 0 2 hexString;
      green = builtins.substring 2 2 hexString;
      blue = builtins.substring 4 2 hexString;
    in
    {
      r = hexPairToDec red;
      g = hexPairToDec green;
      b = hexPairToDec blue;
    };

  colours = lib.mapAttrs (name: value: hexToRgb value) coloursRaw;
  rgba = (c: a: "rgba(${toString c.r}, ${toString c.g}, ${toString c.b}, ${toString a})");
  rgb = (c: "rgb(${toString c.r}, ${toString c.g}, ${toString c.b})");
in
{
  programs.rofi = {
    enable = true;
    theme = {
      "window" = {
        border-radius = mkLiteral "12px";
        border = mkLiteral "2px solid";
        border-color = mkLiteral "@selected-normal-background";
        background-color = lib.mkForce (
          mkLiteral (if host.highPerformance then rgba colours.base00 0.5 else rgb coloursRaw.base00)
        );
      };

      "*" = {
        background-color = lib.mkForce (mkLiteral "transparent");
        background = lib.mkForce (
          mkLiteral (if host.highPerformance then rgba colours.base00 0.5 else rgb coloursRaw.base00)
        );
        lightbg = lib.mkForce (
          mkLiteral (if host.highPerformance then rgba colours.base01 0.5 else rgb coloursRaw.base01)
        );
      };

      "inputbar" = {
        padding = mkLiteral "8px 12px";
      };

      "entry" = {
        placeholder = "Search...";
      };

      "element" = {
        padding = mkLiteral "4px 8px";
      };

      "element-icon" = {
        size = mkLiteral "20px";
        # margin-right = mkLiteral "32px";
        margin = mkLiteral "0px 8px 0px 4px";
      };

      "element-text" = {
        vertical-align = mkLiteral "0.5";
      };

      "prompt" = {
        enabled = false;
      };
    };
  };

  stylix.targets.rofi = {
    fonts.override = {
      monospace = config.stylix.fonts.sansSerif;
    };
  };
}
