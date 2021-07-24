{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ grobi ];
  services.grobi = {
    enable = true;
    executeAfter = [
      "${pkgs.systemd}/bin/systemctl --user restart picom"
  #    "${pkgs.systemd}/bin/systemctl --user restart kdeconnect-indicator kdeconnect network-manager-applet pasystray udiskie"
    ];
    rules = [
      {
        name = "docked";
        outputs_connected = [ "eDP1" "DP-1" ];
        configure_single = "DP-1";
        primary = true;
        atomic = true;
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --dpi 284"
          "${pkgs.xorg.xrandr}/bin/xrandr --output DP-1 --primary"
        ];
      }
      {
        name = "mobile";
        #outputs_connected = [ "eDP-1" ];
        outputs_disconnected = [ "DP-1" ];
        configure_single = "eDP-1";
        execute_after = [
          "${pkgs.xorg.xrandr}/bin/xrandr --dpi 227"
          "${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --primary"
        ];
      }
    ];
  };
}


         #     DP-1 = {
         #       enable = true;
         #       position = "0x0";
         #       mode = "3840x2160";
         #       primary = true;
         #       rate = "60.00";
         #       # dpi = 284;
         #       dpi = 163;
         #     };
         #   };
         # };
         # mobile = {
         #   fingerprint = {
         #   eDP-1 = "00ffffffffffff0038706a0000000000031f0104a51e137802ee96a3544c99260f4e5100000001010101010101010101010101010101f46900a0a0403e60302035002ebd10000018c35400a0a0403e60302035002ebd10000018000000100000000000000000000000000000000000fe004c4d3134304746314c30320a200087";
         #   };
         #     config = {
         #       eDP1 = {
         #         enable = true;
         #         position = "0x0";
         #         mode = "2560x1600";
         #         primary = true;
         #         rate = "60.00";
         #         dpi = 227;
         #       };
         #     };
