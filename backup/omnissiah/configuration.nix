{ config, pkgs, ... }:

{

  nixpkgs = {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
    };
    overlays = [
      (import ../../packages/overlay.nix {
        # inherit secrets;
      })
    ];
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../packages/portable.nix
      ../../users/rob.nix
      ../../fonts.nix
      ../../services.nix
      ../../programs.nix
      ../../hardware.nix
    ];

    hardware.cpu.amd.updateMicrocode = true;


  #####################################
  # services.wakeonlan.interfaces = [ #
  #   {                               #
  #     # interface = "wlp9s0";       #
  #     ##########################    #
  #     # interface = "enp12s0"; #    #
  #     ##########################    #
  #     interface = "enp11s0";        #
  #                                   #
  #     method = "magicpacket";       #
  #   }                               #
  # ];                                #
  #####################################

  # Blacklist nouveau
  #boot.extraModprobeConfig = "install nouveau /run/current-system/sw/bin/false";
  #boot.blacklistedKernelModules = [ "hid_steam" "nouveau" ];


  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 15;
  };


  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp97s0f0.useDHCP = true;
  networking.interfaces.enp97s0f1.useDHCP = true;


#  fileSystems."/" =
#
#    {
#      label = "root";
#      device = "/dev/partitions/btrfs-root";
#      fsType = "btrfs";
#      options = [ "subvol=root" ];
#    };
#
#  fileSystems."/home" =
#    {
#      label = "home";
#      device = "/dev/partitions/btrfs-root";
#      fsType = "btrfs";
#      options = [ "subvol=home" ];
#    };
#
#
#  fileSystems."/backup" =
#    {
#      label = "backup";
#      device = "/dev/disk/by-uuid/5bbabd76-43e3-4618-a0ac-4ed1c7f98662";
#      fsType = "btrfs";
#      options = [ "subvol=backup" ];
#    };
#
#
#  fileSystems."/boot" =
#    { device = "/dev/disk/by-uuid/730C-9ED3";
#      fsType = "vfat";
#    };
#
#  fileSystems."/share/data" =
#    { device = "/dev/disk/by-uuid/abb933b8-5c29-4dba-aeaf-a7ee1637e6c9";
#      fsType = "ext4";
#      label = "data";
#    };
#
#  fileSystems."/share/unorganized" =
#    { device = "/dev/disk/by-uuid/27049b3a-5026-4c36-a0e0-761b0bf66fa7";
#      fsType = "ext4";
#    };
#
#  fileSystems."/export/data" = {
#    device = "/share/data";
#    options = [ "bind" ];
#  };
#
#  fileSystems."/export/unorganized" = {
#    device = "/share/unorganized";
#    options = [ "bind" ];
#  };

  # fileSystems."/export/tomoyo" = {
  #   device = "/mnt/tomoyo";
  #   options = [ "bind" ];
  # };

  # fileSystems."/export/kotomi" = {
  #   device = "/mnt/kotomi";
  #   options = [ "bind" ];
  # };


  time.timeZone = "America/New_York";

  services.emacs = {
    enable = true;
    package = pkgs.custom-emacs;
    defaultEditor = true;
  };

  # Only start emacs for actual users, lol
  systemd.user.services.emacs.unitConfig = {
    ConditionGroup = "users";
  };

  #console.earlySetup = true;

  boot = {
    kernelPackages = pkgs.linuxPackages;
  };

  documentation.man.enable = true;
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.openssh = {
    enable = true;
#    passwordAuthentication = false;
    permitRootLogin = "yes";
    # useDns = true;
    forwardX11 = true;
    # extraConfig = ''
    #         X11UseLocalhost no
    # '';
  };

  programs.ssh = {
    forwardX11 = true;
  };

  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services = {
    interception-tools = {
      enable = true;
      #       udevmonConfig = {
      # ''
      #   - JOB: "intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE"
      #     DEVICE:
      #       EVENTS:
      #         EV_KEY: [KEY_CAPSLOCK, KEY_ESC]

      # ''
      #       };

    };
  };


  # services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "${pkgs.i3}/bin/i3";


