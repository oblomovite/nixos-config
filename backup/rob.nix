{ config, lib, pkgs, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev =  "040ea28e448a93d24540b7cf2eda4b25300c5ab1";
    ref = "master";
  };

in

{

  imports = [
    (import "${home-manager}/nixos")
  ];

  # Install packages to /etc/profile rather than $HOME/.nix-profile
  home-manager.useUserPackages = true;
  # Use system packages rather than private pkgs instance from home-manager
  home-manager.useGlobalPkgs = true;
  home-manager.users.rob = {
    programs.home-manager.enable = true;
    # packages = with pkgs; [ xdg-utils];

    programs.git = {
      enable = true;
      userName  = "oblomovite";
      userEmail = "robert.sheynin@gmail.com";
    };

    home.packages = with pkgs; [
      atool
      httpie
      pinentry_emacs
      alacritty
      rofi 
      swaylock # lockscreen
      swayidle
    #   xwayland # for legacy apps
      waybar # status bar
      mako # notification daemon
      kanshi # autorandr
      wlr-randr
      firefox-wayland
      grim
      slurp
      wl-clipboard
      clipman
      i3status-rust
    #   ## Media ##
      vlc
      mplayer
      mpv
      playerctl
      qrencode # image generation for qrcodes
      spotify
    ];

    programs.emacs = {
      enable = true;
      package = pkgs.emacsGcc;
      # extraPackages = (epkgs: [ epkgs.vterm ] );
    };

    # programs.direnv = {
    #   enable = true; 
    #   enableNixDirenvIntegration = true;
    # };

    # wayland.windowManager.sway = {
    #   systemdIntegration = true;
    #   enable = true; 
    #   xwayland = true;
    #   # package = null;
    #   # config = null;
    # };

    # xdg.configFile."sway/config" = {
    #   # source = configFile;
    #   source = "/home/rob/.config/sway/config";
    #   onChange = ''
    #     swaySocket=''${XDG_RUNTIME_DIR:-/run/user/$UID}/sway-ipc.$UID.$(${pkgs.procps}/bin/pgrep -x sway || ${pkgs.coreutils}/bin/true).sock
    #     if [ -S $swaySocket ]; then
    #       echo "Reloading sway"
    #       $DRY_RUN_CMD ${pkgs.sway}/bin/swaymsg -s $swaySocket reload
    #     fi
    #   '';
    # };
    # 
    # systemd.user.targets.sway-session = {
    #   Unit = {
    #     Description = "sway compositor session";
    #     Documentation = [ "man:systemd.special(7)" ];
    #     BindsTo = [ "graphical-session.target" ];
    #     Wants = [ "graphical-session-pre.target" ];
    #     After = [ "graphical-session-pre.target" ];
    #   };
    # };


    # programs.kanashi = {
    #   enable = true;
    # };

    # programs.mako = {
    #   enable = true;
    #   font = "Hack 12";
    # };
    # 
    # programs.password-store = {
    #  enable = true;
    #  package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    # };
    # 
    # programs.rofi = {
    #   enable = true;
    #   package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
    #   font = "Hack 14";
    # };

    # programs.firefox = {
    #   enable = true;
    #   profiles = {
    #     myprofile = {
    #       settings = {
    #         "general.smoothScroll" = false;
    #       };
    #     };
    #   };
    # };


    # xdg.configFile."i3/config".source = "${my-dotfile-dir}/i3.conf";

  # xdg.configFile."sway/config".source = "/home/rob/.config/sway/config";
    # xdg.enable = true;
    # home.file."sway/config".source = "/home/rob/.config/sway/config";

  };
  programs.sway.enable = true;
  environment = {
    loginShellInit = ''
           if [ "$(tty)" = "/dev/tty1" ]; then
               exec sway
           fi
       '';
  };
  
  users.extraUsers.rob = {
    createHome = true;
    subUidRanges = [{
      startUid = 100000;
      count = 65536;
    }];
    subGidRanges = [{
      startGid = 100000;
      count = 65536;
    }];
    description = "Robert";
    uid = 1000;
    isNormalUser = true;
    initialPassword = "init";
    extraGroups = [
      "adbusers"
      "audio"
      "dialout" # for access to /dev/ttyUSBx
      "docker"
      "git" # for read-only access to gitolite repos on the filesystem
      "libvirtd"
      "networkmanager"
      "systemd-journal"
      "tracing"
      "transmission"
      "wheel" # admin rights
      "wireshark"
      "libvirtd"
      "adbusers"
      "syncthing"
      "deluge"
      "tty"
      "video"
    ];

    shell = "/run/current-system/sw/bin/zsh";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDN7xbuynOGDUCI2BLW8SzFq+4s7bx8Qo5vleH1fRokw0RcGtkO1XHYvXO6sHsu5YVhKvTuTmE/ZmiUavMGv1iGbw/gA/e7ENwR/uV0z4xQRBX/CCrSGvvGp+XCrU/pl8YtXVbzOqwRvtaWEq9wuyNofBf54C6uv063GICkQIqdFue1WyBlPhAIiz7V5uOZqPUZuytFVwG7Ny42IRg/48pVm6LomVkbcvB1CjB0QGPlEAyozAPI6vOz8YNydqxvGHBTzfIIS6sGXpaESviXQ2GCJRvpcNmZPUO9EbFMuvP4CW1o22C5YZmheES0+HPrgig8khl3PZ6cqoRemNVe+L+yF5dDd3cXjQEBk7snYEh+p17MFtrrrm8QoLzG9x5CBwDeJNoTQXPaaILNBYoFQdteEpLDkd6p+wT6usCylaruQHkgx7/WICLM5RAi1io4xOAgXExo8zew1D2NaVPpOL+d1cszgqWWOgTUD5aszPhH2Ed2Y4fNLotSK3T6a3gMKFM= rob@oblomovite"
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAGDMN8/nzaEPpzTaezP1gc23PCzGAEqIMgR/BmSKUHr96TDMi4je6qYlsejQFt6nxvTZU9J66XfNm1gwYk1in3oYwFo0pCrgm5vS8RPHGgTA+wXFwhjIk0EOqCHAuWvV2F4PqoObQ/XQkLJB2zkhUAj+brrKlEgy+GmStR5POHk0Vb74g== rob@oblomovite"
    ];
  };
}
