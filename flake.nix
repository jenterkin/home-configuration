{
  inputs =
    {
      # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixpkgs.url = "nixpkgs/nixos-23.05";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = inputs: {
    defaultPackage.x86_64-linux = inputs.home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = inputs.home-manager.defaultPackage.x86_64-darwin;

    homeConfigurations = {
      personalDarwin = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-darwin;
        modules = [
          ./home.nix
          {
            home = {
              username = "jenterkin";
              homeDirectory = "/Users/jenterkin";
            };
          }
        ];
      };

      personalLinux = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-darwin;
        modules = [
          ./home.nix
          {
            system = "x86_64-linux";
            username = "jenterkin";
            homeDirectory = "/home/jenterkin";
          }
        ];
      };
    };
  };
}
