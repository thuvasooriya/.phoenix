{
  pkgs,
  lib,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # mpv
      # luajit
      notcurses
      # yq-go # yaml processer https://github.com/mikefarah/yq
      flyctl

      ### android ###
      scrcpy

      ### gen ###
      ollama
      llama-cpp

      ### containers ###
      colima
      xquartz

      ### gui apps ###
      # discord
      # vencord

      ### typesetting ###
      glow # markdown previewer in terminal
      typst
      hugo

      sioyek

      # spotifyd

      ### hdl ###
      verilator
      verilog
      gtkwave
      logisim-evolution
      wireshark
      ngspice
      verible
      maven
    ];
  };
}
