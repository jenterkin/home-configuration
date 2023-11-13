{ inputs, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home = {
    stateVersion = "23.11";
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

      firefox
      alacritty
      nerdfonts
      powerline-fonts
      discord
      slack
      tofi
      killall
      brave
      waybar
      neofetch
      grimblast
      wlr-randr
      entr
      dig
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

    waybar = {
      source = ./dot-files/waybar;
      recursive = true;
    };

    hypr = {
      source = ./dot-files/hypr;
      recursive = true;
    };

    tofi = {
      source = ./dot-files/tofi;
      recursive = true;
    };
  };


  services.mako = {
    enable = true;
    defaultTimeout = 4000;
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

    ags.enable = true;
  };
}
