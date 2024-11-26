{
  lib,
  pkgs,
  ...
}: {
  services.aerospace = {
    enable = true;
    settings = pkgs.lib.importTOML ../../config/starship.toml;
  };
}
