args @ {
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    # inputs.nix-index-database.hmModules.nix-index
    ../modules/fish.nix
    ../modules/git.nix
    ../modules/nvim.nix
    # outputs.homeModules
  ];
  xdg.enable = true; # export XDG vars to ensure the correct directories are used
  targets.genericLinux.enable = pkgs.stdenv.isLinux && ! args ? nixosConfig;

  # xdg.configFile."nixpkgs/config.nix".source = ../../nixpkgs/config.nix; # read by "nix-shell", "nix shell --impure" etc

  # nix = {
  # package = lib.mkDefault pkgs.nix;
  # settings = import ../../nix/nix.nix;

  # registry = rec {
  #   nixos.flake = nixos-flake;
  #   #nixos-small.flake = inputs.nixos-small;
  #   # nixos-unstable.flake = inputs.nixos-unstable;
  #   #nixpkgs-darwin.flake = inputs.nixpkgs-darwin;
  #   #nur.flake = inputs.nur;
  #   #flake-utils.flake = inputs.flake-utils;
  #   #rust-overlay.flake = inputs.rust-overlay;
  #   # home-manager.flake = home-manager-flake;
  #   nixpkgs.to = {
  #     type = "path";
  #     path = (toString pkgs.path);
  #   };
  #   n = nixpkgs; # shortcut
  #   self.flake = inputs.self;
  # };
  #registry = lib.mapAttrs (_: value: { flake = value; }) inputs; # nix.generateRegistryFromInputs in flake-utils-plus
  #nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry; # nix.generateNixPathFromInputs in flake-utils-plus # nix.nixPath is not available in HM
  # };

  # systemd.user.systemctlPath = "/usr/bin/systemctl"; # TODO ?

  # always keep a reference to the source flake that generated each generations
  # file.".source-flake".source = ../.;

  #   packages = with pkgs; [
  #   ]
  #   ++ lib.optionals pkgs.stdenv.isLinux (
  #     [
  #     ] ++ lib.optionals (config.home.username == "root") [ # if root and linux
  #     ]
  #   ) ++ lib.optionals (pkgs.stdenv.hostPlatform.system == "x86_64-linux") (
  #     [
  #     ] ++ lib.optionals (config.home.username == "root") [ # if root and linux
  #     ]
  #   );
  # };

  home = {
    stateVersion = "23.11";
    enableNixpkgsReleaseCheck = true; # check for release version mismatch between Home Manager and Nixpkgs
    username = "tony";
    homeDirectory = "/home/tony";
    packages = with pkgs; [
      hello
      coreutils
      curl
      neofetch
      rsync
      hyperfine
      yt-dlp
      (writeShellScriptBin "update-home" ''
        home-manager switch --flake ~/.phoenix/#default
      '')
    ];
    # packages = [
    # pkgs.hello
    # pkgs.coreutils
    # pkgs.curl
    # ];
    file = {
    };
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  programs = {
    home-manager.enable = true;
    # fish.enable = true;
    # git.enable = true;
    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #   # viAlias = true;
    #   # vimAlias = true;
    #   vimdiffAlias = true;
    # };
    nushell.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    zoxide.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };
}
