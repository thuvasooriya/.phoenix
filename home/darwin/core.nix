{pkgs, ...}: {
  home = {
    activation = {
    };
    packages = with pkgs; [
      flyctl
      scrcpy
      tigervnc

      ### move to project specific flakes
      ### hdl ###
      iverilog
      yosys
      netlistsvg
      # yosys-synlig
      # verilator
      logisim-evolution
      platformio-core
      qemu
      digital
      haskellPackages.sv2v

      ### network ###
      # wireshark

      ### java ###
      # maven

      ### broken ###
      # sioyek
      # ghostty
      # ripes
      # xquartz
      neovide
    ];
  };
}
