{
  description = "phoenix config";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://openlane.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "openlane.cachix.org-1:qqdwh+QMNGmZAuyeQJTH9ErW57OWSvdtuwfBKdS254E="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      # url = "github:nix-community/home-manager/master";

      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      # inputs.nixpkgs.follows = "nixpkgs-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # impermanance.url = ;
    # lanzaboote
    # hyprland
    # wayland
    # anyrun
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # secrets management ? agenix
    nix-gaming.url = "github:fufexan/nix-gaming";
    disko = {
      url = "github:nix-community/disko/v1.6.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nuenv.url = "github:DeterminateSystems/nuenv";

    # daeuniverse.url = "github:daeuniverse/flake.nix";
    # daeuniverse.url = "github:daeuniverse/flake.nix/exp";

    # haumea = {
    #   url = "github:nix-community/haumea/v0.2.2";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "github:thuvasooriya/walls";
      flake = false;
    };

    # nur-ryan4yin = {
    #   url = "github:ryan4yin/nur-packages";
    #   # inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # # riscv64 SBCs
    # nixos-licheepi4a.url = "github:ryan4yin/nixos-licheepi4a";
    # # nixos-jh7110.url = "github:ryan4yin/nixos-jh7110";
    #
    # # aarch64 SBCs
    # nixos-rk3588.url = "github:ryan4yin/nixos-rk3588";
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
        ./modules

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
