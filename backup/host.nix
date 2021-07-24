let
  machine = {host, port ? 22, name, hostNic, guests ? {}}: {pkgs, lib, ...}@args:
    {
      imports = [ ./baseline.nix ];

      # We still want to be able to boot, adjust as needed based on your setup
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        kernelParams = [ "nomodeset" ];
      };
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/${name}-root";
        };
        "/boot" = {
          device = "/dev/disk/by-label/${name}-boot";
        };
      };
      boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];

      boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
      virtualisation.libvirtd.enable = true;

      environment.etc."virt/base-images/baseline.qcow2".source = "${import ./image.nix args}/baseline.qcow2";

      # Tell NixOps how to find the machine
      deployment.targetEnv = "none";
      deployment.targetHost = host;
      deployment.targetPort = port;
      networking.privateIPv4 = host;
    };
in
{
  # Tell NixOps about the hosts it should manage
  # athens = machine {
  #   host = "192.168.0.2";
  #   name = "athens";
  #   hostNic = "enp30s0";
  #   guests = {
  #     some-athens-guest = {
  #       memory = "4"; # GB
  #       diskSize = "50"; # GB
  #       mac = "D2:91:69:C0:14:9A";
  #       ip = "192.168.0.101"; # Ignored, only for personal reference
  #     };
  #   };

    # rome = machine {
    #   host = "192.168.0.3";
    #   name = "rome";
    #   hostNic = "enp3s0";
    # };
  # };


  systemd.services = lib.mapAttrs' (name: guest: lib.nameValuePair "libvirtd-guest-${name}" {
    after = [ "libvirtd.service" ];
    requires = [ "libvirtd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
    };
    script =
      let
        xml = pkgs.writeText "libvirt-guest-${name}.xml"
          ''
          <domain type="kvm">
            <name>${name}</name>
            <uuid>UUID</uuid>
            <os>
              <type>hvm</type>
            </os>
            <memory unit="GiB">${guest.memory}</memory>
            <devices>
              <disk type="volume">
                <source volume="guest-${name}"/>
                <target dev="vda" bus="virtio"/>
              </disk>
              <graphics type="spice" autoport="yes"/>
              <input type="keyboard" bus="usb"/>
              <interface type="direct">
                <source dev="${hostNic}" mode="bridge"/>
                <mac address="${guest.mac}"/>
                <model type="virtio"/>
              </interface>
            </devices>
            <features>
              <acpi/>
            </features>
          </domain>
        '';
      in
        ''
        uuid="$(${pkgs.libvirt}/bin/virsh domuuid '${name}' || true)"
        ${pkgs.libvirt}/bin/virsh define <(sed "s/UUID/$uuid/" '${xml}')
        ${pkgs.libvirt}/bin/virsh start '${name}'
      '';
    preStop =
      ''
      ${pkgs.libvirt}/bin/virsh shutdown '${name}'
      let "timeout = $(date +%s) + 10"
      while [ "$(${pkgs.libvirt}/bin/virsh list --name | grep --count '^${name}$')" -gt 0 ]; do
        if [ "$(date +%s)" -ge "$timeout" ]; then
          # Meh, we warned it...
          ${pkgs.libvirt}/bin/virsh destroy '${name}'
        else
          # The machine is still running, let's give it some time to shut down
          sleep 0.5
        fi
      done
    '';
  }) guests;


}

  # {
  #   # Make sure that we still have admin access to the machine
  #   services.openssh.enable = true;
  #   networking.firewall.allowedTCPPorts = [ 22 ];
  #   users = {
  #     mutableUsers = false;
  #     users.root.openssh.authorizedKeys.keyFiles = [ ./teozkr_id_rsa.pub ];
  #   };
  # }

  # $ NIXOPS_DEPLOYMENT=vm-test-hosts nixops create network-hosts.nix
  # $ NIXOPS_DEPLOYMENT=vm-test-hosts nixops deploy
