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

  # programs.neovim.extraPackages = with pkgs; [
  # moves the extraPackages to home because they were giving some hazzle

  home.packages = with pkgs;
    [
      (writeShellScriptBin "clean-nvim" ''
        rm -rf ${config.xdg.dataHome}/nvim
        rm -rf ${config.xdg.stateHome}/nvim
        rm -rf ${config.xdg.cacheHome}/nvim
      '')
      unzip
      fd
      ### treesitter ###
      tree-sitter
      gcc
      # clang-tools_17
      clang-tools

      ### rust ###
      # rust-analyzer

      ### nix ###
      nil
      alejandra

      ### mason migration ###
      shfmt
      lua-language-server
      stylua
      prettierd
      vscode-langservers-extracted
      biome

      ### latex ###
      texlab
      tectonic
      entr

      ### python ###
      # pyright
      ruff
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      wl-clipboard
      xclip
    ];
}
