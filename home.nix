{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  xdg.configFile = {
    nvim = {
      source = ./dot-files/nvim;
      recursive = true;
    };

    direnv = {
      source = ./dot-files/direnv;
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
    gh
    git
    jq
    neovim
    ripgrep
    tmux
    wget
  ];

  programs = {
    zsh = import ./programs/zsh.nix;
    direnv = import ./programs/direnv.nix;
  };

}
