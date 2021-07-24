{ config, lib, pkgs, ... }:

{
  users.extraGroups = {
    plugdev = { gid = 500; };
    tracing = { gid = 501; };
    usbtmc = { gid = 502; };
    wireshark = { gid = 503; };
    usbmon = { gid = 504; };
    backup = { gid = 600; };
  };

}
