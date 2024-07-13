{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    m-cli
  ];

  environment = {
    systemPath = [
      "$HOME/.zvm/bin"
      "$HOME/.zvm/self"
    ];
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      if [[ $(uname -m) == 'arm64' ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      set fish_greeting
      if test (uname -m) = "arm64"
          eval (/opt/homebrew/bin/brew shellenv)
      end
    '';
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $(uname -m) == 'arm64' ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };
}
