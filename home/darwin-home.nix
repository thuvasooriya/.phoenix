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
        yt-dlp
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
  };

  programs = {
    home-manager.enable = true;
    nushell.enable = true;
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    zoxide.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };
}
