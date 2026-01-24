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

        # it is insane how much config is needed to make this browser respect privacy
        settings = {
          # allow nixos to manage extensions
          "extensions.autoDisableScopes" = 0;
          "extensions.enabledScopes" = 15;

          # no ai
          "browser.ml.enabled" = false;

          # disable telemetry
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.sessions.current.clean" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # disable pocket
          "extensions.pocket.enabled" = false;

          # no sponsors
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          # misc
          "ui.key.menuAccessKeyFocuses" = false; # no alt key focus
          "identity.fxaccounts.enabled" = false; # no firefox account
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # allow userChrome.css

          "browser.tabs.allow_transparent_browser" = true; # this is sick like actually really cool
        };

        # userChrome
        userChrome = ''
            /*
              disable:
              - urlbar search mode switcher (google icon, for example)
              - bookmarks toolbar
              - toolbar spring (the flexible space that spaces out the searchbar for some reason?)
              - all tabs button
              - close button
              - tracking protection icon
              - firefox view button (archive button)
            */
            toolbarspring, 
            #urlbar-searchmode-switcher, 
            #PersonalToolbar,
            #alltabs-button,
            #tracking-protection-icon-container,
            #firefox-view-button,
            .titlebar-buttonbox-container {
              display: none !important;
            }

            /*
              we removed all buttons on the new tab, so add some padding to the left of the urlbar
            */
            #urlbar[unifiedsearchbutton-available=""] {
              padding-left: 8px !important;
            }

            /*
              hide the border where the archive button used to be
            */
            #tabbrowser-tabs {
              border-inline-start: none !important;
              padding-inline-start: 2px !important;
              margin-inline-start: 0 !important;
            }

            /*
              all settings below relate to transparency
            */
            :root {
              --tabpanel-background-color: #00000000 !important;
              --toolbar-bgcolor: transparent !important;
              --toolbar-bgcolor-inactive: transparent !important;
              --in-content-page-background: #00000000 !important;
              --in-content-box-background: #00000088 !important;
            }

            #navigator-toolbox {
              background-color: color-mix(
                in srgb,
                var(--toolbox-bgcolor),
                transparent 25%
              ) !important;
            }

            #navigator-toolbox:-moz-window-inactive {
              background-color: color-mix(
                in srgb,
                var(--toolbox-bgcolor-inactive),
                transparent 50%
              ) !important;
            }

          #nav-bar {
            border-top: none !important;
            border-bottom: 0.01px var(--tabs-navbar-separator-style) var(--tabs-navbar-separator-color) !important;
          }

          .urlbar-background {
            background-color: color-mix(
              in srgb,
              var(--toolbar-field-background-color),
              transparent 50%
            ) !important;
          }

          #urlbar[focused=""] .urlbar-background {
            background-color: color-mix(
              in srgb,
              var(--toolbar-field-focus-background-color),
              transparent 25%
            ) !important;
          }

          .tab-background:is([selected], [multiselected]) {
            background-color: color-mix(
              in srgb,
              var(--tab-selected-bgcolor),
              transparent 25%
            ) !important;
          }
        '';
      };
    };
  };

  stylix.targets.firefox = {
    profileNames = [ "nullptr" ];
    colorTheme.enable = true;
  };
}
