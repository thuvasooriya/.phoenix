{
  pkgs,
  lib,
  ...
}: {
  programs = {
    fish = {
      loginShellInit = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };
}
