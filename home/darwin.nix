{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  user = "tony";
in {
  environment.variables = {
    ## todo: ghostty terminfo config for sbcs
    # TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };

  ## auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # services.karabiner-elements.enable = true;

  ## todo: nix config stuff need to move to another file ###
  nix.settings.experimental-features = "nix-command flakes";
  nix.gc = {
    automatic = true;
  };
  nix.optimise = {
    automatic = true;
    # options = "--delete-older-than 10d";
    interval = {
      Hour = 48;
      Minute = 0;
    };
  };

  nix.package = pkgs.nixFlakes;
  nix.settings.auto-optimise-store = true;
  nix.extraOptions =
    ''
    ''
    + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';

  nixpkgs.hostPlatform = {
    config = "aarch64-apple-darwin";
    system = "aarch64-darwin";
  };
  # nixpkgs.config.allowUnsupportedSystem = true;

  ## darwin programs
  programs.nix-index.enable = true;
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

  # todo: write a script to check whether homebrew is installed and install it
  homebrew = {
    enable = true;
    # brewPrefix = "/opt/homebrew";
    onActivation = {
      # autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    global = {brewfile = true;};
    taps = ["krtirtho/apps" "mongodb/brew"];
    brews = [
      "latexindent"
      "octave"
      "mongodb-community@7.0"
    ];
    casks = [
      # dev
      "orbstack"
      "visual-studio-code"
      "zed"

      "amethyst"

      # cli tools
      "android-platform-tools"

      # digital design tools
      "logisim-evolution"
      "ltspice"
      "wireshark"
      # "kicad"
      # "ngspice"
      # "digital"

      # utils
      "keyclu"
      "notion"
      "notion-calendar"
      "obsidian"
      "telegram"
      "whatsapp"
      "orion"
      # "syncthing"
      # "spotube"
      # "arc"
      "obs"
      "zoom"
      "keka"
      "skim"
      # "selfcontrol"
      # "loungy"
      # "raycast"
      "anki"
      # "blender"
      "handbrake"
      # "utm"
    ];
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

  system = {
    stateVersion = 4;
    # ./defaults.nix;
  };

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
  };
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

