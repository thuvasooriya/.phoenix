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
    # ./tmux.nix
  ];

  targets.genericLinux.enable = pkgs.stdenv.isLinux;
  home = {
    stateVersion = "23.11";
    packages = with pkgs;
      [
        coreutils
        curl
        rsync
        hyperfine
        # fzf
        rsync
        neofetch
        scrcpy
        docker
        colima
        # x11docker
        xquartz
        xorg.xauth

        luajit
        xonsh
        rmtrash
        # mcfly
        ffmpeg
        # mosh
        # lua

        nodejs
        # nodejs_21
        (python3.withPackages
          (p: [
            p.pip
          ]))
        pipx
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
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
      # ".config/nvim" = {
      #   source = ../config/nvim;
      #   recursive = true;
      # ".aria2/aria2.conf".source = config.lib.file.mkOutOfStoreSymlink ../config/aria2.conf;
      ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../config/.rgignore;
      ".rules.verible_lint".source = config.lib.file.mkOutOfStoreSymlink ../config/.rules.verible_lint;
    };

    # sessionVariables = {
    #   EDITOR = "nvim";
    # };
    # need to do something about these things
    sessionPath = ["$HOME/.zvm/bin" "$HOME/.zvm/self" "$HOME/.local/bin" "$HOME/.cargo/bin"];
  };
  # ++ lib.optionals pkgs.stdenv.isLinux {
  #   username = "tony";
  #   homeDirectory = "/home/tony";
  # };
}
