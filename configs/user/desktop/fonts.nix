{
  pkgs,
  ...
}:

{
  # home.packages = with pkgs; [
  #   geist-font
  #   nerd-fonts.symbols-only
  #   nerd-fonts.monaspace
  # ];

  # fonts.fontconfig = {
  #   enable = true;
  #   defaultFonts = {
  #     sansSerif = [ "Geist" ];
  #     monospace = [ "MonaspiceNe NF" ];
  #   };
  # };

  stylix.fonts = {
    sansSerif = {
      package = pkgs.geist-font;
      name = "Geist";
    };

    monospace = {
      package = pkgs.nerd-fonts.monaspace;
      name = "MonaspiceNe Nerd Font";
    };

    sizes = {
      applications = 11;
      desktop = 11;
    };
  };

  # we want to enable the font in kitty as well
  programs.kitty.settings = {
    font_family = "family=\"MonaspiceNe Nerd Font\" style=Medium";
    font_size = 12.0;
    bold_font = "auto";
    italic_font = "auto";
    bold_italic_font = "auto";
  };
}
