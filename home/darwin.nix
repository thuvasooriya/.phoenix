{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  user = "tony";
in {
  # environment.systemPackages = with pkgs; [
  #   vim
  # ];

  # environment.shells = [pkgs.fish pkgs.bashInteractive];

  # https://github.com/nix-community/home-manager/issues/423
  environment.variables = {
    # GHOSTTY TERMINFO CONFIG
    # TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;
  # nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    automatic = true;
    # options = "--delete-older-than 10d";
    # interval = {
    #   Hour = 20;
    #   Minute = 0;
    # };
  };

  # nix.package = pkgs.nixUnstable;
  nix.extraOptions =
    ''
      auto-optimise-store = true
    ''
    + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

  # system.defaults.NSGlobalDomain = {
  # InitialKeyRepeat = 33; # unit is 15ms, so 500ms
  # KeyRepeat = 2; # unit is 15ms, so 30ms
  # NSDocumentSaveNewDocumentsToCloud = false;
  # };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableFzfCompletion = true;
    # enableFzfGit = true;
    enableFzfHistory = true;
    enableSyntaxHighlighting = true;
    # loginShellInit = '''';
    shellInit = ''
      if [[ $(uname -m) == 'arm64' ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
      if [[ $(${pkgs.procps}/bin/ps -o comm= -p $PPID) != "fish" && $SHLVL -eq 1 ]]; then
          if [[ -o login ]]; then
              LOGIN_OPTION='--login'
          else
              LOGIN_OPTION=""
          fi
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  fonts = {
    fontDir.enable = true;
    fonts = [
      (pkgs.nerdfonts.override {
        fonts = ["CascadiaCode" "Hasklig" "Inconsolata" "Iosevka" "JetBrainsMono"];
      })
    ];
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # upgrade = true;
      cleanup = "zap";
    };
    global = {brewfile = true;};
    # taps = ["homebrew/bundle" "homebrew/cask" "homebrew/core"];
    brews = ["latexindent"];
    casks = [
      # dev
      "orbstack"
      # editors
      "visual-studio-code"
      "zed"
      # cli tools
      "android-platform-tools"
      # utils
      "keyclu"
      "selfcontrol"
      "loungy"
      # tools
      "kicad"
      "capcut"
      "anki"
      "blender"
      # "syncthing"
      "obs"
      "ltspice"
      "handbrake"
      "zoom"
      "wireshark"
    ];
    masApps = {};
  };

  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system = {
    stateVersion = 4;
    # ./defaults.nix;
  };
  # system.defaults = {
  #   dock.autohide = true;
  #   dock.mru-spaces = false;
  #   # finder.AppleShowAllExtensions = true;
  #   # finder.FXPreferredViewStyle = "clmv";
  #   # loginwindow.LoginwindowText = "nixcademy.com";
  #   # screencapture.location = "~/Pictures/screenshots";
  #   # screensaver.askForPasswordDelay = 10;
  # };

  nixpkgs.hostPlatform = "aarch64-darwin";
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
  };
}
