{
  enable = true;
  dotDir = "./config/zsh";
  enableSyntaxHighlighting = true;
  history.ignoreDups = true;

  envExtra = ''
    export PATH=~/.local/bin:/usr/local/sbin:~/.bin:~/.cargo/bin:~/.local/share/flutter/bin:~/.local/share/sdkmanager/bin
    export TERM=xterm-256color
  '';

  shellAliases = {
    ls = "ls -G";
    ll = "ls -l";

    dc = "docker-compose";

    tn = "tmux new -s";
    ta = "tmux attach -t";
  };

  initExtra = ''
    autoload -U colors && colors

    green_fg="%{$fg[green]%}"
    blue_fg="%{$fg[blue]%}"
    reset_color="%{$reset_color%}"

    PROMPT="
    $blue_fg%~$reset_color
    $green_fg➲ $reset_color"

    set -o vi

    # Load extra configs that I don't want checked into version control
    if [[ -f ~/.zsh_extra ]]; then
        source ~/.zsh_extra
    fi
  '';
}
