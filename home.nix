{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  xdg.configFile = {
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
    git
    jq
    neovim
    ripgrep
    tmux
  ];

  programs = {
    zsh = import ./programs/zsh.nix;
    direnv = import ./programs/direnv.nix;
  };

}
