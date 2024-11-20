{myvars, ...}: {
  home = {
    inherit (myvars) username;
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
