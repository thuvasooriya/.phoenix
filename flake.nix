{
  description = "phoenix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    ...
  }:
  # { pkgs, lib, ... }:
  {
    darwinConfigurations = {
      "tonymbp" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tony = import ./modules/core.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
    # darwinPackages = self.darwinConfigurations."simple".pkgs;
    # homeConfigurations = {
    #   default = home-manager.lib.homeManagerConfiguration {
    #     pkgs = pkgs;
    #     modules = [
    #     ./home/linux-home.nix
    #     ];
    #   };
    # };
  };
}
