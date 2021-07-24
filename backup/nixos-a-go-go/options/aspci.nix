
  hardware = {

    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
      #    powerOnBoot = true;
    };

    brightnessctl.enable = true;

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };
