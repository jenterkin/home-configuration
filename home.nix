{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "jordanenterkin";
  home.homeDirectory = "/Users/jordanenterkin";

  home.stateVersion = "21.11";

  xdg.configFile = {
    nvim = {
      source = ./dot-files/nvim;
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
