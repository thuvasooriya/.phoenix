{
  pkgs,
  config,
  lib,
  ...
}: {
  xdg.configFile = {
    "ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/ghostty";
      recursive = true;
    };
    "zed" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/zed";
      recursive = true;
    };
    "zellij" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/zellij";
      recursive = true;
    };
    "yt-dlp" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/yt-dlp";
      recursive = true;
    };
    "aria2" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/aria2";
      recursive = true;
    };
    "yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/yazi";
      recursive = true;
    };
    "neovide" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/neovide";
      recursive = true;
    };
  };

  home.file = {
    ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../../../config/.rgignore;
    ".rules.verible_lint".source = config.lib.file.mkOutOfStoreSymlink ../../../config/.rules.verible_lint;
  };
}
