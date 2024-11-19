{pkgs, ...}: {
  home = {
    activation = {
    };
    packages = with pkgs; [
      flyctl

      scrcpy

      # colima

      # xquartz
      tigervnc

      # gcc
      ### hdl ###
      iverilog
      logisim-evolution
      platformio-core

      ### network ###
      # wireshark

      ### java ###
      # maven

      # sioyek
      # neovide
      # libiconv
    ];
  };
}
