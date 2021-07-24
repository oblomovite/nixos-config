{ pkgs, config } : {
  containers.gabo= {
    autoStart = true;
    # privateNetwork = true;
    # hostAddress = "192.168.101.10";
    # localAddress = "192.168.101.11"; # ssh -X testusr@192.168.101.11

    config = { config, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        emacs
        pciutils
        file
        gnumake
        gcc
        cudatoolkit
      ];

    users.users.testusr = {
      isNormalUser = true;
      home = "/home/testusr";
      description = "test";
      password = "init";
      extraGroups = ["wheel"];
      uid = 2000;
    };

    # For laptop only #
      # services.xserver = {
        # videoDrivers = [ "nv" ];
        # enable = true;
        # windowManager.i3.enable = true;
      # };

      # hardware.enableAllFirmware = true;
      # services.openssh = {
        # enable = true;
        # forwardX11 = true;
      # };

      # programs.ssh.setXAuthLocation = true;

    # };
  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
  };

  nixpkgs.config.allowUnfree = true;
    };
  };
}
