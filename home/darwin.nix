{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  user = "tony";
in {
  # https://github.com/nix-community/home-manager/issues/423
  environment.variables = {
    # GHOSTTY TERMINFO CONFIG
    # TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;

  ### nix config stuff need to move to another file ###
  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    # automatic = true;
    # options = "--delete-older-than 10d";
    # interval = {
    #   Hour = 20;
    #   Minute = 0;
    # };
  };
  nix.optimise = {
    automatic = true;
    # options = "--delete-older-than 10d";
    interval = {
      Hour = 48;
      Minute = 0;
    };
  };

  # nix.package = pkgs.nix;
  nix.package = pkgs.nixUnstable;
  nix.settings.auto-optimise-store = true;
  nix.extraOptions =
    ''
    ''
    + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

  programs.nix-index.enable = true;
  nixpkgs.hostPlatform = {
    config = "aarch64-apple-darwin";
    system = "aarch64-darwin";
  };
  # nixpkgs.config.allowUnsupportedSystem = true;

  programs.man.enable = true;

  programs.zsh = {
    enable = true;
    enableFzfCompletion = true;
    # enableFzfGit = true;
    enableFzfHistory = true;
    enableSyntaxHighlighting = true;
    loginShellInit = ''
      if [[ $(uname -m) == 'arm64' ]]; then
          eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };
  programs.fish = {
    enable = true;
    shellInit = ''
      if test (uname -m) = "arm64"
          eval (/opt/homebrew/bin/brew shellenv)
      end
    '';
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  fonts = {
    fontDir.enable = true;
    fonts = [
      (pkgs.nerdfonts.override {
        fonts = ["JetBrainsMono"];
        # fonts = ["CascadiaCode" "Hasklig" "Inconsolata" "Iosevka" "JetBrainsMono"];
      })
    ];
  };

  # TODO: write a script to check whether homebrew is installed and install it
  homebrew = {
    enable = true;
    # brewPrefix = "/opt/homebrew";
    onActivation = {
      # autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    global = {brewfile = true;};
    taps = ["krtirtho/apps"];
    brews = [
      "latexindent"
      "octave"
    ];
    /*
    casks = [
      # dev
      "orbstack"

      # editors
      "visual-studio-code"
      "zed"

      # cli tools
      "android-platform-tools"
      "logisim-evolution"

      # utils
      "keyclu"
      # "selfcontrol"
      "loungy"

      # tools
      "kicad"
      # "ngspice"
      "digital"
      "capcut"
      "anki"
      "blender"
      # "syncthing"
      "spotube"
      "obs"
      "ltspice"
      "handbrake"
      "zoom"
      "wireshark"
      "utm"
    ];
    */
    masApps = {};
  };

  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
  # system.configurationRevision = self.rev or self.dirtyRev or null;
  security.pam.enableSudoTouchIdAuth = true;
  # system.defaults.NSGlobalDomain = {
  # InitialKeyRepeat = 33; # unit is 15ms, so 500ms
  # KeyRepeat = 2; # unit is 15ms, so 30ms
  # NSDocumentSaveNewDocumentsToCloud = false;
  # };

  # system.defaults = {
  #   dock.autohide = true;
  #   dock.mru-spaces = false;
  #   # finder.AppleShowAllExtensions = true;
  #   # finder.FXPreferredViewStyle = "clmv";
  #   # loginwindow.LoginwindowText = "nixcademy.com";
  #   # screencapture.location = "~/Pictures/screenshots";
  #   # screensaver.askForPasswordDelay = 10;
  # };

  # Used for backwards compatibility, please read the changelog before changing.
  system = {
    stateVersion = 4;
    # ./defaults.nix;
  };

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
  };

  # environment.systemPackages = with pkgs; [
  # fish
  # zsh
  # bashInteractive
  # ];

  # environment.shells = [pkgs.fish pkgs.zsh];
}
### following function can be used to call fish conditionally in zsh by including it in the loginShellInit
### but I personally don't like it :)
# if [[ $(${pkgs.procps}/bin/ps -o comm= -p $PPID) != "fish" && $SHLVL -eq 1 ]]; then
#     if [[ -o login ]]; then
#         LOGIN_OPTION='--login'
#     else
#         LOGIN_OPTION=""
#     fi
#     exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
# fi

