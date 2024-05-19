{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  # user = "tony";
in {
  ## darwin programs
  programs.nix-index.enable = true;
  programs.man.enable = true;
  # programs.zsh = {
  #   enable = true;
  #   enableFzfCompletion = true;
  #   # enableFzfGit = true;
  #   enableFzfHistory = true;
  #   enableSyntaxHighlighting = true;
  #   loginShellInit = ''
  #     if [[ $(uname -m) == 'arm64' ]]; then
  #         eval "$(/opt/homebrew/bin/brew shellenv)"
  #     fi
  #   '';
  # };
  programs.fish = {
    enable = true;
    shellInit = ''
      if test (uname -m) = "arm64"
          eval (/opt/homebrew/bin/brew shellenv)
      end
    '';
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  # system = {
  #   stateVersion = 4;
  #   # ./defaults.nix;
  # };

  # users.users.${user} = {
  #   name = "${user}";
  #   home = "/Users/${user}";
  # };
}
