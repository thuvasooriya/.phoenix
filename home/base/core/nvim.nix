{
  pkgs,
  config,
  lib,
  neovim-nightly,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = neovim-nightly.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/nvim";
    recursive = true;
  };

  home.packages = with pkgs;
    [
      (writeShellScriptBin "clean-nvim" ''
        rm -rf ${config.xdg.dataHome}/nvim
        rm -rf ${config.xdg.stateHome}/nvim
        rm -rf ${config.xdg.cacheHome}/nvim
      '')

      unzip
      fd
      tree-sitter

      # zls managed by zvm
      clang-tools

      nil
      alejandra

      shfmt

      lua
      lua-language-server
      stylua

      prettierd
      vscode-langservers-extracted
      biome

      tectonic
      typst
      glow # markdown previewer in terminal
      hugo

      ruff
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      wl-clipboard
      xclip
    ];
}
