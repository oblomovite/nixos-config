{ config, lib, pkgs, ... }:

{

# A system user for backup automation
    users.extraUsers.backup = {
      description = "Backup user";
      uid = 600;
      group = "backup";
      home = "/var/lib/backup";
      createHome = true;
      shell = pkgs.zsh;
    };
}
