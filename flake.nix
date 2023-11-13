{
  inputs =
    {
      # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      nixpkgs.url = "nixpkgs/nixos-unstable";
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
      ags.url = "github:Aylur/ags";
    };

  outputs = inputs: {
    defaultPackage.x86_64-linux = inputs.home-manager.defaultPackage.x86_64-linux;
    defaultPackage.x86_64-darwin = inputs.home-manager.defaultPackage.x86_64-darwin;

    homeConfigurations = {
      personalDarwin = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-darwin;
        modules = [
          ./home.nix
          ./darwin.nix
        ];
      };

      personalLinux = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.allowUnfreePredicate = _: true;
          }
          ./home.nix
          ./linux.nix
        ];
      };
    };
  };
}
