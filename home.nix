{ config, pkgs, lib, ... }:

{
  home.stateVersion = "23.11";
  home.packages = [
    pkgs.hello
    pkgs.coreutils
    pkgs.curl
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
    m-cli # useful macOS CLI commands
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  programs.fish = {
    enable = true;
  };
  programs.git.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # viAlias = true;
    # vimAlias = true;
    vimdiffAlias = true;
 };
}
