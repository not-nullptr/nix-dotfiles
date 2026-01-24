{
  programs.bash.enable = true;
  programs.bash.enableCompletion = false; # causes issues with `nix develop`
  programs.bash.initExtra = ''
    parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }
    export PS1="\[\e[32m\]\u@\h \[\e[34m\]\w\[\e[33m\]\$(parse_git_branch)\[\e[0m\] $ ";
  '';
}
