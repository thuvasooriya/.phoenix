{outputs, pkgs, config, inputs, lib, ...}: {
  imports = [
    # inputs.nix-index-database.hmModules.nix-index
    ../modules/fish.nix
    ../modules/git.nix
    ../modules/nvim.nix
    # outputs.homeModules
  ];
  
  # nixpkgs.overlays = [
  #   outputs.overlays.additions
  #   outputs.overlays.modifications
  #   ];
  #
  # nixpkgs.config.allowUnfreePredicate = _: true;
  #
  # home.username = "eggflaw";
  # home.homeDirectory = "/home/eggflaw";

  home = {
    stateVersion = "23.11";
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
