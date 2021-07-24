{ config, pkgs, lib, ... }: {

  ## use wl-clipboard-x11 which is a wrapper to use wl-clipboard as a drop-in replacement to x11 clipboard tools
  # nixpkgs.overlays = [
  #   (self: super: {
  #     wl-clipboard-x11 = super.stdenv.mkDerivation rec {
  #       pname = "wl-clipboard-x11";
  #       version = "5";
        
  #       src = super.fetchFromGitHub {
  #         owner = "brunelli";
  #         repo = "wl-clipboard-x11";
  #         rev = "v${version}";
  #         sha256 = "1y7jv7rps0sdzmm859wn2l8q4pg2x35smcrm7mbfxn5vrga0bslb";
  #       };
        
  #       dontBuild = true;
  #       dontConfigure = true;
 #       propagatedBuildInputs = [ super.wl-clipboard ];
  #       makeFlags = [ "PREFIX=$(out)" ];
  #     };
      
  #     xsel = self.wl-clipboard-x11;
  #     xclip = self.wl-clipboard-x11;
  #   })
  # ];

  programs.xwayland = {
    enable = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock # lockscreen
      swayidle
      waybar # status bar
      mako # notification daemon
      kanshi # autorandr
      wl-clipboard
      alacritty
    ];
    extraSessionCommands = ''
  # SDL:
  export SDL_VIDEODRIVER=wayland
  # QT (needs qt5.qtwayland in systemPackages):
  export QT_QPA_PLATFORM=wayland-egl
  export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
  # Fix for some Java AWT applications (e.g. Android Studio),
  # use this if they aren't displayed properly:
  export _JAVA_AWT_WM_NONREPARENTING=1
'';
  };

  programs.light.enable = true;


#  environment = {
#    #etc = {
#      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
#      #"sway/config".source = ./dotfiles/sway/config;
#      #"xdg/waybar/config".source = ./dotfiles/waybar/config;
#      #"xdg/waybar/style.css".source = ./dotfiles/waybar/style.css;
#    #};
#  };

  # Here we but a shell script into path, which lets us start sway.service (after importing the environment of the login shell).
  environment.systemPackages = with pkgs; [
    (
      pkgs.writeTextFile {
        name = "startsway";
        destination = "/bin/startsway";
        executable = true;
        text = ''
          #! ${pkgs.bash}/bin/bash

          # first import environment variables from the login manager
          systemctl --user import-environment
          # then start the service
          exec systemctl --user start sway.service
        '';
      }
    )
  ];

  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  systemd.user.services.sway = {
    description = "Sway - Wayland window manager";
    documentation = [ "man:sway(5)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
    # We explicitly unset PATH here, as we want it to be set by
    # systemctl --user import-environment in startsway
    environment.PATH = lib.mkForce null;
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
      '';
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  systemd.user.services.swayidle = {
    description = "Idle Manager for Wayland";
    documentation = [ "man:swayidle(1)" ];
    wantedBy = [ "sway-session.target" ];
    partOf = [ "graphical-session.target" ];
    path = [ pkgs.bash ];
    serviceConfig = {
      ExecStart = '' ${pkgs.swayidle}/bin/swayidle -w -d \
        timeout 300 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
        resume '${pkgs.sway}/bin/swaymsg "output * dpms on"'
      '';
    };
  };

  location = {
    latitude = 40.75;
    longitude = -73.84;
  };
  services.redshift = {
    enable = true;
    # Redshift with wayland support isn't present in nixos-19.09 atm. You have to cherry-pick the commit from https://github.com/NixOS/nixpkgs/pull/68285 to do that.
    package = pkgs.redshift-wlr;
  };

  programs.waybar.enable = true;

  systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig ";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      # kanshi doesn't have an option to specifiy config file yet, so it looks
      # at .config/kanshi/config
      ExecStart = ''
        ${pkgs.kanshi}/bin/kanshi
      '';
      RestartSec = 5;
      Restart = "always";
    };
  };

}
