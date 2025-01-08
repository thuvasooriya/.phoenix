{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    m-cli
  ];

  # nix-homebrew = {
  #   enable = true;
  #   enableRosetta = true;
  #   user = "tony";
  #   autoMigrate = true;
  # };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
  };

  homebrew = {
    enable = true;
    # brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      # autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    global = {brewfile = true;};

    # applications to install from mac app store using mas.
    # you need to install all these apps manually first so that your apple account have records for them.
    # otherwise apple store will refuse to install them.
    # for details, see https://github.com/mas-cli/mas
    masApps = {
      # Xcode = 497799835;
    };

    taps = [
      # "mongodb/brew"
    ];

    # `brew install`
    brews = [
      "curl"
    ];

    # `brew install --cask`
    casks = [
      ### dev ###
      "orbstack"
      "visual-studio-code"
      "zed"
      "lunar"
      "xquartz"
      # "utm"
      "android-platform-tools"

      # "ltspice"
      # "wireshark"
      # "ngspice"
      # "digital"

      ### social ###
      "whatsapp"
      "discord"

      ### utils ###
      # "keyclu"
      # "syncthing"
      "keka"
      # "raycast"
      # "loungy"
      # "orion"
      # "spotube"
      # "arc"

      # "inkscape"
      "obs"
      "zoom"
      # "blender"
      "handbrake"
    ];
  };
}
