{
  outputs,
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../modules/fish.nix
    ../modules/git.nix
    ../modules/nvim.nix
  ];

  # nixpkgs.overlays = [
  #   outputs.overlays.additions
  #   outputs.overlays.modifications
  #   ];

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

  programs = {
    home-manager.enable = true;
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
}
