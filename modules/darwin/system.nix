{pkgs, ...}: {
  system = {
    activationScripts.postUserActivation.text = ''
      # will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      # menuExtraClock.Show24Hour = true;  # show 24 hour clock

      dock = {
        autohide = true;
        show-recents = false; # disable recent apps
        mru-spaces = false;
        # wvous-tl-corner = 2; # top-left - Mission Control
        # wvous-tr-corner = 13; # top-right - Lock Screen
        # wvous-bl-corner = 3; # bottom-left - Application Windows
        # wvous-br-corner = 4; # bottom-right - Desktop
      };

      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        FXPreferredViewStyle = "clmv";
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
        CreateDesktop = false;
        FXDefaultSearchScope = null; # "SCcf"
        # When performing a search, search the current folder by default
      };

      trackpad = {
        Clicking = true; # enable tap to click
        TrackpadRightClick = true; # enable two finger right click
        TrackpadThreeFingerDrag = true; # enable three finger drag
      };

      screencapture.location = "~/arc/now/ss";

      # customize settings that not supported by nix-darwin directly
      # https://github.com/yannbertrand/macos-defaults
      NSGlobalDomain = {
        # `defaults read NSGlobalDomain "xxx"`
        "com.apple.swipescrolldirection" = true; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key
        AppleInterfaceStyle = "Dark"; # dark mode
        AppleKeyboardUIMode = 3; # Mode 3 enables full keyboard control.
        ApplePressAndHoldEnabled = false; # enable press and hold

        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        KeyRepeat = 3; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled = false; # disable auto capitalization
        NSAutomaticDashSubstitutionEnabled = false; # disable auto dash substitution
        NSAutomaticPeriodSubstitutionEnabled = false; # disable auto period substitution
        NSAutomaticQuoteSubstitutionEnabled = false; # disable auto quote substitution
        NSAutomaticSpellingCorrectionEnabled = false; # disable auto spelling correction
        NSNavPanelExpandedStateForSaveMode = true; # expand save panel by default
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSDocumentSaveNewDocumentsToCloud = false; # save new documents to disk by default
      };

      # customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # all custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        ".GlobalPreferences" = {
          # automatically switch to a new space when switching to the application
          AppleSpacesSwitchOnActivate = false;
        };
        NSGlobalDomain = {
          # add a context menu item for showing the web inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            "70".enabled = false;
          };
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          _FXSortFoldersFirst = true;
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = 0; # Click wallpaper to reveal desktop
          StandardHideDesktopIcons = 0; # Show items on desktop
          HideDesktop = 0; # Do not hide items on desktop & stage manager
          StageManagerHideWidgets = 0;
          StandardHideWidgets = 0;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.screencapture" = {
          location = "~/arc/now/ss";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
        "pl.maketheweb.cleanshotx" = {
          annotateLastSaveURL = "/Users/tony/arc/now/ss";
          exportPath = "/Users/tony/arc/now/ss";
          SUAutomaticallyUpdate = 0;
          SUEnableAutomaticChecks = 0;
          SUHasLaunchedBefore = 1;
          analyticsAllowed = 0;
          automaticallyCheckForUpdates = 0;
          captureWithoutDesktopIcons = 1;
          deletePopupAfterDragging = 1;
          didAskAboutURLSchemesAPI = 1;
          highlightClicks = 1;
          lastAcceptedEulaVersion = 1;
          onboardingDisplayed = 1;
          onboardingOCRDisplayed = 1;
          playSounds = 0;
          popupAskForDestinationWhenSaving = 0;
          recordComputerAudio = 0;
          snapInAnnotateCrop = 1;
          textRecognitionKeepLineBreaks = 1;
          afterScreenshotActions = [
            0
            1
          ];
          annotateExpandCanvas = 1;
          autoClosePopup = 1;
          crosshairMode = 1;
          doNotDisturbWhileRecording = 1;
          historyCapacity = 3;
          lastAutoIncrement = 0;
          lastLegitVersionNumber = 7;
          mediaNameTemplate = [
            "ss"
            "%m"
            "%d"
            "@"
            "%H"
            "%M"
            "%S"
          ];
          popupSize = 0;
          rememberRecordingArea = 1;
          # s000 = 1721273623;
          # s008 = 1;
          showMenubarIcon = 0;
          transparentWindowBackground = 0;
          windowBackgroundPadding = 0;
          # LAVAqaoRestore = mkDataTag "LAVAqaoRestore" "eyJjYXJib25LZXkiOjMzLCJjYXJib25Nb2RpZmllcnMiOjY5MTJ9";
          # LAVAtakeAllInOne = mkDataTag "LAVAtakeAllInOne" "eyJjYXJib25LZXkiOjI4LCJjYXJib25Nb2RpZmllcnMiOjY5MTJ9";
          # LAVAtakeArea = mkDataTag "LAVAtakeArea" "eyJjYXJib25Nb2RpZmllcnMiOjY5MTIsImNhcmJvbktleSI6MjR9";
          # LAVAtakeFullscreen = mkDataTag "LAVAtakeFullscreen" "eyJjYXJib25Nb2RpZmllcnMiOjY5MTIsImNhcmJvbktleSI6Mjl9";
          # LAVAtakeOCR = mkDataTag "LAVAtakeOCR" "eyJjYXJib25LZXkiOjI1LCJjYXJib25Nb2RpZmllcnMiOjY5MTJ9";
          # LAVAtakePreviousArea = mkDataTag "LAVAtakePreviousArea" "eyJjYXJib25LZXkiOjI3LCJjYXJib25Nb2RpZmllcnMiOjY5MTJ9";
          # LAVAqaoRestore = {
          #   length = 39;
          #   bytes = eyJjYXJib25LZXkiOjMzLCJjYXJib25Nb2RpZmllcnMiOjY5MTJ9;
          #   # bytes = "0x7b226361 72626f6e 4b657922 3a33332c ... 73223a36 3931327d";
          # };
          # LAVAtakeAllInOne = {
          #   length = 39;
          #   # bytes = "0x7b226361 72626f6e 4b657922 3a32382c ... 73223a36 3931327d";
          #   bytes = eyJjYXJib25LZXkiOjI4LCJjYXJib25Nb2RpZmllcnMiOjY5MTJ9;
          # };
          # LAVAtakeArea = {
          #   length = 39;
          #   # bytes = "0x7b226361 72626f6e 4d6f6469 66696572 ... 4b657922 3a32347d";
          #   bytes = eyJjYXJib25Nb2RpZmllcnMiOjY5MTIsImNhcmJvbktleSI6MjR9;
          # };
          # LAVAtakeFullscreen = {
          #   length = 39;
          #   # bytes = "0x7b226361 72626f6e 4d6f6469 66696572 ... 4b657922 3a32397d";
          #   bytes = eyJjYXJib25Nb2RpZmllcnMiOjY5MTIsImNhcmJvbktleSI6Mjl9;
          # };
          # LAVAtakeOCR = {
          #   length = 39;
          #   # bytes = "0x7b226361 72626f6e 4b657922 3a32352c ... 73223a36 3931327d";
          #   bytes = eyJjYXJib25LZXkiOjI1LCJjYXJib25Nb2RpZmllcnMiOjY5MTJ9;
          # };
          # LAVAtakePreviousArea = {
          #   length = 39;
          #   # bytes = "0x7b226361 72626f6e 4b657922 3a32372c ... 73223a36 3931327d";
          #   bytes = eyJjYXJib25LZXkiOjI3LCJjYXJib25Nb2RpZmllcnMiOjY5MTJ9;
          # };
          "LaunchAtLogin__hasMigrated" = 1;
          # MGR001 = 1;
          # MGR002 = 1;
        };
      };

      # ZoomChat = {
      #   ZMEnableShowUserName = false;
      #   ZoomFitDock = true;
      #   ZoomFitXPos = 620;
      #   ZoomFitYPos = 864;
      #   ZoomRememberPhoneKey = true;
      #   "com.zoom.client.langid" = 1033;
      #   "conf.crash.enable.auto.uploaddumps" = true;
      #   "conf.webserver" = "https://us04web.zoom.us";
      #   "conf.webserver.vendor.default" = "https://zoom.us";
      # };

      loginwindow = {
        GuestEnabled = false; # disable guest user
        SHOWFULLNAME = true; # show full name in login window
        LoginwindowText = "we create our own demons";
      };
    };

    # keyboard settings is not very useful on macOS
    # the most important thing is to remap option key to alt key globally,
    # but it's not supported by macOS yet.
    keyboard = {
      enableKeyMapping = true; # enable key mapping so that we can use `option` as `control`

      # NOTE: do NOT support remap capslock to both control and escape at the same time
      remapCapsLockToControl = true; # remap caps lock to control, useful for emac users
      remapCapsLockToEscape = false; # remap caps lock to escape, useful for vim users
      # system.configurationRevision = self.rev or self.dirtyRev or null;

      # swap left command and left alt
      # so it matches common keyboard layout: `ctrl | command | alt`
      # disabled, caused only problems!
      swapLeftCommandAndLeftAlt = false;
    };
  };

  # add ability to used touchid for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  environment.shells = [
    pkgs.zsh
  ];

  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
  };

  # stateVersion = 4;

  # set your time zone.
  # comment this due to the issue:
  #   https://github.com/LnL7/nix-darwin/issues/359
  # time.timeZone = "Asia/shanghai";

  # fonts
  fonts = {
    # will be removed after this PR is merged:
    #   https://github.com/LnL7/nix-darwin/pull/754
    # fontDir.enable = true;

    # will change to `fonts.packages` after this PR is merged:
    #   https://github.com/LnL7/nix-darwin/pull/754
    packages = with pkgs; [
      # packages = with pkgs; [
      # icon fonts
      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # characters
          "JetBrainsMono"
        ];
        # fonts = ["CascadiaCode" "Hasklig" "Inconsolata" "Iosevka" "JetBrainsMono"];
      })
    ];
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