#  services.nfs.server = {
#    enable = true;
#
#    # XXX enable to everyone on local network?
#    # exports = ''
#    #   /media/shared ${hosts.kodi.lan.ip}(ro,all_squash,anonuid=1000,anongid=${builtins.toString config.ids.gids.transmission}) ${hosts.ishamael.lan.ip}(rw,all_squash,anonuid=1000,anongid=${builtins.toString config.ids.gids.transmission}) ${hosts.ishamael.wifi.ip}(rw,all_squash,anonuid=1000,anongid=${builtins.toString config.ids.gids.transmission}) ${hosts.rpi3.lan.ip}(rw,all_squash,anonuid=1000,anongid=${builtins.toString config.ids.gids.transmission}) ${hosts.rpi3.wlan.ip}(rw,all_squash,anonuid=1000,anongid=${builtins.toString config.ids.gids.transmission})
#    # '';
#
#    exports = ''
#        /export          192.168.0.0/255.255.0.0(rw,fsid=0,no_subtree_check)
#        /export/data      192.168.0.0/255.255.0.0(rw,nohide,insecure,no_subtree_check)
#        /export/unorganized 192.168.0.0/255.255.0.0(rw,nohide,insecure,no_subtree_check)
#    '';
#
#    lockdPort = 4001;
#    mountdPort = 4002;
#    statdPort = 4000;
#  };

  networking = {
    networkmanager = {
      enable = true;
    };

    hostName = "omnissiah"; # Define your hostname.
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.


    firewall = {
      enable = true;
      allowPing = true;


      allowedTCPPorts = [
        22
        # 139 445 # xrdp
        2049 111 4000 4001 # nfs
        3389 2222

        22000 # Syncthing
        80 443
        9091 # Transmission
        8880
      ];

      allowedUDPPorts = [
        22
        # 137 138 # xrdp
        2049 111 4000 4001 # nfs
        3389 2222

        21027 # Syncthing
        9091 # Transmission

        8880
      ];


    # iptables -A nixos-fw -i enp11s0 -p tcp -s 192.168.0.0/255.255.0.0 --dport ${builtins.toString config.services.transmission.port} -j nixos-fw-accept
    #
    # iptables -A nixos-fw -i enp12s0 -p tcp -s 192.168.0.0/255.255.0.0 --dport ${builtins.toString config.services.transmission.port} -j nixos-fw-accept

      extraCommands = ''
    iptables -A nixos-fw -i enp12s0 -p tcp -s 192.168.0.0/255.255.0.0 --dport 4000:4002 -j nixos-fw-accept # nfs server
    iptables -A nixos-fw -i enp12s0 -p tcp -s 192.168.0.0/255.255.0.0 --dport 2049 -j nixos-fw-accept # nfs server
    iptables -A nixos-fw -i enp12s0 -p udp -s 192.168.0.0/255.255.0.0 --dport 2049 -j nixos-fw-accept # nfs server
    iptables -A nixos-fw -i enp11s0 -p tcp -s 192.168.0.0/255.255.0.0 --dport 4000:4002 -j nixos-fw-accept # nfs server
    iptables -A nixos-fw -i enp11s0 -p tcp -s 192.168.0.0/255.255.0.0 --dport 2049 -j nixos-fw-accept # nfs server
    iptables -A nixos-fw -i enp11s0 -p udp -s 192.168.0.0/255.255.0.0 --dport 2049 -j nixos-fw-accept # nfs server
  '';

    };
  };

  # services.transmission = {
  #   enable = true;
  #   settings = {
  #     download-dir = "/export/data";
  #     incomplete-dir = "/export/data/incomplete-torrents/";
  #     incomplete-dir-enabled = true;
  #     rpc-whitelist = "127.0.0.1,192.168.*.*,10.10.10.*";
  #   };
  # };

  # environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw


#  services.xserver.displayManager.sddm.enable = true;
#  services.xserver.desktopManager.plasma5.enable = true;
services.xserver.displayManager.lightdm.enable = true;
services.xserver.windowManager.i3.enable = true;
  services.xserver.autorun = true;
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  services.xserver.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

#
#  services = {
#    xserver = {
#      autorun = true;
#
##      synaptics.enable = true;
#      videoDrivers = [ "nvidia" ];
#      enable = true;
#      #exportConfiguration = true;
#
#  #    displayManager.lightdm = {
#  #      enable = true;
#  #    };
#
#  #    windowManager.i3 = {
#  #      enable = true;
#  #      extraPackages = with pkgs;
#  #        [
#  #          rofi alacritty xclip
#  #        ];
#      };

      ########################################################################
      # TODO REMOVE DISPLAY MANAGER AND CONSIDER MOVING TO KMSCON ALTOGETHER #
      ########################################################################
#    };
  #};


  services.jupyter = {
    enable = true;
    ip = "localhost";
    port = 8880;
    notebookDir = "/home/rob/jupyter-notebooks";
    user = "rob";
    group = "users";
    ## TODO ##
    password = "'init'";
    kernels = {
      python3 = let
        env = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
          ipykernel pandas scikitlearn
          matplotlib numpy scipy sympy
          keras tensorflow
        ]));
      in {
        displayName = "Python 3";
        argv = [
          "$ {env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        language = "python";
        #            logo32 = "$ {env.sitePackages}/ipykernel/resources/logo-32x32.png";
        #            logo64 = "$ {env.sitePackages}/ipykernel/resources/logo-64x64.png";
      };
    };
  };
  system.stateVersion = "19.09"; # Did you read the comment?
}
