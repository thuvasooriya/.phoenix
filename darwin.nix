{ pkgs, lib, ... }:
let user = "tony";
in {
# nix.binaryCaches = [
#     "https://cache.nixos.org/"
#   ];
#   nix.binaryCachePublicKeys = [
#     "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
#   ];
#   nix.trustedUsers = [
#     "@admin"
#   ];
  users.nix.configureBuildUsers = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = [ pkgs.vim ];
  # environment.systemPackages = with pkgs; [
  #   kitty
  #   terminal-notifier
  # ];
  
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;
  # nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina


  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # https://github.com/nix-community/home-manager/issues/423
  # environment.variables = {
  #   TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  # };
  
  programs.nix-index.enable = true;

  # Fonts
  # fonts.enableFontDir = true;
  # fonts.fonts = with pkgs; [
  #    recursive
  #    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  #  ];

  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    # finder.AppleShowAllExtensions = true;
    # finder.FXPreferredViewStyle = "clmv";
    # loginwindow.LoginwindowText = "nixcademy.com";
    # screencapture.location = "~/Pictures/screenshots";
    # screensaver.askForPasswordDelay = 10;
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    # isHidden = false;
    # shell = pkgs.zsh;
  };
}
