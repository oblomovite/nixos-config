{ config, lib, pkgs, ... }: {
  # These optimations come from:
  # https://github.com/NixOS/nixpkgs/pull/22310#issuecomment-644863702


  boot.blacklistedKernelModules = [ 
    # disable gpu
    "nouveau" 
    "nvidia" 

    # disable integrated web cam
    "uvcvideo" 

  ];  

  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ ];
  };


  boot.kernelModules = [ 
    "kvm-intel" 
    "coretemp" 
    "cpuid" 
  ];

  boot.kernelParams = [ 
    #"acpi_rev_override=5" # allow acpi to manage power events
    "intel_pstate=passive"
    "i915.enable_fbc=1"
    "i915.enable_psr=2"
  ];  

  # boot.extraModprobeConfig = ''
  #   # idle audio and network cards after 1 second
  #   options snd_hda_intel power_save=1
  #   options snd_hda_codec_hdmi=1
  #   # options iwldvm force_cam=0
  #   # disable 802.11n, enable software encryption 
  #   options iwlwifi 11n_disable=1 swcrypto=1
  #   #
  #   options iwlwifi power_save=1 d0i3_disable=0 uapsd_disable=0

  #   '';

  # environment.systemPackages = with pkgs;
  #   [ tlp powertop s-tui ] ++ [ config.boot.kernelPackages.cpupower ];

  # system.activationScripts.cpu-frequency-set =
  #   let max-freq = 75; # 100 = the maximum capacity of my CPU
  #   in lib.mkIf (max-freq != null) {
  #     text = ''
  #       max_perf_pct=/sys/devices/system/cpu/intel_pstate/max_perf_pct
  #       value=${toString max-freq}
  #       if [[ -f $max_perf_pct ]]; then
  #         echo $value > $max_perf_pct
  #       fi
  #     '';
  #     deps = [ ];
  #   };

  # powerManagement = {
  #   enable = true;
  #   # powertop.enable = false;
  #   powertop.enable = true;
  # };

  # services.tlp = {
  #   enable = true;
  #   # The following prevents the battery from charging fully to
  #   # preserve lifetime. Run `tlp fullcharge` to temporarily force
  #   # full charge.

  #   # extraConfig = ''
  #   #   CPU_SCALING_GOVERNOR_ON_BAT=powersave
  #   #   ENERGY_PERF_POLICY_ON_BAT=powersave
  #   #   START_CHARGE_THRESH_BAT0=40
  #   #   STOP_CHARGE_THRESH_BAT0=50
  #   # '';
  # };

  services.upower = {
    enable = true;
    # usePercentageForPolicy = true;
    percentageCritical = 8;
    # percentageAction = 5;
    # criticalPowerAction = "HybridSleep";
    criticalPowerAction = "Hibernate";
  };


  services.udev.extraRules = lib.mkMerge [
    # autosuspend USB devices
    ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
    # autosuspend PCI devices
    ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
    # disable Ethernet Wake-on-LAN
    ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
  ];

  services = {
    tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
        START_CHARGE_THRESH_BAT1 = 75;
        STOP_CHARGE_THRESH_BAT1 = 80;
        RESTORE_THRESHOLDS_ON_BAT = 1;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
        DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
      };
    };
  };

  powerManagement = {
    enable = true;
    # cpuFreqGovernor = "shedutil";
  };



}
