{
  outputs,
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./nvim.nix
    ./config.nix
  ];

  targets.genericLinux.enable = pkgs.stdenv.isLinux;
  programs = {
    home-manager.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = pkgs.lib.importTOML ../config/starship.toml;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    nushell.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    man = {
      enable = true;
      generateCaches = true;
    };
  };
  home = {
    stateVersion = "23.11";
    packages = with pkgs;
      [
        coreutils
        curl
        neofetch
        rsync
        hyperfine
        fzf

        luajit
        # lua

        nodejs
        # nodejs_21

        (python3.withPackages
          (p: [
            p.pandas
            p.pip
          ]))
        pipx
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        yt-dlp
        cmatrix
        aria2
        verilog
        verilator
        (writeShellScriptBin "darwinix" ''
          darwin-rebuild switch --flake ~/.phoenix/
        '')
      ]
      ++ lib.optionals pkgs.stdenv.isLinux [
        (writeShellScriptBin "update-home" ''
          home-manager switch --flake ~/.phoenix/home/
        '')
      ];

    file = {
    };

    sessionVariables = {
      EDITOR = "nvim";
    };
    # using bun and zvm outside of nix
    sessionPath = ["$HOME/.zvm/bin" "$HOME/.zvm/self" "$HOME/.bun/bin"];
  };
  # ++ lib.optionals pkgs.stdenv.isLinux {
  #   username = "tony";
  #   homeDirectory = "/home/tony";
  # };
}
