{ config, pkgs, ...}:

{

  hardware = {

    nvidia = {
      modesetting.enable = true;
    };

    opengl = {
      enable = true;
      extraPackages = [ pkgs.linuxPackages.nvidia_x11 ];
      driSupport32Bit = true;
    };

    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
      powerOnBoot = true;
    };

    brightnessctl.enable = true;

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };
  };
}
