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
    "btop/themes" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/btop/themes";
      recursive = true;
    };
    "bat/themes" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/bat/themes";
      recursive = true;
    };
    "neovide" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/neovide";
      recursive = true;
    };
  };

  home.file = {
    ".rgignore".source = config.lib.file.mkOutOfStoreSymlink ../../../config/.rgignore;
    ".justfile".source = config.lib.file.mkOutOfStoreSymlink ../../../config/.justfile;
  };
}
