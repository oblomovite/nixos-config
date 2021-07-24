{ config, pkgs, lib, ... }:

# let
#   start-sway = pkgs.writeShellScriptBin "start-sway" ''
#     # first import environment variables from the login manager
#     systemctl --user import-environment
#     # then start the service
#     exec systemctl --user start sway.service
#   '';

#   start-waybar = pkgs.writeShellScriptBin "start-waybar" ''
#     export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -f 'sway$').sock
#     ${pkgs.waybar}/bin/waybar
#   '';
# # root = /home/rob/projects/nixos-config;
# # secrets = import "${root}/secrets.nix";
#   in

let

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload"
    ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec -a "$0" "$@"
    '';

in {

  nixpkgs = {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };
    overlays = [(import ../../packages/overlay.nix {
      # inherit secrets;
    })
               ];
  };

  imports = [
    ./hardware-configuration.nix
    ../../packages/portable.nix
    ../../users/rob.nix
    ../../fonts.nix
    ../../hardware.nix
    ../../services.nix
    ../../programs.nix
    ../../packages/symlinks/service.nix
    ../../vm/host.nix
  ];

  boot.initrd.luks.devices."root" = {
    device = "/dev/nvme0n1p2";
    preLVM = true;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.interfaces.enp0s20f0u4u4.useDHCP = true;

  environment = {
    variables = {
      #          EDITOR = "emacs -nw";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    };
  };

  ## TODO ## For Yubikey setup

  # services.udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];
  # services.pcscd.enable = true;

  # environment.shellInit = ''
  #                       export GPG_TTY="$(tty)"
  #                       gpg-connect-agent /bye
  #                       export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-gent.ssh
  #                       '';


  # programs.ssh.startAgent = false;


  # Not Sure

  console = {
    # packages = with pkgs; [ terminus_font ];
    # font = "ter-i32b";
    # defaultLocale = "en_US.UTF-8";
    # useXkbConfig = true;
    earlySetup = true;
  };

  services.mingetty.autologinUser = "rob";

  #  console.extraTTYs = ["tty2" "tty3" "tty4" "tty5" "tty6" "tty7" "tty8" "tty9" "tty10"];
  #  services.rogue.tty = true;
  #  services.syslogd.tty = true;

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    extraConfig = ''
      HandlePowerKey=suspend
      IdleAction=ignore
      '';
  };

  powerManagement = {
    enable = true;
    # cpuFreqGovernor = "powersave";
    cpuFreqGovernor = "ondemand";
  };

  services.offlineimap = {
    enable = true;
    path = [ pkgs.pass pkgs.bash pkgs.zsh ];
    # install = true;
  };

  programs.adb.enable = true;

  services.emacs = {
    enable = true;
    package = pkgs.custom-emacs;
    defaultEditor = true;
  };

  # Only start emacs for actual users, lol
  systemd.user.services.emacs.unitConfig = {
    ConditionGroup = "users";
  };

  boot = {
    supportedFilesystems = [ "nfs" ];
    kernelPackages = pkgs.linuxPackages;
    # kernelParams = [
    # 	"i915.enable_fbc=1" # Enable Framebuffer Compression
    # ];
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 15;
    };
  };

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    epson-escpr
    # epson-201106w
    # epson_201207w
  ];

  programs.system-config-printer.enable = true;

  services.nfs.server.enable = true;
  services.nfs.server.statdPort = 4000; #
  services.nfs.server.lockdPort = 4001; #



  networking = {
    firewall.checkReversePath = false;
    firewall.allowedTCPPorts = [ 111 3000 9222 2222 2049 4000 4001];
    firewall.allowedUDPPorts = [ 111 3000 9222 2222 2049 4000 4001];
    networkmanager = {
      enable = true;
      # dhcp = "dhcpcd";
      # dns = "dnsmasq";
    };
    enableIPv6 = true;
    hostName = "xiao";

  };

  virtualisation.docker = {
    enable = true;
  };

  time.timeZone = "America/New_York";

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
    # Not sure if I need this
    opengl.enable = true;
  };

  environment.systemPackages = [ nvidia-offload ];                               #
  hardware.nvidia.prime.offload.enable = true;                                   #
  hardware.nvidia.prime = {                                                      #
    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA   #
    intelBusId = "PCI:0:2:0";                                                    #
    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA  #
    nvidiaBusId = "PCI:1:0:0";                                                   #
  };                                                                             #

  # security.pam.services.lightdm.enable = true;

  # services.unclutter.enable = true;

  documentation.man.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  nix = {
    # useSandbox = true;
    # distributedBuilds = true;
    # buildMachines = secrets.buildMachines;
    # nixPath = [
    #   "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    #   "nixos-config=${toString root}/devices/morbo/configuration.nix"
    # ];
    gc = {
      automatic = true;
      dates = "*:0/10";
    };
  };

  systemd.services.nix-gc.unitConfig.ConditionACPower = true;

  # Keybindings for setting brightness
  programs.light.enable = true;

  sound = {
    enable = true;
  };


  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # programs.waybar.enable = true;
  # programs.sway = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     swaylock # lockscreen
  #     swayidle
  #     xwayland # for legacy apps
  #     waybar # status bar
  #     mako # notification daemon
  #     kanshi # autorandr
  #
  #
  #     wofi
  #     grim
  #     wl-clipboard
  #     imv
  #     slurp
  #     bemenu
  #     firefox-wayland
  #     wlr-randr
  #     # start-waybar
  #     # start-sway
  #
  #     alacritty
  #     rofi
  #     rofi-pass
  #     rofi-systemd
  #     rofi-menugen
  #     conky
  #
  #     nvidia-offload
  #   ];
  # };

  ## Sway Configuration ##
  environment = {
    #
    #   loginShellInit = ''
    #       if [ "$(tty)" = "/dev/tty1" ]; then
    #           exec sway
    #       fi
    #   '';

    etc = {
      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
      "sway/config".source = ./../../packages/swayconfig/config;
      "xdg/waybar/config".source = ./../../packages/swayconfig/waybar/config;
      "xdg/waybar/style.css".source = ./../../packages/swayconfig/waybar/style.css;
      "xdg/kanshi/config".source = ./../../packages/swayconfig/kanshi/config;

      "i3/config".source = ./../../packages/i3config/config;
    };
  };

  services = {
    interception-tools = {
      enable = true;
      udevmonConfig = 
        ''
        - JOB: "intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';

    };
  };

  services.deluge = {
    enable = true;
    openFirewall = true;
    user = "rob";
    # dataDir = /var/lib/deluge;
    web = {
      enable = true;
      openFirewall = true;
      port = 8112;
    };
  };

  # services.redshift = {
  #   enable = true;
  #   # Redshift with wayland support isn't present in nixos-19.09 atm. You have to cherry-pick the commit from https://github.com/NixOS/nixpkgs/pull/68285 to do that.
  #   package = pkgs.redshift-wlr;
  # };

  services.lorri.enable = true;

  services = {
    xserver = {
      displayManager = {
        lightdm = {
          enable = true;
          autoLogin = {
            enable = true;
            user = "rob";
          };
        };
      };

     libinput = {
       enable = true;
       disableWhileTyping = true;
     };

      videoDrivers = ["modesetting" "nvidia"];
      enable = true;
      autorun = true;
      #exportConfiguration = true;

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs;
          [
            rofi
            alacritty
            xclip
            alacritty
            rofi
            rofi-pass
            rofi-systemd
            rofi-menugen
            conky
          ];
      };
    };
  };

  system.autoUpgrade = {
    enable = true;
    channel = https://nixos.org/channels/nixos-unstable;
  };

  system.stateVersion = "19.09"; # Did you read the comment?
}
