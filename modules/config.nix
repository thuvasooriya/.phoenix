{
  pkgs,
  config,
  lib,
  ...
}: {
  xdg.configFile = {
    # universal config files go here
    # won't work properly if the .phoenix was not cloned to home directory
    "ghostty" = {
      # source = ../config/ghostty;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.phoenix/config/ghostty";
      recursive = true;
    };
    "zed" = {
      # source = ../config/zed;
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
  };

  # ++ lib.optionals pkgs.stdenv.isDarwin {
  #   "ghostty" = {
  #     source = ../config/ghostty;
  #     recursive = true;
  #   };
  # }
  # ++ lib.optionals pkgs.stdenv.isLinux {};
}
