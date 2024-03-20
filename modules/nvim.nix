{
  pkgs,
  config,
  lib,
  ...
}: let
  nvchad = pkgs.fetchFromGitHub {
    owner = "NvChad";
    repo = "starter";
    rev = "9d47133ba1433b07e1ac9e32fb110851cf1d6368";
    hash = "sha256-bQdO88FsBJBcxM43cyabqua9S3gWO/i2O0PL/8ulC7Y=";
  };
in 
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };

  xdg.configFile."nvim/init.lua" = {
    source = "${nvchad}/init.lua"; 
  };

  xdg.configFile."nvim/lua" = {
    source = ../config/nvim;
    recursive = true;
  };
  
  programs.neovim.extraPackages = with pkgs; [
    shfmt
    ripgrep
    unzip

    # Used for treesitter
    gcc

    # Lua
    lua-language-server
    stylua
    selene

    # Python
    python311Packages.python-lsp-server

    # Javascript
    prettierd

    # Rust
    # rust-analyzer

    # nix
    nil
    alejandra
    ] ++ lib.optionals pkgs.stdenv.isLinux(
   [
    wl-clipboard
    xclip
    ]
   )  
  ];

  home.packages = with pkgs; [
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
  ];
}
