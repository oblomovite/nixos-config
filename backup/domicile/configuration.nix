{ config, pkgs, ... }:

{
  imports =

    [
      ./hardware-configuration.nix
      ./environment/system/packages.nix
      ./options/kernel.nix
      ./options/hardware.nix
      ./xorg/display.nix
      ../../users/rob.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [{
    name = "root";
    device = "/dev/nvme0n1p2";
    preLVM = true;
  }];

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = [
    "8.8.8.8"
    "8.8.4.4"
  ];

  networking.hostName = "domicile"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.networkmanager.dhcp = "dhclient";
  networking.networkmanager.dns = "dnsmasq";
  networking.localCommands =
    ''
    ip -6 addr add 2001:610:685:1::1/64 dev enp11s0
  '';

  networking.enableIPv6 = true;
  # networking.useDHCP = true;
  # networking.dhcpcd.persistent = true;
  # networking.useNetworkd = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  services.emacs = {
    defaultEditor = true;
    enable = true;
    install = true;
    package = import (../../programs/emacs.nix) { inherit pkgs; };
  };

  sound.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    kvmgt.enable = true;
    kvmgt.device = "0e:00.0";
  };

  # networking.firewall.checkReversePath = false;
  # networking.firewall.allowedTCPPorts = [22 80];
  # networking.firewall.enable = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.java = {
    enable = true;
    package = pkgs.openjdk;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
                   enable = true;
                   forwardX11 = true;
                   permitRootLogin = "no";
                   passwordAuthentication = false;
  };

  programs.zsh = {

    enable = true;
    enableCompletion = true;
    zsh-autoenv.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = [ "main" ];
      # patterns = {"rm -rf *" = "fg=white,bold,bg=red"; };
      # styles = {"alias" = "fg=magenta,bold"; };
    };

    autosuggestions = {
      enable = true;
      # extraConfig = { "ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE" = "20"; };
      # highlightStyle = { "fg=8","bg=12" };
      strategy = "match_prev_cmd";
    };

    shellAliases = {
      l = "ls -alh";
      ll = "ls -l";
      ls = "ls --color=tty";
      mkdir = "mkdir -p";
    };

    # promptInit = "";

    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "sudo" "docker" "systemd" "lein" "fasd" ];
    };
  };

  i18n = {
    # consoleFont = "Lat2-Terminus16";
    defaultLocale = "en_US.UTF-8";
    consoleUseXkbConfig = true;
    consoleFont = "ter-i32b";
    consolePackages = with pkgs; [ terminus_font ];
  };

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;
    fonts = with pkgs;
      [
        dejavu_fonts
        tewi-font
        source-code-pro
        font-awesome_5
        fira
        fira-code
        # fira-code-symbols

      material-icons
      material-design-icons
      nerdfonts
      ];
  };

  services.clamav = {
    updater.enable = true;
    updater.frequency = 1;
  };

  security.sudo = {
    enable = true;
    extraConfig = "wheel ALL=(ALL:ALL) SETENV: ALL";
  };

  system.autoUpgrade = {
    enable = true;
    #Double Check that this is the one you want
    channel = https://nixos.org/channels/nixos-unstable-small;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
