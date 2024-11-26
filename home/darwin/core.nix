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
      qemu
      digital
      ripes

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
