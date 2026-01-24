{ pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      github.copilot
      github.copilot-chat
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];

    userSettings = {
      "window.zoomLevel" = 1;

      "workbench.colorTheme" = lib.mkForce "Catppuccin Macchiato";
      "workbench.iconTheme" = lib.mkForce "catppuccin-macchiato";
      "workbench.editor.empty.hint" = "hidden";

      "editor.fontWeight" = "500";
      "editor.lineHeight" = 1.6;
      "editor.stickyScroll.enabled" = false;
      "editor.inlineSuggest.edits.showCollapsed" = true;
      "editor.formatOnSave" = true;
      "editor.inlineSuggest.edits.allowCodeShifting" = "never";
      "editor.inlayHints.enabled" = "off";

      "git.confirmSync" = false;
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;

      "terminal.integrated.initialHint" = false;
      "terminal.integrated.stickyScroll.enabled" = false;
      "terminal.integrated.fontWeight" = "500";

      "github.copilot.nextEditSuggestions.enabled" = false;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
    };
  };
}
