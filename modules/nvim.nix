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

  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
  };

  xdg.configFile."ghostty" = {
    source = ../config/ghostty;
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
      # shfmt
      ripgrep
      unzip

      # Used for treesitter
      gcc

      # Lua
      # lua-language-server
      # stylua
      # selene

      # Python
      # python311Packages.python-lsp-server

      # Javascript
      # prettierd

      # Rust
      # rust-analyzer

      # nix
      # nil
      alejandra
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      wl-clipboard
      xclip
    ];
}
