{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    geist-font
    nerd-fonts.symbols-only
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Geist" ];
      monospace = [ "Geist Mono" ];
    };
  };

  # we want to enable the font in kitty as well
  programs.kitty.settings = {
    font_family = "family='Geist mono' postscript_name=GeistMono-Regular";
    font_size = 12.0;
    bold_font = "auto";
    italic_font = "auto";
    bold_italic_font = "auto";
  };
}
