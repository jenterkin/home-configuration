{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home = {
    stateVersion = "23.05";
    username = "jenterkin";

    file = {
      ".bin" = {
        source = ./bin;
        recursive = true;
      };
    };

    packages = with pkgs; [
      bat
      fd
      ffmpeg
      gcc
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
  };

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
