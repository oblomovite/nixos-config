{ config, pkgs, ... }:

{

  sound.enable = true;

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;

    nvidia.modesetting = true;

    bumblebee = {
      enable = true;
      connectDisplay = true;
      driver = "nvidia";
      pmMethod = "bbswitch";
    };

    opengl = {
      enable = true;
      extraPackages =
        # with pkgs;
        [ pkgs.linuxPackages.nvidia_x11 ];
    };
  };

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
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1-2 --off --output DP-1 --off --output HDMI-2 --off
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

    # videoDrivers = [
    #     "intel"
    # ];

    layout = "us";
    xkbOptions = "caps:swapescape";

  };
}
