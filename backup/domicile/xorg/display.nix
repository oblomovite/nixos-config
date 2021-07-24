{ config, pkgs, ... }:

{
  services.xserver = {

    enable = true;
    autorun = true;

    resolutions = [
      {
        x = 1920;
        y = 1080;
      }
      {
        x = 2560;
        y = 1440;
      }
    ];

    exportConfiguration = true;

    desktopManager = {
      default = "none";
      xterm.enable = false;

    };

    windowManager.default = "i3";
    windowManager.i3 = {
      enable = true;
      extraSessionCommands = ''
                            xrandr --output HDMI-0 --auto
                            '';

      extraPackages = with pkgs;
                    [
                      rofi
                      i3lock-pixeled
                      termite
                      i3status-rust
                    ];
    };

    displayManager = {
      lightdm = {
        enable = true;
        autoLogin = {
          enable = true;
          user = "rob";
        };
      };
    };

    videoDrivers = [ "nv" "nvidia" ];

    layout = "us";
    xkbOptions = "caps:swapescape";

  };
}
