{ config, lib, pkgs, ... }:
# let
#   android-sdk =
#     let
#       android-nixpkgs = import (fetchTarball "https://github.com/tadfisher/android-nixpkgs/archive/main.tar.gz") {
#         inherit pkgs;
#       };
    # in
    #   import (android-nixpkgs + "/hm-module.nix");
  # in


{

  imports = [
	  (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    # android-sdk
  ];

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  # home.file = {
  #   ".vim".source = ./.vim;
  #   ".nvim".source = ./.vim;
  #   ".nethackrc".source = ./.nethackrc;
  # };

  # programs.fish.shellInit = ''
  #   set -x PATH ${./bin} $PATH
  # '';
  

  # install packages to /etc/profile rather than $HOME/.nix-profile
  home-manager.useUserPackages = true;
  # Use system packages rather than private pkgs instance from home-manager
  home-manager.useGlobalPkgs = true;
  home-manager.users.rob = {

  # android-sdk.enable = true;

  # # Optional; default path is "~/.local/share/android".
  # android-sdk.path = "${config.home.homeDirectory}/.android/sdk";

  # android-sdk.packages = sdk: with sdk; [
  #   build-tools-30-0-2
  #   cmdline-tools-latest
  #   emulator
  #   platforms-android-30
  #   sources-android-30
  # ];

    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName  = "oblomovite";
      userEmail = "robert.sheynin@gmail.com";
      package = pkgs.gitAndTools.gitFull;

      signing = {
        key = "D64C2B113E675E7C";
        signByDefault = true;
      };

       extraConfig = {

         color.ui = true;
         core.editor = "emacsclient -c";
         push.default = "simple";
         pull.rebase = true;
      #   rebase.autostash = true;
      #   rerere.enabled = true;
      #   advice.detachedHead = false;

      #   #   sendemail = {
      #   #     smtpencryption = "ssl";
      #   #     smtpserver = "smtp.gmail.com";
      #   #     smtpuser = "rasen.dubi@gmail.com";
      #   #     smtpserverport = 465;
      #   #   };
       };

    };

     programs.git.extraConfig = {
       url."git@github.com:".pushInsteadOf = "https://github.com";
     };

#     programs.starship = {
#       enable = true;
#       enableZshIntegration = true;
#       # Configuration written to ~/.config/starship.toml
#       settings = {
#         # add_newline = false;

#         # character = {
#         #   success_symbol = "[➜](bold green)";
#         #   error_symbol = "[➜](bold red)";
#         # };

#         # package.disabled = true;
#     };
# #
    home.packages = with pkgs; [
      atool
      httpie

    #   ## Media ##
      vlc
      mplayer
      mpv
      spotify
      youtube-dl
      ffmpeg

      # processing

      # (pass.withExtensions (exts: [ exts.pass-otp ]))
      # pkgs.pinentry
      # pkgs.pinentry-emacs
      # pkgs.pinentry-curses
      libnotify

      # pinentry
      pinentry-emacs

      syncthing

      # Python
      python3
      python-language-server
      python3Packages.pyls-black
      python3Packages.pyls-isort
      python3Packages.pyls-mypy




      # Meetings
      zoom-us

      yubioath-desktop

      godot

      # Languages Servers
      ### should be dir-local rather than global

      rnix-lsp
      # python-language-server # ms
      python3Packages.python-language-server # palantir
      python3Packages.pyls-mypy
      python3Packages.pyls-isort
      python3Packages.pyls-black
      python3Packages.jedi

      # nodePackages.bash-language-server
      # nodePackages.json-server
      # nodejs
      # nodePackages.javascript-typescript-langserver
      # nodePackages.typescript
      # nodePackages.typescript-language-server
      # gopls
      # svls
      # nodePackages.vscode-css-languageserver-bin
      # nodePackages.vscode-html-languageserver-bin
      # clojure-lsp
      # metals
      # texlab
      # ccls
      # asls
      # rls

      gitFull
      git-doc

      # Lint + Format
      black
      nodePackages.js-beautify
      nodePackages.jshint
      nodePackages.jsdoc
      nodePackages.eslint
      nodePackages.prettier
      nodePackages.eslint_d
      python3Packages.pylint
      python3Packages.jedi
      python3Packages.flake8
      python3Packages.black

      wmname

      htop
      curl
      ## Greps
      ripgrep
      ripgrep-all
      ack

      poppler # pdf rendering

      pandoc # conversion between markup formats

      s-tar
      gzip
      zip

      tomb # encryption

      rustscan # Faster nmap scan with Rust
      wireshark
      gimp

      # tesseract # OCR engine

      starship
      nethack

      # Mail
      isync
      goimapnotify
      notmuch
      
      # Java
      #eclipses.eclipse-platform
      #eclipse-mat
      jdk11
      maven
      gradle
      spring-boot-cli

      # C/C++
      pkg-config
      #autotools
      cmake
      llvm
      gcc

      sqlite
      emacs-all-the-icons-fonts
      auctex
 

      # automatically sort music
      # muso 


      imagemagick
      # Spelling
      enchant
      nuspell
      hunspell
      hunspellDicts.ru-ru
      hunspellDicts.en-us-large
      hunspellDicts.de-de
      hunspellDicts.fr-moderne
      languagetool
      diction

      # utils 
      findutils
      xdg-utils
      alsaUtils
      #idutils
      gputils
      iputils
      usbutils
      pciutils
      diffutils
      dateutils
      coreutils-full
      renameutils
      fetchutils
      cpufrequtils
      # Rust rewrite of GNU coreutils
      #uutils-coreutils
      progress
    ];

    programs.browserpass = {
      enable = true;
      browsers = ["firefox" "chromium"];
    };

    programs.chromium = {
      enable = true; 

      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        { id = "dcpihecpambacapedldabdbpakmachpb";
         updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
        }
      ];
    };
    
    # programs.firefox = {
    #   enable = true;
    #   package = pkgs.firefox.override {
    #     # See nixpkgs' firefox/wrapper.nix to check which options you can use
    #     cfg = {
    #       # Tridactyl native connector
    #       enableTridactylNative = true;
    #     };
    #   };
    #   # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #   #   https-everywhere
    #   #   privacy-badger
    #   # ];

    # };

    ### TODO move email configs to home manager
# https://beb.ninja/post/email/
#     programs.mbsync.enable = true;
#     programs.msmtp.enable = true;
#     programs.notmuch = {
#       enable = true;
#       hooks = {
#         preNew = "mbsync --all"
#       };
#     };
#     accounts.email = {
#       accounts.oblomovite = {
#         address = "rob@oblomovite.com";
#       };

# };

    programs.emacs = {
      enable = true;
      package = pkgs.emacsGcc;
    };

    programs.direnv = {
      enable = true; 
      nix-direnv = {
        enable = true;
      };
    };

    programs.msmtp.enable = true;

    programs.password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp exts.pass-tomb]);
    };


    # programs.rofi = {
    #   enable = true;
    #   package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    #   font = "Hack 14";
    # };

    # programs.firefox = {
    #   enable = true;
    #   profiles = {
    #     myprofile = {
    #       settings = {
    #         "general.smoothScroll" = false;
    #       };
    #     };
    #   };
    # };


    # xdg.configFile."i3/config".source = "${my-dotfile-dir}/i3.conf";
    # xdg.configFile."picom/config".source = "/home/rob/.config/picom/config";

    # xdg.enable = true;
    # home.file."sway/config".source = "/home/rob/.config/sway/config";

    # xresources.properties = {
    #   "Xft.dpi" = 276;
    #   "Xcursor.size" = 64;
    # };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      # xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    gtkUsePortal = true;
  };
  
  programs.adb.enable = true;

  fonts.fonts = with pkgs; [
    corefonts
    emacs-all-the-icons-fonts
    dejavu_fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts
    dina-font
    proggyfonts
    hack-font
    nerdfonts
    symbola
    dejavu_fonts
    etBook
  ];

    programs.java = { 
      enable = true; package = pkgs.jdk11; 
    };
  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      #pinentryFlavor = "curses";
    };
  };

  environment.variables = {
    EDITOR = "emacsclient -c -a \"\" \"$@\"";
    VISUAL = "emacsclient -c -a \"\" \"$@\"";

  };

  ## TODO -- Move this config to a yaml file so formatter 
  ## doesn’t mess up the string
  ## use something like:
