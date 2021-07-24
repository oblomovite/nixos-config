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

  # boot.kernelParams = [ 
  #   "acpi_rev_override=5" # allow acpi to manage power events
  #   "i915 enable_fbc=1" # frame-buffer compression to reduce power consumption

  #   "i915.enable_guc=2" # enabled by default on this system
  #   "i915 fastboot=1" # enabled by default on this system

  # ];  

  # Idle the audio, network cards + hdmi audio interface
  # after one second
  # boot.extraModprobeConfig = ''
  #   options snd_hda_intel power_save=1
  #   options snd_hda_codec_hdmi=1
  #   options iwlwifi power_save=1 d0i3_disable=0 uapsd_disable=0
  #   options iwldvm force_cam=0
  #   '';

  environment.systemPackages = with pkgs;
    [ tlp powertop s-tui ] ++ [ config.boot.kernelPackages.cpupower ];

  system.activationScripts.cpu-frequency-set =
    let max-freq = 75; # 100 = the maximum capacity of my CPU
    in lib.mkIf (max-freq != null) {
      text = ''
        max_perf_pct=/sys/devices/system/cpu/intel_pstate/max_perf_pct
        value=${toString max-freq}
        if [[ -f $max_perf_pct ]]; then
          echo $value > $max_perf_pct
        fi
      '';
      deps = [ ];
    };

  powerManagement = {
    enable = true;
    powertop.enable = false;
  };

  services.tlp = {
    enable = true;
    # The following prevents the battery from charging fully to
    # preserve lifetime. Run `tlp fullcharge` to temporarily force
    # full charge.

    # extraConfig = ''
    #   CPU_SCALING_GOVERNOR_ON_BAT=powersave
    #   ENERGY_PERF_POLICY_ON_BAT=powersave
    #   START_CHARGE_THRESH_BAT0=40
    #   STOP_CHARGE_THRESH_BAT0=50
    # '';
  };

  services.upower = {
    enable = true;
    # usePercentageForPolicy = true;
    # percentageCritical = 5;
    # percentageAction = 5;
    # criticalPowerAction = "HybridSleep";
    # criticalPowerAction = "Hibernate";
  };


  services.udev.extraRules = lib.mkMerge [
    # autosuspend USB devices
    ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
    # autosuspend PCI devices
    ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
    # disable Ethernet Wake-on-LAN
    ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
  ];


}
