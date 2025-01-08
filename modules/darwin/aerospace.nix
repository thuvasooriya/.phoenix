{
  lib,
  pkgs,
  ...
}: {
  services.aerospace = {
    enable = true;
    settings = pkgs.lib.importTOML ../../config/aerospace.toml;
  };
  services.jankyborders = {
    enable = true;
    style = "round";
    width = 2.0;
    hidpi = false;
    order = "above";
    active_color = "0xff74c7ec";
    inactive_color = "0x00000000";
    blacklist = [
      "Steam"
      "WhatsApp"
      "XQuartz"
    ];
  };
}
