{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscode.fhs;
  # };

  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
  };

  # programs.neovim.extraPackages = with pkgs; [
  # moves the extraPackages to home because they were giving some hazzle

  home.packages = with pkgs;
    [
      (writeShellScriptBin "clean-nvim" ''
        rm -rf ${config.xdg.dataHome}/nvim
        rm -rf ${config.xdg.stateHome}/nvim
        rm -rf ${config.xdg.cacheHome}/nvim
      '')
      (writeShellScriptBin "clean-nvim-full" ''
        rm -rf ${config.xdg.dataHome}/nvim
        rm -rf ${config.xdg.stateHome}/nvim
        rm -rf ${config.xdg.cacheHome}/nvim
        rm -rf ${config.xdg.configHome}/nvim
      '')
      ripgrep
      unzip
      fd
      wget
      ### treesitter ###
      gcc
      tree-sitter
      # clang-tools_17
      ### rust ###
      # rust-analyzer
      ### nix ###
      nil
      alejandra
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      wl-clipboard
      xclip
    ];
}
