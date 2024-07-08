{myvars, ...}: {
  home = {
    inherit (myvars) username;
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
