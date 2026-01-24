{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      nullptr = {
        isDefault = true;
        extensions = {
          packages = with pkgs.firefox-addons; [
            ublock-origin
            decentraleyes
            firefox-color
            sponsorblock
            return-youtube-dislikes
            control-panel-for-twitter
            restfox-cors-helper
          ];
          force = true;
        };
        settings = {
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };

  stylix.targets.firefox = {
    profileNames = [ "nullptr" ];
    colorTheme.enable = true;
  };
}
