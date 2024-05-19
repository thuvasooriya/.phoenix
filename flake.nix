{
  description = "phoenix config";

  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      # url = "github:nix-community/home-manager/release-23.11";
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs-darwin";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    darwin,
    ...
  }: let
    username = "tony";
    usermail = "thuvaragan28@gmail.com";
    system = "aarch64-darwin";
    hostname = "tonymbp";
    specialArgs =
      inputs
      // {
        inherit username usermail hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        # ./modules/homebrew-mirror.nix # comment this line if you don't need a homebrew mirror
        ./modules/host-users.nix
        # ./modules/git.nix
        # ./modules/nvim.nix
        # ./modules/fish.nix
        # ./modules/config.nix
        # ./home/darwin.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home;
          # home-manager.users."${username}" = import ./modules/core.nix;
          home-manager.extraSpecialArgs = specialArgs;
        }
      ];
    };
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
