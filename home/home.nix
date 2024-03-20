{pkgs, config, inputs, lib, ...}: {
  imports = [
    # inputs.nix-index-database.hmModules.nix-index
    ./fish.nix
    ./git.nix
  ];
  
  home = {
    stateVersion = "23.11";
    packages = [
    pkgs.hello
    pkgs.coreutils
    pkgs.curl
    ];
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
    neovim = {
      enable = true;
      defaultEditor = true;
      # viAlias = true;
      # vimAlias = true;
      vimdiffAlias = true;
    };
    };
}
