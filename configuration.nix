
{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in

{
  nixpkgs = {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
      # Needed to get android sdk;
      #android_sdk.accept_license = true;
      ## Add packages/options from unstable
      packageOverrides = pkgs: {
        unstable = import unstableTarball {
          config = config.nixpkgs.config;
        };
      };
      # maybe remove?
      nixpkgs.config.packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override { 
          enableHybridCodec = true; 
        };
      };

    };
    overlays = [
      #      (import ../../packages/overlay.nix {
      #        # inherit secrets;
      #      })

    ];
  };

  # protect nix-shell from garabage collection
  # run gc when low on space
nix.extraOptions = ''
  keep-outputs = true
  keep-derivations = true
  min-free = ${toString (100 * 1024 * 1024)}
  max-free = ${toString (1024 * 1024 * 1024)}
'';

nix.trustedUsers = ["root" "rob"];

#nix.gc.automatic = true;
#nix.gc.dates = "03:15"; # 3am
#nix.optimise.automatic = true;
#nix.optimise.dates = ["weekly"];

  imports =
    [ # Include the results of the hardware scan.

      ./hardware-configuration.nix
      #./sway.nix
      ./rob.nix
      ./cachix.nix
      ./power-management.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
	  root = {
		  device = "/dev/nvme0n1p2";
		  preLVM = true;
	  };
  };

  boot.kernelPackages =  pkgs.linuxPackages_latest;
  networking.hostName = "rocinante";


  networking = {
    wireless.iwd.enable = true;
    networkmanager = {
      wifi.backend = "iwd";
      wifi.powersave = true;
    };
  };

  # networking.useDHCP = true;
  networking.useDHCP = false;
  # networking.interfaces.wlp0s20f3.useDHCP = false;
  networking.interfaces.wlan0.useDHCP = true;

  networking.enableIPv6 = true;

  networking.firewall.allowedTCPPorts = [
      22 80 443
      631 # printing
      8384
      22000
    ];
  networking.firewall.allowedUDPPorts = [
      22 80 443
      631
      8384
      21027
      8880
    ];

  # Set your time zone.
  time.timeZone = "America/New_York";


  # hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel ];

  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    vaapiIntel

    #   intel-compute-runtime
    #   vulkan-loader
    #   vulkan-headers
  ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  hardware.video.hidpi.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # environment.pathsToLink = [
  #   "/share/nix-direnv"
  # ];
  
  programs.mtr.enable = true;

  services.openssh.enable = true;

  virtualisation.libvirtd.enable = true;

  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  # system.autoUpgrade.channel = https://nixos.org/channels/nixos-21.05;
  # system.autoUpgrade.channel = https://nixos.org/channels/unstable;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

