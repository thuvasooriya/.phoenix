{pkgs, ...}: {
  home = {
    activation = {
    };
    packages = with pkgs; [
      notcurses
      flyctl

      ### android ###
      scrcpy

      ### containers ###
      colima
      xquartz

      ### typesetting ###
      glow # markdown previewer in terminal
      typst
      hugo

      ### hdl ###
      verilator
      verilog #iverilog
      gtkwave
      logisim-evolution
      ngspice
      verible

      ### network ###
      wireshark

      ### java ###
      maven

      ### problamatic ###
      sioyek
    ];
  };
}
