{
  inputs =
    {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              rnix-lsp
              nodePackages.bash-language-server
            ];
          };
        }) // {
      homeConfigurations = {
        personalDarwin = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-darwin";
          username = "jenterkin";
          homeDirectory = "/Users/jenterkin";
          stateVersion = "21.11";
          configuration.imports = [ ./home.nix ];
        };

        personalLinux = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          username = "jenterkin";
          homeDirectory = "/home/jenterkin";
          stateVersion = "21.11";
          configuration.imports = [ ./home.nix ];
        };

        work = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-darwin";
          username = "jordanenterkin";
          homeDirectory = "/Users/jordanenterkin";
          stateVersion = "21.11";
          configuration.imports = [ ./home.nix ];
        };
      };
    };
}
