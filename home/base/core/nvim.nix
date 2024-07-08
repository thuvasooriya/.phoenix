{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
  };
  xdg.configFile."nvim" = {
    # source = ../config/nvim; # this will make a readonly config that syncs during switch command
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
      (writeShellScriptBin "clean-nvim-full" ''
        rm -rf ${config.xdg.dataHome}/nvim
        rm -rf ${config.xdg.stateHome}/nvim
        rm -rf ${config.xdg.cacheHome}/nvim
        rm -rf ${config.xdg.configHome}/nvim
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
      # typescript-language-server
      prettierd
      vscode-langservers-extracted
      biome

      ### latex ###
      texlab
      # perl
      # perl538Packages.LatexIndent
      # perlPackages.YAMLTiny
      # perlPackages.FileHomeDir
      # perlPackages.UnicodeLineBreak
      tectonic
      zathura
      entr

      ### python ###
      pyright
      ruff
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      wl-clipboard
      xclip
    ];
}
