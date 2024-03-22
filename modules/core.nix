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
        aria2
        cmatrix
        fzf
        yt-dlp

        luajit
        # lua

        verilog
        verilator

        nodejs
        # nodejs_21

        (python3.withPackages
          (p: [
            p.pandas
            p.pip
          ]))
        pipx

        (writeShellScriptBin "darwinix" ''
          darwin-rebuild switch --flake ~/.phoenix/
        '')
      ]
      ++ lib.optionals pkgs.stdenv.isLinux [
        # (writeShellScriptBin "update-home" ''
        #   home-manager switch --flake ~/.phoenix/home/
        # '')
      ];

    file = {
    };

    sessionVariables = {
      EDITOR = "nvim";
    };

    sessionPath = ["$HOME/.zvm/bin" "$HOME/.zvm/self" "$HOME/.bun/bin"];
  };
}
