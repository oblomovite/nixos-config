{ config, pkgs, ... }:

{
  nixpkgs = {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
      # Needed to get android sdk;
      android_sdk.accept_license = true;
    };
    overlays = [
      (import ../../packages/overlay.nix {
        # inherit secrets;
      })
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      }))
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
    #    ../../packages/symlinks/service.nix
    #    ../../vm/host.nix
  ];

  boot.initrd.luks.devices."root" = {
    device = "/dev/nvme0n1p2";
    preLVM = true;
  };

  # @oblomovite-specific fixes
  #  networking.enableIntel2200BGFirmware = true;
  services.throttled.enable = true;

  # network.systemd.enable = true;
  networking = {
    hostName = "oblomovite"; # Define your hostname.
    # useNetworkd = true;
    # wireless.iwd.enable = true;
    useDHCP = false;
    interfaces.enp0s20f0u3.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [
      22 80 443
      22000
    ];
    firewall.allowedUDPPorts = [
      22 80 443
      21027
      8880
    ];
  };

  boot = {
    #supportedFilesystems = [ "nfs" ];
    kernelPackages = pkgs.linuxPackages;
    kernelParams = [ 
      "i915.enable_fbc=1" # Enable Framebuffer Compression
    ];

    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 15;
      efi.canTouchEfiVariables = true;
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  #  programs.gnupg.agent = {
  #enable = true;
  #enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  #  };

  # Must restart computer, otherwise you may hit this bug:
  # https://github.com/NixOS/nixpkgs/issues/35464#issuecomment-383894005
  programs.gnupg = {
    agent = {
      enable = true;
      enableExtraSocket = true;
      pinentryFlavor = "emacs";
    };
  };
  environment.systemPackages = with pkgs; [
    pass
  ];
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  #hardware.pulseaudio.enable = true;

  time.timeZone = "America/New_York";

  hardware = {
    cpu.intel.updateMicrocode = true;
    # enableAllFirmware = true;
    opengl.enable = true;
    rtl-sdr.enable = true;
  };

  documentation.man.enable = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  systemd.services.nix-gc.unitConfig.ConditionACPower = true;

  sound.mediaKeys.enable = true;
  sound.mediaKeys.volumeStep = "5%";
  # programs.waybar.enable = true;
  # programs.sway.wrapperFeatures.gtk = true;
  # programs.sway.enable = true;



  # Keybindings for setting brightness
  programs.light.enable = true;
  programs.adb.enable = true;
  environment = {
    # loginShellInit = ''
    #        if [ "$(tty)" = "/dev/tty1" ]; then
    #            exec sway
    #        fi
    #    '';
  #   # etc = {
  #   #   "sway/config".source = ./../../packages/swayconfig/config;
  #   #   "xdg/waybar/config".source = ./../../packages/swayconfig/waybar/config;
  #   #   "xdg/waybar/style.css".source = ./../../packages/swayconfig/waybar/style.css;
  #   #   "xdg/kanshi/config".source = ./../../packages/swayconfig/kanshi/config;
  #   # };
  };

  services.mpd = {
    enable = true;
    startWhenNeeded = true;
  };

  services.ympd = {
    enable = true;
    webPort = "9090";
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

  system.autoUpgrade = {
    enable = true;
    channel = https://nixos.org/channels/nixos-unstable;
  };

  services.tlp = {
    enable = true;
  };

  services.thermald = {
    enable = true; 
    debug = true;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  system.stateVersion = "20.03";
}

