{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      github.copilot
      github.copilot-chat
    ];

    userSettings = {
      # editor stuff
      "editor.inlineSuggest.edits.allowCodeShifting" = "never";
      "editor.formatOnSave" = true;
      "window.zoomLevel" = 1;
      "editor.stickyScroll.enabled" = false;
      "terminal.integrated.stickyScroll.enabled" = false;
      "editor.inlineSuggest.edits.showCollapsed" = true;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;

      # nix-ide
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
    };
  };
}
