{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "jordanenterkin";
  home.homeDirectory = "/Users/jordanenterkin";

  home.stateVersion = "21.11";

  xdg.configFile = {
    nvim = {
      source = ./nvim;
      recursive = true;
    };
  };

  home.packages = with pkgs; [
    bat
    fd
    jq
    ripgrep
    tmux
    neovim
  ];

  programs.zsh = {
    enable = true;
    dotDir = "./config/zsh";
    enableSyntaxHighlighting = true;
    history.ignoreDups = true;

    envExtra = ''
      export PATH=~/.local/bin:/usr/local/sbin
      export TERM=xterm-256color
    '';

    profileExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
    '';

    shellAliases = {
      ls = "ls -G";
      ll = "ls -l";

      dc = "docker-compose";

      teedown-console = ''convox run web "APPOPTICS_SERVICE_KEY=dummy rails c" -r teespring/rails-staging -a teespring'';

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

      eval "$(rbenv init -)"

      function rtrev () {
          convox run web "APPOPTICS_SERVICE_KEY=dummy rails c" -r teespring/rails-staging -a "rails-teespring-$1"
      }
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };
}
