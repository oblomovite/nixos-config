{ config, pkgs, ...}:

{
  services.blueman.enable = true;

  hardware = {

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluezFull;
    };

    brightnessctl.enable = true;

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };
}