#       environment.etc."dual-function-keys.yaml".target = (builtins.readFile ./dual-function-keys.yaml) 

      environment.etc."dual-function-keys.yaml".text = ''
        MAPPINGS:
          - KEY: KEY_CAPSLOCK
            TAP: KEY_ESC
            HOLD: KEY_LEFTCTRL
          - KEY: KEY_LEFTALT
            TAP: KEY_ESC
            HOLD: KEY_LEFTMETA
          - KEY: KEY_LEFTMETA
            TAP: KEY_ESC
            HOLD: KEY_LEFTALT
      '';
      services.interception-tools = {
        enable = true;
        plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
        udevmonConfig = ''
          - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
            DEVICE:
              EVENTS:
                EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
        '';
      };

      # services.actkbd = {
      #   enable = true;
      #   bindings = [
      #     # Map F4 to decrease light
      #     { keys = [ 70 ]; events = [ "key" ]; 
      #       command = "/run/current-system/sw/bin/light -A 5"; 
      #     }

      #     # Map F4 to increase light
      #     { keys = [ 71 ]; events = [ "key" ]; 
      #       command = "/run/current-system/sw/bin/light -U 5"; 
      #     }
      #   ];
      # };

      # services.yubikey-agent.enable = true;


      services.udev.packages = [
        pkgs.yubikey-personalization
        pkgs.libu2f-host
      ];

      # don't suspend if plugged in
      services.logind = {
        lidSwitchDocked = "ignore";
        lidSwitchExternalPower = "ignore";
        lidSwitch = "suspend";
      };

      services.acpid = {
        enable = true;
        logEvents = true;
      };

      services.xserver.desktopManager.xterm.enable = false;
      services.xserver.windowManager.i3.enable = true;
      services.xserver.windowManager.i3.extraPackages = with pkgs; [
        alacritty
        i3lock 
        rofi
        dunst
        picom
        batsignal
        flameshot

        xclip
        escrotum
        xorg.xkbcomp
        feh
        # xss-lock
      ];

      services.xserver.wacom.enable = true;
      services.xserver.libinput.enable = true;
      services.xserver.libinput.touchpad = {
        tapping = true;
        accelProfile = "flat";
      };
      services.xserver.libinput.mouse = {
        accelProfile = "flat";
      };
      services.xserver.windowManager.exwm.enable = false;
      services.xserver.displayManager.defaultSession = "none+i3";
      services.xserver.displayManager.lightdm.enable = true;
      services.xserver.displayManager.autoLogin.enable = true;
      services.xserver.displayManager.autoLogin.user = "rob";
      services.xserver.videoDrivers = [ 
        # "nvidia"
        "modesetting" 
      ];
      services.xserver.useGlamor = true;
      programs.slock.enable = true;
      services.xserver.enable = true;

      services.pcscd.enable = true;
      # Depending on the details of your configuration,
      # this section might be necessary or not;
      # feel free to experiment
      environment.shellInit = ''
  export GPG_TTY="$(tty)"
  gpg-connect-agent /bye
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
'';

      documentation = {
        man.enable = true;
        dev.enable = true;
        nixos.includeAllModules = true;
      };

      services.autorandr = {
        enable = true;
        defaultTarget = "mobile";
      };


      services.printing = {
        enable = true;
        drivers = [ pkgs.epson-escpr ];
      };

      services.avahi = {
        enable = true;
        nssmdns = true;
      };

      programs.bash = {
        enableLsColors = true;
        enableCompletion = true;
      };

      programs.light.enable = true;

#       services.udev.path = [
#         pkgs.coreutils # for chgrp
#       ];

      ## TODO
      # services.cron = {
      #   enable = true;
      #   systemCronJobs = [
      #     "*/1 * * * * /home/rob/.config/cron-scripts/battest.sh"
      #   ];
      # };

      security.sudo = {
        enable = true;
        wheelNeedsPassword = false;
      };


      environment.systemPackages = with pkgs; [
        man-pages
        stdman
        posix_man_pages
        stdmanpages

        wget
        curlFull

      ];

      users.groups.video = {}; 

      users.extraUsers.rob = {
        createHome = true;
        subUidRanges = [{
          startUid = 100000;
          count = 65536;
        }];
        subGidRanges = [{
          startGid = 100000;
          count = 65536;
        }];
        description = "Robert";
        uid = 1000;
        isNormalUser = true;
        initialPassword = "init";
        extraGroups = [
          "adbusers"
          "audio"
          "video"
          "libvirtd"
          "networkmanager"
          "systemd-journal"
          "wheel"
          "wireshark"
          "libvirtd"
          "adbusers"
          "syncthing"
          "deluge"
          "tty"
        ];
        shell = pkgs.bash;

#    shell = "/run/current-system/sw/bin/zsh";
    # openssh.authorizedKeys.keys = [];
  };
}

