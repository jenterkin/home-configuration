{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";

  xdg.configFile = {
    alacritty = {
      source = ./dot-files/alacritty;
      recursive = true;
    };

    direnv = {
      source = ./dot-files/direnv;
      recursive = true;
    };

    nvim = {
      source = ./dot-files/nvim;
      recursive = true;
    };
  };

  home.file = {
    ".bin" = {
      source = ./bin;
      recursive = true;
    };
  };

  home.packages = with pkgs; [
    bat
    fd
    ffmpeg
    gh
    gifsicle
    git
    jq
    neovim
    nixops_unstable
    ripgrep
    rnix-lsp
    tree
    wget
  ];

  programs = {
    direnv = import ./programs/direnv.nix;
    zsh = import ./programs/zsh.nix;
    tmux = {
      enable = true;
      extraConfig = ''
        set-option -ga terminal-overrides ",xterm-256color:Tc"
        set -g default-terminal "xterm"
      '';
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = power-theme;
          extraConfig = "set -g @tmux_power_theme 'sky'";
        }
      ];
    };
  };
}
