{
  enable = true;
  dotDir = "./config/zsh";
  enableSyntaxHighlighting = true;
  history.ignoreDups = true;

  envExtra = ''
    export PATH=~/.local/bin:/usr/local/sbin:~/.bin:~/.cargo/bin
    export TERM=xterm-256color
  '';

  profileExtra = ''
    if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
  '';

  shellAliases = {
    ls = "ls -G";
    ll = "ls -l";

    dc = "docker-compose";

    tn = "tmux new-session -s";
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

    source $HOME/.nix-profile/etc/profile.d/nix.sh

    # Load extra configs that I don't want checked into version control
    if [[ -f ~/.zsh_extra ]]; then
        source ~/.zsh_extra
    fi
  '';
}
