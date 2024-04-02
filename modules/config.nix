{
  pkgs,
  config,
  lib,
  ...
}: {
  xdg.configFile = {
    # universal config files go here
    "ghostty" = {
      source = ../config/ghostty;
      recursive = true;
    };
    "zed" = {
      source = ../config/zed;
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
